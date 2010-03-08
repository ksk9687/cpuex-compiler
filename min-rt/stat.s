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
.define { store_inst %iReg, [%iReg + %Imm] } { store_inst %2 %3 %1 }
.define { load [%iReg + %Imm], %fReg } { fload %1 %2 %3 }
.define { load [%iReg + %iReg], %fReg } { floadr %1 %2 %3 }
.define { store %fReg, [%iReg + %Imm] } { fstore %2 %3 %1 }
.define { mov %iReg, %fReg } { imovf %1 %2 }
.define { mov %fReg, %iReg } { fmovi %1 %2 }
.define { write %iReg, %iReg } { write %1 %2 }

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
    mov $f2, $f1                        # |    189,164 |    189,164 |
    bge $f1, $f0, FLOOR_POSITIVE        # |    189,164 |    189,164 |
    fneg $f1, $f1                       # |    166,713 |    166,713 |
    mov $ra, $tmp                       # |    166,713 |    166,713 |
    call FLOOR_POSITIVE                 # |    166,713 |    166,713 |
    load [FLOOR_MONE], $f2              # |    166,713 |    166,713 |
    fsub $f2, $f1, $f1                  # |    166,713 |    166,713 |
    jr $tmp                             # |    166,713 |    166,713 |
FLOOR_POSITIVE:
    load [FLOAT_MAGICF], $f3            # |    189,164 |    189,164 |
    ble $f1, $f3, FLOOR_POSITIVE_MAIN   # |    189,164 |    189,164 |
    ret
FLOOR_POSITIVE_MAIN:
    mov $f1, $f2                        # |    189,164 |    189,164 |
    fadd $f1, $f3, $f1                  # |    189,164 |    189,164 |
    fsub $f1, $f3, $f1                  # |    189,164 |    189,164 |
    ble $f1, $f2, FLOOR_RET             # |    189,164 |    189,164 |
    load [FLOOR_ONE], $f2
    fsub $f1, $f2, $f1
FLOOR_RET:
    ret                                 # |    189,164 |    189,164 |
.end floor

######################################################################
# $f1 = float_of_int($i2)
# $ra = $ra
# [$i2 - $i4]
# [$f1 - $f3]
######################################################################
.begin float_of_int
ext_float_of_int:
    bge $i2, 0, ITOF_MAIN               # |     16,565 |     16,565 |
    neg $i2, $i2                        # |      8,256 |      8,256 |
    mov $ra, $tmp                       # |      8,256 |      8,256 |
    call ITOF_MAIN                      # |      8,256 |      8,256 |
    fneg $f1, $f1                       # |      8,256 |      8,256 |
    jr $tmp                             # |      8,256 |      8,256 |
ITOF_MAIN:
    load [FLOAT_MAGICF], $f2            # |     16,565 |     16,565 |
    load [FLOAT_MAGICFHX], $i3          # |     16,565 |     16,565 |
    load [FLOAT_MAGICI], $i4            # |     16,565 |     16,565 |
    bge $i2, $i4, ITOF_BIG              # |     16,565 |     16,565 |
    add $i2, $i3, $i2                   # |     16,565 |     16,565 |
    mov $i2, $f1                        # |     16,565 |     16,565 |
    fsub $f1, $f2, $f1                  # |     16,565 |     16,565 |
    ret                                 # |     16,565 |     16,565 |
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
    bg      $f0, $f2, ble_else._192     # |      9,151 |      9,151 |
ble_then._192:
.count load_float
    load    [f._184], $f7               # |      8,651 |      8,651 |
    bg      $f7, $f2, cordic_sin._82    # |      8,651 |      8,651 |
.count load_float
    load    [f._185], $f7               # |      5,303 |      5,303 |
    bg      $f7, $f2, ble_else._194     # |      5,303 |      5,303 |
ble_then._194:
.count load_float
    load    [f._186], $f1               # |      3,758 |      3,758 |
    bg      $f1, $f2, ble_else._195     # |      3,758 |      3,758 |
ble_then._195:
    fsub    $f2, $f1, $f2               # |      2,416 |      2,416 |
    b       ext_sin                     # |      2,416 |      2,416 |
ble_else._195:
.count stack_move
    sub     $sp, 1, $sp                 # |      1,342 |      1,342 |
.count stack_store
    store   $ra, [$sp + 0]              # |      1,342 |      1,342 |
    fsub    $f1, $f2, $f2               # |      1,342 |      1,342 |
    call    ext_sin                     # |      1,342 |      1,342 |
.count stack_load
    load    [$sp + 0], $ra              # |      1,342 |      1,342 |
.count stack_move
    add     $sp, 1, $sp                 # |      1,342 |      1,342 |
    fneg    $f1, $f1                    # |      1,342 |      1,342 |
    ret                                 # |      1,342 |      1,342 |
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
    bne     $i2, 25, be_else._190       # |    127,218 |    127,218 |
be_then._190:
    mov     $f4, $f1                    # |      4,893 |      4,893 |
    ret                                 # |      4,893 |      4,893 |
be_else._190:
    fmul    $f6, $f4, $f1               # |    122,325 |    122,325 |
    bg      $f2, $f5, ble_else._191     # |    122,325 |    122,325 |
ble_then._191:
    fadd    $f3, $f1, $f1               # |     59,231 |     59,231 |
    fmul    $f6, $f3, $f3               # |     59,231 |     59,231 |
    fsub    $f4, $f3, $f4               # |     59,231 |     59,231 |
    load    [ext_atan_table + $i2], $f3 # |     59,231 |     59,231 |
    fsub    $f5, $f3, $f5               # |     59,231 |     59,231 |
.count load_float
    load    [f._181], $f3               # |     59,231 |     59,231 |
    fmul    $f6, $f3, $f6               # |     59,231 |     59,231 |
    add     $i2, 1, $i2                 # |     59,231 |     59,231 |
.count move_args
    mov     $f1, $f3                    # |     59,231 |     59,231 |
    b       cordic_rec._111             # |     59,231 |     59,231 |
ble_else._191:
    fsub    $f3, $f1, $f1               # |     63,094 |     63,094 |
    fmul    $f6, $f3, $f3               # |     63,094 |     63,094 |
    fadd    $f4, $f3, $f4               # |     63,094 |     63,094 |
    load    [ext_atan_table + $i2], $f3 # |     63,094 |     63,094 |
    fadd    $f5, $f3, $f5               # |     63,094 |     63,094 |
.count load_float
    load    [f._181], $f3               # |     63,094 |     63,094 |
    fmul    $f6, $f3, $f6               # |     63,094 |     63,094 |
    add     $i2, 1, $i2                 # |     63,094 |     63,094 |
.count move_args
    mov     $f1, $f3                    # |     63,094 |     63,094 |
    b       cordic_rec._111             # |     63,094 |     63,094 |

cordic_sin._82:
.count load_float
    load    [f._183], $f3               # |      4,893 |      4,893 |
.count load_float
    load    [f._182], $f6               # |      4,893 |      4,893 |
    li      0, $i2                      # |      4,893 |      4,893 |
.count move_args
    mov     $f0, $f4                    # |      4,893 |      4,893 |
.count move_args
    mov     $f0, $f5                    # |      4,893 |      4,893 |
    b       cordic_rec._111             # |      4,893 |      4,893 |
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
f.32088:    .float  -2.0000000000E+02
f.32087:    .float  2.0000000000E+02
f.32059:    .float  1.2800000000E+02
f.31997:    .float  9.0000000000E-01
f.31996:    .float  2.0000000000E-01
f.31968:    .float  1.5000000000E+02
f.31967:    .float  -1.5000000000E+02
f.31966:    .float  6.6666666667E-03
f.31965:    .float  -6.6666666667E-03
f.31964:    .float  -2.0000000000E+00
f.31963:    .float  3.9062500000E-03
f.31962:    .float  2.5600000000E+02
f.31961:    .float  1.0000000000E+08
f.31960:    .float  1.0000000000E+09
f.31959:    .float  1.0000000000E+01
f.31958:    .float  2.0000000000E+01
f.31957:    .float  5.0000000000E-02
f.31956:    .float  2.5000000000E-01
f.31955:    .float  1.0000000000E-01
f.31954:    .float  3.3333333333E+00
f.31953:    .float  2.5500000000E+02
f.31952:    .float  1.5000000000E-01
f.31951:    .float  3.1830988148E-01
f.31950:    .float  3.1415927000E+00
f.31949:    .float  3.0000000000E+01
f.31948:    .float  1.5000000000E+01
f.31947:    .float  1.0000000000E-04
f.31946:    .float  -1.0000000000E-01
f.31945:    .float  1.0000000000E-02
f.31944:    .float  -2.0000000000E-01
f.31943:    .float  5.0000000000E-01
f.31942:    .float  1.0000000000E+00
f.31941:    .float  -1.0000000000E+00
f.31940:    .float  2.0000000000E+00
f.31927:    .float  1.7453293000E-02

######################################################################
# $i1 = read_nth_object($i6)
# $ra = $ra1
# [$i1 - $i15]
# [$f1 - $f17]
# []
# []
######################################################################
.begin read_nth_object
read_nth_object.2719:
    call    ext_read_int                # |         18 |         18 |
.count move_ret
    mov     $i1, $i7                    # |         18 |         18 |
    bne     $i7, -1, be_else.32268      # |         18 |         18 |
be_then.32268:
    li      0, $i1                      # |          1 |          1 |
    jr      $ra1                        # |          1 |          1 |
be_else.32268:
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
    be      $i10, 0, bne_cont.32269     # |         17 |         17 |
bne_then.32269:
    call    ext_read_float
.count load_float
    load    [f.31927], $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i15 + 0]
    call    ext_read_float
    fmul    $f1, $f2, $f1
    store   $f1, [$i15 + 1]
    call    ext_read_float
    fmul    $f1, $f2, $f1
    store   $f1, [$i15 + 2]
bne_cont.32269:
    li      4, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
    bg      $f0, $f3, ble_else.32270    # |         17 |         17 |
ble_then.32270:
    li      0, $i2                      # |         15 |         15 |
.count b_cont
    b       ble_cont.32270              # |         15 |         15 |
ble_else.32270:
    li      1, $i2                      # |          2 |          2 |
ble_cont.32270:
    bne     $i8, 2, be_else.32271       # |         17 |         17 |
be_then.32271:
    li      1, $i3                      # |          2 |          2 |
.count b_cont
    b       be_cont.32271               # |          2 |          2 |
be_else.32271:
    mov     $i2, $i3                    # |         15 |         15 |
be_cont.32271:
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
    bne     $i8, 3, be_else.32272       # |         17 |         17 |
be_then.32272:
    load    [$i11 + 0], $f1             # |          9 |          9 |
    bne     $f1, $f0, be_else.32273     # |          9 |          9 |
be_then.32273:
    mov     $f0, $f1                    # |          2 |          2 |
.count b_cont
    b       be_cont.32273               # |          2 |          2 |
be_else.32273:
    bne     $f1, $f0, be_else.32274     # |          7 |          7 |
be_then.32274:
    fmul    $f1, $f1, $f1
    finv    $f1, $f1
    mov     $f0, $f1
.count b_cont
    b       be_cont.32274
be_else.32274:
    bg      $f1, $f0, ble_else.32275    # |          7 |          7 |
ble_then.32275:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
.count b_cont
    b       ble_cont.32275
ble_else.32275:
    fmul    $f1, $f1, $f1               # |          7 |          7 |
    finv    $f1, $f1                    # |          7 |          7 |
ble_cont.32275:
be_cont.32274:
be_cont.32273:
    store   $f1, [$i11 + 0]             # |          9 |          9 |
    load    [$i11 + 1], $f1             # |          9 |          9 |
    bne     $f1, $f0, be_else.32276     # |          9 |          9 |
be_then.32276:
    mov     $f0, $f1
.count b_cont
    b       be_cont.32276
be_else.32276:
    bne     $f1, $f0, be_else.32277     # |          9 |          9 |
be_then.32277:
    fmul    $f1, $f1, $f1
    finv    $f1, $f1
    mov     $f0, $f1
.count b_cont
    b       be_cont.32277
be_else.32277:
    bg      $f1, $f0, ble_else.32278    # |          9 |          9 |
ble_then.32278:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
.count b_cont
    b       ble_cont.32278
ble_else.32278:
    fmul    $f1, $f1, $f1               # |          9 |          9 |
    finv    $f1, $f1                    # |          9 |          9 |
ble_cont.32278:
be_cont.32277:
be_cont.32276:
    store   $f1, [$i11 + 1]             # |          9 |          9 |
    load    [$i11 + 2], $f1             # |          9 |          9 |
    bne     $f1, $f0, be_else.32279     # |          9 |          9 |
be_then.32279:
    mov     $f0, $f1
.count b_cont
    b       be_cont.32279
be_else.32279:
    bne     $f1, $f0, be_else.32280     # |          9 |          9 |
be_then.32280:
    fmul    $f1, $f1, $f1
    finv    $f1, $f1
    mov     $f0, $f1
.count b_cont
    b       be_cont.32280
be_else.32280:
    bg      $f1, $f0, ble_else.32281    # |          9 |          9 |
ble_then.32281:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
.count b_cont
    b       ble_cont.32281
ble_else.32281:
    fmul    $f1, $f1, $f1               # |          9 |          9 |
    finv    $f1, $f1                    # |          9 |          9 |
ble_cont.32281:
be_cont.32280:
be_cont.32279:
    store   $f1, [$i11 + 2]             # |          9 |          9 |
    bne     $i10, 0, be_else.32282      # |          9 |          9 |
be_then.32282:
    li      1, $i1                      # |          9 |          9 |
    jr      $ra1                        # |          9 |          9 |
be_else.32282:
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
be_else.32272:
    bne     $i8, 2, be_else.32283       # |          8 |          8 |
be_then.32283:
    load    [$i11 + 0], $f1             # |          2 |          2 |
    bne     $i2, 0, be_else.32284       # |          2 |          2 |
be_then.32284:
    li      1, $i1                      # |          2 |          2 |
.count b_cont
    b       be_cont.32284               # |          2 |          2 |
be_else.32284:
    li      0, $i1
be_cont.32284:
    fmul    $f1, $f1, $f2               # |          2 |          2 |
    load    [$i11 + 1], $f3             # |          2 |          2 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |
    load    [$i11 + 2], $f3             # |          2 |          2 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |
    fsqrt   $f2, $f2                    # |          2 |          2 |
    bne     $f2, $f0, be_else.32285     # |          2 |          2 |
be_then.32285:
    mov     $fc0, $f2
.count b_cont
    b       be_cont.32285
be_else.32285:
    bne     $i1, 0, be_else.32286       # |          2 |          2 |
be_then.32286:
    finv    $f2, $f2
.count b_cont
    b       be_cont.32286
be_else.32286:
    finv_n  $f2, $f2                    # |          2 |          2 |
be_cont.32286:
be_cont.32285:
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |
    load    [$i11 + 1], $f1             # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 1]             # |          2 |          2 |
    load    [$i11 + 2], $f1             # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 2]             # |          2 |          2 |
    bne     $i10, 0, be_else.32287      # |          2 |          2 |
be_then.32287:
    li      1, $i1                      # |          2 |          2 |
    jr      $ra1                        # |          2 |          2 |
be_else.32287:
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
be_else.32283:
    bne     $i10, 0, be_else.32288      # |          6 |          6 |
be_then.32288:
    li      1, $i1                      # |          6 |          6 |
    jr      $ra1                        # |          6 |          6 |
be_else.32288:
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
######################################################################
.begin read_object
read_object.2721:
    bl      $i16, 60, bge_else.32289    # |          2 |          2 |
bge_then.32289:
    jr      $ra2
bge_else.32289:
.count move_args
    mov     $i16, $i6                   # |          2 |          2 |
    jal     read_nth_object.2719, $ra1  # |          2 |          2 |
    bne     $i1, 0, be_else.32290       # |          2 |          2 |
be_then.32290:
    mov     $i16, $ig0
    jr      $ra2
be_else.32290:
    add     $i16, 1, $i16               # |          2 |          2 |
    bl      $i16, 60, bge_else.32291    # |          2 |          2 |
bge_then.32291:
    jr      $ra2
bge_else.32291:
.count move_args
    mov     $i16, $i6                   # |          2 |          2 |
    jal     read_nth_object.2719, $ra1  # |          2 |          2 |
    bne     $i1, 0, be_else.32292       # |          2 |          2 |
be_then.32292:
    mov     $i16, $ig0
    jr      $ra2
be_else.32292:
    add     $i16, 1, $i16               # |          2 |          2 |
    bl      $i16, 60, bge_else.32293    # |          2 |          2 |
bge_then.32293:
    jr      $ra2
bge_else.32293:
.count move_args
    mov     $i16, $i6                   # |          2 |          2 |
    jal     read_nth_object.2719, $ra1  # |          2 |          2 |
    bne     $i1, 0, be_else.32294       # |          2 |          2 |
be_then.32294:
    mov     $i16, $ig0
    jr      $ra2
be_else.32294:
    add     $i16, 1, $i16               # |          2 |          2 |
    bl      $i16, 60, bge_else.32295    # |          2 |          2 |
bge_then.32295:
    jr      $ra2
bge_else.32295:
.count move_args
    mov     $i16, $i6                   # |          2 |          2 |
    jal     read_nth_object.2719, $ra1  # |          2 |          2 |
    bne     $i1, 0, be_else.32296       # |          2 |          2 |
be_then.32296:
    mov     $i16, $ig0
    jr      $ra2
be_else.32296:
    add     $i16, 1, $i16               # |          2 |          2 |
    bl      $i16, 60, bge_else.32297    # |          2 |          2 |
bge_then.32297:
    jr      $ra2
bge_else.32297:
.count move_args
    mov     $i16, $i6                   # |          2 |          2 |
    jal     read_nth_object.2719, $ra1  # |          2 |          2 |
    bne     $i1, 0, be_else.32298       # |          2 |          2 |
be_then.32298:
    mov     $i16, $ig0
    jr      $ra2
be_else.32298:
    add     $i16, 1, $i16               # |          2 |          2 |
    bl      $i16, 60, bge_else.32299    # |          2 |          2 |
bge_then.32299:
    jr      $ra2
bge_else.32299:
.count move_args
    mov     $i16, $i6                   # |          2 |          2 |
    jal     read_nth_object.2719, $ra1  # |          2 |          2 |
    bne     $i1, 0, be_else.32300       # |          2 |          2 |
be_then.32300:
    mov     $i16, $ig0                  # |          1 |          1 |
    jr      $ra2                        # |          1 |          1 |
be_else.32300:
    add     $i16, 1, $i16               # |          1 |          1 |
    bl      $i16, 60, bge_else.32301    # |          1 |          1 |
bge_then.32301:
    jr      $ra2
bge_else.32301:
.count move_args
    mov     $i16, $i6                   # |          1 |          1 |
    jal     read_nth_object.2719, $ra1  # |          1 |          1 |
    bne     $i1, 0, be_else.32302       # |          1 |          1 |
be_then.32302:
    mov     $i16, $ig0
    jr      $ra2
be_else.32302:
    add     $i16, 1, $i16               # |          1 |          1 |
    bl      $i16, 60, bge_else.32303    # |          1 |          1 |
bge_then.32303:
    jr      $ra2
bge_else.32303:
.count move_args
    mov     $i16, $i6                   # |          1 |          1 |
    jal     read_nth_object.2719, $ra1  # |          1 |          1 |
    bne     $i1, 0, be_else.32304       # |          1 |          1 |
be_then.32304:
    mov     $i16, $ig0
    jr      $ra2
be_else.32304:
    add     $i16, 1, $i16               # |          1 |          1 |
    b       read_object.2721            # |          1 |          1 |
.end read_object

######################################################################
# $i1 = read_net_item($i1)
# $ra = $ra
# [$i1 - $i5]
# []
# []
# []
######################################################################
.begin read_net_item
read_net_item.2725:
.count stack_store_ra
    store   $ra, [$sp - 9]              # |          7 |          7 |
.count stack_move
    sub     $sp, 9, $sp                 # |          7 |          7 |
.count stack_store
    store   $i1, [$sp + 1]              # |          7 |          7 |
    call    ext_read_int                # |          7 |          7 |
    bne     $i1, -1, be_else.32305      # |          7 |          7 |
be_then.32305:
.count stack_load_ra
    load    [$sp + 0], $ra              # |          2 |          2 |
.count stack_move
    add     $sp, 9, $sp                 # |          2 |          2 |
.count stack_load
    load    [$sp - 8], $i1              # |          2 |          2 |
    add     $i1, 1, $i2                 # |          2 |          2 |
    add     $i0, -1, $i3                # |          2 |          2 |
    b       ext_create_array_int        # |          2 |          2 |
be_else.32305:
.count stack_store
    store   $i1, [$sp + 2]              # |          5 |          5 |
    call    ext_read_int                # |          5 |          5 |
.count stack_load
    load    [$sp + 1], $i2              # |          5 |          5 |
    add     $i2, 1, $i3                 # |          5 |          5 |
    bne     $i1, -1, be_else.32306      # |          5 |          5 |
be_then.32306:
    add     $i3, 1, $i2                 # |          3 |          3 |
    add     $i0, -1, $i3                # |          3 |          3 |
    call    ext_create_array_int        # |          3 |          3 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          3 |          3 |
.count stack_move
    add     $sp, 9, $sp                 # |          3 |          3 |
.count stack_load
    load    [$sp - 8], $i2              # |          3 |          3 |
.count stack_load
    load    [$sp - 7], $i3              # |          3 |          3 |
.count storer
    add     $i1, $i2, $tmp              # |          3 |          3 |
    store   $i3, [$tmp + 0]             # |          3 |          3 |
    ret                                 # |          3 |          3 |
be_else.32306:
.count stack_store
    store   $i1, [$sp + 3]              # |          2 |          2 |
.count stack_store
    store   $i3, [$sp + 4]              # |          2 |          2 |
    call    ext_read_int                # |          2 |          2 |
.count stack_load
    load    [$sp + 4], $i2              # |          2 |          2 |
    add     $i2, 1, $i3                 # |          2 |          2 |
    bne     $i1, -1, be_else.32307      # |          2 |          2 |
be_then.32307:
    add     $i3, 1, $i2                 # |          1 |          1 |
    add     $i0, -1, $i3                # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 9, $sp                 # |          1 |          1 |
.count stack_load
    load    [$sp - 5], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 6], $i3              # |          1 |          1 |
.count storer
    add     $i1, $i2, $tmp              # |          1 |          1 |
    store   $i3, [$tmp + 0]             # |          1 |          1 |
.count stack_load
    load    [$sp - 8], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 7], $i3              # |          1 |          1 |
.count storer
    add     $i1, $i2, $tmp              # |          1 |          1 |
    store   $i3, [$tmp + 0]             # |          1 |          1 |
    ret                                 # |          1 |          1 |
be_else.32307:
.count stack_store
    store   $i1, [$sp + 5]              # |          1 |          1 |
.count stack_store
    store   $i3, [$sp + 6]              # |          1 |          1 |
    call    ext_read_int                # |          1 |          1 |
.count stack_load
    load    [$sp + 6], $i2              # |          1 |          1 |
    add     $i2, 1, $i3                 # |          1 |          1 |
    bne     $i1, -1, be_else.32308      # |          1 |          1 |
be_then.32308:
    add     $i3, 1, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
.count stack_load
    load    [$sp - 3], $i2
.count stack_load
    load    [$sp - 4], $i3
.count storer
    add     $i1, $i2, $tmp
    store   $i3, [$tmp + 0]
.count stack_load
    load    [$sp - 5], $i2
.count stack_load
    load    [$sp - 6], $i3
.count storer
    add     $i1, $i2, $tmp
    store   $i3, [$tmp + 0]
.count stack_load
    load    [$sp - 8], $i2
.count stack_load
    load    [$sp - 7], $i3
.count storer
    add     $i1, $i2, $tmp
    store   $i3, [$tmp + 0]
    ret
be_else.32308:
.count stack_store
    store   $i3, [$sp + 7]              # |          1 |          1 |
.count stack_store
    store   $i1, [$sp + 8]              # |          1 |          1 |
    add     $i3, 1, $i1                 # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 9, $sp                 # |          1 |          1 |
.count stack_load
    load    [$sp - 2], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 1], $i3              # |          1 |          1 |
.count storer
    add     $i1, $i2, $tmp              # |          1 |          1 |
    store   $i3, [$tmp + 0]             # |          1 |          1 |
.count stack_load
    load    [$sp - 3], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 4], $i3              # |          1 |          1 |
.count storer
    add     $i1, $i2, $tmp              # |          1 |          1 |
    store   $i3, [$tmp + 0]             # |          1 |          1 |
.count stack_load
    load    [$sp - 5], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 6], $i3              # |          1 |          1 |
.count storer
    add     $i1, $i2, $tmp              # |          1 |          1 |
    store   $i3, [$tmp + 0]             # |          1 |          1 |
.count stack_load
    load    [$sp - 8], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 7], $i3              # |          1 |          1 |
.count storer
    add     $i1, $i2, $tmp              # |          1 |          1 |
    store   $i3, [$tmp + 0]             # |          1 |          1 |
    ret                                 # |          1 |          1 |
.end read_net_item

######################################################################
# $i1 = read_or_network($i1)
# $ra = $ra
# [$i1 - $i8]
# []
# []
# []
######################################################################
.begin read_or_network
read_or_network.2727:
.count stack_store_ra
    store   $ra, [$sp - 5]              # |          1 |          1 |
.count stack_move
    sub     $sp, 5, $sp                 # |          1 |          1 |
.count stack_store
    store   $i1, [$sp + 1]              # |          1 |          1 |
    call    ext_read_int                # |          1 |          1 |
    mov     $i1, $i6                    # |          1 |          1 |
    bne     $i6, -1, be_else.32309      # |          1 |          1 |
be_then.32309:
    li      1, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
.count b_cont
    b       be_cont.32309
be_else.32309:
    call    ext_read_int                # |          1 |          1 |
.count move_ret
    mov     $i1, $i7                    # |          1 |          1 |
    bne     $i7, -1, be_else.32310      # |          1 |          1 |
be_then.32310:
    li      2, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
    store   $i6, [$i1 + 0]
.count b_cont
    b       be_cont.32310
be_else.32310:
    call    ext_read_int                # |          1 |          1 |
.count move_ret
    mov     $i1, $i8                    # |          1 |          1 |
    bne     $i8, -1, be_else.32311      # |          1 |          1 |
be_then.32311:
    li      3, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
    store   $i7, [$i1 + 1]
    store   $i6, [$i1 + 0]
.count b_cont
    b       be_cont.32311
be_else.32311:
    li      3, $i1                      # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
    store   $i8, [$i1 + 2]              # |          1 |          1 |
    store   $i7, [$i1 + 1]              # |          1 |          1 |
    store   $i6, [$i1 + 0]              # |          1 |          1 |
be_cont.32311:
be_cont.32310:
be_cont.32309:
    load    [$i1 + 0], $i2              # |          1 |          1 |
    bne     $i2, -1, be_else.32312      # |          1 |          1 |
be_then.32312:
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 4], $i2
    add     $i2, 1, $i2
.count move_args
    mov     $i1, $i3
    b       ext_create_array_int
be_else.32312:
.count stack_store
    store   $i1, [$sp + 2]              # |          1 |          1 |
    call    ext_read_int                # |          1 |          1 |
    mov     $i1, $i6                    # |          1 |          1 |
    bne     $i6, -1, be_else.32313      # |          1 |          1 |
be_then.32313:
    li      1, $i2                      # |          1 |          1 |
    add     $i0, -1, $i3                # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count b_cont
    b       be_cont.32313               # |          1 |          1 |
be_else.32313:
    call    ext_read_int
.count move_ret
    mov     $i1, $i7
    bne     $i7, -1, be_else.32314
be_then.32314:
    li      2, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
    store   $i6, [$i1 + 0]
.count b_cont
    b       be_cont.32314
be_else.32314:
    li      2, $i1
    call    read_net_item.2725
    store   $i7, [$i1 + 1]
    store   $i6, [$i1 + 0]
be_cont.32314:
be_cont.32313:
    load    [$i1 + 0], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp + 1], $i3              # |          1 |          1 |
    add     $i3, 1, $i4                 # |          1 |          1 |
    bne     $i2, -1, be_else.32315      # |          1 |          1 |
be_then.32315:
    add     $i4, 1, $i2                 # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 5, $sp                 # |          1 |          1 |
.count stack_load
    load    [$sp - 4], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 3], $i3              # |          1 |          1 |
.count storer
    add     $i1, $i2, $tmp              # |          1 |          1 |
    store   $i3, [$tmp + 0]             # |          1 |          1 |
    ret                                 # |          1 |          1 |
be_else.32315:
.count stack_store
    store   $i4, [$sp + 3]
.count stack_store
    store   $i1, [$sp + 4]
    add     $i4, 1, $i1
    call    read_or_network.2727
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 2], $i2
.count stack_load
    load    [$sp - 1], $i3
.count storer
    add     $i1, $i2, $tmp
    store   $i3, [$tmp + 0]
.count stack_load
    load    [$sp - 4], $i2
.count stack_load
    load    [$sp - 3], $i3
.count storer
    add     $i1, $i2, $tmp
    store   $i3, [$tmp + 0]
    ret
.end read_or_network

######################################################################
# read_and_network($i6)
# $ra = $ra1
# [$i1 - $i9]
# []
# []
# []
######################################################################
.begin read_and_network
read_and_network.2729:
    call    ext_read_int                # |          3 |          3 |
.count move_ret
    mov     $i1, $i7                    # |          3 |          3 |
    bne     $i7, -1, be_else.32316      # |          3 |          3 |
be_then.32316:
    li      1, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
.count b_cont
    b       be_cont.32316
be_else.32316:
    call    ext_read_int                # |          3 |          3 |
.count move_ret
    mov     $i1, $i8                    # |          3 |          3 |
    bne     $i8, -1, be_else.32317      # |          3 |          3 |
be_then.32317:
    li      2, $i2                      # |          2 |          2 |
    add     $i0, -1, $i3                # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    store   $i7, [$i1 + 0]              # |          2 |          2 |
.count b_cont
    b       be_cont.32317               # |          2 |          2 |
be_else.32317:
    call    ext_read_int                # |          1 |          1 |
.count move_ret
    mov     $i1, $i9                    # |          1 |          1 |
    bne     $i9, -1, be_else.32318      # |          1 |          1 |
be_then.32318:
    li      3, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
    store   $i8, [$i1 + 1]
    store   $i7, [$i1 + 0]
.count b_cont
    b       be_cont.32318
be_else.32318:
    li      3, $i1                      # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
    store   $i9, [$i1 + 2]              # |          1 |          1 |
    store   $i8, [$i1 + 1]              # |          1 |          1 |
    store   $i7, [$i1 + 0]              # |          1 |          1 |
be_cont.32318:
be_cont.32317:
be_cont.32316:
    load    [$i1 + 0], $i2              # |          3 |          3 |
    bne     $i2, -1, be_else.32319      # |          3 |          3 |
be_then.32319:
    jr      $ra1
be_else.32319:
    store   $i1, [ext_and_net + $i6]    # |          3 |          3 |
    call    ext_read_int                # |          3 |          3 |
.count move_ret
    mov     $i1, $i7                    # |          3 |          3 |
    bne     $i7, -1, be_else.32320      # |          3 |          3 |
be_then.32320:
    li      1, $i2                      # |          1 |          1 |
    add     $i0, -1, $i3                # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count b_cont
    b       be_cont.32320               # |          1 |          1 |
be_else.32320:
    call    ext_read_int                # |          2 |          2 |
.count move_ret
    mov     $i1, $i8                    # |          2 |          2 |
    bne     $i8, -1, be_else.32321      # |          2 |          2 |
be_then.32321:
    li      2, $i2                      # |          1 |          1 |
    add     $i0, -1, $i3                # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
    store   $i7, [$i1 + 0]              # |          1 |          1 |
.count b_cont
    b       be_cont.32321               # |          1 |          1 |
be_else.32321:
    li      2, $i1                      # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
    store   $i8, [$i1 + 1]              # |          1 |          1 |
    store   $i7, [$i1 + 0]              # |          1 |          1 |
be_cont.32321:
be_cont.32320:
    load    [$i1 + 0], $i2              # |          3 |          3 |
    bne     $i2, -1, be_else.32322      # |          3 |          3 |
be_then.32322:
    jr      $ra1                        # |          1 |          1 |
be_else.32322:
    add     $i6, 1, $i6                 # |          2 |          2 |
    store   $i1, [ext_and_net + $i6]    # |          2 |          2 |
    call    ext_read_int                # |          2 |          2 |
.count move_ret
    mov     $i1, $i7                    # |          2 |          2 |
    bne     $i7, -1, be_else.32323      # |          2 |          2 |
be_then.32323:
    li      1, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
.count b_cont
    b       be_cont.32323
be_else.32323:
    call    ext_read_int                # |          2 |          2 |
.count move_ret
    mov     $i1, $i8                    # |          2 |          2 |
    bne     $i8, -1, be_else.32324      # |          2 |          2 |
be_then.32324:
    li      2, $i2                      # |          2 |          2 |
    add     $i0, -1, $i3                # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    store   $i7, [$i1 + 0]              # |          2 |          2 |
.count b_cont
    b       be_cont.32324               # |          2 |          2 |
be_else.32324:
    call    ext_read_int
.count move_ret
    mov     $i1, $i9
    bne     $i9, -1, be_else.32325
be_then.32325:
    li      3, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
    store   $i8, [$i1 + 1]
    store   $i7, [$i1 + 0]
.count b_cont
    b       be_cont.32325
be_else.32325:
    li      3, $i1
    call    read_net_item.2725
    store   $i9, [$i1 + 2]
    store   $i8, [$i1 + 1]
    store   $i7, [$i1 + 0]
be_cont.32325:
be_cont.32324:
be_cont.32323:
    load    [$i1 + 0], $i2              # |          2 |          2 |
    bne     $i2, -1, be_else.32326      # |          2 |          2 |
be_then.32326:
    jr      $ra1
be_else.32326:
    add     $i6, 1, $i6                 # |          2 |          2 |
    store   $i1, [ext_and_net + $i6]    # |          2 |          2 |
    call    ext_read_int                # |          2 |          2 |
.count move_ret
    mov     $i1, $i7                    # |          2 |          2 |
    bne     $i7, -1, be_else.32327      # |          2 |          2 |
be_then.32327:
    li      1, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
.count b_cont
    b       be_cont.32327
be_else.32327:
    call    ext_read_int                # |          2 |          2 |
.count move_ret
    mov     $i1, $i8                    # |          2 |          2 |
    bne     $i8, -1, be_else.32328      # |          2 |          2 |
be_then.32328:
    li      2, $i2                      # |          1 |          1 |
    add     $i0, -1, $i3                # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
    store   $i7, [$i1 + 0]              # |          1 |          1 |
.count b_cont
    b       be_cont.32328               # |          1 |          1 |
be_else.32328:
    li      2, $i1                      # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
    store   $i8, [$i1 + 1]              # |          1 |          1 |
    store   $i7, [$i1 + 0]              # |          1 |          1 |
be_cont.32328:
be_cont.32327:
    load    [$i1 + 0], $i2              # |          2 |          2 |
    bne     $i2, -1, be_else.32329      # |          2 |          2 |
be_then.32329:
    jr      $ra1
be_else.32329:
    add     $i6, 1, $i2                 # |          2 |          2 |
    store   $i1, [ext_and_net + $i2]    # |          2 |          2 |
    add     $i2, 1, $i6                 # |          2 |          2 |
    b       read_and_network.2729       # |          2 |          2 |
.end read_and_network

######################################################################
# $i1 = solver($i1, $i2)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f13]
# []
# [$fg0]
######################################################################
.begin solver
solver.2773:
    load    [ext_objects + $i1], $i1    # |     23,754 |     23,754 |
    load    [$i1 + 5], $i3              # |     23,754 |     23,754 |
    load    [$i1 + 5], $i4              # |     23,754 |     23,754 |
    load    [$i1 + 5], $i5              # |     23,754 |     23,754 |
    load    [$i1 + 1], $i6              # |     23,754 |     23,754 |
    load    [$i3 + 0], $f1              # |     23,754 |     23,754 |
    load    [$i4 + 1], $f2              # |     23,754 |     23,754 |
    load    [$i5 + 2], $f3              # |     23,754 |     23,754 |
    fsub    $fg21, $f1, $f1             # |     23,754 |     23,754 |
    fsub    $fg22, $f2, $f2             # |     23,754 |     23,754 |
    fsub    $fg23, $f3, $f3             # |     23,754 |     23,754 |
    load    [$i2 + 0], $f4              # |     23,754 |     23,754 |
    bne     $i6, 1, be_else.32330       # |     23,754 |     23,754 |
be_then.32330:
    bne     $f4, $f0, be_else.32331     # |     23,754 |     23,754 |
be_then.32331:
    li      0, $i3
.count b_cont
    b       be_cont.32331
be_else.32331:
    load    [$i1 + 4], $i3              # |     23,754 |     23,754 |
    load    [$i3 + 1], $f5              # |     23,754 |     23,754 |
    load    [$i2 + 1], $f6              # |     23,754 |     23,754 |
    load    [$i1 + 6], $i4              # |     23,754 |     23,754 |
    bg      $f0, $f4, ble_else.32332    # |     23,754 |     23,754 |
ble_then.32332:
    li      0, $i5                      # |     23,580 |     23,580 |
.count b_cont
    b       ble_cont.32332              # |     23,580 |     23,580 |
ble_else.32332:
    li      1, $i5                      # |        174 |        174 |
ble_cont.32332:
    bne     $i4, 0, be_else.32333       # |     23,754 |     23,754 |
be_then.32333:
    mov     $i5, $i4                    # |     23,754 |     23,754 |
.count b_cont
    b       be_cont.32333               # |     23,754 |     23,754 |
be_else.32333:
    bne     $i5, 0, be_else.32334
be_then.32334:
    li      1, $i4
.count b_cont
    b       be_cont.32334
be_else.32334:
    li      0, $i4
be_cont.32334:
be_cont.32333:
    load    [$i3 + 0], $f7              # |     23,754 |     23,754 |
    bne     $i4, 0, be_cont.32335       # |     23,754 |     23,754 |
be_then.32335:
    fneg    $f7, $f7                    # |     23,580 |     23,580 |
be_cont.32335:
    fsub    $f7, $f1, $f7               # |     23,754 |     23,754 |
    finv    $f4, $f4                    # |     23,754 |     23,754 |
    fmul    $f7, $f4, $f4               # |     23,754 |     23,754 |
    fmul    $f4, $f6, $f6               # |     23,754 |     23,754 |
    fadd_a  $f6, $f2, $f6               # |     23,754 |     23,754 |
    bg      $f5, $f6, ble_else.32336    # |     23,754 |     23,754 |
ble_then.32336:
    li      0, $i3                      # |     14,964 |     14,964 |
.count b_cont
    b       ble_cont.32336              # |     14,964 |     14,964 |
ble_else.32336:
    load    [$i3 + 2], $f5              # |      8,790 |      8,790 |
    load    [$i2 + 2], $f6              # |      8,790 |      8,790 |
    fmul    $f4, $f6, $f6               # |      8,790 |      8,790 |
    fadd_a  $f6, $f3, $f6               # |      8,790 |      8,790 |
    bg      $f5, $f6, ble_else.32337    # |      8,790 |      8,790 |
ble_then.32337:
    li      0, $i3                      # |      5,123 |      5,123 |
.count b_cont
    b       ble_cont.32337              # |      5,123 |      5,123 |
ble_else.32337:
    mov     $f4, $fg0                   # |      3,667 |      3,667 |
    li      1, $i3                      # |      3,667 |      3,667 |
ble_cont.32337:
ble_cont.32336:
be_cont.32331:
    bne     $i3, 0, be_else.32338       # |     23,754 |     23,754 |
be_then.32338:
    load    [$i2 + 1], $f4              # |     20,087 |     20,087 |
    bne     $f4, $f0, be_else.32339     # |     20,087 |     20,087 |
be_then.32339:
    li      0, $i3
.count b_cont
    b       be_cont.32339
be_else.32339:
    load    [$i1 + 4], $i3              # |     20,087 |     20,087 |
    load    [$i3 + 2], $f5              # |     20,087 |     20,087 |
    load    [$i2 + 2], $f6              # |     20,087 |     20,087 |
    load    [$i1 + 6], $i4              # |     20,087 |     20,087 |
    bg      $f0, $f4, ble_else.32340    # |     20,087 |     20,087 |
ble_then.32340:
    li      0, $i5                      # |         38 |         38 |
.count b_cont
    b       ble_cont.32340              # |         38 |         38 |
ble_else.32340:
    li      1, $i5                      # |     20,049 |     20,049 |
ble_cont.32340:
    bne     $i4, 0, be_else.32341       # |     20,087 |     20,087 |
be_then.32341:
    mov     $i5, $i4                    # |     20,087 |     20,087 |
.count b_cont
    b       be_cont.32341               # |     20,087 |     20,087 |
be_else.32341:
    bne     $i5, 0, be_else.32342
be_then.32342:
    li      1, $i4
.count b_cont
    b       be_cont.32342
be_else.32342:
    li      0, $i4
be_cont.32342:
be_cont.32341:
    load    [$i3 + 1], $f7              # |     20,087 |     20,087 |
    bne     $i4, 0, be_cont.32343       # |     20,087 |     20,087 |
be_then.32343:
    fneg    $f7, $f7                    # |         38 |         38 |
be_cont.32343:
    fsub    $f7, $f2, $f7               # |     20,087 |     20,087 |
    finv    $f4, $f4                    # |     20,087 |     20,087 |
    fmul    $f7, $f4, $f4               # |     20,087 |     20,087 |
    fmul    $f4, $f6, $f6               # |     20,087 |     20,087 |
    fadd_a  $f6, $f3, $f6               # |     20,087 |     20,087 |
    bg      $f5, $f6, ble_else.32344    # |     20,087 |     20,087 |
ble_then.32344:
    li      0, $i3                      # |     16,512 |     16,512 |
.count b_cont
    b       ble_cont.32344              # |     16,512 |     16,512 |
ble_else.32344:
    load    [$i3 + 0], $f5              # |      3,575 |      3,575 |
    load    [$i2 + 0], $f6              # |      3,575 |      3,575 |
    fmul    $f4, $f6, $f6               # |      3,575 |      3,575 |
    fadd_a  $f6, $f1, $f6               # |      3,575 |      3,575 |
    bg      $f5, $f6, ble_else.32345    # |      3,575 |      3,575 |
ble_then.32345:
    li      0, $i3                      # |      2,631 |      2,631 |
.count b_cont
    b       ble_cont.32345              # |      2,631 |      2,631 |
ble_else.32345:
    mov     $f4, $fg0                   # |        944 |        944 |
    li      1, $i3                      # |        944 |        944 |
ble_cont.32345:
ble_cont.32344:
be_cont.32339:
    bne     $i3, 0, be_else.32346       # |     20,087 |     20,087 |
be_then.32346:
    load    [$i2 + 2], $f4              # |     19,143 |     19,143 |
    bne     $f4, $f0, be_else.32347     # |     19,143 |     19,143 |
be_then.32347:
    li      0, $i1
    ret
be_else.32347:
    load    [$i1 + 4], $i3              # |     19,143 |     19,143 |
    load    [$i1 + 6], $i1              # |     19,143 |     19,143 |
    load    [$i3 + 0], $f5              # |     19,143 |     19,143 |
    load    [$i2 + 0], $f6              # |     19,143 |     19,143 |
    bg      $f0, $f4, ble_else.32348    # |     19,143 |     19,143 |
ble_then.32348:
    li      0, $i4                      # |     12,429 |     12,429 |
.count b_cont
    b       ble_cont.32348              # |     12,429 |     12,429 |
ble_else.32348:
    li      1, $i4                      # |      6,714 |      6,714 |
ble_cont.32348:
    bne     $i1, 0, be_else.32349       # |     19,143 |     19,143 |
be_then.32349:
    mov     $i4, $i1                    # |     19,143 |     19,143 |
.count b_cont
    b       be_cont.32349               # |     19,143 |     19,143 |
be_else.32349:
    bne     $i4, 0, be_else.32350
be_then.32350:
    li      1, $i1
.count b_cont
    b       be_cont.32350
be_else.32350:
    li      0, $i1
be_cont.32350:
be_cont.32349:
    load    [$i3 + 2], $f7              # |     19,143 |     19,143 |
    bne     $i1, 0, be_cont.32351       # |     19,143 |     19,143 |
be_then.32351:
    fneg    $f7, $f7                    # |     12,429 |     12,429 |
be_cont.32351:
    fsub    $f7, $f3, $f3               # |     19,143 |     19,143 |
    finv    $f4, $f4                    # |     19,143 |     19,143 |
    fmul    $f3, $f4, $f3               # |     19,143 |     19,143 |
    fmul    $f3, $f6, $f4               # |     19,143 |     19,143 |
    fadd_a  $f4, $f1, $f1               # |     19,143 |     19,143 |
    bg      $f5, $f1, ble_else.32352    # |     19,143 |     19,143 |
ble_then.32352:
    li      0, $i1                      # |     15,261 |     15,261 |
    ret                                 # |     15,261 |     15,261 |
ble_else.32352:
    load    [$i3 + 1], $f1              # |      3,882 |      3,882 |
    load    [$i2 + 1], $f4              # |      3,882 |      3,882 |
    fmul    $f3, $f4, $f4               # |      3,882 |      3,882 |
    fadd_a  $f4, $f2, $f2               # |      3,882 |      3,882 |
    bg      $f1, $f2, ble_else.32353    # |      3,882 |      3,882 |
ble_then.32353:
    li      0, $i1                      # |      1,717 |      1,717 |
    ret                                 # |      1,717 |      1,717 |
ble_else.32353:
    mov     $f3, $fg0                   # |      2,165 |      2,165 |
    li      3, $i1                      # |      2,165 |      2,165 |
    ret                                 # |      2,165 |      2,165 |
be_else.32346:
    li      2, $i1                      # |        944 |        944 |
    ret                                 # |        944 |        944 |
be_else.32338:
    li      1, $i1                      # |      3,667 |      3,667 |
    ret                                 # |      3,667 |      3,667 |
be_else.32330:
    bne     $i6, 2, be_else.32354
be_then.32354:
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
    bg      $f4, $f0, ble_else.32355
ble_then.32355:
    li      0, $i1
    ret
ble_else.32355:
    fmul    $f5, $f1, $f1
    fmul    $f7, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f8, $f3, $f2
    fadd_n  $f1, $f2, $f1
    finv    $f4, $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.32354:
    load    [$i1 + 4], $i3
    load    [$i1 + 4], $i4
    load    [$i1 + 4], $i5
    load    [$i1 + 3], $i7
    load    [$i2 + 1], $f5
    load    [$i2 + 2], $f6
    fmul    $f4, $f4, $f7
    load    [$i3 + 0], $f8
    fmul    $f7, $f8, $f7
    fmul    $f5, $f5, $f9
    load    [$i4 + 1], $f10
    fmul    $f9, $f10, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f6, $f9
    load    [$i5 + 2], $f11
    fmul    $f9, $f11, $f9
    fadd    $f7, $f9, $f7
    be      $i7, 0, bne_cont.32356
bne_then.32356:
    fmul    $f5, $f6, $f9
    load    [$i1 + 9], $i2
    load    [$i2 + 0], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f4, $f9
    load    [$i1 + 9], $i2
    load    [$i2 + 1], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f4, $f5, $f9
    load    [$i1 + 9], $i2
    load    [$i2 + 2], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
bne_cont.32356:
    bne     $f7, $f0, be_else.32357
be_then.32357:
    li      0, $i1
    ret
be_else.32357:
    load    [$i1 + 3], $i2
    load    [$i1 + 3], $i3
    fmul    $f4, $f1, $f9
    fmul    $f9, $f8, $f9
    fmul    $f5, $f2, $f12
    fmul    $f12, $f10, $f12
    fadd    $f9, $f12, $f9
    fmul    $f6, $f3, $f12
    fmul    $f12, $f11, $f12
    fadd    $f9, $f12, $f9
    bne     $i2, 0, be_else.32358
be_then.32358:
    mov     $f9, $f4
.count b_cont
    b       be_cont.32358
be_else.32358:
    fmul    $f6, $f2, $f12
    fmul    $f5, $f3, $f13
    fadd    $f12, $f13, $f12
    load    [$i1 + 9], $i2
    load    [$i2 + 0], $f13
    fmul    $f12, $f13, $f12
    fmul    $f4, $f3, $f13
    fmul    $f6, $f1, $f6
    fadd    $f13, $f6, $f6
    load    [$i1 + 9], $i2
    load    [$i2 + 1], $f13
    fmul    $f6, $f13, $f6
    fadd    $f12, $f6, $f6
    fmul    $f4, $f2, $f4
    fmul    $f5, $f1, $f5
    fadd    $f4, $f5, $f4
    load    [$i1 + 9], $i2
    load    [$i2 + 2], $f5
    fmul    $f4, $f5, $f4
    fadd    $f6, $f4, $f4
    fmul    $f4, $fc3, $f4
    fadd    $f9, $f4, $f4
be_cont.32358:
    fmul    $f4, $f4, $f5
    fmul    $f1, $f1, $f6
    fmul    $f6, $f8, $f6
    fmul    $f2, $f2, $f8
    fmul    $f8, $f10, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f3, $f8
    fmul    $f8, $f11, $f8
    fadd    $f6, $f8, $f6
    bne     $i3, 0, be_else.32359
be_then.32359:
    mov     $f6, $f1
.count b_cont
    b       be_cont.32359
be_else.32359:
    fmul    $f2, $f3, $f8
    load    [$i1 + 9], $i2
    load    [$i2 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f1, $f3
    load    [$i1 + 9], $i2
    load    [$i2 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f6, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i1 + 9], $i2
    load    [$i2 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.32359:
    bne     $i6, 3, be_cont.32360
be_then.32360:
    fsub    $f1, $fc0, $f1
be_cont.32360:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    bg      $f1, $f0, ble_else.32361
ble_then.32361:
    li      0, $i1
    ret
ble_else.32361:
    load    [$i1 + 6], $i1
    fsqrt   $f1, $f1
    finv    $f7, $f2
    bne     $i1, 0, be_else.32362
be_then.32362:
    fneg    $f1, $f1
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.32362:
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin solver_fast
solver_fast.2796:
    load    [ext_objects + $i1], $i2    # |    660,661 |    660,661 |
    load    [$i2 + 5], $i3              # |    660,661 |    660,661 |
    load    [$i2 + 5], $i4              # |    660,661 |    660,661 |
    load    [$i2 + 5], $i5              # |    660,661 |    660,661 |
    load    [ext_light_dirvec + 1], $i6 # |    660,661 |    660,661 |
    load    [$i2 + 1], $i7              # |    660,661 |    660,661 |
    load    [ext_intersection_point + 0], $f1# |    660,661 |    660,661 |
    load    [$i3 + 0], $f2              # |    660,661 |    660,661 |
    load    [ext_intersection_point + 1], $f3# |    660,661 |    660,661 |
    load    [$i4 + 1], $f4              # |    660,661 |    660,661 |
    load    [ext_intersection_point + 2], $f5# |    660,661 |    660,661 |
    load    [$i5 + 2], $f6              # |    660,661 |    660,661 |
    fsub    $f1, $f2, $f1               # |    660,661 |    660,661 |
    fsub    $f3, $f4, $f2               # |    660,661 |    660,661 |
    fsub    $f5, $f6, $f3               # |    660,661 |    660,661 |
    load    [$i6 + $i1], $i1            # |    660,661 |    660,661 |
    bne     $i7, 1, be_else.32363       # |    660,661 |    660,661 |
be_then.32363:
    load    [ext_light_dirvec + 0], $i3 # |    660,661 |    660,661 |
    load    [$i2 + 4], $i4              # |    660,661 |    660,661 |
    load    [$i4 + 1], $f4              # |    660,661 |    660,661 |
    load    [$i3 + 1], $f5              # |    660,661 |    660,661 |
    load    [$i1 + 0], $f6              # |    660,661 |    660,661 |
    fsub    $f6, $f1, $f6               # |    660,661 |    660,661 |
    load    [$i1 + 1], $f7              # |    660,661 |    660,661 |
    fmul    $f6, $f7, $f6               # |    660,661 |    660,661 |
    fmul    $f6, $f5, $f5               # |    660,661 |    660,661 |
    fadd_a  $f5, $f2, $f5               # |    660,661 |    660,661 |
    bg      $f4, $f5, ble_else.32364    # |    660,661 |    660,661 |
ble_then.32364:
    li      0, $i4                      # |    437,614 |    437,614 |
.count b_cont
    b       ble_cont.32364              # |    437,614 |    437,614 |
ble_else.32364:
    load    [$i2 + 4], $i4              # |    223,047 |    223,047 |
    load    [$i4 + 2], $f5              # |    223,047 |    223,047 |
    load    [$i3 + 2], $f7              # |    223,047 |    223,047 |
    fmul    $f6, $f7, $f7               # |    223,047 |    223,047 |
    fadd_a  $f7, $f3, $f7               # |    223,047 |    223,047 |
    bg      $f5, $f7, ble_else.32365    # |    223,047 |    223,047 |
ble_then.32365:
    li      0, $i4                      # |     76,254 |     76,254 |
.count b_cont
    b       ble_cont.32365              # |     76,254 |     76,254 |
ble_else.32365:
    load    [$i1 + 1], $f5              # |    146,793 |    146,793 |
    bne     $f5, $f0, be_else.32366     # |    146,793 |    146,793 |
be_then.32366:
    li      0, $i4
.count b_cont
    b       be_cont.32366
be_else.32366:
    li      1, $i4                      # |    146,793 |    146,793 |
be_cont.32366:
ble_cont.32365:
ble_cont.32364:
    bne     $i4, 0, be_else.32367       # |    660,661 |    660,661 |
be_then.32367:
    load    [$i2 + 4], $i4              # |    513,868 |    513,868 |
    load    [$i4 + 0], $f5              # |    513,868 |    513,868 |
    load    [$i3 + 0], $f6              # |    513,868 |    513,868 |
    load    [$i1 + 2], $f7              # |    513,868 |    513,868 |
    fsub    $f7, $f2, $f7               # |    513,868 |    513,868 |
    load    [$i1 + 3], $f8              # |    513,868 |    513,868 |
    fmul    $f7, $f8, $f7               # |    513,868 |    513,868 |
    fmul    $f7, $f6, $f6               # |    513,868 |    513,868 |
    fadd_a  $f6, $f1, $f6               # |    513,868 |    513,868 |
    bg      $f5, $f6, ble_else.32368    # |    513,868 |    513,868 |
ble_then.32368:
    li      0, $i2                      # |    438,844 |    438,844 |
.count b_cont
    b       ble_cont.32368              # |    438,844 |    438,844 |
ble_else.32368:
    load    [$i2 + 4], $i2              # |     75,024 |     75,024 |
    load    [$i2 + 2], $f6              # |     75,024 |     75,024 |
    load    [$i3 + 2], $f8              # |     75,024 |     75,024 |
    fmul    $f7, $f8, $f8               # |     75,024 |     75,024 |
    fadd_a  $f8, $f3, $f8               # |     75,024 |     75,024 |
    bg      $f6, $f8, ble_else.32369    # |     75,024 |     75,024 |
ble_then.32369:
    li      0, $i2                      # |     40,191 |     40,191 |
.count b_cont
    b       ble_cont.32369              # |     40,191 |     40,191 |
ble_else.32369:
    load    [$i1 + 3], $f6              # |     34,833 |     34,833 |
    bne     $f6, $f0, be_else.32370     # |     34,833 |     34,833 |
be_then.32370:
    li      0, $i2
.count b_cont
    b       be_cont.32370
be_else.32370:
    li      1, $i2                      # |     34,833 |     34,833 |
be_cont.32370:
ble_cont.32369:
ble_cont.32368:
    bne     $i2, 0, be_else.32371       # |    513,868 |    513,868 |
be_then.32371:
    load    [$i3 + 0], $f6              # |    479,035 |    479,035 |
    load    [$i1 + 4], $f7              # |    479,035 |    479,035 |
    fsub    $f7, $f3, $f3               # |    479,035 |    479,035 |
    load    [$i1 + 5], $f7              # |    479,035 |    479,035 |
    fmul    $f3, $f7, $f3               # |    479,035 |    479,035 |
    fmul    $f3, $f6, $f6               # |    479,035 |    479,035 |
    fadd_a  $f6, $f1, $f1               # |    479,035 |    479,035 |
    bg      $f5, $f1, ble_else.32372    # |    479,035 |    479,035 |
ble_then.32372:
    li      0, $i1                      # |    447,036 |    447,036 |
    ret                                 # |    447,036 |    447,036 |
ble_else.32372:
    load    [$i3 + 1], $f1              # |     31,999 |     31,999 |
    fmul    $f3, $f1, $f1               # |     31,999 |     31,999 |
    fadd_a  $f1, $f2, $f1               # |     31,999 |     31,999 |
    bg      $f4, $f1, ble_else.32373    # |     31,999 |     31,999 |
ble_then.32373:
    li      0, $i1                      # |      7,652 |      7,652 |
    ret                                 # |      7,652 |      7,652 |
ble_else.32373:
    load    [$i1 + 5], $f1              # |     24,347 |     24,347 |
    bne     $f1, $f0, be_else.32374     # |     24,347 |     24,347 |
be_then.32374:
    li      0, $i1
    ret
be_else.32374:
    mov     $f3, $fg0                   # |     24,347 |     24,347 |
    li      3, $i1                      # |     24,347 |     24,347 |
    ret                                 # |     24,347 |     24,347 |
be_else.32371:
    mov     $f7, $fg0                   # |     34,833 |     34,833 |
    li      2, $i1                      # |     34,833 |     34,833 |
    ret                                 # |     34,833 |     34,833 |
be_else.32367:
    mov     $f6, $fg0                   # |    146,793 |    146,793 |
    li      1, $i1                      # |    146,793 |    146,793 |
    ret                                 # |    146,793 |    146,793 |
be_else.32363:
    load    [$i1 + 0], $f4
    bne     $i7, 2, be_else.32375
be_then.32375:
    bg      $f0, $f4, ble_else.32376
ble_then.32376:
    li      0, $i1
    ret
ble_else.32376:
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
be_else.32375:
    bne     $f4, $f0, be_else.32377
be_then.32377:
    li      0, $i1
    ret
be_else.32377:
    load    [$i2 + 4], $i3
    load    [$i2 + 4], $i4
    load    [$i2 + 4], $i5
    load    [$i2 + 3], $i6
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
    load    [$i4 + 1], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f3, $f8
    load    [$i5 + 2], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    bne     $i6, 0, be_else.32378
be_then.32378:
    mov     $f7, $f1
.count b_cont
    b       be_cont.32378
be_else.32378:
    fmul    $f2, $f3, $f8
    load    [$i2 + 9], $i3
    load    [$i3 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i2 + 9], $i3
    load    [$i3 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i2 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.32378:
    bne     $i7, 3, be_cont.32379
be_then.32379:
    fsub    $f1, $fc0, $f1
be_cont.32379:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    bg      $f1, $f0, ble_else.32380
ble_then.32380:
    li      0, $i1
    ret
ble_else.32380:
    load    [$i2 + 6], $i2
    load    [$i1 + 4], $f2
    li      1, $i1
    fsqrt   $f1, $f1
    bne     $i2, 0, be_else.32381
be_then.32381:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ret
be_else.32381:
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
    bne     $i6, 1, be_else.32382       # |  1,134,616 |  1,134,616 |
be_then.32382:
    load    [$i2 + 0], $i2              # |  1,134,616 |  1,134,616 |
    load    [$i3 + 4], $i4              # |  1,134,616 |  1,134,616 |
    load    [$i4 + 1], $f4              # |  1,134,616 |  1,134,616 |
    load    [$i2 + 1], $f5              # |  1,134,616 |  1,134,616 |
    load    [$i1 + 0], $f6              # |  1,134,616 |  1,134,616 |
    fsub    $f6, $f1, $f6               # |  1,134,616 |  1,134,616 |
    load    [$i1 + 1], $f7              # |  1,134,616 |  1,134,616 |
    fmul    $f6, $f7, $f6               # |  1,134,616 |  1,134,616 |
    fmul    $f6, $f5, $f5               # |  1,134,616 |  1,134,616 |
    fadd_a  $f5, $f2, $f5               # |  1,134,616 |  1,134,616 |
    bg      $f4, $f5, ble_else.32383    # |  1,134,616 |  1,134,616 |
ble_then.32383:
    li      0, $i4                      # |    640,191 |    640,191 |
.count b_cont
    b       ble_cont.32383              # |    640,191 |    640,191 |
ble_else.32383:
    load    [$i3 + 4], $i4              # |    494,425 |    494,425 |
    load    [$i4 + 2], $f5              # |    494,425 |    494,425 |
    load    [$i2 + 2], $f7              # |    494,425 |    494,425 |
    fmul    $f6, $f7, $f7               # |    494,425 |    494,425 |
    fadd_a  $f7, $f3, $f7               # |    494,425 |    494,425 |
    bg      $f5, $f7, ble_else.32384    # |    494,425 |    494,425 |
ble_then.32384:
    li      0, $i4                      # |    164,419 |    164,419 |
.count b_cont
    b       ble_cont.32384              # |    164,419 |    164,419 |
ble_else.32384:
    load    [$i1 + 1], $f5              # |    330,006 |    330,006 |
    bne     $f5, $f0, be_else.32385     # |    330,006 |    330,006 |
be_then.32385:
    li      0, $i4
.count b_cont
    b       be_cont.32385
be_else.32385:
    li      1, $i4                      # |    330,006 |    330,006 |
be_cont.32385:
ble_cont.32384:
ble_cont.32383:
    bne     $i4, 0, be_else.32386       # |  1,134,616 |  1,134,616 |
be_then.32386:
    load    [$i3 + 4], $i4              # |    804,610 |    804,610 |
    load    [$i4 + 0], $f5              # |    804,610 |    804,610 |
    load    [$i2 + 0], $f6              # |    804,610 |    804,610 |
    load    [$i1 + 2], $f7              # |    804,610 |    804,610 |
    fsub    $f7, $f2, $f7               # |    804,610 |    804,610 |
    load    [$i1 + 3], $f8              # |    804,610 |    804,610 |
    fmul    $f7, $f8, $f7               # |    804,610 |    804,610 |
    fmul    $f7, $f6, $f6               # |    804,610 |    804,610 |
    fadd_a  $f6, $f1, $f6               # |    804,610 |    804,610 |
    bg      $f5, $f6, ble_else.32387    # |    804,610 |    804,610 |
ble_then.32387:
    li      0, $i3                      # |    453,618 |    453,618 |
.count b_cont
    b       ble_cont.32387              # |    453,618 |    453,618 |
ble_else.32387:
    load    [$i3 + 4], $i3              # |    350,992 |    350,992 |
    load    [$i3 + 2], $f6              # |    350,992 |    350,992 |
    load    [$i2 + 2], $f8              # |    350,992 |    350,992 |
    fmul    $f7, $f8, $f8               # |    350,992 |    350,992 |
    fadd_a  $f8, $f3, $f8               # |    350,992 |    350,992 |
    bg      $f6, $f8, ble_else.32388    # |    350,992 |    350,992 |
ble_then.32388:
    li      0, $i3                      # |    123,643 |    123,643 |
.count b_cont
    b       ble_cont.32388              # |    123,643 |    123,643 |
ble_else.32388:
    load    [$i1 + 3], $f6              # |    227,349 |    227,349 |
    bne     $f6, $f0, be_else.32389     # |    227,349 |    227,349 |
be_then.32389:
    li      0, $i3
.count b_cont
    b       be_cont.32389
be_else.32389:
    li      1, $i3                      # |    227,349 |    227,349 |
be_cont.32389:
ble_cont.32388:
ble_cont.32387:
    bne     $i3, 0, be_else.32390       # |    804,610 |    804,610 |
be_then.32390:
    load    [$i2 + 0], $f6              # |    577,261 |    577,261 |
    load    [$i1 + 4], $f7              # |    577,261 |    577,261 |
    fsub    $f7, $f3, $f3               # |    577,261 |    577,261 |
    load    [$i1 + 5], $f7              # |    577,261 |    577,261 |
    fmul    $f3, $f7, $f3               # |    577,261 |    577,261 |
    fmul    $f3, $f6, $f6               # |    577,261 |    577,261 |
    fadd_a  $f6, $f1, $f1               # |    577,261 |    577,261 |
    bg      $f5, $f1, ble_else.32391    # |    577,261 |    577,261 |
ble_then.32391:
    li      0, $i1                      # |    412,314 |    412,314 |
    ret                                 # |    412,314 |    412,314 |
ble_else.32391:
    load    [$i2 + 1], $f1              # |    164,947 |    164,947 |
    fmul    $f3, $f1, $f1               # |    164,947 |    164,947 |
    fadd_a  $f1, $f2, $f1               # |    164,947 |    164,947 |
    bg      $f4, $f1, ble_else.32392    # |    164,947 |    164,947 |
ble_then.32392:
    li      0, $i1                      # |     37,478 |     37,478 |
    ret                                 # |     37,478 |     37,478 |
ble_else.32392:
    load    [$i1 + 5], $f1              # |    127,469 |    127,469 |
    bne     $f1, $f0, be_else.32393     # |    127,469 |    127,469 |
be_then.32393:
    li      0, $i1
    ret
be_else.32393:
    mov     $f3, $fg0                   # |    127,469 |    127,469 |
    li      3, $i1                      # |    127,469 |    127,469 |
    ret                                 # |    127,469 |    127,469 |
be_else.32390:
    mov     $f7, $fg0                   # |    227,349 |    227,349 |
    li      2, $i1                      # |    227,349 |    227,349 |
    ret                                 # |    227,349 |    227,349 |
be_else.32386:
    mov     $f6, $fg0                   # |    330,006 |    330,006 |
    li      1, $i1                      # |    330,006 |    330,006 |
    ret                                 # |    330,006 |    330,006 |
be_else.32382:
    bne     $i6, 2, be_else.32394
be_then.32394:
    load    [$i1 + 0], $f1
    bg      $f0, $f1, ble_else.32395
ble_then.32395:
    li      0, $i1
    ret
ble_else.32395:
    load    [$i4 + 3], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.32394:
    load    [$i1 + 0], $f4
    bne     $f4, $f0, be_else.32396
be_then.32396:
    li      0, $i1
    ret
be_else.32396:
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
    bg      $f2, $f0, ble_else.32397
ble_then.32397:
    li      0, $i1
    ret
ble_else.32397:
    load    [$i3 + 6], $i2
    fsqrt   $f2, $f2
    bne     $i2, 0, be_else.32398
be_then.32398:
    fsub    $f1, $f2, $f1
    load    [$i1 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.32398:
    fadd    $f1, $f2, $f1
    load    [$i1 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
.end solver_fast2

######################################################################
# iter_setup_dirvec_constants($i4, $i5)
# $ra = $ra1
# [$i1 - $i10]
# [$f1 - $f8]
# []
# []
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
    bl      $i5, 0, bge_else.32399      # |      7,375 |      7,375 |
bge_then.32399:
    load    [$i4 + 1], $i6              # |      7,375 |      7,375 |
    load    [ext_objects + $i5], $i7    # |      7,375 |      7,375 |
    load    [$i7 + 1], $i1              # |      7,375 |      7,375 |
    load    [$i4 + 0], $i8              # |      7,375 |      7,375 |
.count move_args
    mov     $f0, $f2                    # |      7,375 |      7,375 |
    bne     $i1, 1, be_else.32400       # |      7,375 |      7,375 |
be_then.32400:
    li      6, $i2                      # |      3,010 |      3,010 |
    call    ext_create_array_float      # |      3,010 |      3,010 |
    load    [$i8 + 0], $f1              # |      3,010 |      3,010 |
    bne     $f1, $f0, be_else.32401     # |      3,010 |      3,010 |
be_then.32401:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.32401
be_else.32401:
    load    [$i7 + 6], $i2              # |      3,010 |      3,010 |
    bg      $f0, $f1, ble_else.32402    # |      3,010 |      3,010 |
ble_then.32402:
    li      0, $i3                      # |      1,505 |      1,505 |
.count b_cont
    b       ble_cont.32402              # |      1,505 |      1,505 |
ble_else.32402:
    li      1, $i3                      # |      1,505 |      1,505 |
ble_cont.32402:
    bne     $i2, 0, be_else.32403       # |      3,010 |      3,010 |
be_then.32403:
    mov     $i3, $i2                    # |      3,010 |      3,010 |
.count b_cont
    b       be_cont.32403               # |      3,010 |      3,010 |
be_else.32403:
    bne     $i3, 0, be_else.32404
be_then.32404:
    li      1, $i2
.count b_cont
    b       be_cont.32404
be_else.32404:
    li      0, $i2
be_cont.32404:
be_cont.32403:
    load    [$i7 + 4], $i3              # |      3,010 |      3,010 |
    load    [$i3 + 0], $f1              # |      3,010 |      3,010 |
    bne     $i2, 0, be_else.32405       # |      3,010 |      3,010 |
be_then.32405:
    fneg    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i1 + 0]              # |      1,505 |      1,505 |
    load    [$i8 + 0], $f1              # |      1,505 |      1,505 |
    finv    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i1 + 1]              # |      1,505 |      1,505 |
.count b_cont
    b       be_cont.32405               # |      1,505 |      1,505 |
be_else.32405:
    store   $f1, [$i1 + 0]              # |      1,505 |      1,505 |
    load    [$i8 + 0], $f1              # |      1,505 |      1,505 |
    finv    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i1 + 1]              # |      1,505 |      1,505 |
be_cont.32405:
be_cont.32401:
    load    [$i8 + 1], $f1              # |      3,010 |      3,010 |
    bne     $f1, $f0, be_else.32406     # |      3,010 |      3,010 |
be_then.32406:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.32406
be_else.32406:
    load    [$i7 + 6], $i2              # |      3,010 |      3,010 |
    bg      $f0, $f1, ble_else.32407    # |      3,010 |      3,010 |
ble_then.32407:
    li      0, $i3                      # |      1,505 |      1,505 |
.count b_cont
    b       ble_cont.32407              # |      1,505 |      1,505 |
ble_else.32407:
    li      1, $i3                      # |      1,505 |      1,505 |
ble_cont.32407:
    bne     $i2, 0, be_else.32408       # |      3,010 |      3,010 |
be_then.32408:
    mov     $i3, $i2                    # |      3,010 |      3,010 |
.count b_cont
    b       be_cont.32408               # |      3,010 |      3,010 |
be_else.32408:
    bne     $i3, 0, be_else.32409
be_then.32409:
    li      1, $i2
.count b_cont
    b       be_cont.32409
be_else.32409:
    li      0, $i2
be_cont.32409:
be_cont.32408:
    load    [$i7 + 4], $i3              # |      3,010 |      3,010 |
    load    [$i3 + 1], $f1              # |      3,010 |      3,010 |
    bne     $i2, 0, be_else.32410       # |      3,010 |      3,010 |
be_then.32410:
    fneg    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i1 + 2]              # |      1,505 |      1,505 |
    load    [$i8 + 1], $f1              # |      1,505 |      1,505 |
    finv    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i1 + 3]              # |      1,505 |      1,505 |
.count b_cont
    b       be_cont.32410               # |      1,505 |      1,505 |
be_else.32410:
    store   $f1, [$i1 + 2]              # |      1,505 |      1,505 |
    load    [$i8 + 1], $f1              # |      1,505 |      1,505 |
    finv    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i1 + 3]              # |      1,505 |      1,505 |
be_cont.32410:
be_cont.32406:
    load    [$i8 + 2], $f1              # |      3,010 |      3,010 |
    bne     $f1, $f0, be_else.32411     # |      3,010 |      3,010 |
be_then.32411:
    store   $f0, [$i1 + 5]
.count b_cont
    b       be_cont.32411
be_else.32411:
    load    [$i7 + 6], $i2              # |      3,010 |      3,010 |
    bg      $f0, $f1, ble_else.32412    # |      3,010 |      3,010 |
ble_then.32412:
    li      0, $i3                      # |      1,510 |      1,510 |
.count b_cont
    b       ble_cont.32412              # |      1,510 |      1,510 |
ble_else.32412:
    li      1, $i3                      # |      1,500 |      1,500 |
ble_cont.32412:
    bne     $i2, 0, be_else.32413       # |      3,010 |      3,010 |
be_then.32413:
    mov     $i3, $i2                    # |      3,010 |      3,010 |
.count b_cont
    b       be_cont.32413               # |      3,010 |      3,010 |
be_else.32413:
    bne     $i3, 0, be_else.32414
be_then.32414:
    li      1, $i2
.count b_cont
    b       be_cont.32414
be_else.32414:
    li      0, $i2
be_cont.32414:
be_cont.32413:
    load    [$i7 + 4], $i3              # |      3,010 |      3,010 |
    load    [$i3 + 2], $f1              # |      3,010 |      3,010 |
    bne     $i2, 0, be_else.32415       # |      3,010 |      3,010 |
be_then.32415:
    fneg    $f1, $f1                    # |      1,510 |      1,510 |
    store   $f1, [$i1 + 4]              # |      1,510 |      1,510 |
    load    [$i8 + 2], $f1              # |      1,510 |      1,510 |
    finv    $f1, $f1                    # |      1,510 |      1,510 |
    store   $f1, [$i1 + 5]              # |      1,510 |      1,510 |
.count b_cont
    b       be_cont.32415               # |      1,510 |      1,510 |
be_else.32415:
    store   $f1, [$i1 + 4]              # |      1,500 |      1,500 |
    load    [$i8 + 2], $f1              # |      1,500 |      1,500 |
    finv    $f1, $f1                    # |      1,500 |      1,500 |
    store   $f1, [$i1 + 5]              # |      1,500 |      1,500 |
be_cont.32415:
be_cont.32411:
.count storer
    add     $i6, $i5, $tmp              # |      3,010 |      3,010 |
    store   $i1, [$tmp + 0]             # |      3,010 |      3,010 |
    sub     $i5, 1, $i5                 # |      3,010 |      3,010 |
    bl      $i5, 0, bge_else.32416      # |      3,010 |      3,010 |
bge_then.32416:
    load    [ext_objects + $i5], $i7    # |      2,408 |      2,408 |
    load    [$i7 + 1], $i1              # |      2,408 |      2,408 |
.count move_args
    mov     $f0, $f2                    # |      2,408 |      2,408 |
    bne     $i1, 1, be_else.32417       # |      2,408 |      2,408 |
be_then.32417:
    li      6, $i2                      # |        602 |        602 |
    call    ext_create_array_float      # |        602 |        602 |
    load    [$i8 + 0], $f1              # |        602 |        602 |
    bne     $f1, $f0, be_else.32418     # |        602 |        602 |
be_then.32418:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.32418
be_else.32418:
    load    [$i7 + 6], $i2              # |        602 |        602 |
    bg      $f0, $f1, ble_else.32419    # |        602 |        602 |
ble_then.32419:
    li      0, $i3                      # |        301 |        301 |
.count b_cont
    b       ble_cont.32419              # |        301 |        301 |
ble_else.32419:
    li      1, $i3                      # |        301 |        301 |
ble_cont.32419:
    bne     $i2, 0, be_else.32420       # |        602 |        602 |
be_then.32420:
    mov     $i3, $i2                    # |        602 |        602 |
.count b_cont
    b       be_cont.32420               # |        602 |        602 |
be_else.32420:
    bne     $i3, 0, be_else.32421
be_then.32421:
    li      1, $i2
.count b_cont
    b       be_cont.32421
be_else.32421:
    li      0, $i2
be_cont.32421:
be_cont.32420:
    load    [$i7 + 4], $i3              # |        602 |        602 |
    load    [$i3 + 0], $f1              # |        602 |        602 |
    bne     $i2, 0, be_else.32422       # |        602 |        602 |
be_then.32422:
    fneg    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 0]              # |        301 |        301 |
    load    [$i8 + 0], $f1              # |        301 |        301 |
    finv    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 1]              # |        301 |        301 |
.count b_cont
    b       be_cont.32422               # |        301 |        301 |
be_else.32422:
    store   $f1, [$i1 + 0]              # |        301 |        301 |
    load    [$i8 + 0], $f1              # |        301 |        301 |
    finv    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 1]              # |        301 |        301 |
be_cont.32422:
be_cont.32418:
    load    [$i8 + 1], $f1              # |        602 |        602 |
    bne     $f1, $f0, be_else.32423     # |        602 |        602 |
be_then.32423:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.32423
be_else.32423:
    load    [$i7 + 6], $i2              # |        602 |        602 |
    bg      $f0, $f1, ble_else.32424    # |        602 |        602 |
ble_then.32424:
    li      0, $i3                      # |        301 |        301 |
.count b_cont
    b       ble_cont.32424              # |        301 |        301 |
ble_else.32424:
    li      1, $i3                      # |        301 |        301 |
ble_cont.32424:
    bne     $i2, 0, be_else.32425       # |        602 |        602 |
be_then.32425:
    mov     $i3, $i2                    # |        602 |        602 |
.count b_cont
    b       be_cont.32425               # |        602 |        602 |
be_else.32425:
    bne     $i3, 0, be_else.32426
be_then.32426:
    li      1, $i2
.count b_cont
    b       be_cont.32426
be_else.32426:
    li      0, $i2
be_cont.32426:
be_cont.32425:
    load    [$i7 + 4], $i3              # |        602 |        602 |
    load    [$i3 + 1], $f1              # |        602 |        602 |
    bne     $i2, 0, be_else.32427       # |        602 |        602 |
be_then.32427:
    fneg    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 2]              # |        301 |        301 |
    load    [$i8 + 1], $f1              # |        301 |        301 |
    finv    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 3]              # |        301 |        301 |
.count b_cont
    b       be_cont.32427               # |        301 |        301 |
be_else.32427:
    store   $f1, [$i1 + 2]              # |        301 |        301 |
    load    [$i8 + 1], $f1              # |        301 |        301 |
    finv    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 3]              # |        301 |        301 |
be_cont.32427:
be_cont.32423:
    load    [$i8 + 2], $f1              # |        602 |        602 |
    bne     $f1, $f0, be_else.32428     # |        602 |        602 |
be_then.32428:
    store   $f0, [$i1 + 5]
.count storer
    add     $i6, $i5, $tmp
    store   $i1, [$tmp + 0]
    sub     $i5, 1, $i5
    b       iter_setup_dirvec_constants.2826
be_else.32428:
    load    [$i7 + 6], $i2              # |        602 |        602 |
    load    [$i7 + 4], $i3              # |        602 |        602 |
    bg      $f0, $f1, ble_else.32429    # |        602 |        602 |
ble_then.32429:
    li      0, $i7                      # |        302 |        302 |
.count b_cont
    b       ble_cont.32429              # |        302 |        302 |
ble_else.32429:
    li      1, $i7                      # |        300 |        300 |
ble_cont.32429:
    bne     $i2, 0, be_else.32430       # |        602 |        602 |
be_then.32430:
    mov     $i7, $i2                    # |        602 |        602 |
.count b_cont
    b       be_cont.32430               # |        602 |        602 |
be_else.32430:
    bne     $i7, 0, be_else.32431
be_then.32431:
    li      1, $i2
.count b_cont
    b       be_cont.32431
be_else.32431:
    li      0, $i2
be_cont.32431:
be_cont.32430:
    load    [$i3 + 2], $f1              # |        602 |        602 |
    bne     $i2, 0, be_cont.32432       # |        602 |        602 |
be_then.32432:
    fneg    $f1, $f1                    # |        302 |        302 |
be_cont.32432:
    store   $f1, [$i1 + 4]              # |        602 |        602 |
    load    [$i8 + 2], $f1              # |        602 |        602 |
    finv    $f1, $f1                    # |        602 |        602 |
    store   $f1, [$i1 + 5]              # |        602 |        602 |
.count storer
    add     $i6, $i5, $tmp              # |        602 |        602 |
    store   $i1, [$tmp + 0]             # |        602 |        602 |
    sub     $i5, 1, $i5                 # |        602 |        602 |
    b       iter_setup_dirvec_constants.2826# |        602 |        602 |
be_else.32417:
    bne     $i1, 2, be_else.32433       # |      1,806 |      1,806 |
be_then.32433:
    li      4, $i2                      # |        602 |        602 |
    call    ext_create_array_float      # |        602 |        602 |
    load    [$i7 + 4], $i2              # |        602 |        602 |
    load    [$i7 + 4], $i3              # |        602 |        602 |
    load    [$i7 + 4], $i9              # |        602 |        602 |
    load    [$i8 + 0], $f1              # |        602 |        602 |
    load    [$i2 + 0], $f2              # |        602 |        602 |
    fmul    $f1, $f2, $f1               # |        602 |        602 |
    load    [$i8 + 1], $f2              # |        602 |        602 |
    load    [$i3 + 1], $f3              # |        602 |        602 |
    fmul    $f2, $f3, $f2               # |        602 |        602 |
    fadd    $f1, $f2, $f1               # |        602 |        602 |
    load    [$i8 + 2], $f2              # |        602 |        602 |
    load    [$i9 + 2], $f3              # |        602 |        602 |
    fmul    $f2, $f3, $f2               # |        602 |        602 |
    fadd    $f1, $f2, $f1               # |        602 |        602 |
.count storer
    add     $i6, $i5, $tmp              # |        602 |        602 |
    sub     $i5, 1, $i5                 # |        602 |        602 |
    bg      $f1, $f0, ble_else.32434    # |        602 |        602 |
ble_then.32434:
    store   $f0, [$i1 + 0]              # |        301 |        301 |
    store   $i1, [$tmp + 0]             # |        301 |        301 |
    b       iter_setup_dirvec_constants.2826# |        301 |        301 |
ble_else.32434:
    finv    $f1, $f1                    # |        301 |        301 |
    fneg    $f1, $f2                    # |        301 |        301 |
    store   $f2, [$i1 + 0]              # |        301 |        301 |
    load    [$i7 + 4], $i2              # |        301 |        301 |
    load    [$i2 + 0], $f2              # |        301 |        301 |
    fmul_n  $f2, $f1, $f2               # |        301 |        301 |
    store   $f2, [$i1 + 1]              # |        301 |        301 |
    load    [$i7 + 4], $i2              # |        301 |        301 |
    load    [$i2 + 1], $f2              # |        301 |        301 |
    fmul_n  $f2, $f1, $f2               # |        301 |        301 |
    store   $f2, [$i1 + 2]              # |        301 |        301 |
    load    [$i7 + 4], $i2              # |        301 |        301 |
    load    [$i2 + 2], $f2              # |        301 |        301 |
    fmul_n  $f2, $f1, $f1               # |        301 |        301 |
    store   $f1, [$i1 + 3]              # |        301 |        301 |
    store   $i1, [$tmp + 0]             # |        301 |        301 |
    b       iter_setup_dirvec_constants.2826# |        301 |        301 |
be_else.32433:
    li      5, $i2                      # |      1,204 |      1,204 |
    call    ext_create_array_float      # |      1,204 |      1,204 |
    load    [$i7 + 3], $i2              # |      1,204 |      1,204 |
    load    [$i7 + 4], $i3              # |      1,204 |      1,204 |
    load    [$i7 + 4], $i9              # |      1,204 |      1,204 |
    load    [$i7 + 4], $i10             # |      1,204 |      1,204 |
    load    [$i8 + 0], $f1              # |      1,204 |      1,204 |
    load    [$i8 + 1], $f2              # |      1,204 |      1,204 |
    load    [$i8 + 2], $f3              # |      1,204 |      1,204 |
    fmul    $f1, $f1, $f4               # |      1,204 |      1,204 |
    load    [$i3 + 0], $f5              # |      1,204 |      1,204 |
    fmul    $f4, $f5, $f4               # |      1,204 |      1,204 |
    fmul    $f2, $f2, $f5               # |      1,204 |      1,204 |
    load    [$i9 + 1], $f6              # |      1,204 |      1,204 |
    fmul    $f5, $f6, $f5               # |      1,204 |      1,204 |
    fadd    $f4, $f5, $f4               # |      1,204 |      1,204 |
    fmul    $f3, $f3, $f5               # |      1,204 |      1,204 |
    load    [$i10 + 2], $f6             # |      1,204 |      1,204 |
    fmul    $f5, $f6, $f5               # |      1,204 |      1,204 |
    fadd    $f4, $f5, $f4               # |      1,204 |      1,204 |
    bne     $i2, 0, be_else.32435       # |      1,204 |      1,204 |
be_then.32435:
    mov     $f4, $f1                    # |      1,204 |      1,204 |
.count b_cont
    b       be_cont.32435               # |      1,204 |      1,204 |
be_else.32435:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.32435:
    store   $f1, [$i1 + 0]              # |      1,204 |      1,204 |
    load    [$i7 + 4], $i3              # |      1,204 |      1,204 |
    load    [$i7 + 4], $i9              # |      1,204 |      1,204 |
    load    [$i7 + 4], $i10             # |      1,204 |      1,204 |
    load    [$i8 + 0], $f2              # |      1,204 |      1,204 |
    load    [$i3 + 0], $f3              # |      1,204 |      1,204 |
    fmul    $f2, $f3, $f2               # |      1,204 |      1,204 |
    load    [$i8 + 1], $f3              # |      1,204 |      1,204 |
    load    [$i9 + 1], $f4              # |      1,204 |      1,204 |
    fmul    $f3, $f4, $f4               # |      1,204 |      1,204 |
    load    [$i8 + 2], $f5              # |      1,204 |      1,204 |
    load    [$i10 + 2], $f6             # |      1,204 |      1,204 |
    fmul    $f5, $f6, $f6               # |      1,204 |      1,204 |
    fneg    $f2, $f2                    # |      1,204 |      1,204 |
    fneg    $f4, $f4                    # |      1,204 |      1,204 |
    fneg    $f6, $f6                    # |      1,204 |      1,204 |
.count storer
    add     $i6, $i5, $tmp              # |      1,204 |      1,204 |
    sub     $i5, 1, $i5                 # |      1,204 |      1,204 |
    bne     $i2, 0, be_else.32436       # |      1,204 |      1,204 |
be_then.32436:
    store   $f2, [$i1 + 1]              # |      1,204 |      1,204 |
    store   $f4, [$i1 + 2]              # |      1,204 |      1,204 |
    store   $f6, [$i1 + 3]              # |      1,204 |      1,204 |
    bne     $f1, $f0, be_else.32437     # |      1,204 |      1,204 |
be_then.32437:
    store   $i1, [$tmp + 0]
    b       iter_setup_dirvec_constants.2826
be_else.32437:
    finv    $f1, $f1                    # |      1,204 |      1,204 |
    store   $f1, [$i1 + 4]              # |      1,204 |      1,204 |
    store   $i1, [$tmp + 0]             # |      1,204 |      1,204 |
    b       iter_setup_dirvec_constants.2826# |      1,204 |      1,204 |
be_else.32436:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.32438
be_then.32438:
    store   $i1, [$tmp + 0]
    b       iter_setup_dirvec_constants.2826
be_else.32438:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    b       iter_setup_dirvec_constants.2826
bge_else.32416:
    jr      $ra1                        # |        602 |        602 |
be_else.32400:
    bne     $i1, 2, be_else.32439       # |      4,365 |      4,365 |
be_then.32439:
    li      4, $i2                      # |        151 |        151 |
    call    ext_create_array_float      # |        151 |        151 |
    load    [$i7 + 4], $i2              # |        151 |        151 |
    load    [$i7 + 4], $i3              # |        151 |        151 |
    load    [$i7 + 4], $i9              # |        151 |        151 |
    load    [$i8 + 0], $f1              # |        151 |        151 |
    load    [$i2 + 0], $f2              # |        151 |        151 |
    fmul    $f1, $f2, $f1               # |        151 |        151 |
    load    [$i8 + 1], $f2              # |        151 |        151 |
    load    [$i3 + 1], $f3              # |        151 |        151 |
    fmul    $f2, $f3, $f2               # |        151 |        151 |
    fadd    $f1, $f2, $f1               # |        151 |        151 |
    load    [$i8 + 2], $f2              # |        151 |        151 |
    load    [$i9 + 2], $f3              # |        151 |        151 |
    fmul    $f2, $f3, $f2               # |        151 |        151 |
    fadd    $f1, $f2, $f1               # |        151 |        151 |
.count storer
    add     $i6, $i5, $tmp              # |        151 |        151 |
    sub     $i5, 1, $i5                 # |        151 |        151 |
    bg      $f1, $f0, ble_else.32440    # |        151 |        151 |
ble_then.32440:
    store   $f0, [$i1 + 0]              # |         80 |         80 |
    store   $i1, [$tmp + 0]             # |         80 |         80 |
    b       iter_setup_dirvec_constants.2826# |         80 |         80 |
ble_else.32440:
    finv    $f1, $f1                    # |         71 |         71 |
    fneg    $f1, $f2                    # |         71 |         71 |
    store   $f2, [$i1 + 0]              # |         71 |         71 |
    load    [$i7 + 4], $i2              # |         71 |         71 |
    load    [$i2 + 0], $f2              # |         71 |         71 |
    fmul_n  $f2, $f1, $f2               # |         71 |         71 |
    store   $f2, [$i1 + 1]              # |         71 |         71 |
    load    [$i7 + 4], $i2              # |         71 |         71 |
    load    [$i2 + 1], $f2              # |         71 |         71 |
    fmul_n  $f2, $f1, $f2               # |         71 |         71 |
    store   $f2, [$i1 + 2]              # |         71 |         71 |
    load    [$i7 + 4], $i2              # |         71 |         71 |
    load    [$i2 + 2], $f2              # |         71 |         71 |
    fmul_n  $f2, $f1, $f1               # |         71 |         71 |
    store   $f1, [$i1 + 3]              # |         71 |         71 |
    store   $i1, [$tmp + 0]             # |         71 |         71 |
    b       iter_setup_dirvec_constants.2826# |         71 |         71 |
be_else.32439:
    li      5, $i2                      # |      4,214 |      4,214 |
    call    ext_create_array_float      # |      4,214 |      4,214 |
    load    [$i7 + 3], $i2              # |      4,214 |      4,214 |
    load    [$i7 + 4], $i3              # |      4,214 |      4,214 |
    load    [$i7 + 4], $i9              # |      4,214 |      4,214 |
    load    [$i7 + 4], $i10             # |      4,214 |      4,214 |
    load    [$i8 + 0], $f1              # |      4,214 |      4,214 |
    load    [$i8 + 1], $f2              # |      4,214 |      4,214 |
    load    [$i8 + 2], $f3              # |      4,214 |      4,214 |
    fmul    $f1, $f1, $f4               # |      4,214 |      4,214 |
    load    [$i3 + 0], $f5              # |      4,214 |      4,214 |
    fmul    $f4, $f5, $f4               # |      4,214 |      4,214 |
    fmul    $f2, $f2, $f5               # |      4,214 |      4,214 |
    load    [$i9 + 1], $f6              # |      4,214 |      4,214 |
    fmul    $f5, $f6, $f5               # |      4,214 |      4,214 |
    fadd    $f4, $f5, $f4               # |      4,214 |      4,214 |
    fmul    $f3, $f3, $f5               # |      4,214 |      4,214 |
    load    [$i10 + 2], $f6             # |      4,214 |      4,214 |
    fmul    $f5, $f6, $f5               # |      4,214 |      4,214 |
    fadd    $f4, $f5, $f4               # |      4,214 |      4,214 |
    bne     $i2, 0, be_else.32441       # |      4,214 |      4,214 |
be_then.32441:
    mov     $f4, $f1                    # |      4,214 |      4,214 |
.count b_cont
    b       be_cont.32441               # |      4,214 |      4,214 |
be_else.32441:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.32441:
    store   $f1, [$i1 + 0]              # |      4,214 |      4,214 |
    load    [$i7 + 4], $i3              # |      4,214 |      4,214 |
    load    [$i7 + 4], $i9              # |      4,214 |      4,214 |
    load    [$i7 + 4], $i10             # |      4,214 |      4,214 |
    load    [$i8 + 0], $f2              # |      4,214 |      4,214 |
    load    [$i3 + 0], $f3              # |      4,214 |      4,214 |
    fmul    $f2, $f3, $f2               # |      4,214 |      4,214 |
    load    [$i8 + 1], $f3              # |      4,214 |      4,214 |
    load    [$i9 + 1], $f4              # |      4,214 |      4,214 |
    fmul    $f3, $f4, $f4               # |      4,214 |      4,214 |
    load    [$i8 + 2], $f5              # |      4,214 |      4,214 |
    load    [$i10 + 2], $f6             # |      4,214 |      4,214 |
    fmul    $f5, $f6, $f6               # |      4,214 |      4,214 |
    fneg    $f2, $f2                    # |      4,214 |      4,214 |
    fneg    $f4, $f4                    # |      4,214 |      4,214 |
    fneg    $f6, $f6                    # |      4,214 |      4,214 |
.count storer
    add     $i6, $i5, $tmp              # |      4,214 |      4,214 |
    sub     $i5, 1, $i5                 # |      4,214 |      4,214 |
    bne     $i2, 0, be_else.32442       # |      4,214 |      4,214 |
be_then.32442:
    store   $f2, [$i1 + 1]              # |      4,214 |      4,214 |
    store   $f4, [$i1 + 2]              # |      4,214 |      4,214 |
    store   $f6, [$i1 + 3]              # |      4,214 |      4,214 |
    bne     $f1, $f0, be_else.32443     # |      4,214 |      4,214 |
be_then.32443:
    store   $i1, [$tmp + 0]
    b       iter_setup_dirvec_constants.2826
be_else.32443:
    finv    $f1, $f1                    # |      4,214 |      4,214 |
    store   $f1, [$i1 + 4]              # |      4,214 |      4,214 |
    store   $i1, [$tmp + 0]             # |      4,214 |      4,214 |
    b       iter_setup_dirvec_constants.2826# |      4,214 |      4,214 |
be_else.32442:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.32444
be_then.32444:
    store   $i1, [$tmp + 0]
    b       iter_setup_dirvec_constants.2826
be_else.32444:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    b       iter_setup_dirvec_constants.2826
bge_else.32399:
    jr      $ra1
.end iter_setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1 - $i9]
# [$f1 - $f6]
# []
# []
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
    bl      $i1, 0, bge_else.32445      # |    667,764 |    667,764 |
bge_then.32445:
    load    [ext_objects + $i1], $i3    # |    630,666 |    630,666 |
    load    [$i3 + 5], $i4              # |    630,666 |    630,666 |
    load    [$i3 + 10], $i5             # |    630,666 |    630,666 |
    load    [$i2 + 0], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 0], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 0]              # |    630,666 |    630,666 |
    load    [$i3 + 5], $i4              # |    630,666 |    630,666 |
    load    [$i2 + 1], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 1], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 1]              # |    630,666 |    630,666 |
    load    [$i3 + 5], $i4              # |    630,666 |    630,666 |
    load    [$i2 + 2], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 2], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 2]              # |    630,666 |    630,666 |
    load    [$i3 + 1], $i4              # |    630,666 |    630,666 |
    bne     $i4, 2, be_else.32446       # |    630,666 |    630,666 |
be_then.32446:
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
be_else.32446:
    bg      $i4, 2, ble_else.32447      # |    556,470 |    556,470 |
ble_then.32447:
    sub     $i1, 1, $i1                 # |    222,588 |    222,588 |
    b       setup_startp_constants.2831 # |    222,588 |    222,588 |
ble_else.32447:
    load    [$i3 + 4], $i6              # |    333,882 |    333,882 |
    load    [$i3 + 4], $i7              # |    333,882 |    333,882 |
    load    [$i3 + 4], $i8              # |    333,882 |    333,882 |
    load    [$i3 + 3], $i9              # |    333,882 |    333,882 |
    load    [$i5 + 0], $f1              # |    333,882 |    333,882 |
    load    [$i5 + 1], $f2              # |    333,882 |    333,882 |
    load    [$i5 + 2], $f3              # |    333,882 |    333,882 |
    fmul    $f1, $f1, $f4               # |    333,882 |    333,882 |
    load    [$i6 + 0], $f5              # |    333,882 |    333,882 |
    fmul    $f4, $f5, $f4               # |    333,882 |    333,882 |
    fmul    $f2, $f2, $f5               # |    333,882 |    333,882 |
    load    [$i7 + 1], $f6              # |    333,882 |    333,882 |
    fmul    $f5, $f6, $f5               # |    333,882 |    333,882 |
    fadd    $f4, $f5, $f4               # |    333,882 |    333,882 |
    fmul    $f3, $f3, $f5               # |    333,882 |    333,882 |
    load    [$i8 + 2], $f6              # |    333,882 |    333,882 |
    fmul    $f5, $f6, $f5               # |    333,882 |    333,882 |
    fadd    $f4, $f5, $f4               # |    333,882 |    333,882 |
    bne     $i9, 0, be_else.32448       # |    333,882 |    333,882 |
be_then.32448:
    mov     $f4, $f1                    # |    333,882 |    333,882 |
.count b_cont
    b       be_cont.32448               # |    333,882 |    333,882 |
be_else.32448:
    load    [$i3 + 9], $i6
    load    [$i3 + 9], $i7
    load    [$i3 + 9], $i3
    fmul    $f2, $f3, $f5
    load    [$i6 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.32448:
    sub     $i1, 1, $i1                 # |    333,882 |    333,882 |
    bne     $i4, 3, be_else.32449       # |    333,882 |    333,882 |
be_then.32449:
    fsub    $f1, $fc0, $f1              # |    333,882 |    333,882 |
    store   $f1, [$i5 + 3]              # |    333,882 |    333,882 |
    b       setup_startp_constants.2831 # |    333,882 |    333,882 |
be_else.32449:
    store   $f1, [$i5 + 3]
    b       setup_startp_constants.2831
bge_else.32445:
    ret                                 # |     37,098 |     37,098 |
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i9]
# [$f1 - $f9]
# []
# []
######################################################################
.begin check_all_inside
check_all_inside.2856:
    load    [$i3 + $i1], $i2            # |  1,716,028 |  1,716,028 |
    bne     $i2, -1, be_else.32450      # |  1,716,028 |  1,716,028 |
be_then.32450:
    li      1, $i1                      # |     22,090 |     22,090 |
    ret                                 # |     22,090 |     22,090 |
be_else.32450:
    load    [ext_objects + $i2], $i2    # |  1,693,938 |  1,693,938 |
    load    [$i2 + 1], $i4              # |  1,693,938 |  1,693,938 |
    load    [$i2 + 5], $i5              # |  1,693,938 |  1,693,938 |
    load    [$i2 + 5], $i6              # |  1,693,938 |  1,693,938 |
    load    [$i2 + 5], $i7              # |  1,693,938 |  1,693,938 |
    load    [$i5 + 0], $f1              # |  1,693,938 |  1,693,938 |
    fsub    $f2, $f1, $f1               # |  1,693,938 |  1,693,938 |
    load    [$i6 + 1], $f5              # |  1,693,938 |  1,693,938 |
    fsub    $f3, $f5, $f5               # |  1,693,938 |  1,693,938 |
    load    [$i7 + 2], $f6              # |  1,693,938 |  1,693,938 |
    fsub    $f4, $f6, $f6               # |  1,693,938 |  1,693,938 |
    bne     $i4, 1, be_else.32451       # |  1,693,938 |  1,693,938 |
be_then.32451:
    load    [$i2 + 4], $i4              # |    716,909 |    716,909 |
    load    [$i4 + 0], $f7              # |    716,909 |    716,909 |
    fabs    $f1, $f1                    # |    716,909 |    716,909 |
    bg      $f7, $f1, ble_else.32452    # |    716,909 |    716,909 |
ble_then.32452:
    load    [$i2 + 6], $i2              # |    198,344 |    198,344 |
    bne     $i2, 0, be_else.32453       # |    198,344 |    198,344 |
be_then.32453:
    li      1, $i2                      # |    198,344 |    198,344 |
.count b_cont
    b       be_cont.32451               # |    198,344 |    198,344 |
be_else.32453:
    li      0, $i2
.count b_cont
    b       be_cont.32451
ble_else.32452:
    load    [$i2 + 4], $i4              # |    518,565 |    518,565 |
    load    [$i4 + 1], $f1              # |    518,565 |    518,565 |
    fabs    $f5, $f5                    # |    518,565 |    518,565 |
    bg      $f1, $f5, ble_else.32454    # |    518,565 |    518,565 |
ble_then.32454:
    load    [$i2 + 6], $i2              # |     55,268 |     55,268 |
    bne     $i2, 0, be_else.32455       # |     55,268 |     55,268 |
be_then.32455:
    li      1, $i2                      # |     55,268 |     55,268 |
.count b_cont
    b       be_cont.32451               # |     55,268 |     55,268 |
be_else.32455:
    li      0, $i2
.count b_cont
    b       be_cont.32451
ble_else.32454:
    load    [$i2 + 4], $i4              # |    463,297 |    463,297 |
    load    [$i4 + 2], $f1              # |    463,297 |    463,297 |
    fabs    $f6, $f5                    # |    463,297 |    463,297 |
    load    [$i2 + 6], $i2              # |    463,297 |    463,297 |
    bg      $f1, $f5, be_cont.32451     # |    463,297 |    463,297 |
ble_then.32456:
    bne     $i2, 0, be_else.32457       # |     17,085 |     17,085 |
be_then.32457:
    li      1, $i2                      # |     17,085 |     17,085 |
.count b_cont
    b       be_cont.32451               # |     17,085 |     17,085 |
be_else.32457:
    li      0, $i2
.count b_cont
    b       be_cont.32451
be_else.32451:
    bne     $i4, 2, be_else.32458       # |    977,029 |    977,029 |
be_then.32458:
    load    [$i2 + 6], $i4              # |    460,725 |    460,725 |
    load    [$i2 + 4], $i2              # |    460,725 |    460,725 |
    load    [$i2 + 0], $f7              # |    460,725 |    460,725 |
    fmul    $f7, $f1, $f1               # |    460,725 |    460,725 |
    load    [$i2 + 1], $f7              # |    460,725 |    460,725 |
    fmul    $f7, $f5, $f5               # |    460,725 |    460,725 |
    fadd    $f1, $f5, $f1               # |    460,725 |    460,725 |
    load    [$i2 + 2], $f5              # |    460,725 |    460,725 |
    fmul    $f5, $f6, $f5               # |    460,725 |    460,725 |
    fadd    $f1, $f5, $f1               # |    460,725 |    460,725 |
    bg      $f0, $f1, ble_else.32459    # |    460,725 |    460,725 |
ble_then.32459:
    bne     $i4, 0, be_else.32460       # |    460,725 |    460,725 |
be_then.32460:
    li      1, $i2
.count b_cont
    b       be_cont.32458
be_else.32460:
    li      0, $i2                      # |    460,725 |    460,725 |
.count b_cont
    b       be_cont.32458               # |    460,725 |    460,725 |
ble_else.32459:
    bne     $i4, 0, be_else.32461
be_then.32461:
    li      0, $i2
.count b_cont
    b       be_cont.32458
be_else.32461:
    li      1, $i2
.count b_cont
    b       be_cont.32458
be_else.32458:
    load    [$i2 + 6], $i5              # |    516,304 |    516,304 |
    fmul    $f1, $f1, $f7               # |    516,304 |    516,304 |
    load    [$i2 + 4], $i6              # |    516,304 |    516,304 |
    load    [$i6 + 0], $f8              # |    516,304 |    516,304 |
    fmul    $f7, $f8, $f7               # |    516,304 |    516,304 |
    fmul    $f5, $f5, $f8               # |    516,304 |    516,304 |
    load    [$i2 + 4], $i6              # |    516,304 |    516,304 |
    load    [$i6 + 1], $f9              # |    516,304 |    516,304 |
    fmul    $f8, $f9, $f8               # |    516,304 |    516,304 |
    fadd    $f7, $f8, $f7               # |    516,304 |    516,304 |
    fmul    $f6, $f6, $f8               # |    516,304 |    516,304 |
    load    [$i2 + 4], $i6              # |    516,304 |    516,304 |
    load    [$i6 + 2], $f9              # |    516,304 |    516,304 |
    fmul    $f8, $f9, $f8               # |    516,304 |    516,304 |
    fadd    $f7, $f8, $f7               # |    516,304 |    516,304 |
    load    [$i2 + 3], $i6              # |    516,304 |    516,304 |
    bne     $i6, 0, be_else.32462       # |    516,304 |    516,304 |
be_then.32462:
    mov     $f7, $f1                    # |    516,304 |    516,304 |
.count b_cont
    b       be_cont.32462               # |    516,304 |    516,304 |
be_else.32462:
    fmul    $f5, $f6, $f8
    load    [$i2 + 9], $i6
    load    [$i6 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 9], $i6
    load    [$i6 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 9], $i2
    load    [$i2 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.32462:
    bne     $i4, 3, be_cont.32463       # |    516,304 |    516,304 |
be_then.32463:
    fsub    $f1, $fc0, $f1              # |    516,304 |    516,304 |
be_cont.32463:
    bg      $f0, $f1, ble_else.32464    # |    516,304 |    516,304 |
ble_then.32464:
    bne     $i5, 0, be_else.32465       # |    184,512 |    184,512 |
be_then.32465:
    li      1, $i2                      # |    184,512 |    184,512 |
.count b_cont
    b       ble_cont.32464              # |    184,512 |    184,512 |
be_else.32465:
    li      0, $i2
.count b_cont
    b       ble_cont.32464
ble_else.32464:
    bne     $i5, 0, be_else.32466       # |    331,792 |    331,792 |
be_then.32466:
    li      0, $i2                      # |    331,792 |    331,792 |
.count b_cont
    b       be_cont.32466               # |    331,792 |    331,792 |
be_else.32466:
    li      1, $i2
be_cont.32466:
ble_cont.32464:
be_cont.32458:
be_cont.32451:
    bne     $i2, 0, be_else.32467       # |  1,693,938 |  1,693,938 |
be_then.32467:
    add     $i1, 1, $i1                 # |  1,238,729 |  1,238,729 |
    load    [$i3 + $i1], $i2            # |  1,238,729 |  1,238,729 |
    bne     $i2, -1, be_else.32468      # |  1,238,729 |  1,238,729 |
be_then.32468:
    li      1, $i1                      # |    596,960 |    596,960 |
    ret                                 # |    596,960 |    596,960 |
be_else.32468:
    load    [ext_objects + $i2], $i2    # |    641,769 |    641,769 |
    load    [$i2 + 5], $i4              # |    641,769 |    641,769 |
    load    [$i2 + 5], $i5              # |    641,769 |    641,769 |
    load    [$i2 + 5], $i6              # |    641,769 |    641,769 |
    load    [$i2 + 1], $i7              # |    641,769 |    641,769 |
    load    [$i4 + 0], $f1              # |    641,769 |    641,769 |
    fsub    $f2, $f1, $f1               # |    641,769 |    641,769 |
    load    [$i5 + 1], $f5              # |    641,769 |    641,769 |
    fsub    $f3, $f5, $f5               # |    641,769 |    641,769 |
    load    [$i6 + 2], $f6              # |    641,769 |    641,769 |
    fsub    $f4, $f6, $f6               # |    641,769 |    641,769 |
    bne     $i7, 1, be_else.32469       # |    641,769 |    641,769 |
be_then.32469:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    bg      $f7, $f1, ble_else.32470
ble_then.32470:
    load    [$i2 + 6], $i2
    bne     $i2, 0, be_else.32471
be_then.32471:
    li      1, $i2
.count b_cont
    b       be_cont.32469
be_else.32471:
    li      0, $i2
.count b_cont
    b       be_cont.32469
ble_else.32470:
    load    [$i2 + 4], $i4
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.32472
ble_then.32472:
    load    [$i2 + 6], $i2
    bne     $i2, 0, be_else.32473
be_then.32473:
    li      1, $i2
.count b_cont
    b       be_cont.32469
be_else.32473:
    li      0, $i2
.count b_cont
    b       be_cont.32469
ble_else.32472:
    load    [$i2 + 4], $i4
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    load    [$i2 + 6], $i2
    bg      $f1, $f5, be_cont.32469
ble_then.32474:
    bne     $i2, 0, be_else.32475
be_then.32475:
    li      1, $i2
.count b_cont
    b       be_cont.32469
be_else.32475:
    li      0, $i2
.count b_cont
    b       be_cont.32469
be_else.32469:
    load    [$i2 + 6], $i4              # |    641,769 |    641,769 |
    bne     $i7, 2, be_else.32476       # |    641,769 |    641,769 |
be_then.32476:
    load    [$i2 + 4], $i2              # |     31,829 |     31,829 |
    load    [$i2 + 0], $f7              # |     31,829 |     31,829 |
    fmul    $f7, $f1, $f1               # |     31,829 |     31,829 |
    load    [$i2 + 1], $f7              # |     31,829 |     31,829 |
    fmul    $f7, $f5, $f5               # |     31,829 |     31,829 |
    fadd    $f1, $f5, $f1               # |     31,829 |     31,829 |
    load    [$i2 + 2], $f5              # |     31,829 |     31,829 |
    fmul    $f5, $f6, $f5               # |     31,829 |     31,829 |
    fadd    $f1, $f5, $f1               # |     31,829 |     31,829 |
    bg      $f0, $f1, ble_else.32477    # |     31,829 |     31,829 |
ble_then.32477:
    bne     $i4, 0, be_else.32478       # |     20,422 |     20,422 |
be_then.32478:
    li      1, $i2
.count b_cont
    b       be_cont.32476
be_else.32478:
    li      0, $i2                      # |     20,422 |     20,422 |
.count b_cont
    b       be_cont.32476               # |     20,422 |     20,422 |
ble_else.32477:
    bne     $i4, 0, be_else.32479       # |     11,407 |     11,407 |
be_then.32479:
    li      0, $i2
.count b_cont
    b       be_cont.32476
be_else.32479:
    li      1, $i2                      # |     11,407 |     11,407 |
.count b_cont
    b       be_cont.32476               # |     11,407 |     11,407 |
be_else.32476:
    load    [$i2 + 1], $i5              # |    609,940 |    609,940 |
    load    [$i2 + 4], $i6              # |    609,940 |    609,940 |
    load    [$i2 + 4], $i7              # |    609,940 |    609,940 |
    load    [$i2 + 4], $i8              # |    609,940 |    609,940 |
    load    [$i2 + 3], $i9              # |    609,940 |    609,940 |
    fmul    $f1, $f1, $f7               # |    609,940 |    609,940 |
    load    [$i6 + 0], $f8              # |    609,940 |    609,940 |
    fmul    $f7, $f8, $f7               # |    609,940 |    609,940 |
    fmul    $f5, $f5, $f8               # |    609,940 |    609,940 |
    load    [$i7 + 1], $f9              # |    609,940 |    609,940 |
    fmul    $f8, $f9, $f8               # |    609,940 |    609,940 |
    fadd    $f7, $f8, $f7               # |    609,940 |    609,940 |
    fmul    $f6, $f6, $f8               # |    609,940 |    609,940 |
    load    [$i8 + 2], $f9              # |    609,940 |    609,940 |
    fmul    $f8, $f9, $f8               # |    609,940 |    609,940 |
    fadd    $f7, $f8, $f7               # |    609,940 |    609,940 |
    bne     $i9, 0, be_else.32480       # |    609,940 |    609,940 |
be_then.32480:
    mov     $f7, $f1                    # |    609,940 |    609,940 |
.count b_cont
    b       be_cont.32480               # |    609,940 |    609,940 |
be_else.32480:
    load    [$i2 + 9], $i6
    load    [$i2 + 9], $i7
    load    [$i2 + 9], $i2
    fmul    $f5, $f6, $f8
    load    [$i6 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i7 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.32480:
    bne     $i5, 3, be_cont.32481       # |    609,940 |    609,940 |
be_then.32481:
    fsub    $f1, $fc0, $f1              # |    609,940 |    609,940 |
be_cont.32481:
    bg      $f0, $f1, ble_else.32482    # |    609,940 |    609,940 |
ble_then.32482:
    bne     $i4, 0, be_else.32483       # |    299,723 |    299,723 |
be_then.32483:
    li      1, $i2                      # |    108,345 |    108,345 |
.count b_cont
    b       ble_cont.32482              # |    108,345 |    108,345 |
be_else.32483:
    li      0, $i2                      # |    191,378 |    191,378 |
.count b_cont
    b       ble_cont.32482              # |    191,378 |    191,378 |
ble_else.32482:
    bne     $i4, 0, be_else.32484       # |    310,217 |    310,217 |
be_then.32484:
    li      0, $i2                      # |    243,275 |    243,275 |
.count b_cont
    b       be_cont.32484               # |    243,275 |    243,275 |
be_else.32484:
    li      1, $i2                      # |     66,942 |     66,942 |
be_cont.32484:
ble_cont.32482:
be_cont.32476:
be_cont.32469:
    bne     $i2, 0, be_else.32485       # |    641,769 |    641,769 |
be_then.32485:
    add     $i1, 1, $i1                 # |    455,075 |    455,075 |
    load    [$i3 + $i1], $i2            # |    455,075 |    455,075 |
    bne     $i2, -1, be_else.32486      # |    455,075 |    455,075 |
be_then.32486:
    li      1, $i1                      # |    219,472 |    219,472 |
    ret                                 # |    219,472 |    219,472 |
be_else.32486:
    load    [ext_objects + $i2], $i2    # |    235,603 |    235,603 |
    load    [$i2 + 1], $i4              # |    235,603 |    235,603 |
    load    [$i2 + 5], $i5              # |    235,603 |    235,603 |
    load    [$i2 + 5], $i6              # |    235,603 |    235,603 |
    load    [$i2 + 5], $i7              # |    235,603 |    235,603 |
    load    [$i5 + 0], $f1              # |    235,603 |    235,603 |
    fsub    $f2, $f1, $f1               # |    235,603 |    235,603 |
    load    [$i6 + 1], $f5              # |    235,603 |    235,603 |
    fsub    $f3, $f5, $f5               # |    235,603 |    235,603 |
    load    [$i7 + 2], $f6              # |    235,603 |    235,603 |
    fsub    $f4, $f6, $f6               # |    235,603 |    235,603 |
    bne     $i4, 1, be_else.32487       # |    235,603 |    235,603 |
be_then.32487:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    bg      $f7, $f1, ble_else.32488
ble_then.32488:
    load    [$i2 + 6], $i2
    bne     $i2, 0, be_else.32489
be_then.32489:
    li      1, $i2
.count b_cont
    b       be_cont.32487
be_else.32489:
    li      0, $i2
.count b_cont
    b       be_cont.32487
ble_else.32488:
    load    [$i2 + 4], $i4
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.32490
ble_then.32490:
    load    [$i2 + 6], $i2
    bne     $i2, 0, be_else.32491
be_then.32491:
    li      1, $i2
.count b_cont
    b       be_cont.32487
be_else.32491:
    li      0, $i2
.count b_cont
    b       be_cont.32487
ble_else.32490:
    load    [$i2 + 4], $i4
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    load    [$i2 + 6], $i2
    bg      $f1, $f5, be_cont.32487
ble_then.32492:
    bne     $i2, 0, be_else.32493
be_then.32493:
    li      1, $i2
.count b_cont
    b       be_cont.32487
be_else.32493:
    li      0, $i2
.count b_cont
    b       be_cont.32487
be_else.32487:
    bne     $i4, 2, be_else.32494       # |    235,603 |    235,603 |
be_then.32494:
    load    [$i2 + 6], $i4              # |     46,306 |     46,306 |
    load    [$i2 + 4], $i2              # |     46,306 |     46,306 |
    load    [$i2 + 0], $f7              # |     46,306 |     46,306 |
    fmul    $f7, $f1, $f1               # |     46,306 |     46,306 |
    load    [$i2 + 1], $f7              # |     46,306 |     46,306 |
    fmul    $f7, $f5, $f5               # |     46,306 |     46,306 |
    fadd    $f1, $f5, $f1               # |     46,306 |     46,306 |
    load    [$i2 + 2], $f5              # |     46,306 |     46,306 |
    fmul    $f5, $f6, $f5               # |     46,306 |     46,306 |
    fadd    $f1, $f5, $f1               # |     46,306 |     46,306 |
    bg      $f0, $f1, ble_else.32495    # |     46,306 |     46,306 |
ble_then.32495:
    bne     $i4, 0, be_else.32496       # |     26,044 |     26,044 |
be_then.32496:
    li      1, $i2
.count b_cont
    b       be_cont.32494
be_else.32496:
    li      0, $i2                      # |     26,044 |     26,044 |
.count b_cont
    b       be_cont.32494               # |     26,044 |     26,044 |
ble_else.32495:
    bne     $i4, 0, be_else.32497       # |     20,262 |     20,262 |
be_then.32497:
    li      0, $i2
.count b_cont
    b       be_cont.32494
be_else.32497:
    li      1, $i2                      # |     20,262 |     20,262 |
.count b_cont
    b       be_cont.32494               # |     20,262 |     20,262 |
be_else.32494:
    load    [$i2 + 6], $i4              # |    189,297 |    189,297 |
    load    [$i2 + 1], $i5              # |    189,297 |    189,297 |
    load    [$i2 + 3], $i6              # |    189,297 |    189,297 |
    fmul    $f1, $f1, $f7               # |    189,297 |    189,297 |
    load    [$i2 + 4], $i7              # |    189,297 |    189,297 |
    load    [$i7 + 0], $f8              # |    189,297 |    189,297 |
    fmul    $f7, $f8, $f7               # |    189,297 |    189,297 |
    fmul    $f5, $f5, $f8               # |    189,297 |    189,297 |
    load    [$i2 + 4], $i7              # |    189,297 |    189,297 |
    load    [$i7 + 1], $f9              # |    189,297 |    189,297 |
    fmul    $f8, $f9, $f8               # |    189,297 |    189,297 |
    fadd    $f7, $f8, $f7               # |    189,297 |    189,297 |
    fmul    $f6, $f6, $f8               # |    189,297 |    189,297 |
    load    [$i2 + 4], $i7              # |    189,297 |    189,297 |
    load    [$i7 + 2], $f9              # |    189,297 |    189,297 |
    fmul    $f8, $f9, $f8               # |    189,297 |    189,297 |
    fadd    $f7, $f8, $f7               # |    189,297 |    189,297 |
    bne     $i6, 0, be_else.32498       # |    189,297 |    189,297 |
be_then.32498:
    mov     $f7, $f1                    # |    189,297 |    189,297 |
.count b_cont
    b       be_cont.32498               # |    189,297 |    189,297 |
be_else.32498:
    fmul    $f5, $f6, $f8
    load    [$i2 + 9], $i6
    load    [$i6 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 9], $i6
    load    [$i6 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 9], $i2
    load    [$i2 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.32498:
    bne     $i5, 3, be_cont.32499       # |    189,297 |    189,297 |
be_then.32499:
    fsub    $f1, $fc0, $f1              # |    189,297 |    189,297 |
be_cont.32499:
    bg      $f0, $f1, ble_else.32500    # |    189,297 |    189,297 |
ble_then.32500:
    bne     $i4, 0, be_else.32501       # |    153,079 |    153,079 |
be_then.32501:
    li      1, $i2
.count b_cont
    b       ble_cont.32500
be_else.32501:
    li      0, $i2                      # |    153,079 |    153,079 |
.count b_cont
    b       ble_cont.32500              # |    153,079 |    153,079 |
ble_else.32500:
    bne     $i4, 0, be_else.32502       # |     36,218 |     36,218 |
be_then.32502:
    li      0, $i2
.count b_cont
    b       be_cont.32502
be_else.32502:
    li      1, $i2                      # |     36,218 |     36,218 |
be_cont.32502:
ble_cont.32500:
be_cont.32494:
be_cont.32487:
    bne     $i2, 0, be_else.32503       # |    235,603 |    235,603 |
be_then.32503:
    add     $i1, 1, $i1                 # |    179,123 |    179,123 |
    load    [$i3 + $i1], $i2            # |    179,123 |    179,123 |
    bne     $i2, -1, be_else.32504      # |    179,123 |    179,123 |
be_then.32504:
    li      1, $i1                      # |    179,123 |    179,123 |
    ret                                 # |    179,123 |    179,123 |
be_else.32504:
    load    [ext_objects + $i2], $i2
    load    [$i2 + 5], $i4
    load    [$i2 + 5], $i5
    load    [$i2 + 5], $i6
    load    [$i2 + 1], $i7
    load    [$i4 + 0], $f1
    load    [$i5 + 1], $f5
    load    [$i6 + 2], $f6
    fsub    $f2, $f1, $f1
    fsub    $f3, $f5, $f5
    fsub    $f4, $f6, $f6
    bne     $i7, 1, be_else.32505
be_then.32505:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    bg      $f7, $f1, ble_else.32506
ble_then.32506:
    li      0, $i4
.count b_cont
    b       ble_cont.32506
ble_else.32506:
    load    [$i2 + 4], $i4
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.32507
ble_then.32507:
    li      0, $i4
.count b_cont
    b       ble_cont.32507
ble_else.32507:
    load    [$i2 + 4], $i4
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, ble_else.32508
ble_then.32508:
    li      0, $i4
.count b_cont
    b       ble_cont.32508
ble_else.32508:
    li      1, $i4
ble_cont.32508:
ble_cont.32507:
ble_cont.32506:
    load    [$i2 + 6], $i2
    bne     $i4, 0, be_else.32509
be_then.32509:
    bne     $i2, 0, be_else.32510
be_then.32510:
    li      0, $i1
    ret
be_else.32510:
    add     $i1, 1, $i1
    b       check_all_inside.2856
be_else.32509:
    bne     $i2, 0, be_else.32511
be_then.32511:
    add     $i1, 1, $i1
    b       check_all_inside.2856
be_else.32511:
    li      0, $i1
    ret
be_else.32505:
    load    [$i2 + 6], $i4
    bne     $i7, 2, be_else.32512
be_then.32512:
    load    [$i2 + 4], $i2
    load    [$i2 + 0], $f7
    fmul    $f7, $f1, $f1
    load    [$i2 + 1], $f7
    fmul    $f7, $f5, $f5
    fadd    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f5, $f6, $f5
    fadd    $f1, $f5, $f1
    bg      $f0, $f1, ble_else.32513
ble_then.32513:
    bne     $i4, 0, be_else.32514
be_then.32514:
    li      0, $i1
    ret
be_else.32514:
    add     $i1, 1, $i1
    b       check_all_inside.2856
ble_else.32513:
    bne     $i4, 0, be_else.32515
be_then.32515:
    add     $i1, 1, $i1
    b       check_all_inside.2856
be_else.32515:
    li      0, $i1
    ret
be_else.32512:
    load    [$i2 + 4], $i5
    load    [$i2 + 4], $i6
    load    [$i2 + 4], $i8
    load    [$i2 + 3], $i9
    fmul    $f1, $f1, $f7
    load    [$i5 + 0], $f8
    fmul    $f7, $f8, $f7
    fmul    $f5, $f5, $f8
    load    [$i6 + 1], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f6, $f8
    load    [$i8 + 2], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    bne     $i9, 0, be_else.32516
be_then.32516:
    mov     $f7, $f1
.count b_cont
    b       be_cont.32516
be_else.32516:
    fmul    $f5, $f6, $f8
    load    [$i2 + 9], $i5
    load    [$i5 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 9], $i5
    load    [$i5 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 9], $i2
    load    [$i2 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.32516:
    bne     $i7, 3, be_cont.32517
be_then.32517:
    fsub    $f1, $fc0, $f1
be_cont.32517:
    bg      $f0, $f1, ble_else.32518
ble_then.32518:
    bne     $i4, 0, be_else.32519
be_then.32519:
    li      0, $i1
    ret
be_else.32519:
    add     $i1, 1, $i1
    b       check_all_inside.2856
ble_else.32518:
    bne     $i4, 0, be_else.32520
be_then.32520:
    add     $i1, 1, $i1
    b       check_all_inside.2856
be_else.32520:
    li      0, $i1
    ret
be_else.32503:
    li      0, $i1                      # |     56,480 |     56,480 |
    ret                                 # |     56,480 |     56,480 |
be_else.32485:
    li      0, $i1                      # |    186,694 |    186,694 |
    ret                                 # |    186,694 |    186,694 |
be_else.32467:
    li      0, $i1                      # |    455,209 |    455,209 |
    ret                                 # |    455,209 |    455,209 |
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i10, $i11)
# $ra = $ra1
# [$i1 - $i11]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
    load    [$i11 + $i10], $i1          # |  4,222,772 |  4,222,772 |
    bne     $i1, -1, be_else.32521      # |  4,222,772 |  4,222,772 |
be_then.32521:
    li      0, $i1                      # |    627,857 |    627,857 |
    jr      $ra1                        # |    627,857 |    627,857 |
be_else.32521:
    load    [ext_objects + $i1], $i2    # |  3,594,915 |  3,594,915 |
    load    [$i2 + 5], $i3              # |  3,594,915 |  3,594,915 |
    load    [$i2 + 5], $i4              # |  3,594,915 |  3,594,915 |
    load    [$i2 + 5], $i5              # |  3,594,915 |  3,594,915 |
    load    [ext_light_dirvec + 1], $i6 # |  3,594,915 |  3,594,915 |
    load    [$i2 + 1], $i7              # |  3,594,915 |  3,594,915 |
    load    [ext_intersection_point + 0], $f1# |  3,594,915 |  3,594,915 |
    load    [$i3 + 0], $f2              # |  3,594,915 |  3,594,915 |
    fsub    $f1, $f2, $f1               # |  3,594,915 |  3,594,915 |
    load    [ext_intersection_point + 1], $f2# |  3,594,915 |  3,594,915 |
    load    [$i4 + 1], $f3              # |  3,594,915 |  3,594,915 |
    fsub    $f2, $f3, $f2               # |  3,594,915 |  3,594,915 |
    load    [ext_intersection_point + 2], $f3# |  3,594,915 |  3,594,915 |
    load    [$i5 + 2], $f4              # |  3,594,915 |  3,594,915 |
    fsub    $f3, $f4, $f3               # |  3,594,915 |  3,594,915 |
    load    [$i6 + $i1], $i3            # |  3,594,915 |  3,594,915 |
    bne     $i7, 1, be_else.32522       # |  3,594,915 |  3,594,915 |
be_then.32522:
    load    [ext_light_dirvec + 0], $i4 # |  1,409,409 |  1,409,409 |
    load    [$i2 + 4], $i5              # |  1,409,409 |  1,409,409 |
    load    [$i5 + 1], $f4              # |  1,409,409 |  1,409,409 |
    load    [$i4 + 1], $f5              # |  1,409,409 |  1,409,409 |
    load    [$i3 + 0], $f6              # |  1,409,409 |  1,409,409 |
    fsub    $f6, $f1, $f6               # |  1,409,409 |  1,409,409 |
    load    [$i3 + 1], $f7              # |  1,409,409 |  1,409,409 |
    fmul    $f6, $f7, $f6               # |  1,409,409 |  1,409,409 |
    fmul    $f6, $f5, $f5               # |  1,409,409 |  1,409,409 |
    fadd_a  $f5, $f2, $f5               # |  1,409,409 |  1,409,409 |
    bg      $f4, $f5, ble_else.32523    # |  1,409,409 |  1,409,409 |
ble_then.32523:
    li      0, $i5                      # |    998,347 |    998,347 |
.count b_cont
    b       ble_cont.32523              # |    998,347 |    998,347 |
ble_else.32523:
    load    [$i2 + 4], $i5              # |    411,062 |    411,062 |
    load    [$i5 + 2], $f4              # |    411,062 |    411,062 |
    load    [$i4 + 2], $f5              # |    411,062 |    411,062 |
    fmul    $f6, $f5, $f5               # |    411,062 |    411,062 |
    fadd_a  $f5, $f3, $f5               # |    411,062 |    411,062 |
    bg      $f4, $f5, ble_else.32524    # |    411,062 |    411,062 |
ble_then.32524:
    li      0, $i5                      # |    136,251 |    136,251 |
.count b_cont
    b       ble_cont.32524              # |    136,251 |    136,251 |
ble_else.32524:
    load    [$i3 + 1], $f4              # |    274,811 |    274,811 |
    bne     $f4, $f0, be_else.32525     # |    274,811 |    274,811 |
be_then.32525:
    li      0, $i5
.count b_cont
    b       be_cont.32525
be_else.32525:
    li      1, $i5                      # |    274,811 |    274,811 |
be_cont.32525:
ble_cont.32524:
ble_cont.32523:
    bne     $i5, 0, be_else.32526       # |  1,409,409 |  1,409,409 |
be_then.32526:
    load    [$i2 + 4], $i5              # |  1,134,598 |  1,134,598 |
    load    [$i5 + 0], $f4              # |  1,134,598 |  1,134,598 |
    load    [$i4 + 0], $f5              # |  1,134,598 |  1,134,598 |
    load    [$i3 + 2], $f6              # |  1,134,598 |  1,134,598 |
    fsub    $f6, $f2, $f6               # |  1,134,598 |  1,134,598 |
    load    [$i3 + 3], $f7              # |  1,134,598 |  1,134,598 |
    fmul    $f6, $f7, $f6               # |  1,134,598 |  1,134,598 |
    fmul    $f6, $f5, $f5               # |  1,134,598 |  1,134,598 |
    fadd_a  $f5, $f1, $f5               # |  1,134,598 |  1,134,598 |
    bg      $f4, $f5, ble_else.32527    # |  1,134,598 |  1,134,598 |
ble_then.32527:
    li      0, $i5                      # |    632,414 |    632,414 |
.count b_cont
    b       ble_cont.32527              # |    632,414 |    632,414 |
ble_else.32527:
    load    [$i2 + 4], $i5              # |    502,184 |    502,184 |
    load    [$i5 + 2], $f4              # |    502,184 |    502,184 |
    load    [$i4 + 2], $f5              # |    502,184 |    502,184 |
    fmul    $f6, $f5, $f5               # |    502,184 |    502,184 |
    fadd_a  $f5, $f3, $f5               # |    502,184 |    502,184 |
    bg      $f4, $f5, ble_else.32528    # |    502,184 |    502,184 |
ble_then.32528:
    li      0, $i5                      # |    138,902 |    138,902 |
.count b_cont
    b       ble_cont.32528              # |    138,902 |    138,902 |
ble_else.32528:
    load    [$i3 + 3], $f4              # |    363,282 |    363,282 |
    bne     $f4, $f0, be_else.32529     # |    363,282 |    363,282 |
be_then.32529:
    li      0, $i5
.count b_cont
    b       be_cont.32529
be_else.32529:
    li      1, $i5                      # |    363,282 |    363,282 |
be_cont.32529:
ble_cont.32528:
ble_cont.32527:
    bne     $i5, 0, be_else.32530       # |  1,134,598 |  1,134,598 |
be_then.32530:
    load    [$i2 + 4], $i5              # |    771,316 |    771,316 |
    load    [$i5 + 0], $f4              # |    771,316 |    771,316 |
    load    [$i4 + 0], $f5              # |    771,316 |    771,316 |
    load    [$i3 + 4], $f6              # |    771,316 |    771,316 |
    fsub    $f6, $f3, $f3               # |    771,316 |    771,316 |
    load    [$i3 + 5], $f6              # |    771,316 |    771,316 |
    fmul    $f3, $f6, $f3               # |    771,316 |    771,316 |
    fmul    $f3, $f5, $f5               # |    771,316 |    771,316 |
    fadd_a  $f5, $f1, $f1               # |    771,316 |    771,316 |
    bg      $f4, $f1, ble_else.32531    # |    771,316 |    771,316 |
ble_then.32531:
    li      0, $i2                      # |    642,019 |    642,019 |
.count b_cont
    b       be_cont.32522               # |    642,019 |    642,019 |
ble_else.32531:
    load    [$i2 + 4], $i2              # |    129,297 |    129,297 |
    load    [$i2 + 1], $f1              # |    129,297 |    129,297 |
    load    [$i4 + 1], $f4              # |    129,297 |    129,297 |
    fmul    $f3, $f4, $f4               # |    129,297 |    129,297 |
    fadd_a  $f4, $f2, $f2               # |    129,297 |    129,297 |
    bg      $f1, $f2, ble_else.32532    # |    129,297 |    129,297 |
ble_then.32532:
    li      0, $i2                      # |     78,455 |     78,455 |
.count b_cont
    b       be_cont.32522               # |     78,455 |     78,455 |
ble_else.32532:
    load    [$i3 + 5], $f1              # |     50,842 |     50,842 |
    bne     $f1, $f0, be_else.32533     # |     50,842 |     50,842 |
be_then.32533:
    li      0, $i2
.count b_cont
    b       be_cont.32522
be_else.32533:
    mov     $f3, $fg0                   # |     50,842 |     50,842 |
    li      3, $i2                      # |     50,842 |     50,842 |
.count b_cont
    b       be_cont.32522               # |     50,842 |     50,842 |
be_else.32530:
    mov     $f6, $fg0                   # |    363,282 |    363,282 |
    li      2, $i2                      # |    363,282 |    363,282 |
.count b_cont
    b       be_cont.32522               # |    363,282 |    363,282 |
be_else.32526:
    mov     $f6, $fg0                   # |    274,811 |    274,811 |
    li      1, $i2                      # |    274,811 |    274,811 |
.count b_cont
    b       be_cont.32522               # |    274,811 |    274,811 |
be_else.32522:
    load    [$i3 + 0], $f4              # |  2,185,506 |  2,185,506 |
    bne     $i7, 2, be_else.32534       # |  2,185,506 |  2,185,506 |
be_then.32534:
    bg      $f0, $f4, ble_else.32535    # |    566,355 |    566,355 |
ble_then.32535:
    li      0, $i2                      # |     11,416 |     11,416 |
.count b_cont
    b       be_cont.32534               # |     11,416 |     11,416 |
ble_else.32535:
    load    [$i3 + 1], $f4              # |    554,939 |    554,939 |
    fmul    $f4, $f1, $f1               # |    554,939 |    554,939 |
    load    [$i3 + 2], $f4              # |    554,939 |    554,939 |
    fmul    $f4, $f2, $f2               # |    554,939 |    554,939 |
    fadd    $f1, $f2, $f1               # |    554,939 |    554,939 |
    load    [$i3 + 3], $f2              # |    554,939 |    554,939 |
    fmul    $f2, $f3, $f2               # |    554,939 |    554,939 |
    fadd    $f1, $f2, $fg0              # |    554,939 |    554,939 |
    li      1, $i2                      # |    554,939 |    554,939 |
.count b_cont
    b       be_cont.32534               # |    554,939 |    554,939 |
be_else.32534:
    bne     $f4, $f0, be_else.32536     # |  1,619,151 |  1,619,151 |
be_then.32536:
    li      0, $i2
.count b_cont
    b       be_cont.32536
be_else.32536:
    load    [$i3 + 1], $f5              # |  1,619,151 |  1,619,151 |
    fmul    $f5, $f1, $f5               # |  1,619,151 |  1,619,151 |
    load    [$i3 + 2], $f6              # |  1,619,151 |  1,619,151 |
    fmul    $f6, $f2, $f6               # |  1,619,151 |  1,619,151 |
    fadd    $f5, $f6, $f5               # |  1,619,151 |  1,619,151 |
    load    [$i3 + 3], $f6              # |  1,619,151 |  1,619,151 |
    fmul    $f6, $f3, $f6               # |  1,619,151 |  1,619,151 |
    fadd    $f5, $f6, $f5               # |  1,619,151 |  1,619,151 |
    fmul    $f5, $f5, $f6               # |  1,619,151 |  1,619,151 |
    fmul    $f1, $f1, $f7               # |  1,619,151 |  1,619,151 |
    load    [$i2 + 4], $i4              # |  1,619,151 |  1,619,151 |
    load    [$i4 + 0], $f8              # |  1,619,151 |  1,619,151 |
    fmul    $f7, $f8, $f7               # |  1,619,151 |  1,619,151 |
    fmul    $f2, $f2, $f8               # |  1,619,151 |  1,619,151 |
    load    [$i2 + 4], $i4              # |  1,619,151 |  1,619,151 |
    load    [$i4 + 1], $f9              # |  1,619,151 |  1,619,151 |
    fmul    $f8, $f9, $f8               # |  1,619,151 |  1,619,151 |
    fadd    $f7, $f8, $f7               # |  1,619,151 |  1,619,151 |
    fmul    $f3, $f3, $f8               # |  1,619,151 |  1,619,151 |
    load    [$i2 + 4], $i4              # |  1,619,151 |  1,619,151 |
    load    [$i4 + 2], $f9              # |  1,619,151 |  1,619,151 |
    fmul    $f8, $f9, $f8               # |  1,619,151 |  1,619,151 |
    fadd    $f7, $f8, $f7               # |  1,619,151 |  1,619,151 |
    load    [$i2 + 3], $i4              # |  1,619,151 |  1,619,151 |
    bne     $i4, 0, be_else.32537       # |  1,619,151 |  1,619,151 |
be_then.32537:
    mov     $f7, $f1                    # |  1,619,151 |  1,619,151 |
.count b_cont
    b       be_cont.32537               # |  1,619,151 |  1,619,151 |
be_else.32537:
    fmul    $f2, $f3, $f8
    load    [$i2 + 9], $i4
    load    [$i4 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i2 + 9], $i4
    load    [$i4 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i2 + 9], $i4
    load    [$i4 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.32537:
    bne     $i7, 3, be_cont.32538       # |  1,619,151 |  1,619,151 |
be_then.32538:
    fsub    $f1, $fc0, $f1              # |  1,619,151 |  1,619,151 |
be_cont.32538:
    fmul    $f4, $f1, $f1               # |  1,619,151 |  1,619,151 |
    fsub    $f6, $f1, $f1               # |  1,619,151 |  1,619,151 |
    bg      $f1, $f0, ble_else.32539    # |  1,619,151 |  1,619,151 |
ble_then.32539:
    li      0, $i2                      # |  1,270,619 |  1,270,619 |
.count b_cont
    b       ble_cont.32539              # |  1,270,619 |  1,270,619 |
ble_else.32539:
    load    [$i2 + 6], $i2              # |    348,532 |    348,532 |
    load    [$i3 + 4], $f2              # |    348,532 |    348,532 |
    fsqrt   $f1, $f1                    # |    348,532 |    348,532 |
    bne     $i2, 0, be_else.32540       # |    348,532 |    348,532 |
be_then.32540:
    fsub    $f5, $f1, $f1               # |    278,489 |    278,489 |
    fmul    $f1, $f2, $fg0              # |    278,489 |    278,489 |
    li      1, $i2                      # |    278,489 |    278,489 |
.count b_cont
    b       be_cont.32540               # |    278,489 |    278,489 |
be_else.32540:
    fadd    $f5, $f1, $f1               # |     70,043 |     70,043 |
    fmul    $f1, $f2, $fg0              # |     70,043 |     70,043 |
    li      1, $i2                      # |     70,043 |     70,043 |
be_cont.32540:
ble_cont.32539:
be_cont.32536:
be_cont.32534:
be_cont.32522:
    bne     $i2, 0, be_else.32541       # |  3,594,915 |  3,594,915 |
be_then.32541:
    li      0, $i2                      # |  2,002,509 |  2,002,509 |
.count b_cont
    b       be_cont.32541               # |  2,002,509 |  2,002,509 |
be_else.32541:
.count load_float
    load    [f.31944], $f1              # |  1,592,406 |  1,592,406 |
    bg      $f1, $fg0, ble_else.32542   # |  1,592,406 |  1,592,406 |
ble_then.32542:
    li      0, $i2                      # |  1,029,338 |  1,029,338 |
.count b_cont
    b       ble_cont.32542              # |  1,029,338 |  1,029,338 |
ble_else.32542:
    li      1, $i2                      # |    563,068 |    563,068 |
ble_cont.32542:
be_cont.32541:
    bne     $i2, 0, be_else.32543       # |  3,594,915 |  3,594,915 |
be_then.32543:
    load    [ext_objects + $i1], $i1    # |  3,031,847 |  3,031,847 |
    load    [$i1 + 6], $i1              # |  3,031,847 |  3,031,847 |
    bne     $i1, 0, be_else.32544       # |  3,031,847 |  3,031,847 |
be_then.32544:
    li      0, $i1                      # |  2,406,042 |  2,406,042 |
    jr      $ra1                        # |  2,406,042 |  2,406,042 |
be_else.32544:
    add     $i10, 1, $i10               # |    625,805 |    625,805 |
    b       shadow_check_and_group.2862 # |    625,805 |    625,805 |
be_else.32543:
    load    [$i11 + 0], $i1             # |    563,068 |    563,068 |
    bne     $i1, -1, be_else.32545      # |    563,068 |    563,068 |
be_then.32545:
    li      1, $i1
    jr      $ra1
be_else.32545:
    load    [ext_objects + $i1], $i1    # |    563,068 |    563,068 |
    load    [$i1 + 5], $i2              # |    563,068 |    563,068 |
    load    [$i1 + 5], $i3              # |    563,068 |    563,068 |
    load    [$i1 + 5], $i4              # |    563,068 |    563,068 |
    load    [$i1 + 1], $i5              # |    563,068 |    563,068 |
    load    [$i2 + 0], $f1              # |    563,068 |    563,068 |
    fadd    $fg0, $fc16, $f2            # |    563,068 |    563,068 |
    fmul    $fg12, $f2, $f3             # |    563,068 |    563,068 |
    load    [ext_intersection_point + 0], $f4# |    563,068 |    563,068 |
    fadd    $f3, $f4, $f5               # |    563,068 |    563,068 |
    fsub    $f5, $f1, $f1               # |    563,068 |    563,068 |
    load    [$i3 + 1], $f3              # |    563,068 |    563,068 |
    fmul    $fg13, $f2, $f4             # |    563,068 |    563,068 |
    load    [ext_intersection_point + 1], $f6# |    563,068 |    563,068 |
    fadd    $f4, $f6, $f6               # |    563,068 |    563,068 |
    fsub    $f6, $f3, $f3               # |    563,068 |    563,068 |
    load    [$i4 + 2], $f4              # |    563,068 |    563,068 |
    fmul    $fg14, $f2, $f2             # |    563,068 |    563,068 |
    load    [ext_intersection_point + 2], $f7# |    563,068 |    563,068 |
    fadd    $f2, $f7, $f7               # |    563,068 |    563,068 |
    fsub    $f7, $f4, $f2               # |    563,068 |    563,068 |
    bne     $i5, 1, be_else.32546       # |    563,068 |    563,068 |
be_then.32546:
    load    [$i1 + 4], $i2              # |    541,392 |    541,392 |
    load    [$i2 + 0], $f4              # |    541,392 |    541,392 |
    fabs    $f1, $f1                    # |    541,392 |    541,392 |
    bg      $f4, $f1, ble_else.32547    # |    541,392 |    541,392 |
ble_then.32547:
    load    [$i1 + 6], $i1              # |     56,355 |     56,355 |
    bne     $i1, 0, be_else.32548       # |     56,355 |     56,355 |
be_then.32548:
    li      1, $i1                      # |     56,355 |     56,355 |
.count b_cont
    b       be_cont.32546               # |     56,355 |     56,355 |
be_else.32548:
    li      0, $i1
.count b_cont
    b       be_cont.32546
ble_else.32547:
    load    [$i1 + 4], $i2              # |    485,037 |    485,037 |
    load    [$i2 + 1], $f1              # |    485,037 |    485,037 |
    fabs    $f3, $f3                    # |    485,037 |    485,037 |
    bg      $f1, $f3, ble_else.32549    # |    485,037 |    485,037 |
ble_then.32549:
    load    [$i1 + 6], $i1              # |      5,586 |      5,586 |
    bne     $i1, 0, be_else.32550       # |      5,586 |      5,586 |
be_then.32550:
    li      1, $i1                      # |      5,586 |      5,586 |
.count b_cont
    b       be_cont.32546               # |      5,586 |      5,586 |
be_else.32550:
    li      0, $i1
.count b_cont
    b       be_cont.32546
ble_else.32549:
    load    [$i1 + 4], $i2              # |    479,451 |    479,451 |
    load    [$i2 + 2], $f1              # |    479,451 |    479,451 |
    fabs    $f2, $f2                    # |    479,451 |    479,451 |
    load    [$i1 + 6], $i1              # |    479,451 |    479,451 |
    bg      $f1, $f2, be_cont.32546     # |    479,451 |    479,451 |
ble_then.32551:
    bne     $i1, 0, be_else.32552       # |      2,205 |      2,205 |
be_then.32552:
    li      1, $i1                      # |      2,205 |      2,205 |
.count b_cont
    b       be_cont.32546               # |      2,205 |      2,205 |
be_else.32552:
    li      0, $i1
.count b_cont
    b       be_cont.32546
be_else.32546:
    load    [$i1 + 6], $i2              # |     21,676 |     21,676 |
    bne     $i5, 2, be_else.32553       # |     21,676 |     21,676 |
be_then.32553:
    load    [$i1 + 4], $i1
    load    [$i1 + 0], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 1], $f4
    fmul    $f4, $f3, $f3
    fadd    $f1, $f3, $f1
    load    [$i1 + 2], $f3
    fmul    $f3, $f2, $f2
    fadd    $f1, $f2, $f1
    bg      $f0, $f1, ble_else.32554
ble_then.32554:
    bne     $i2, 0, be_else.32555
be_then.32555:
    li      1, $i1
.count b_cont
    b       be_cont.32553
be_else.32555:
    li      0, $i1
.count b_cont
    b       be_cont.32553
ble_else.32554:
    bne     $i2, 0, be_else.32556
be_then.32556:
    li      0, $i1
.count b_cont
    b       be_cont.32553
be_else.32556:
    li      1, $i1
.count b_cont
    b       be_cont.32553
be_else.32553:
    fmul    $f1, $f1, $f4               # |     21,676 |     21,676 |
    load    [$i1 + 4], $i3              # |     21,676 |     21,676 |
    load    [$i3 + 0], $f8              # |     21,676 |     21,676 |
    fmul    $f4, $f8, $f4               # |     21,676 |     21,676 |
    fmul    $f3, $f3, $f8               # |     21,676 |     21,676 |
    load    [$i1 + 4], $i3              # |     21,676 |     21,676 |
    load    [$i3 + 1], $f9              # |     21,676 |     21,676 |
    fmul    $f8, $f9, $f8               # |     21,676 |     21,676 |
    fadd    $f4, $f8, $f4               # |     21,676 |     21,676 |
    fmul    $f2, $f2, $f8               # |     21,676 |     21,676 |
    load    [$i1 + 4], $i3              # |     21,676 |     21,676 |
    load    [$i3 + 2], $f9              # |     21,676 |     21,676 |
    fmul    $f8, $f9, $f8               # |     21,676 |     21,676 |
    load    [$i1 + 3], $i3              # |     21,676 |     21,676 |
    fadd    $f4, $f8, $f4               # |     21,676 |     21,676 |
    bne     $i3, 0, be_else.32557       # |     21,676 |     21,676 |
be_then.32557:
    mov     $f4, $f1                    # |     21,676 |     21,676 |
.count b_cont
    b       be_cont.32557               # |     21,676 |     21,676 |
be_else.32557:
    fmul    $f3, $f2, $f8
    load    [$i1 + 9], $i3
    load    [$i3 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f4, $f8, $f4
    fmul    $f2, $f1, $f2
    load    [$i1 + 9], $i3
    load    [$i3 + 1], $f8
    fmul    $f2, $f8, $f2
    fadd    $f4, $f2, $f2
    fmul    $f1, $f3, $f1
    load    [$i1 + 9], $i1
    load    [$i1 + 2], $f3
    fmul    $f1, $f3, $f1
    fadd    $f2, $f1, $f1
be_cont.32557:
    bne     $i5, 3, be_cont.32558       # |     21,676 |     21,676 |
be_then.32558:
    fsub    $f1, $fc0, $f1              # |     21,676 |     21,676 |
be_cont.32558:
    bg      $f0, $f1, ble_else.32559    # |     21,676 |     21,676 |
ble_then.32559:
    bne     $i2, 0, be_else.32560
be_then.32560:
    li      1, $i1
.count b_cont
    b       ble_cont.32559
be_else.32560:
    li      0, $i1
.count b_cont
    b       ble_cont.32559
ble_else.32559:
    bne     $i2, 0, be_else.32561       # |     21,676 |     21,676 |
be_then.32561:
    li      0, $i1                      # |     21,676 |     21,676 |
.count b_cont
    b       be_cont.32561               # |     21,676 |     21,676 |
be_else.32561:
    li      1, $i1
be_cont.32561:
ble_cont.32559:
be_cont.32553:
be_cont.32546:
    bne     $i1, 0, be_else.32562       # |    563,068 |    563,068 |
be_then.32562:
    li      1, $i1                      # |    498,922 |    498,922 |
.count move_args
    mov     $i11, $i3                   # |    498,922 |    498,922 |
.count move_args
    mov     $f5, $f2                    # |    498,922 |    498,922 |
.count move_args
    mov     $f6, $f3                    # |    498,922 |    498,922 |
.count move_args
    mov     $f7, $f4                    # |    498,922 |    498,922 |
    call    check_all_inside.2856       # |    498,922 |    498,922 |
    bne     $i1, 0, be_else.32563       # |    498,922 |    498,922 |
be_then.32563:
    add     $i10, 1, $i10               # |    262,860 |    262,860 |
    b       shadow_check_and_group.2862 # |    262,860 |    262,860 |
be_else.32563:
    li      1, $i1                      # |    236,062 |    236,062 |
    jr      $ra1                        # |    236,062 |    236,062 |
be_else.32562:
    add     $i10, 1, $i10               # |     64,146 |     64,146 |
    b       shadow_check_and_group.2862 # |     64,146 |     64,146 |
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i12, $i13)
# $ra = $ra2
# [$i1 - $i13]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
    load    [$i13 + $i12], $i1          # |    223,481 |    223,481 |
    bne     $i1, -1, be_else.32564      # |    223,481 |    223,481 |
be_then.32564:
    li      0, $i1
    jr      $ra2
be_else.32564:
    li      0, $i10                     # |    223,481 |    223,481 |
    load    [ext_and_net + $i1], $i11   # |    223,481 |    223,481 |
    jal     shadow_check_and_group.2862, $ra1# |    223,481 |    223,481 |
    bne     $i1, 0, be_else.32565       # |    223,481 |    223,481 |
be_then.32565:
    add     $i12, 1, $i12               # |    113,403 |    113,403 |
    load    [$i13 + $i12], $i1          # |    113,403 |    113,403 |
    bne     $i1, -1, be_else.32566      # |    113,403 |    113,403 |
be_then.32566:
    li      0, $i1
    jr      $ra2
be_else.32566:
    li      0, $i10                     # |    113,403 |    113,403 |
    load    [ext_and_net + $i1], $i11   # |    113,403 |    113,403 |
    jal     shadow_check_and_group.2862, $ra1# |    113,403 |    113,403 |
    bne     $i1, 0, be_else.32567       # |    113,403 |    113,403 |
be_then.32567:
    add     $i12, 1, $i12               # |    106,755 |    106,755 |
    load    [$i13 + $i12], $i1          # |    106,755 |    106,755 |
    bne     $i1, -1, be_else.32568      # |    106,755 |    106,755 |
be_then.32568:
    li      0, $i1                      # |     10,334 |     10,334 |
    jr      $ra2                        # |     10,334 |     10,334 |
be_else.32568:
    li      0, $i10                     # |     96,421 |     96,421 |
    load    [ext_and_net + $i1], $i11   # |     96,421 |     96,421 |
    jal     shadow_check_and_group.2862, $ra1# |     96,421 |     96,421 |
    bne     $i1, 0, be_else.32569       # |     96,421 |     96,421 |
be_then.32569:
    add     $i12, 1, $i12               # |     94,249 |     94,249 |
    load    [$i13 + $i12], $i1          # |     94,249 |     94,249 |
    bne     $i1, -1, be_else.32570      # |     94,249 |     94,249 |
be_then.32570:
    li      0, $i1
    jr      $ra2
be_else.32570:
    li      0, $i10                     # |     94,249 |     94,249 |
    load    [ext_and_net + $i1], $i11   # |     94,249 |     94,249 |
    jal     shadow_check_and_group.2862, $ra1# |     94,249 |     94,249 |
    bne     $i1, 0, be_else.32571       # |     94,249 |     94,249 |
be_then.32571:
    add     $i12, 1, $i12               # |     82,757 |     82,757 |
    load    [$i13 + $i12], $i1          # |     82,757 |     82,757 |
    bne     $i1, -1, be_else.32572      # |     82,757 |     82,757 |
be_then.32572:
    li      0, $i1                      # |     82,757 |     82,757 |
    jr      $ra2                        # |     82,757 |     82,757 |
be_else.32572:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32573
be_then.32573:
    add     $i12, 1, $i12
    load    [$i13 + $i12], $i1
    bne     $i1, -1, be_else.32574
be_then.32574:
    li      0, $i1
    jr      $ra2
be_else.32574:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32575
be_then.32575:
    add     $i12, 1, $i12
    load    [$i13 + $i12], $i1
    bne     $i1, -1, be_else.32576
be_then.32576:
    li      0, $i1
    jr      $ra2
be_else.32576:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32577
be_then.32577:
    add     $i12, 1, $i12
    load    [$i13 + $i12], $i1
    bne     $i1, -1, be_else.32578
be_then.32578:
    li      0, $i1
    jr      $ra2
be_else.32578:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32579
be_then.32579:
    add     $i12, 1, $i12
    b       shadow_check_one_or_group.2865
be_else.32579:
    li      1, $i1
    jr      $ra2
be_else.32577:
    li      1, $i1
    jr      $ra2
be_else.32575:
    li      1, $i1
    jr      $ra2
be_else.32573:
    li      1, $i1
    jr      $ra2
be_else.32571:
    li      1, $i1                      # |     11,492 |     11,492 |
    jr      $ra2                        # |     11,492 |     11,492 |
be_else.32569:
    li      1, $i1                      # |      2,172 |      2,172 |
    jr      $ra2                        # |      2,172 |      2,172 |
be_else.32567:
    li      1, $i1                      # |      6,648 |      6,648 |
    jr      $ra2                        # |      6,648 |      6,648 |
be_else.32565:
    li      1, $i1                      # |    110,078 |    110,078 |
    jr      $ra2                        # |    110,078 |    110,078 |
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i14, $i15)
# $ra = $ra3
# [$i1 - $i16]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
    load    [$i15 + $i14], $i16         # |    565,273 |    565,273 |
    load    [$i16 + 0], $i1             # |    565,273 |    565,273 |
    bne     $i1, -1, be_else.32580      # |    565,273 |    565,273 |
be_then.32580:
    li      0, $i1                      # |     10,334 |     10,334 |
    jr      $ra3                        # |     10,334 |     10,334 |
be_else.32580:
    bne     $i1, 99, be_else.32581      # |    554,939 |    554,939 |
be_then.32581:
    li      1, $i1                      # |    544,605 |    544,605 |
.count b_cont
    b       be_cont.32581               # |    544,605 |    544,605 |
be_else.32581:
    load    [ext_objects + $i1], $i2    # |     10,334 |     10,334 |
    load    [ext_intersection_point + 0], $f1# |     10,334 |     10,334 |
    load    [$i2 + 5], $i3              # |     10,334 |     10,334 |
    load    [$i3 + 0], $f2              # |     10,334 |     10,334 |
    fsub    $f1, $f2, $f1               # |     10,334 |     10,334 |
    load    [ext_intersection_point + 1], $f2# |     10,334 |     10,334 |
    load    [$i2 + 5], $i3              # |     10,334 |     10,334 |
    load    [$i3 + 1], $f3              # |     10,334 |     10,334 |
    fsub    $f2, $f3, $f2               # |     10,334 |     10,334 |
    load    [ext_intersection_point + 2], $f3# |     10,334 |     10,334 |
    load    [$i2 + 5], $i3              # |     10,334 |     10,334 |
    load    [$i3 + 2], $f4              # |     10,334 |     10,334 |
    fsub    $f3, $f4, $f3               # |     10,334 |     10,334 |
    load    [ext_light_dirvec + 1], $i3 # |     10,334 |     10,334 |
    load    [$i3 + $i1], $i1            # |     10,334 |     10,334 |
    load    [$i2 + 1], $i3              # |     10,334 |     10,334 |
    bne     $i3, 1, be_else.32582       # |     10,334 |     10,334 |
be_then.32582:
    load    [ext_light_dirvec + 0], $i3 # |     10,334 |     10,334 |
    load    [$i2 + 4], $i4              # |     10,334 |     10,334 |
    load    [$i4 + 1], $f4              # |     10,334 |     10,334 |
    load    [$i3 + 1], $f5              # |     10,334 |     10,334 |
    load    [$i1 + 0], $f6              # |     10,334 |     10,334 |
    fsub    $f6, $f1, $f6               # |     10,334 |     10,334 |
    load    [$i1 + 1], $f7              # |     10,334 |     10,334 |
    fmul    $f6, $f7, $f6               # |     10,334 |     10,334 |
    fmul    $f6, $f5, $f5               # |     10,334 |     10,334 |
    fadd_a  $f5, $f2, $f5               # |     10,334 |     10,334 |
    bg      $f4, $f5, ble_else.32583    # |     10,334 |     10,334 |
ble_then.32583:
    li      0, $i4                      # |      6,459 |      6,459 |
.count b_cont
    b       ble_cont.32583              # |      6,459 |      6,459 |
ble_else.32583:
    load    [$i2 + 4], $i4              # |      3,875 |      3,875 |
    load    [$i4 + 2], $f4              # |      3,875 |      3,875 |
    load    [$i3 + 2], $f5              # |      3,875 |      3,875 |
    fmul    $f6, $f5, $f5               # |      3,875 |      3,875 |
    fadd_a  $f5, $f3, $f5               # |      3,875 |      3,875 |
    bg      $f4, $f5, ble_else.32584    # |      3,875 |      3,875 |
ble_then.32584:
    li      0, $i4                      # |      3,875 |      3,875 |
.count b_cont
    b       ble_cont.32584              # |      3,875 |      3,875 |
ble_else.32584:
    load    [$i1 + 1], $f4
    bne     $f4, $f0, be_else.32585
be_then.32585:
    li      0, $i4
.count b_cont
    b       be_cont.32585
be_else.32585:
    li      1, $i4
be_cont.32585:
ble_cont.32584:
ble_cont.32583:
    bne     $i4, 0, be_else.32586       # |     10,334 |     10,334 |
be_then.32586:
    load    [$i2 + 4], $i4              # |     10,334 |     10,334 |
    load    [$i4 + 0], $f4              # |     10,334 |     10,334 |
    load    [$i3 + 0], $f5              # |     10,334 |     10,334 |
    load    [$i1 + 2], $f6              # |     10,334 |     10,334 |
    fsub    $f6, $f2, $f6               # |     10,334 |     10,334 |
    load    [$i1 + 3], $f7              # |     10,334 |     10,334 |
    fmul    $f6, $f7, $f6               # |     10,334 |     10,334 |
    fmul    $f6, $f5, $f5               # |     10,334 |     10,334 |
    fadd_a  $f5, $f1, $f5               # |     10,334 |     10,334 |
    bg      $f4, $f5, ble_else.32587    # |     10,334 |     10,334 |
ble_then.32587:
    li      0, $i4                      # |      9,079 |      9,079 |
.count b_cont
    b       ble_cont.32587              # |      9,079 |      9,079 |
ble_else.32587:
    load    [$i2 + 4], $i4              # |      1,255 |      1,255 |
    load    [$i4 + 2], $f4              # |      1,255 |      1,255 |
    load    [$i3 + 2], $f5              # |      1,255 |      1,255 |
    fmul    $f6, $f5, $f5               # |      1,255 |      1,255 |
    fadd_a  $f5, $f3, $f5               # |      1,255 |      1,255 |
    bg      $f4, $f5, ble_else.32588    # |      1,255 |      1,255 |
ble_then.32588:
    li      0, $i4                      # |      1,255 |      1,255 |
.count b_cont
    b       ble_cont.32588              # |      1,255 |      1,255 |
ble_else.32588:
    load    [$i1 + 3], $f4
    bne     $f4, $f0, be_else.32589
be_then.32589:
    li      0, $i4
.count b_cont
    b       be_cont.32589
be_else.32589:
    li      1, $i4
be_cont.32589:
ble_cont.32588:
ble_cont.32587:
    bne     $i4, 0, be_else.32590       # |     10,334 |     10,334 |
be_then.32590:
    load    [$i2 + 4], $i4              # |     10,334 |     10,334 |
    load    [$i4 + 0], $f4              # |     10,334 |     10,334 |
    load    [$i3 + 0], $f5              # |     10,334 |     10,334 |
    load    [$i1 + 4], $f6              # |     10,334 |     10,334 |
    fsub    $f6, $f3, $f3               # |     10,334 |     10,334 |
    load    [$i1 + 5], $f6              # |     10,334 |     10,334 |
    fmul    $f3, $f6, $f3               # |     10,334 |     10,334 |
    fmul    $f3, $f5, $f5               # |     10,334 |     10,334 |
    fadd_a  $f5, $f1, $f1               # |     10,334 |     10,334 |
    bg      $f4, $f1, ble_else.32591    # |     10,334 |     10,334 |
ble_then.32591:
    li      0, $i1                      # |     10,334 |     10,334 |
.count b_cont
    b       be_cont.32582               # |     10,334 |     10,334 |
ble_else.32591:
    load    [$i2 + 4], $i2
    load    [$i2 + 1], $f1
    load    [$i3 + 1], $f4
    fmul    $f3, $f4, $f4
    fadd_a  $f4, $f2, $f2
    bg      $f1, $f2, ble_else.32592
ble_then.32592:
    li      0, $i1
.count b_cont
    b       be_cont.32582
ble_else.32592:
    load    [$i1 + 5], $f1
    bne     $f1, $f0, be_else.32593
be_then.32593:
    li      0, $i1
.count b_cont
    b       be_cont.32582
be_else.32593:
    mov     $f3, $fg0
    li      3, $i1
.count b_cont
    b       be_cont.32582
be_else.32590:
    mov     $f6, $fg0
    li      2, $i1
.count b_cont
    b       be_cont.32582
be_else.32586:
    mov     $f6, $fg0
    li      1, $i1
.count b_cont
    b       be_cont.32582
be_else.32582:
    load    [$i1 + 0], $f4
    bne     $i3, 2, be_else.32594
be_then.32594:
    bg      $f0, $f4, ble_else.32595
ble_then.32595:
    li      0, $i1
.count b_cont
    b       be_cont.32594
ble_else.32595:
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
    b       be_cont.32594
be_else.32594:
    bne     $f4, $f0, be_else.32596
be_then.32596:
    li      0, $i1
.count b_cont
    b       be_cont.32596
be_else.32596:
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
    load    [$i2 + 4], $i4
    load    [$i4 + 1], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f3, $f8
    load    [$i2 + 4], $i4
    load    [$i4 + 2], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    load    [$i2 + 3], $i4
    bne     $i4, 0, be_else.32597
be_then.32597:
    mov     $f7, $f1
.count b_cont
    b       be_cont.32597
be_else.32597:
    fmul    $f2, $f3, $f8
    load    [$i2 + 9], $i4
    load    [$i4 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i2 + 9], $i4
    load    [$i4 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i2 + 9], $i4
    load    [$i4 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.32597:
    bne     $i3, 3, be_cont.32598
be_then.32598:
    fsub    $f1, $fc0, $f1
be_cont.32598:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    bg      $f1, $f0, ble_else.32599
ble_then.32599:
    li      0, $i1
.count b_cont
    b       ble_cont.32599
ble_else.32599:
    load    [$i2 + 6], $i2
    load    [$i1 + 4], $f2
    li      1, $i1
    fsqrt   $f1, $f1
    bne     $i2, 0, be_else.32600
be_then.32600:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
.count b_cont
    b       be_cont.32600
be_else.32600:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
be_cont.32600:
ble_cont.32599:
be_cont.32596:
be_cont.32594:
be_cont.32582:
    bne     $i1, 0, be_else.32601       # |     10,334 |     10,334 |
be_then.32601:
    li      0, $i1                      # |     10,334 |     10,334 |
.count b_cont
    b       be_cont.32601               # |     10,334 |     10,334 |
be_else.32601:
    bg      $fc7, $fg0, ble_else.32602
ble_then.32602:
    li      0, $i1
.count b_cont
    b       ble_cont.32602
ble_else.32602:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32603
be_then.32603:
    li      0, $i1
.count b_cont
    b       be_cont.32603
be_else.32603:
    load    [ext_and_net + $i1], $i11
    li      0, $i10
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32604
be_then.32604:
    li      2, $i12
.count move_args
    mov     $i16, $i13
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, be_else.32605
be_then.32605:
    li      0, $i1
.count b_cont
    b       be_cont.32604
be_else.32605:
    li      1, $i1
.count b_cont
    b       be_cont.32604
be_else.32604:
    li      1, $i1
be_cont.32604:
be_cont.32603:
ble_cont.32602:
be_cont.32601:
be_cont.32581:
    bne     $i1, 0, be_else.32606       # |    554,939 |    554,939 |
be_then.32606:
    add     $i14, 1, $i14               # |     10,334 |     10,334 |
    load    [$i15 + $i14], $i16         # |     10,334 |     10,334 |
    load    [$i16 + 0], $i1             # |     10,334 |     10,334 |
    bne     $i1, -1, be_else.32607      # |     10,334 |     10,334 |
be_then.32607:
    li      0, $i1
    jr      $ra3
be_else.32607:
    bne     $i1, 99, be_else.32608      # |     10,334 |     10,334 |
be_then.32608:
    li      1, $i1                      # |     10,334 |     10,334 |
.count b_cont
    b       be_cont.32608               # |     10,334 |     10,334 |
be_else.32608:
    call    solver_fast.2796
    bne     $i1, 0, be_else.32609
be_then.32609:
    li      0, $i1
.count b_cont
    b       be_cont.32609
be_else.32609:
    bg      $fc7, $fg0, ble_else.32610
ble_then.32610:
    li      0, $i1
.count b_cont
    b       ble_cont.32610
ble_else.32610:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32611
be_then.32611:
    li      0, $i1
.count b_cont
    b       be_cont.32611
be_else.32611:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32612
be_then.32612:
    load    [$i16 + 2], $i1
    bne     $i1, -1, be_else.32613
be_then.32613:
    li      0, $i1
.count b_cont
    b       be_cont.32612
be_else.32613:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32614
be_then.32614:
    li      3, $i12
.count move_args
    mov     $i16, $i13
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, be_else.32615
be_then.32615:
    li      0, $i1
.count b_cont
    b       be_cont.32612
be_else.32615:
    li      1, $i1
.count b_cont
    b       be_cont.32612
be_else.32614:
    li      1, $i1
.count b_cont
    b       be_cont.32612
be_else.32612:
    li      1, $i1
be_cont.32612:
be_cont.32611:
ble_cont.32610:
be_cont.32609:
be_cont.32608:
    bne     $i1, 0, be_else.32616       # |     10,334 |     10,334 |
be_then.32616:
    add     $i14, 1, $i14
    b       shadow_check_one_or_matrix.2868
be_else.32616:
    load    [$i16 + 1], $i1             # |     10,334 |     10,334 |
    bne     $i1, -1, be_else.32617      # |     10,334 |     10,334 |
be_then.32617:
    add     $i14, 1, $i14
    b       shadow_check_one_or_matrix.2868
be_else.32617:
    li      0, $i10                     # |     10,334 |     10,334 |
    load    [ext_and_net + $i1], $i11   # |     10,334 |     10,334 |
    jal     shadow_check_and_group.2862, $ra1# |     10,334 |     10,334 |
    bne     $i1, 0, be_else.32618       # |     10,334 |     10,334 |
be_then.32618:
    load    [$i16 + 2], $i1             # |     10,334 |     10,334 |
    bne     $i1, -1, be_else.32619      # |     10,334 |     10,334 |
be_then.32619:
    add     $i14, 1, $i14
    b       shadow_check_one_or_matrix.2868
be_else.32619:
    li      0, $i10                     # |     10,334 |     10,334 |
    load    [ext_and_net + $i1], $i11   # |     10,334 |     10,334 |
    jal     shadow_check_and_group.2862, $ra1# |     10,334 |     10,334 |
    bne     $i1, 0, be_else.32620       # |     10,334 |     10,334 |
be_then.32620:
    li      3, $i12                     # |     10,334 |     10,334 |
.count move_args
    mov     $i16, $i13                  # |     10,334 |     10,334 |
    jal     shadow_check_one_or_group.2865, $ra2# |     10,334 |     10,334 |
    bne     $i1, 0, be_else.32621       # |     10,334 |     10,334 |
be_then.32621:
    add     $i14, 1, $i14               # |     10,334 |     10,334 |
    b       shadow_check_one_or_matrix.2868# |     10,334 |     10,334 |
be_else.32621:
    li      1, $i1
    jr      $ra3
be_else.32620:
    li      1, $i1
    jr      $ra3
be_else.32618:
    li      1, $i1
    jr      $ra3
be_else.32606:
    load    [$i16 + 1], $i1             # |    544,605 |    544,605 |
    bne     $i1, -1, be_else.32622      # |    544,605 |    544,605 |
be_then.32622:
    li      0, $i1
.count b_cont
    b       be_cont.32622
be_else.32622:
    load    [ext_and_net + $i1], $i11   # |    544,605 |    544,605 |
    li      0, $i10                     # |    544,605 |    544,605 |
    jal     shadow_check_and_group.2862, $ra1# |    544,605 |    544,605 |
    bne     $i1, 0, be_else.32623       # |    544,605 |    544,605 |
be_then.32623:
    load    [$i16 + 2], $i1             # |    544,605 |    544,605 |
    bne     $i1, -1, be_else.32624      # |    544,605 |    544,605 |
be_then.32624:
    li      0, $i1
.count b_cont
    b       be_cont.32623
be_else.32624:
    li      0, $i10                     # |    544,605 |    544,605 |
    load    [ext_and_net + $i1], $i11   # |    544,605 |    544,605 |
    jal     shadow_check_and_group.2862, $ra1# |    544,605 |    544,605 |
    bne     $i1, 0, be_else.32625       # |    544,605 |    544,605 |
be_then.32625:
    load    [$i16 + 3], $i1             # |    543,022 |    543,022 |
    bne     $i1, -1, be_else.32626      # |    543,022 |    543,022 |
be_then.32626:
    li      0, $i1
.count b_cont
    b       be_cont.32623
be_else.32626:
    li      0, $i10                     # |    543,022 |    543,022 |
    load    [ext_and_net + $i1], $i11   # |    543,022 |    543,022 |
    jal     shadow_check_and_group.2862, $ra1# |    543,022 |    543,022 |
    bne     $i1, 0, be_else.32627       # |    543,022 |    543,022 |
be_then.32627:
    load    [$i16 + 4], $i1             # |    541,069 |    541,069 |
    bne     $i1, -1, be_else.32628      # |    541,069 |    541,069 |
be_then.32628:
    li      0, $i1
.count b_cont
    b       be_cont.32623
be_else.32628:
    li      0, $i10                     # |    541,069 |    541,069 |
    load    [ext_and_net + $i1], $i11   # |    541,069 |    541,069 |
    jal     shadow_check_and_group.2862, $ra1# |    541,069 |    541,069 |
    bne     $i1, 0, be_else.32629       # |    541,069 |    541,069 |
be_then.32629:
    load    [$i16 + 5], $i1             # |    540,655 |    540,655 |
    bne     $i1, -1, be_else.32630      # |    540,655 |    540,655 |
be_then.32630:
    li      0, $i1                      # |    540,655 |    540,655 |
.count b_cont
    b       be_cont.32623               # |    540,655 |    540,655 |
be_else.32630:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32631
be_then.32631:
    load    [$i16 + 6], $i1
    bne     $i1, -1, be_else.32632
be_then.32632:
    li      0, $i1
.count b_cont
    b       be_cont.32623
be_else.32632:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32633
be_then.32633:
    load    [$i16 + 7], $i1
    bne     $i1, -1, be_else.32634
be_then.32634:
    li      0, $i1
.count b_cont
    b       be_cont.32623
be_else.32634:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32635
be_then.32635:
    li      8, $i12
.count move_args
    mov     $i16, $i13
    jal     shadow_check_one_or_group.2865, $ra2
.count b_cont
    b       be_cont.32623
be_else.32635:
    li      1, $i1
.count b_cont
    b       be_cont.32623
be_else.32633:
    li      1, $i1
.count b_cont
    b       be_cont.32623
be_else.32631:
    li      1, $i1
.count b_cont
    b       be_cont.32623
be_else.32629:
    li      1, $i1                      # |        414 |        414 |
.count b_cont
    b       be_cont.32623               # |        414 |        414 |
be_else.32627:
    li      1, $i1                      # |      1,953 |      1,953 |
.count b_cont
    b       be_cont.32623               # |      1,953 |      1,953 |
be_else.32625:
    li      1, $i1                      # |      1,583 |      1,583 |
.count b_cont
    b       be_cont.32623               # |      1,583 |      1,583 |
be_else.32623:
    li      1, $i1
be_cont.32623:
be_cont.32622:
    bne     $i1, 0, be_else.32636       # |    544,605 |    544,605 |
be_then.32636:
    add     $i14, 1, $i14               # |    540,655 |    540,655 |
    load    [$i15 + $i14], $i16         # |    540,655 |    540,655 |
    load    [$i16 + 0], $i1             # |    540,655 |    540,655 |
    bne     $i1, -1, be_else.32637      # |    540,655 |    540,655 |
be_then.32637:
    li      0, $i1                      # |    540,655 |    540,655 |
    jr      $ra3                        # |    540,655 |    540,655 |
be_else.32637:
    bne     $i1, 99, be_else.32638
be_then.32638:
    li      1, $i1
.count b_cont
    b       be_cont.32638
be_else.32638:
    call    solver_fast.2796
    bne     $i1, 0, be_else.32639
be_then.32639:
    li      0, $i1
.count b_cont
    b       be_cont.32639
be_else.32639:
    bg      $fc7, $fg0, ble_else.32640
ble_then.32640:
    li      0, $i1
.count b_cont
    b       ble_cont.32640
ble_else.32640:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32641
be_then.32641:
    li      0, $i1
.count b_cont
    b       be_cont.32641
be_else.32641:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32642
be_then.32642:
    load    [$i16 + 2], $i1
    bne     $i1, -1, be_else.32643
be_then.32643:
    li      0, $i1
.count b_cont
    b       be_cont.32642
be_else.32643:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32644
be_then.32644:
    li      3, $i12
.count move_args
    mov     $i16, $i13
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, be_else.32645
be_then.32645:
    li      0, $i1
.count b_cont
    b       be_cont.32642
be_else.32645:
    li      1, $i1
.count b_cont
    b       be_cont.32642
be_else.32644:
    li      1, $i1
.count b_cont
    b       be_cont.32642
be_else.32642:
    li      1, $i1
be_cont.32642:
be_cont.32641:
ble_cont.32640:
be_cont.32639:
be_cont.32638:
    bne     $i1, 0, be_else.32646
be_then.32646:
    add     $i14, 1, $i14
    b       shadow_check_one_or_matrix.2868
be_else.32646:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32647
be_then.32647:
    add     $i14, 1, $i14
    b       shadow_check_one_or_matrix.2868
be_else.32647:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32648
be_then.32648:
    load    [$i16 + 2], $i1
    bne     $i1, -1, be_else.32649
be_then.32649:
    add     $i14, 1, $i14
    b       shadow_check_one_or_matrix.2868
be_else.32649:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.32650
be_then.32650:
    li      3, $i12
.count move_args
    mov     $i16, $i13
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, be_else.32651
be_then.32651:
    add     $i14, 1, $i14
    b       shadow_check_one_or_matrix.2868
be_else.32651:
    li      1, $i1
    jr      $ra3
be_else.32650:
    li      1, $i1
    jr      $ra3
be_else.32648:
    li      1, $i1
    jr      $ra3
be_else.32636:
    li      1, $i1                      # |      3,950 |      3,950 |
    jr      $ra3                        # |      3,950 |      3,950 |
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i10, $i11, $i12)
# $ra = $ra1
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element
solve_each_element.2871:
    load    [$i11 + $i10], $i13         # |    193,311 |    193,311 |
    bne     $i13, -1, be_else.32652     # |    193,311 |    193,311 |
be_then.32652:
    jr      $ra1                        # |     43,491 |     43,491 |
be_else.32652:
    load    [ext_objects + $i13], $i1   # |    149,820 |    149,820 |
    load    [$i1 + 5], $i2              # |    149,820 |    149,820 |
    load    [$i1 + 5], $i3              # |    149,820 |    149,820 |
    load    [$i1 + 5], $i4              # |    149,820 |    149,820 |
    load    [$i1 + 1], $i5              # |    149,820 |    149,820 |
    load    [$i2 + 0], $f1              # |    149,820 |    149,820 |
    fsub    $fg21, $f1, $f1             # |    149,820 |    149,820 |
    load    [$i3 + 1], $f2              # |    149,820 |    149,820 |
    fsub    $fg22, $f2, $f2             # |    149,820 |    149,820 |
    load    [$i4 + 2], $f3              # |    149,820 |    149,820 |
    fsub    $fg23, $f3, $f3             # |    149,820 |    149,820 |
    load    [$i12 + 0], $f4             # |    149,820 |    149,820 |
    bne     $i5, 1, be_else.32653       # |    149,820 |    149,820 |
be_then.32653:
    bne     $f4, $f0, be_else.32654     # |     50,858 |     50,858 |
be_then.32654:
    li      0, $i2
.count b_cont
    b       be_cont.32654
be_else.32654:
    load    [$i1 + 4], $i2              # |     50,858 |     50,858 |
    load    [$i1 + 6], $i3              # |     50,858 |     50,858 |
    bg      $f0, $f4, ble_else.32655    # |     50,858 |     50,858 |
ble_then.32655:
    li      0, $i4                      # |     50,160 |     50,160 |
.count b_cont
    b       ble_cont.32655              # |     50,160 |     50,160 |
ble_else.32655:
    li      1, $i4                      # |        698 |        698 |
ble_cont.32655:
    bne     $i3, 0, be_else.32656       # |     50,858 |     50,858 |
be_then.32656:
    mov     $i4, $i3                    # |     50,858 |     50,858 |
.count b_cont
    b       be_cont.32656               # |     50,858 |     50,858 |
be_else.32656:
    bne     $i4, 0, be_else.32657
be_then.32657:
    li      1, $i3
.count b_cont
    b       be_cont.32657
be_else.32657:
    li      0, $i3
be_cont.32657:
be_cont.32656:
    load    [$i2 + 0], $f5              # |     50,858 |     50,858 |
    bne     $i3, 0, be_cont.32658       # |     50,858 |     50,858 |
be_then.32658:
    fneg    $f5, $f5                    # |     50,160 |     50,160 |
be_cont.32658:
    fsub    $f5, $f1, $f5               # |     50,858 |     50,858 |
    finv    $f4, $f4                    # |     50,858 |     50,858 |
    fmul    $f5, $f4, $f4               # |     50,858 |     50,858 |
    load    [$i2 + 1], $f5              # |     50,858 |     50,858 |
    load    [$i12 + 1], $f6             # |     50,858 |     50,858 |
    fmul    $f4, $f6, $f6               # |     50,858 |     50,858 |
    fadd_a  $f6, $f2, $f6               # |     50,858 |     50,858 |
    bg      $f5, $f6, ble_else.32659    # |     50,858 |     50,858 |
ble_then.32659:
    li      0, $i2                      # |     41,048 |     41,048 |
.count b_cont
    b       ble_cont.32659              # |     41,048 |     41,048 |
ble_else.32659:
    load    [$i2 + 2], $f5              # |      9,810 |      9,810 |
    load    [$i12 + 2], $f6             # |      9,810 |      9,810 |
    fmul    $f4, $f6, $f6               # |      9,810 |      9,810 |
    fadd_a  $f6, $f3, $f6               # |      9,810 |      9,810 |
    bg      $f5, $f6, ble_else.32660    # |      9,810 |      9,810 |
ble_then.32660:
    li      0, $i2                      # |      5,699 |      5,699 |
.count b_cont
    b       ble_cont.32660              # |      5,699 |      5,699 |
ble_else.32660:
    mov     $f4, $fg0                   # |      4,111 |      4,111 |
    li      1, $i2                      # |      4,111 |      4,111 |
ble_cont.32660:
ble_cont.32659:
be_cont.32654:
    bne     $i2, 0, be_else.32661       # |     50,858 |     50,858 |
be_then.32661:
    load    [$i12 + 1], $f4             # |     46,747 |     46,747 |
    bne     $f4, $f0, be_else.32662     # |     46,747 |     46,747 |
be_then.32662:
    li      0, $i2
.count b_cont
    b       be_cont.32662
be_else.32662:
    load    [$i1 + 4], $i2              # |     46,747 |     46,747 |
    load    [$i1 + 6], $i3              # |     46,747 |     46,747 |
    bg      $f0, $f4, ble_else.32663    # |     46,747 |     46,747 |
ble_then.32663:
    li      0, $i4                      # |        217 |        217 |
.count b_cont
    b       ble_cont.32663              # |        217 |        217 |
ble_else.32663:
    li      1, $i4                      # |     46,530 |     46,530 |
ble_cont.32663:
    bne     $i3, 0, be_else.32664       # |     46,747 |     46,747 |
be_then.32664:
    mov     $i4, $i3                    # |     46,747 |     46,747 |
.count b_cont
    b       be_cont.32664               # |     46,747 |     46,747 |
be_else.32664:
    bne     $i4, 0, be_else.32665
be_then.32665:
    li      1, $i3
.count b_cont
    b       be_cont.32665
be_else.32665:
    li      0, $i3
be_cont.32665:
be_cont.32664:
    load    [$i2 + 1], $f5              # |     46,747 |     46,747 |
    bne     $i3, 0, be_cont.32666       # |     46,747 |     46,747 |
be_then.32666:
    fneg    $f5, $f5                    # |        217 |        217 |
be_cont.32666:
    fsub    $f5, $f2, $f5               # |     46,747 |     46,747 |
    finv    $f4, $f4                    # |     46,747 |     46,747 |
    fmul    $f5, $f4, $f4               # |     46,747 |     46,747 |
    load    [$i2 + 2], $f5              # |     46,747 |     46,747 |
    load    [$i12 + 2], $f6             # |     46,747 |     46,747 |
    fmul    $f4, $f6, $f6               # |     46,747 |     46,747 |
    fadd_a  $f6, $f3, $f6               # |     46,747 |     46,747 |
    bg      $f5, $f6, ble_else.32667    # |     46,747 |     46,747 |
ble_then.32667:
    li      0, $i2                      # |     28,211 |     28,211 |
.count b_cont
    b       ble_cont.32667              # |     28,211 |     28,211 |
ble_else.32667:
    load    [$i2 + 0], $f5              # |     18,536 |     18,536 |
    load    [$i12 + 0], $f6             # |     18,536 |     18,536 |
    fmul    $f4, $f6, $f6               # |     18,536 |     18,536 |
    fadd_a  $f6, $f1, $f6               # |     18,536 |     18,536 |
    bg      $f5, $f6, ble_else.32668    # |     18,536 |     18,536 |
ble_then.32668:
    li      0, $i2                      # |      6,456 |      6,456 |
.count b_cont
    b       ble_cont.32668              # |      6,456 |      6,456 |
ble_else.32668:
    mov     $f4, $fg0                   # |     12,080 |     12,080 |
    li      1, $i2                      # |     12,080 |     12,080 |
ble_cont.32668:
ble_cont.32667:
be_cont.32662:
    bne     $i2, 0, be_else.32669       # |     46,747 |     46,747 |
be_then.32669:
    load    [$i12 + 2], $f4             # |     34,667 |     34,667 |
    bne     $f4, $f0, be_else.32670     # |     34,667 |     34,667 |
be_then.32670:
    li      0, $i14
.count b_cont
    b       be_cont.32653
be_else.32670:
    load    [$i1 + 4], $i2              # |     34,667 |     34,667 |
    load    [$i2 + 0], $f5              # |     34,667 |     34,667 |
    load    [$i12 + 0], $f6             # |     34,667 |     34,667 |
    load    [$i1 + 6], $i1              # |     34,667 |     34,667 |
    bg      $f0, $f4, ble_else.32671    # |     34,667 |     34,667 |
ble_then.32671:
    li      0, $i3                      # |     24,683 |     24,683 |
.count b_cont
    b       ble_cont.32671              # |     24,683 |     24,683 |
ble_else.32671:
    li      1, $i3                      # |      9,984 |      9,984 |
ble_cont.32671:
    bne     $i1, 0, be_else.32672       # |     34,667 |     34,667 |
be_then.32672:
    mov     $i3, $i1                    # |     34,667 |     34,667 |
.count b_cont
    b       be_cont.32672               # |     34,667 |     34,667 |
be_else.32672:
    bne     $i3, 0, be_else.32673
be_then.32673:
    li      1, $i1
.count b_cont
    b       be_cont.32673
be_else.32673:
    li      0, $i1
be_cont.32673:
be_cont.32672:
    load    [$i2 + 2], $f7              # |     34,667 |     34,667 |
    bne     $i1, 0, be_cont.32674       # |     34,667 |     34,667 |
be_then.32674:
    fneg    $f7, $f7                    # |     24,683 |     24,683 |
be_cont.32674:
    fsub    $f7, $f3, $f3               # |     34,667 |     34,667 |
    finv    $f4, $f4                    # |     34,667 |     34,667 |
    fmul    $f3, $f4, $f3               # |     34,667 |     34,667 |
    fmul    $f3, $f6, $f4               # |     34,667 |     34,667 |
    fadd_a  $f4, $f1, $f1               # |     34,667 |     34,667 |
    bg      $f5, $f1, ble_else.32675    # |     34,667 |     34,667 |
ble_then.32675:
    li      0, $i14                     # |     18,798 |     18,798 |
.count b_cont
    b       be_cont.32653               # |     18,798 |     18,798 |
ble_else.32675:
    load    [$i2 + 1], $f1              # |     15,869 |     15,869 |
    load    [$i12 + 1], $f4             # |     15,869 |     15,869 |
    fmul    $f3, $f4, $f4               # |     15,869 |     15,869 |
    fadd_a  $f4, $f2, $f2               # |     15,869 |     15,869 |
    bg      $f1, $f2, ble_else.32676    # |     15,869 |     15,869 |
ble_then.32676:
    li      0, $i14                     # |     12,844 |     12,844 |
.count b_cont
    b       be_cont.32653               # |     12,844 |     12,844 |
ble_else.32676:
    mov     $f3, $fg0                   # |      3,025 |      3,025 |
    li      3, $i14                     # |      3,025 |      3,025 |
.count b_cont
    b       be_cont.32653               # |      3,025 |      3,025 |
be_else.32669:
    li      2, $i14                     # |     12,080 |     12,080 |
.count b_cont
    b       be_cont.32653               # |     12,080 |     12,080 |
be_else.32661:
    li      1, $i14                     # |      4,111 |      4,111 |
.count b_cont
    b       be_cont.32653               # |      4,111 |      4,111 |
be_else.32653:
    bne     $i5, 2, be_else.32677       # |     98,962 |     98,962 |
be_then.32677:
    load    [$i1 + 4], $i1              # |     24,693 |     24,693 |
    load    [$i1 + 0], $f5              # |     24,693 |     24,693 |
    fmul    $f4, $f5, $f4               # |     24,693 |     24,693 |
    load    [$i12 + 1], $f6             # |     24,693 |     24,693 |
    load    [$i1 + 1], $f7              # |     24,693 |     24,693 |
    fmul    $f6, $f7, $f6               # |     24,693 |     24,693 |
    fadd    $f4, $f6, $f4               # |     24,693 |     24,693 |
    load    [$i12 + 2], $f6             # |     24,693 |     24,693 |
    load    [$i1 + 2], $f8              # |     24,693 |     24,693 |
    fmul    $f6, $f8, $f6               # |     24,693 |     24,693 |
    fadd    $f4, $f6, $f4               # |     24,693 |     24,693 |
    bg      $f4, $f0, ble_else.32678    # |     24,693 |     24,693 |
ble_then.32678:
    li      0, $i14                     # |      7,535 |      7,535 |
.count b_cont
    b       be_cont.32677               # |      7,535 |      7,535 |
ble_else.32678:
    fmul    $f5, $f1, $f1               # |     17,158 |     17,158 |
    fmul    $f7, $f2, $f2               # |     17,158 |     17,158 |
    fadd    $f1, $f2, $f1               # |     17,158 |     17,158 |
    fmul    $f8, $f3, $f2               # |     17,158 |     17,158 |
    fadd_n  $f1, $f2, $f1               # |     17,158 |     17,158 |
    finv    $f4, $f2                    # |     17,158 |     17,158 |
    fmul    $f1, $f2, $fg0              # |     17,158 |     17,158 |
    li      1, $i14                     # |     17,158 |     17,158 |
.count b_cont
    b       be_cont.32677               # |     17,158 |     17,158 |
be_else.32677:
    load    [$i1 + 3], $i2              # |     74,269 |     74,269 |
    load    [$i1 + 4], $i3              # |     74,269 |     74,269 |
    load    [$i1 + 4], $i4              # |     74,269 |     74,269 |
    load    [$i1 + 4], $i5              # |     74,269 |     74,269 |
    load    [$i12 + 1], $f5             # |     74,269 |     74,269 |
    load    [$i12 + 2], $f6             # |     74,269 |     74,269 |
    fmul    $f4, $f4, $f7               # |     74,269 |     74,269 |
    load    [$i3 + 0], $f8              # |     74,269 |     74,269 |
    fmul    $f7, $f8, $f7               # |     74,269 |     74,269 |
    fmul    $f5, $f5, $f9               # |     74,269 |     74,269 |
    load    [$i4 + 1], $f10             # |     74,269 |     74,269 |
    fmul    $f9, $f10, $f9              # |     74,269 |     74,269 |
    fadd    $f7, $f9, $f7               # |     74,269 |     74,269 |
    fmul    $f6, $f6, $f9               # |     74,269 |     74,269 |
    load    [$i5 + 2], $f11             # |     74,269 |     74,269 |
    fmul    $f9, $f11, $f9              # |     74,269 |     74,269 |
    fadd    $f7, $f9, $f7               # |     74,269 |     74,269 |
    be      $i2, 0, bne_cont.32679      # |     74,269 |     74,269 |
bne_then.32679:
    fmul    $f5, $f6, $f9
    load    [$i1 + 9], $i3
    load    [$i3 + 0], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f4, $f9
    load    [$i1 + 9], $i3
    load    [$i3 + 1], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f4, $f5, $f9
    load    [$i1 + 9], $i3
    load    [$i3 + 2], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
bne_cont.32679:
    bne     $f7, $f0, be_else.32680     # |     74,269 |     74,269 |
be_then.32680:
    li      0, $i14
.count b_cont
    b       be_cont.32680
be_else.32680:
    load    [$i1 + 1], $i3              # |     74,269 |     74,269 |
    fmul    $f4, $f1, $f9               # |     74,269 |     74,269 |
    fmul    $f9, $f8, $f9               # |     74,269 |     74,269 |
    fmul    $f5, $f2, $f12              # |     74,269 |     74,269 |
    fmul    $f12, $f10, $f12            # |     74,269 |     74,269 |
    fadd    $f9, $f12, $f9              # |     74,269 |     74,269 |
    fmul    $f6, $f3, $f12              # |     74,269 |     74,269 |
    fmul    $f12, $f11, $f12            # |     74,269 |     74,269 |
    fadd    $f9, $f12, $f9              # |     74,269 |     74,269 |
    bne     $i2, 0, be_else.32681       # |     74,269 |     74,269 |
be_then.32681:
    mov     $f9, $f4                    # |     74,269 |     74,269 |
.count b_cont
    b       be_cont.32681               # |     74,269 |     74,269 |
be_else.32681:
    fmul    $f6, $f2, $f12
    fmul    $f5, $f3, $f13
    fadd    $f12, $f13, $f12
    load    [$i1 + 9], $i4
    load    [$i4 + 0], $f13
    fmul    $f12, $f13, $f12
    fmul    $f4, $f3, $f13
    fmul    $f6, $f1, $f6
    fadd    $f13, $f6, $f6
    load    [$i1 + 9], $i4
    load    [$i4 + 1], $f13
    fmul    $f6, $f13, $f6
    fadd    $f12, $f6, $f6
    fmul    $f4, $f2, $f4
    fmul    $f5, $f1, $f5
    fadd    $f4, $f5, $f4
    load    [$i1 + 9], $i4
    load    [$i4 + 2], $f5
    fmul    $f4, $f5, $f4
    fadd    $f6, $f4, $f4
    fmul    $f4, $fc3, $f4
    fadd    $f9, $f4, $f4
be_cont.32681:
    fmul    $f4, $f4, $f5               # |     74,269 |     74,269 |
    fmul    $f1, $f1, $f6               # |     74,269 |     74,269 |
    fmul    $f6, $f8, $f6               # |     74,269 |     74,269 |
    fmul    $f2, $f2, $f8               # |     74,269 |     74,269 |
    fmul    $f8, $f10, $f8              # |     74,269 |     74,269 |
    fadd    $f6, $f8, $f6               # |     74,269 |     74,269 |
    fmul    $f3, $f3, $f8               # |     74,269 |     74,269 |
    fmul    $f8, $f11, $f8              # |     74,269 |     74,269 |
    fadd    $f6, $f8, $f6               # |     74,269 |     74,269 |
    bne     $i2, 0, be_else.32682       # |     74,269 |     74,269 |
be_then.32682:
    mov     $f6, $f1                    # |     74,269 |     74,269 |
.count b_cont
    b       be_cont.32682               # |     74,269 |     74,269 |
be_else.32682:
    fmul    $f2, $f3, $f8
    load    [$i1 + 9], $i2
    load    [$i2 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f1, $f3
    load    [$i1 + 9], $i2
    load    [$i2 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f6, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i1 + 9], $i2
    load    [$i2 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.32682:
    bne     $i3, 3, be_cont.32683       # |     74,269 |     74,269 |
be_then.32683:
    fsub    $f1, $fc0, $f1              # |     74,269 |     74,269 |
be_cont.32683:
    fmul    $f7, $f1, $f1               # |     74,269 |     74,269 |
    fsub    $f5, $f1, $f1               # |     74,269 |     74,269 |
    bg      $f1, $f0, ble_else.32684    # |     74,269 |     74,269 |
ble_then.32684:
    li      0, $i14                     # |     62,376 |     62,376 |
.count b_cont
    b       ble_cont.32684              # |     62,376 |     62,376 |
ble_else.32684:
    load    [$i1 + 6], $i1              # |     11,893 |     11,893 |
    fsqrt   $f1, $f1                    # |     11,893 |     11,893 |
    li      1, $i14                     # |     11,893 |     11,893 |
    finv    $f7, $f2                    # |     11,893 |     11,893 |
    bne     $i1, 0, be_else.32685       # |     11,893 |     11,893 |
be_then.32685:
    fneg    $f1, $f1                    # |      9,138 |      9,138 |
    fsub    $f1, $f4, $f1               # |      9,138 |      9,138 |
    fmul    $f1, $f2, $fg0              # |      9,138 |      9,138 |
.count b_cont
    b       be_cont.32685               # |      9,138 |      9,138 |
be_else.32685:
    fsub    $f1, $f4, $f1               # |      2,755 |      2,755 |
    fmul    $f1, $f2, $fg0              # |      2,755 |      2,755 |
be_cont.32685:
ble_cont.32684:
be_cont.32680:
be_cont.32677:
be_cont.32653:
    bne     $i14, 0, be_else.32686      # |    149,820 |    149,820 |
be_then.32686:
    load    [ext_objects + $i13], $i1   # |    101,553 |    101,553 |
    load    [$i1 + 6], $i1              # |    101,553 |    101,553 |
    bne     $i1, 0, be_else.32687       # |    101,553 |    101,553 |
be_then.32687:
    jr      $ra1                        # |     92,181 |     92,181 |
be_else.32687:
    add     $i10, 1, $i10               # |      9,372 |      9,372 |
    b       solve_each_element.2871     # |      9,372 |      9,372 |
be_else.32686:
    bg      $fg0, $f0, ble_else.32688   # |     48,267 |     48,267 |
ble_then.32688:
    add     $i10, 1, $i10               # |        847 |        847 |
    b       solve_each_element.2871     # |        847 |        847 |
ble_else.32688:
    bg      $fg7, $fg0, ble_else.32689  # |     47,420 |     47,420 |
ble_then.32689:
    add     $i10, 1, $i10               # |     11,681 |     11,681 |
    b       solve_each_element.2871     # |     11,681 |     11,681 |
ble_else.32689:
    li      0, $i1                      # |     35,739 |     35,739 |
    load    [$i12 + 0], $f1             # |     35,739 |     35,739 |
    fadd    $fg0, $fc16, $f10           # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg21, $f11            # |     35,739 |     35,739 |
    load    [$i12 + 1], $f1             # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg22, $f12            # |     35,739 |     35,739 |
    load    [$i12 + 2], $f1             # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg23, $f13            # |     35,739 |     35,739 |
.count move_args
    mov     $i11, $i3                   # |     35,739 |     35,739 |
.count move_args
    mov     $f11, $f2                   # |     35,739 |     35,739 |
.count move_args
    mov     $f12, $f3                   # |     35,739 |     35,739 |
.count move_args
    mov     $f13, $f4                   # |     35,739 |     35,739 |
    call    check_all_inside.2856       # |     35,739 |     35,739 |
    add     $i10, 1, $i10               # |     35,739 |     35,739 |
    be      $i1, 0, solve_each_element.2871# |     35,739 |     35,739 |
    mov     $f10, $fg7                  # |     25,164 |     25,164 |
    store   $f11, [ext_intersection_point + 0]# |     25,164 |     25,164 |
    store   $f12, [ext_intersection_point + 1]# |     25,164 |     25,164 |
    store   $f13, [ext_intersection_point + 2]# |     25,164 |     25,164 |
    mov     $i13, $ig3                  # |     25,164 |     25,164 |
    mov     $i14, $ig2                  # |     25,164 |     25,164 |
    b       solve_each_element.2871     # |     25,164 |     25,164 |
.end solve_each_element

######################################################################
# solve_one_or_network($i15, $i16, $i17)
# $ra = $ra2
# [$i1 - $i17]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
    load    [$i16 + $i15], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.32691      # |      6,776 |      6,776 |
be_then.32691:
    jr      $ra2
be_else.32691:
    li      0, $i10                     # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i11   # |      6,776 |      6,776 |
.count move_args
    mov     $i17, $i12                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i15, 1, $i15               # |      6,776 |      6,776 |
    load    [$i16 + $i15], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.32692      # |      6,776 |      6,776 |
be_then.32692:
    jr      $ra2
be_else.32692:
    li      0, $i10                     # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i11   # |      6,776 |      6,776 |
.count move_args
    mov     $i17, $i12                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i15, 1, $i15               # |      6,776 |      6,776 |
    load    [$i16 + $i15], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.32693      # |      6,776 |      6,776 |
be_then.32693:
    jr      $ra2
be_else.32693:
    li      0, $i10                     # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i11   # |      6,776 |      6,776 |
.count move_args
    mov     $i17, $i12                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i15, 1, $i15               # |      6,776 |      6,776 |
    load    [$i16 + $i15], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.32694      # |      6,776 |      6,776 |
be_then.32694:
    jr      $ra2
be_else.32694:
    li      0, $i10                     # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i11   # |      6,776 |      6,776 |
.count move_args
    mov     $i17, $i12                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i15, 1, $i15               # |      6,776 |      6,776 |
    load    [$i16 + $i15], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.32695      # |      6,776 |      6,776 |
be_then.32695:
    jr      $ra2
be_else.32695:
    li      0, $i10                     # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i11   # |      6,776 |      6,776 |
.count move_args
    mov     $i17, $i12                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i15, 1, $i15               # |      6,776 |      6,776 |
    load    [$i16 + $i15], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.32696      # |      6,776 |      6,776 |
be_then.32696:
    jr      $ra2
be_else.32696:
    li      0, $i10                     # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i11   # |      6,776 |      6,776 |
.count move_args
    mov     $i17, $i12                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i15, 1, $i15               # |      6,776 |      6,776 |
    load    [$i16 + $i15], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.32697      # |      6,776 |      6,776 |
be_then.32697:
    jr      $ra2                        # |      6,776 |      6,776 |
be_else.32697:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i17, $i12
    jal     solve_each_element.2871, $ra1
    add     $i15, 1, $i15
    load    [$i16 + $i15], $i1
    bne     $i1, -1, be_else.32698
be_then.32698:
    jr      $ra2
be_else.32698:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i17, $i12
    jal     solve_each_element.2871, $ra1
    add     $i15, 1, $i15
    b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix($i18, $i19, $i20)
# $ra = $ra3
# [$i1 - $i20]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
    load    [$i19 + $i18], $i16         # |     23,754 |     23,754 |
    load    [$i16 + 0], $i1             # |     23,754 |     23,754 |
    bne     $i1, -1, be_else.32699      # |     23,754 |     23,754 |
be_then.32699:
    jr      $ra3
be_else.32699:
    bne     $i1, 99, be_else.32700      # |     23,754 |     23,754 |
be_then.32700:
    load    [$i16 + 1], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.32701     # |     23,754 |     23,754 |
bne_then.32701:
    li      0, $i10                     # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i11   # |     23,754 |     23,754 |
.count move_args
    mov     $i20, $i12                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i16 + 2], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.32702     # |     23,754 |     23,754 |
bne_then.32702:
    li      0, $i10                     # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i11   # |     23,754 |     23,754 |
.count move_args
    mov     $i20, $i12                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i16 + 3], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.32703     # |     23,754 |     23,754 |
bne_then.32703:
    li      0, $i10                     # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i11   # |     23,754 |     23,754 |
.count move_args
    mov     $i20, $i12                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i16 + 4], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.32704     # |     23,754 |     23,754 |
bne_then.32704:
    li      0, $i10                     # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i11   # |     23,754 |     23,754 |
.count move_args
    mov     $i20, $i12                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i16 + 5], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.32705     # |     23,754 |     23,754 |
bne_then.32705:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element.2871, $ra1
    load    [$i16 + 6], $i1
    be      $i1, -1, bne_cont.32706
bne_then.32706:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element.2871, $ra1
    li      7, $i15
.count move_args
    mov     $i20, $i17
    jal     solve_one_or_network.2875, $ra2
bne_cont.32706:
bne_cont.32705:
bne_cont.32704:
bne_cont.32703:
bne_cont.32702:
bne_cont.32701:
    add     $i18, 1, $i18               # |     23,754 |     23,754 |
    load    [$i19 + $i18], $i16         # |     23,754 |     23,754 |
    load    [$i16 + 0], $i1             # |     23,754 |     23,754 |
    bne     $i1, -1, be_else.32707      # |     23,754 |     23,754 |
be_then.32707:
    jr      $ra3                        # |     23,754 |     23,754 |
be_else.32707:
    bne     $i1, 99, be_else.32708
be_then.32708:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32709
be_then.32709:
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
be_else.32709:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element.2871, $ra1
    load    [$i16 + 2], $i1
    bne     $i1, -1, be_else.32710
be_then.32710:
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
be_else.32710:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element.2871, $ra1
    load    [$i16 + 3], $i1
    bne     $i1, -1, be_else.32711
be_then.32711:
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
be_else.32711:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element.2871, $ra1
    load    [$i16 + 4], $i1
    bne     $i1, -1, be_else.32712
be_then.32712:
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
be_else.32712:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element.2871, $ra1
    li      5, $i15
.count move_args
    mov     $i20, $i17
    jal     solve_one_or_network.2875, $ra2
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
be_else.32708:
.count move_args
    mov     $i20, $i2
    call    solver.2773
    bne     $i1, 0, be_else.32713
be_then.32713:
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
be_else.32713:
    bg      $fg7, $fg0, ble_else.32714
ble_then.32714:
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
ble_else.32714:
    li      1, $i15
.count move_args
    mov     $i20, $i17
    jal     solve_one_or_network.2875, $ra2
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
be_else.32700:
.count move_args
    mov     $i20, $i2
    call    solver.2773
    bne     $i1, 0, be_else.32715
be_then.32715:
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
be_else.32715:
    bg      $fg7, $fg0, ble_else.32716
ble_then.32716:
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
ble_else.32716:
    li      1, $i15
.count move_args
    mov     $i20, $i17
    jal     solve_one_or_network.2875, $ra2
    add     $i18, 1, $i18
    b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i10, $i11, $i12)
# $ra = $ra1
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
    load    [$i11 + $i10], $i13         # | 13,852,375 | 13,852,375 |
    bne     $i13, -1, be_else.32717     # | 13,852,375 | 13,852,375 |
be_then.32717:
    jr      $ra1                        # |  3,308,310 |  3,308,310 |
be_else.32717:
    load    [ext_objects + $i13], $i1   # | 10,544,065 | 10,544,065 |
    load    [$i1 + 10], $i2             # | 10,544,065 | 10,544,065 |
    load    [$i12 + 1], $i3             # | 10,544,065 | 10,544,065 |
    load    [$i1 + 1], $i4              # | 10,544,065 | 10,544,065 |
    load    [$i2 + 0], $f1              # | 10,544,065 | 10,544,065 |
    load    [$i2 + 1], $f2              # | 10,544,065 | 10,544,065 |
    load    [$i2 + 2], $f3              # | 10,544,065 | 10,544,065 |
    load    [$i3 + $i13], $i3           # | 10,544,065 | 10,544,065 |
    bne     $i4, 1, be_else.32718       # | 10,544,065 | 10,544,065 |
be_then.32718:
    load    [$i12 + 0], $i2             # |  3,873,912 |  3,873,912 |
    load    [$i1 + 4], $i4              # |  3,873,912 |  3,873,912 |
    load    [$i4 + 1], $f4              # |  3,873,912 |  3,873,912 |
    load    [$i2 + 1], $f5              # |  3,873,912 |  3,873,912 |
    load    [$i3 + 0], $f6              # |  3,873,912 |  3,873,912 |
    fsub    $f6, $f1, $f6               # |  3,873,912 |  3,873,912 |
    load    [$i3 + 1], $f7              # |  3,873,912 |  3,873,912 |
    fmul    $f6, $f7, $f6               # |  3,873,912 |  3,873,912 |
    fmul    $f6, $f5, $f5               # |  3,873,912 |  3,873,912 |
    fadd_a  $f5, $f2, $f5               # |  3,873,912 |  3,873,912 |
    bg      $f4, $f5, ble_else.32719    # |  3,873,912 |  3,873,912 |
ble_then.32719:
    li      0, $i4                      # |  3,045,892 |  3,045,892 |
.count b_cont
    b       ble_cont.32719              # |  3,045,892 |  3,045,892 |
ble_else.32719:
    load    [$i1 + 4], $i4              # |    828,020 |    828,020 |
    load    [$i4 + 2], $f4              # |    828,020 |    828,020 |
    load    [$i2 + 2], $f5              # |    828,020 |    828,020 |
    fmul    $f6, $f5, $f5               # |    828,020 |    828,020 |
    fadd_a  $f5, $f3, $f5               # |    828,020 |    828,020 |
    bg      $f4, $f5, ble_else.32720    # |    828,020 |    828,020 |
ble_then.32720:
    li      0, $i4                      # |    324,595 |    324,595 |
.count b_cont
    b       ble_cont.32720              # |    324,595 |    324,595 |
ble_else.32720:
    load    [$i3 + 1], $f4              # |    503,425 |    503,425 |
    bne     $f4, $f0, be_else.32721     # |    503,425 |    503,425 |
be_then.32721:
    li      0, $i4
.count b_cont
    b       be_cont.32721
be_else.32721:
    li      1, $i4                      # |    503,425 |    503,425 |
be_cont.32721:
ble_cont.32720:
ble_cont.32719:
    bne     $i4, 0, be_else.32722       # |  3,873,912 |  3,873,912 |
be_then.32722:
    load    [$i1 + 4], $i4              # |  3,370,487 |  3,370,487 |
    load    [$i4 + 0], $f4              # |  3,370,487 |  3,370,487 |
    load    [$i2 + 0], $f5              # |  3,370,487 |  3,370,487 |
    load    [$i3 + 2], $f6              # |  3,370,487 |  3,370,487 |
    fsub    $f6, $f2, $f6               # |  3,370,487 |  3,370,487 |
    load    [$i3 + 3], $f7              # |  3,370,487 |  3,370,487 |
    fmul    $f6, $f7, $f6               # |  3,370,487 |  3,370,487 |
    fmul    $f6, $f5, $f5               # |  3,370,487 |  3,370,487 |
    fadd_a  $f5, $f1, $f5               # |  3,370,487 |  3,370,487 |
    bg      $f4, $f5, ble_else.32723    # |  3,370,487 |  3,370,487 |
ble_then.32723:
    li      0, $i4                      # |  1,577,233 |  1,577,233 |
.count b_cont
    b       ble_cont.32723              # |  1,577,233 |  1,577,233 |
ble_else.32723:
    load    [$i1 + 4], $i4              # |  1,793,254 |  1,793,254 |
    load    [$i4 + 2], $f4              # |  1,793,254 |  1,793,254 |
    load    [$i2 + 2], $f5              # |  1,793,254 |  1,793,254 |
    fmul    $f6, $f5, $f5               # |  1,793,254 |  1,793,254 |
    fadd_a  $f5, $f3, $f5               # |  1,793,254 |  1,793,254 |
    bg      $f4, $f5, ble_else.32724    # |  1,793,254 |  1,793,254 |
ble_then.32724:
    li      0, $i4                      # |    570,589 |    570,589 |
.count b_cont
    b       ble_cont.32724              # |    570,589 |    570,589 |
ble_else.32724:
    load    [$i3 + 3], $f4              # |  1,222,665 |  1,222,665 |
    bne     $f4, $f0, be_else.32725     # |  1,222,665 |  1,222,665 |
be_then.32725:
    li      0, $i4
.count b_cont
    b       be_cont.32725
be_else.32725:
    li      1, $i4                      # |  1,222,665 |  1,222,665 |
be_cont.32725:
ble_cont.32724:
ble_cont.32723:
    bne     $i4, 0, be_else.32726       # |  3,370,487 |  3,370,487 |
be_then.32726:
    load    [$i1 + 4], $i4              # |  2,147,822 |  2,147,822 |
    load    [$i4 + 0], $f4              # |  2,147,822 |  2,147,822 |
    load    [$i2 + 0], $f5              # |  2,147,822 |  2,147,822 |
    load    [$i3 + 4], $f6              # |  2,147,822 |  2,147,822 |
    fsub    $f6, $f3, $f3               # |  2,147,822 |  2,147,822 |
    load    [$i3 + 5], $f6              # |  2,147,822 |  2,147,822 |
    fmul    $f3, $f6, $f3               # |  2,147,822 |  2,147,822 |
    fmul    $f3, $f5, $f5               # |  2,147,822 |  2,147,822 |
    fadd_a  $f5, $f1, $f1               # |  2,147,822 |  2,147,822 |
    bg      $f4, $f1, ble_else.32727    # |  2,147,822 |  2,147,822 |
ble_then.32727:
    li      0, $i14                     # |  1,541,308 |  1,541,308 |
.count b_cont
    b       be_cont.32718               # |  1,541,308 |  1,541,308 |
ble_else.32727:
    load    [$i1 + 4], $i1              # |    606,514 |    606,514 |
    load    [$i1 + 1], $f1              # |    606,514 |    606,514 |
    load    [$i2 + 1], $f4              # |    606,514 |    606,514 |
    fmul    $f3, $f4, $f4               # |    606,514 |    606,514 |
    fadd_a  $f4, $f2, $f2               # |    606,514 |    606,514 |
    bg      $f1, $f2, ble_else.32728    # |    606,514 |    606,514 |
ble_then.32728:
    li      0, $i14                     # |    331,936 |    331,936 |
.count b_cont
    b       be_cont.32718               # |    331,936 |    331,936 |
ble_else.32728:
    load    [$i3 + 5], $f1              # |    274,578 |    274,578 |
    bne     $f1, $f0, be_else.32729     # |    274,578 |    274,578 |
be_then.32729:
    li      0, $i14
.count b_cont
    b       be_cont.32718
be_else.32729:
    mov     $f3, $fg0                   # |    274,578 |    274,578 |
    li      3, $i14                     # |    274,578 |    274,578 |
.count b_cont
    b       be_cont.32718               # |    274,578 |    274,578 |
be_else.32726:
    mov     $f6, $fg0                   # |  1,222,665 |  1,222,665 |
    li      2, $i14                     # |  1,222,665 |  1,222,665 |
.count b_cont
    b       be_cont.32718               # |  1,222,665 |  1,222,665 |
be_else.32722:
    mov     $f6, $fg0                   # |    503,425 |    503,425 |
    li      1, $i14                     # |    503,425 |    503,425 |
.count b_cont
    b       be_cont.32718               # |    503,425 |    503,425 |
be_else.32718:
    bne     $i4, 2, be_else.32730       # |  6,670,153 |  6,670,153 |
be_then.32730:
    load    [$i3 + 0], $f1              # |  1,242,328 |  1,242,328 |
    bg      $f0, $f1, ble_else.32731    # |  1,242,328 |  1,242,328 |
ble_then.32731:
    li      0, $i14                     # |    647,143 |    647,143 |
.count b_cont
    b       be_cont.32730               # |    647,143 |    647,143 |
ble_else.32731:
    load    [$i2 + 3], $f2              # |    595,185 |    595,185 |
    fmul    $f1, $f2, $fg0              # |    595,185 |    595,185 |
    li      1, $i14                     # |    595,185 |    595,185 |
.count b_cont
    b       be_cont.32730               # |    595,185 |    595,185 |
be_else.32730:
    load    [$i3 + 0], $f4              # |  5,427,825 |  5,427,825 |
    bne     $f4, $f0, be_else.32732     # |  5,427,825 |  5,427,825 |
be_then.32732:
    li      0, $i14
.count b_cont
    b       be_cont.32732
be_else.32732:
    load    [$i3 + 1], $f5              # |  5,427,825 |  5,427,825 |
    fmul    $f5, $f1, $f1               # |  5,427,825 |  5,427,825 |
    load    [$i3 + 2], $f5              # |  5,427,825 |  5,427,825 |
    fmul    $f5, $f2, $f2               # |  5,427,825 |  5,427,825 |
    fadd    $f1, $f2, $f1               # |  5,427,825 |  5,427,825 |
    load    [$i3 + 3], $f2              # |  5,427,825 |  5,427,825 |
    fmul    $f2, $f3, $f2               # |  5,427,825 |  5,427,825 |
    fadd    $f1, $f2, $f1               # |  5,427,825 |  5,427,825 |
    fmul    $f1, $f1, $f2               # |  5,427,825 |  5,427,825 |
    load    [$i2 + 3], $f3              # |  5,427,825 |  5,427,825 |
    fmul    $f4, $f3, $f3               # |  5,427,825 |  5,427,825 |
    fsub    $f2, $f3, $f2               # |  5,427,825 |  5,427,825 |
    bg      $f2, $f0, ble_else.32733    # |  5,427,825 |  5,427,825 |
ble_then.32733:
    li      0, $i14                     # |  3,746,732 |  3,746,732 |
.count b_cont
    b       ble_cont.32733              # |  3,746,732 |  3,746,732 |
ble_else.32733:
    load    [$i1 + 6], $i1              # |  1,681,093 |  1,681,093 |
    li      1, $i14                     # |  1,681,093 |  1,681,093 |
    fsqrt   $f2, $f2                    # |  1,681,093 |  1,681,093 |
    bne     $i1, 0, be_else.32734       # |  1,681,093 |  1,681,093 |
be_then.32734:
    fsub    $f1, $f2, $f1               # |  1,260,286 |  1,260,286 |
    load    [$i3 + 4], $f2              # |  1,260,286 |  1,260,286 |
    fmul    $f1, $f2, $fg0              # |  1,260,286 |  1,260,286 |
.count b_cont
    b       be_cont.32734               # |  1,260,286 |  1,260,286 |
be_else.32734:
    fadd    $f1, $f2, $f1               # |    420,807 |    420,807 |
    load    [$i3 + 4], $f2              # |    420,807 |    420,807 |
    fmul    $f1, $f2, $fg0              # |    420,807 |    420,807 |
be_cont.32734:
ble_cont.32733:
be_cont.32732:
be_cont.32730:
be_cont.32718:
    bne     $i14, 0, be_else.32735      # | 10,544,065 | 10,544,065 |
be_then.32735:
    load    [ext_objects + $i13], $i1   # |  6,267,119 |  6,267,119 |
    load    [$i1 + 6], $i1              # |  6,267,119 |  6,267,119 |
    bne     $i1, 0, be_else.32736       # |  6,267,119 |  6,267,119 |
be_then.32736:
    jr      $ra1                        # |  5,339,098 |  5,339,098 |
be_else.32736:
    add     $i10, 1, $i10               # |    928,021 |    928,021 |
    b       solve_each_element_fast.2885# |    928,021 |    928,021 |
be_else.32735:
    bg      $fg0, $f0, ble_else.32737   # |  4,276,946 |  4,276,946 |
ble_then.32737:
    add     $i10, 1, $i10               # |  2,880,318 |  2,880,318 |
    b       solve_each_element_fast.2885# |  2,880,318 |  2,880,318 |
ble_else.32737:
    load    [$i12 + 0], $i1             # |  1,396,628 |  1,396,628 |
    bg      $fg7, $fg0, ble_else.32738  # |  1,396,628 |  1,396,628 |
ble_then.32738:
    add     $i10, 1, $i10               # |    215,261 |    215,261 |
    b       solve_each_element_fast.2885# |    215,261 |    215,261 |
ble_else.32738:
    li      0, $i2                      # |  1,181,367 |  1,181,367 |
    load    [$i1 + 0], $f1              # |  1,181,367 |  1,181,367 |
    fadd    $fg0, $fc16, $f10           # |  1,181,367 |  1,181,367 |
    fmul    $f1, $f10, $f1              # |  1,181,367 |  1,181,367 |
    fadd    $f1, $fg8, $f11             # |  1,181,367 |  1,181,367 |
    load    [$i1 + 1], $f1              # |  1,181,367 |  1,181,367 |
    fmul    $f1, $f10, $f1              # |  1,181,367 |  1,181,367 |
    fadd    $f1, $fg9, $f12             # |  1,181,367 |  1,181,367 |
    load    [$i1 + 2], $f1              # |  1,181,367 |  1,181,367 |
    fmul    $f1, $f10, $f1              # |  1,181,367 |  1,181,367 |
    fadd    $f1, $fg10, $f13            # |  1,181,367 |  1,181,367 |
.count move_args
    mov     $i2, $i1                    # |  1,181,367 |  1,181,367 |
.count move_args
    mov     $i11, $i3                   # |  1,181,367 |  1,181,367 |
.count move_args
    mov     $f11, $f2                   # |  1,181,367 |  1,181,367 |
.count move_args
    mov     $f12, $f3                   # |  1,181,367 |  1,181,367 |
.count move_args
    mov     $f13, $f4                   # |  1,181,367 |  1,181,367 |
    call    check_all_inside.2856       # |  1,181,367 |  1,181,367 |
    add     $i10, 1, $i10               # |  1,181,367 |  1,181,367 |
    be      $i1, 0, solve_each_element_fast.2885# |  1,181,367 |  1,181,367 |
    mov     $f10, $fg7                  # |    756,419 |    756,419 |
    store   $f11, [ext_intersection_point + 0]# |    756,419 |    756,419 |
    store   $f12, [ext_intersection_point + 1]# |    756,419 |    756,419 |
    store   $f13, [ext_intersection_point + 2]# |    756,419 |    756,419 |
    mov     $i13, $ig3                  # |    756,419 |    756,419 |
    mov     $i14, $ig2                  # |    756,419 |    756,419 |
    b       solve_each_element_fast.2885# |    756,419 |    756,419 |
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i15, $i16, $i17)
# $ra = $ra2
# [$i1 - $i17]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
    load    [$i16 + $i15], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.32740      # |    684,824 |    684,824 |
be_then.32740:
    jr      $ra2
be_else.32740:
    li      0, $i10                     # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i11   # |    684,824 |    684,824 |
.count move_args
    mov     $i17, $i12                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.32741      # |    684,824 |    684,824 |
be_then.32741:
    jr      $ra2
be_else.32741:
    li      0, $i10                     # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i11   # |    684,824 |    684,824 |
.count move_args
    mov     $i17, $i12                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.32742      # |    684,824 |    684,824 |
be_then.32742:
    jr      $ra2
be_else.32742:
    li      0, $i10                     # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i11   # |    684,824 |    684,824 |
.count move_args
    mov     $i17, $i12                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.32743      # |    684,824 |    684,824 |
be_then.32743:
    jr      $ra2
be_else.32743:
    li      0, $i10                     # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i11   # |    684,824 |    684,824 |
.count move_args
    mov     $i17, $i12                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.32744      # |    684,824 |    684,824 |
be_then.32744:
    jr      $ra2
be_else.32744:
    li      0, $i10                     # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i11   # |    684,824 |    684,824 |
.count move_args
    mov     $i17, $i12                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.32745      # |    684,824 |    684,824 |
be_then.32745:
    jr      $ra2
be_else.32745:
    li      0, $i10                     # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i11   # |    684,824 |    684,824 |
.count move_args
    mov     $i17, $i12                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.32746      # |    684,824 |    684,824 |
be_then.32746:
    jr      $ra2                        # |    684,824 |    684,824 |
be_else.32746:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i17, $i12
    jal     solve_each_element_fast.2885, $ra1
    add     $i15, 1, $i15
    load    [$i16 + $i15], $i1
    bne     $i1, -1, be_else.32747
be_then.32747:
    jr      $ra2
be_else.32747:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i17, $i12
    jal     solve_each_element_fast.2885, $ra1
    add     $i15, 1, $i15
    b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i18, $i19, $i20)
# $ra = $ra3
# [$i1 - $i20]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
    load    [$i19 + $i18], $i16         # |  1,134,616 |  1,134,616 |
    load    [$i16 + 0], $i1             # |  1,134,616 |  1,134,616 |
    bne     $i1, -1, be_else.32748      # |  1,134,616 |  1,134,616 |
be_then.32748:
    jr      $ra3
be_else.32748:
    bne     $i1, 99, be_else.32749      # |  1,134,616 |  1,134,616 |
be_then.32749:
    load    [$i16 + 1], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.32750     # |  1,134,616 |  1,134,616 |
bne_then.32750:
    li      0, $i10                     # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i11   # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i20, $i12                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i16 + 2], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.32751     # |  1,134,616 |  1,134,616 |
bne_then.32751:
    li      0, $i10                     # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i11   # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i20, $i12                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i16 + 3], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.32752     # |  1,134,616 |  1,134,616 |
bne_then.32752:
    li      0, $i10                     # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i11   # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i20, $i12                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i16 + 4], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.32753     # |  1,134,616 |  1,134,616 |
bne_then.32753:
    li      0, $i10                     # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i11   # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i20, $i12                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i16 + 5], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.32754     # |  1,134,616 |  1,134,616 |
bne_then.32754:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 6], $i1
    be      $i1, -1, bne_cont.32755
bne_then.32755:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element_fast.2885, $ra1
    li      7, $i15
.count move_args
    mov     $i20, $i17
    jal     solve_one_or_network_fast.2889, $ra2
bne_cont.32755:
bne_cont.32754:
bne_cont.32753:
bne_cont.32752:
bne_cont.32751:
bne_cont.32750:
    add     $i18, 1, $i18               # |  1,134,616 |  1,134,616 |
    load    [$i19 + $i18], $i16         # |  1,134,616 |  1,134,616 |
    load    [$i16 + 0], $i1             # |  1,134,616 |  1,134,616 |
    bne     $i1, -1, be_else.32756      # |  1,134,616 |  1,134,616 |
be_then.32756:
    jr      $ra3                        # |  1,134,616 |  1,134,616 |
be_else.32756:
    bne     $i1, 99, be_else.32757
be_then.32757:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32758
be_then.32758:
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
be_else.32758:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 2], $i1
    bne     $i1, -1, be_else.32759
be_then.32759:
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
be_else.32759:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 3], $i1
    bne     $i1, -1, be_else.32760
be_then.32760:
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
be_else.32760:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 4], $i1
    bne     $i1, -1, be_else.32761
be_then.32761:
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
be_else.32761:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i20, $i12
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i15
.count move_args
    mov     $i20, $i17
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
be_else.32757:
.count move_args
    mov     $i20, $i2
    call    solver_fast2.2814
    bne     $i1, 0, be_else.32762
be_then.32762:
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
be_else.32762:
    bg      $fg7, $fg0, ble_else.32763
ble_then.32763:
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
ble_else.32763:
    li      1, $i15
.count move_args
    mov     $i20, $i17
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
be_else.32749:
.count move_args
    mov     $i20, $i2
    call    solver_fast2.2814
    bne     $i1, 0, be_else.32764
be_then.32764:
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
be_else.32764:
    bg      $fg7, $fg0, ble_else.32765
ble_then.32765:
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
ble_else.32765:
    li      1, $i15
.count move_args
    mov     $i20, $i17
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i18, 1, $i18
    b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f9]
# []
# [$fg11, $fg15 - $fg16]
######################################################################
.begin utexture
utexture.2908:
    load    [$i1 + 8], $i2              # |    660,661 |    660,661 |
    load    [$i2 + 0], $fg16            # |    660,661 |    660,661 |
    load    [$i1 + 8], $i2              # |    660,661 |    660,661 |
    load    [$i2 + 1], $fg11            # |    660,661 |    660,661 |
    load    [$i1 + 8], $i2              # |    660,661 |    660,661 |
    load    [$i2 + 2], $fg15            # |    660,661 |    660,661 |
    load    [$i1 + 0], $i2              # |    660,661 |    660,661 |
    bne     $i2, 1, be_else.32766       # |    660,661 |    660,661 |
be_then.32766:
    load    [$i1 + 5], $i2              # |     94,582 |     94,582 |
    load    [$i1 + 5], $i1              # |     94,582 |     94,582 |
    load    [ext_intersection_point + 0], $f1# |     94,582 |     94,582 |
    load    [$i2 + 0], $f2              # |     94,582 |     94,582 |
.count load_float
    load    [f.31957], $f4              # |     94,582 |     94,582 |
    fsub    $f1, $f2, $f5               # |     94,582 |     94,582 |
    fmul    $f5, $f4, $f2               # |     94,582 |     94,582 |
    call    ext_floor                   # |     94,582 |     94,582 |
.count load_float
    load    [f.31958], $f6              # |     94,582 |     94,582 |
.count load_float
    load    [f.31959], $f7              # |     94,582 |     94,582 |
    fmul    $f1, $f6, $f1               # |     94,582 |     94,582 |
    fsub    $f5, $f1, $f5               # |     94,582 |     94,582 |
    load    [ext_intersection_point + 2], $f1# |     94,582 |     94,582 |
    load    [$i1 + 2], $f2              # |     94,582 |     94,582 |
    fsub    $f1, $f2, $f8               # |     94,582 |     94,582 |
    fmul    $f8, $f4, $f2               # |     94,582 |     94,582 |
    call    ext_floor                   # |     94,582 |     94,582 |
    fmul    $f1, $f6, $f1               # |     94,582 |     94,582 |
    fsub    $f8, $f1, $f1               # |     94,582 |     94,582 |
    bg      $f7, $f5, ble_else.32767    # |     94,582 |     94,582 |
ble_then.32767:
    li      0, $i1                      # |     50,346 |     50,346 |
.count b_cont
    b       ble_cont.32767              # |     50,346 |     50,346 |
ble_else.32767:
    li      1, $i1                      # |     44,236 |     44,236 |
ble_cont.32767:
    bg      $f7, $f1, ble_else.32768    # |     94,582 |     94,582 |
ble_then.32768:
    bne     $i1, 0, be_else.32769       # |     45,724 |     45,724 |
be_then.32769:
    mov     $fc9, $fg11                 # |     24,135 |     24,135 |
    jr      $ra1                        # |     24,135 |     24,135 |
be_else.32769:
    mov     $f0, $fg11                  # |     21,589 |     21,589 |
    jr      $ra1                        # |     21,589 |     21,589 |
ble_else.32768:
    bne     $i1, 0, be_else.32770       # |     48,858 |     48,858 |
be_then.32770:
    mov     $f0, $fg11                  # |     26,211 |     26,211 |
    jr      $ra1                        # |     26,211 |     26,211 |
be_else.32770:
    mov     $fc9, $fg11                 # |     22,647 |     22,647 |
    jr      $ra1                        # |     22,647 |     22,647 |
be_else.32766:
    bne     $i2, 2, be_else.32771       # |    566,079 |    566,079 |
be_then.32771:
    load    [ext_intersection_point + 1], $f1# |      2,885 |      2,885 |
.count load_float
    load    [f.31956], $f2              # |      2,885 |      2,885 |
    fmul    $f1, $f2, $f2               # |      2,885 |      2,885 |
    call    ext_sin                     # |      2,885 |      2,885 |
    fmul    $f1, $f1, $f1               # |      2,885 |      2,885 |
    fmul    $fc9, $f1, $fg16            # |      2,885 |      2,885 |
    fsub    $fc0, $f1, $f1              # |      2,885 |      2,885 |
    fmul    $fc9, $f1, $fg11            # |      2,885 |      2,885 |
    jr      $ra1                        # |      2,885 |      2,885 |
be_else.32771:
    bne     $i2, 3, be_else.32772       # |    563,194 |    563,194 |
be_then.32772:
    load    [$i1 + 5], $i2
    load    [$i1 + 5], $i1
    load    [ext_intersection_point + 0], $f1
    load    [$i2 + 0], $f2
    fsub    $f1, $f2, $f1
    fmul    $f1, $f1, $f1
    load    [ext_intersection_point + 2], $f2
    load    [$i1 + 2], $f3
    fsub    $f2, $f3, $f2
    fmul    $f2, $f2, $f2
    fadd    $f1, $f2, $f1
    fsqrt   $f1, $f1
    fmul    $f1, $fc8, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fmul    $f1, $fc15, $f2
    call    ext_cos
    fmul    $f1, $f1, $f1
    fmul    $f1, $fc9, $fg11
    fsub    $fc0, $f1, $f1
    fmul    $f1, $fc9, $fg15
    jr      $ra1
be_else.32772:
    bne     $i2, 4, be_else.32773       # |    563,194 |    563,194 |
be_then.32773:
    load    [$i1 + 5], $i2
    load    [$i1 + 4], $i3
    load    [$i1 + 5], $i4
    load    [$i1 + 4], $i5
.count load_float
    load    [f.31947], $f6
    load    [ext_intersection_point + 0], $f1
    load    [$i2 + 0], $f2
    fsub    $f1, $f2, $f1
    load    [$i3 + 0], $f2
    fsqrt   $f2, $f2
    fmul    $f1, $f2, $f7
    fabs    $f7, $f1
    load    [ext_intersection_point + 2], $f2
    load    [$i4 + 2], $f3
    fsub    $f2, $f3, $f2
    load    [$i5 + 2], $f3
    fsqrt   $f3, $f3
    fmul    $f2, $f3, $f8
    bg      $f6, $f1, ble_else.32774
ble_then.32774:
    finv    $f7, $f1
    fmul_a  $f8, $f1, $f2
    call    ext_atan
    fmul    $f1, $fc18, $f1
    fmul    $f1, $fc17, $f9
.count b_cont
    b       ble_cont.32774
ble_else.32774:
    mov     $fc19, $f9
ble_cont.32774:
    load    [$i1 + 5], $i2
    load    [$i1 + 4], $i1
    fmul    $f7, $f7, $f1
    fmul    $f8, $f8, $f2
    fadd    $f1, $f2, $f1
    fabs    $f1, $f2
    load    [ext_intersection_point + 1], $f3
    load    [$i2 + 1], $f4
    fsub    $f3, $f4, $f3
    load    [$i1 + 1], $f4
    fsqrt   $f4, $f4
    fmul    $f3, $f4, $f3
    bg      $f6, $f2, ble_else.32775
ble_then.32775:
    finv    $f1, $f1
    fmul_a  $f3, $f1, $f2
    call    ext_atan
    fmul    $f1, $fc18, $f1
    fmul    $f1, $fc17, $f4
.count b_cont
    b       ble_cont.32775
ble_else.32775:
    mov     $fc19, $f4
ble_cont.32775:
.count load_float
    load    [f.31952], $f5
.count move_args
    mov     $f9, $f2
    call    ext_floor
    fsub    $f9, $f1, $f1
    fsub    $fc3, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f5, $f1, $f5
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fsub    $fc3, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f5, $f1, $f1
    bg      $f0, $f1, ble_else.32776
ble_then.32776:
    fmul    $fc9, $f1, $f1
.count load_float
    load    [f.31954], $f2
    fmul    $f1, $f2, $fg15
    jr      $ra1
ble_else.32776:
    mov     $f0, $fg15
    jr      $ra1
be_else.32773:
    jr      $ra1                        # |    563,194 |    563,194 |
.end utexture

######################################################################
# trace_reflections($i21, $f14, $f15, $i22)
# $ra = $ra4
# [$i1 - $i24]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
######################################################################
.begin trace_reflections
trace_reflections.2915:
    bl      $i21, 0, bge_else.32777     # |     36,992 |     36,992 |
bge_then.32777:
    load    [ext_reflections + $i21], $i23# |     18,496 |     18,496 |
    load    [$i23 + 1], $i24            # |     18,496 |     18,496 |
    mov     $fc14, $fg7                 # |     18,496 |     18,496 |
    load    [$ig1 + 0], $i16            # |     18,496 |     18,496 |
    load    [$i16 + 0], $i1             # |     18,496 |     18,496 |
    be      $i1, -1, bne_cont.32778     # |     18,496 |     18,496 |
bne_then.32778:
    bne     $i1, 99, be_else.32779      # |     18,496 |     18,496 |
be_then.32779:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32780
be_then.32780:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i24, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32779
be_else.32780:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i24, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 2], $i1
    bne     $i1, -1, be_else.32781
be_then.32781:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i24, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32779
be_else.32781:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i24, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 3], $i1
    bne     $i1, -1, be_else.32782
be_then.32782:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i24, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32779
be_else.32782:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i24, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 4], $i1
    bne     $i1, -1, be_else.32783
be_then.32783:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i24, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32779
be_else.32783:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i24, $i12
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i15
.count move_args
    mov     $i24, $i17
    jal     solve_one_or_network_fast.2889, $ra2
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i24, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32779
be_else.32779:
.count move_args
    mov     $i24, $i2                   # |     18,496 |     18,496 |
    call    solver_fast2.2814           # |     18,496 |     18,496 |
    bne     $i1, 0, be_else.32784       # |     18,496 |     18,496 |
be_then.32784:
    li      1, $i18                     # |     13,470 |     13,470 |
.count move_args
    mov     $ig1, $i19                  # |     13,470 |     13,470 |
.count move_args
    mov     $i24, $i20                  # |     13,470 |     13,470 |
    jal     trace_or_matrix_fast.2893, $ra3# |     13,470 |     13,470 |
.count b_cont
    b       be_cont.32784               # |     13,470 |     13,470 |
be_else.32784:
    bg      $fg7, $fg0, ble_else.32785  # |      5,026 |      5,026 |
ble_then.32785:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i24, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       ble_cont.32785
ble_else.32785:
    li      1, $i15                     # |      5,026 |      5,026 |
.count move_args
    mov     $i24, $i17                  # |      5,026 |      5,026 |
    jal     solve_one_or_network_fast.2889, $ra2# |      5,026 |      5,026 |
    li      1, $i18                     # |      5,026 |      5,026 |
.count move_args
    mov     $ig1, $i19                  # |      5,026 |      5,026 |
.count move_args
    mov     $i24, $i20                  # |      5,026 |      5,026 |
    jal     trace_or_matrix_fast.2893, $ra3# |      5,026 |      5,026 |
ble_cont.32785:
be_cont.32784:
be_cont.32779:
bne_cont.32778:
    bg      $fg7, $fc7, ble_else.32786  # |     18,496 |     18,496 |
ble_then.32786:
    li      0, $i1
.count b_cont
    b       ble_cont.32786
ble_else.32786:
    bg      $fc13, $fg7, ble_else.32787 # |     18,496 |     18,496 |
ble_then.32787:
    li      0, $i1                      # |      7,212 |      7,212 |
.count b_cont
    b       ble_cont.32787              # |      7,212 |      7,212 |
ble_else.32787:
    li      1, $i1                      # |     11,284 |     11,284 |
ble_cont.32787:
ble_cont.32786:
    bne     $i1, 0, be_else.32788       # |     18,496 |     18,496 |
be_then.32788:
    sub     $i21, 1, $i21               # |      7,212 |      7,212 |
    b       trace_reflections.2915      # |      7,212 |      7,212 |
be_else.32788:
    load    [$i23 + 0], $i1             # |     11,284 |     11,284 |
    add     $ig3, $ig3, $i2             # |     11,284 |     11,284 |
    add     $i2, $i2, $i2               # |     11,284 |     11,284 |
    add     $i2, $ig2, $i2              # |     11,284 |     11,284 |
    bne     $i2, $i1, be_else.32789     # |     11,284 |     11,284 |
be_then.32789:
    li      0, $i14                     # |     10,334 |     10,334 |
.count move_args
    mov     $ig1, $i15                  # |     10,334 |     10,334 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     10,334 |     10,334 |
    bne     $i1, 0, be_else.32790       # |     10,334 |     10,334 |
be_then.32790:
    load    [$i23 + 2], $f1             # |     10,334 |     10,334 |
    load    [$i24 + 0], $i1             # |     10,334 |     10,334 |
    fmul    $f1, $f14, $f2              # |     10,334 |     10,334 |
    load    [ext_nvector + 0], $f3      # |     10,334 |     10,334 |
    load    [$i1 + 0], $f4              # |     10,334 |     10,334 |
    fmul    $f3, $f4, $f3               # |     10,334 |     10,334 |
    load    [ext_nvector + 1], $f5      # |     10,334 |     10,334 |
    load    [$i1 + 1], $f6              # |     10,334 |     10,334 |
    fmul    $f5, $f6, $f5               # |     10,334 |     10,334 |
    fadd    $f3, $f5, $f3               # |     10,334 |     10,334 |
    load    [ext_nvector + 2], $f5      # |     10,334 |     10,334 |
    load    [$i1 + 2], $f7              # |     10,334 |     10,334 |
    fmul    $f5, $f7, $f5               # |     10,334 |     10,334 |
    fadd    $f3, $f5, $f3               # |     10,334 |     10,334 |
    fmul    $f2, $f3, $f2               # |     10,334 |     10,334 |
    ble     $f2, $f0, bg_cont.32791     # |     10,334 |     10,334 |
bg_then.32791:
    fmul    $f2, $fg16, $f3             # |      9,373 |      9,373 |
    fadd    $fg4, $f3, $fg4             # |      9,373 |      9,373 |
    fmul    $f2, $fg11, $f3             # |      9,373 |      9,373 |
    fadd    $fg5, $f3, $fg5             # |      9,373 |      9,373 |
    fmul    $f2, $fg15, $f2             # |      9,373 |      9,373 |
    fadd    $fg6, $f2, $fg6             # |      9,373 |      9,373 |
bg_cont.32791:
    load    [$i22 + 0], $f2             # |     10,334 |     10,334 |
    fmul    $f2, $f4, $f2               # |     10,334 |     10,334 |
    load    [$i22 + 1], $f3             # |     10,334 |     10,334 |
    fmul    $f3, $f6, $f3               # |     10,334 |     10,334 |
    fadd    $f2, $f3, $f2               # |     10,334 |     10,334 |
    load    [$i22 + 2], $f3             # |     10,334 |     10,334 |
    fmul    $f3, $f7, $f3               # |     10,334 |     10,334 |
    fadd    $f2, $f3, $f2               # |     10,334 |     10,334 |
    fmul    $f1, $f2, $f1               # |     10,334 |     10,334 |
    sub     $i21, 1, $i21               # |     10,334 |     10,334 |
    ble     $f1, $f0, trace_reflections.2915# |     10,334 |     10,334 |
    fmul    $f1, $f1, $f1               # |      7,720 |      7,720 |
    fmul    $f1, $f1, $f1               # |      7,720 |      7,720 |
    fmul    $f1, $f15, $f1              # |      7,720 |      7,720 |
    fadd    $fg4, $f1, $fg4             # |      7,720 |      7,720 |
    fadd    $fg5, $f1, $fg5             # |      7,720 |      7,720 |
    fadd    $fg6, $f1, $fg6             # |      7,720 |      7,720 |
    b       trace_reflections.2915      # |      7,720 |      7,720 |
be_else.32790:
    sub     $i21, 1, $i21
    b       trace_reflections.2915
be_else.32789:
    sub     $i21, 1, $i21               # |        950 |        950 |
    b       trace_reflections.2915      # |        950 |        950 |
bge_else.32777:
    jr      $ra4                        # |     18,496 |     18,496 |
.end trace_reflections

######################################################################
# trace_ray($i25, $f16, $i26, $i27, $f17)
# $ra = $ra5
# [$i1 - $i29]
# [$f1 - $f17]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin trace_ray
trace_ray.2920:
    bg      $i25, 4, ble_else.32793     # |     23,754 |     23,754 |
ble_then.32793:
    mov     $fc14, $fg7                 # |     23,754 |     23,754 |
    load    [$ig1 + 0], $i16            # |     23,754 |     23,754 |
    load    [$i16 + 0], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.32794     # |     23,754 |     23,754 |
bne_then.32794:
    bne     $i1, 99, be_else.32795      # |     23,754 |     23,754 |
be_then.32795:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32796
be_then.32796:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i26, $i20
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.32795
be_else.32796:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i26, $i12
    jal     solve_each_element.2871, $ra1
    load    [$i16 + 2], $i1
    bne     $i1, -1, be_else.32797
be_then.32797:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i26, $i20
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.32795
be_else.32797:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i26, $i12
    jal     solve_each_element.2871, $ra1
    load    [$i16 + 3], $i1
    bne     $i1, -1, be_else.32798
be_then.32798:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i26, $i20
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.32795
be_else.32798:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i26, $i12
    jal     solve_each_element.2871, $ra1
    load    [$i16 + 4], $i1
    bne     $i1, -1, be_else.32799
be_then.32799:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i26, $i20
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.32795
be_else.32799:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i26, $i12
    jal     solve_each_element.2871, $ra1
    li      5, $i15
.count move_args
    mov     $i26, $i17
    jal     solve_one_or_network.2875, $ra2
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i26, $i20
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.32795
be_else.32795:
.count move_args
    mov     $i26, $i2                   # |     23,754 |     23,754 |
    call    solver.2773                 # |     23,754 |     23,754 |
    bne     $i1, 0, be_else.32800       # |     23,754 |     23,754 |
be_then.32800:
    li      1, $i18                     # |     16,978 |     16,978 |
.count move_args
    mov     $ig1, $i19                  # |     16,978 |     16,978 |
.count move_args
    mov     $i26, $i20                  # |     16,978 |     16,978 |
    jal     trace_or_matrix.2879, $ra3  # |     16,978 |     16,978 |
.count b_cont
    b       be_cont.32800               # |     16,978 |     16,978 |
be_else.32800:
    bg      $fg7, $fg0, ble_else.32801  # |      6,776 |      6,776 |
ble_then.32801:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i26, $i20
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       ble_cont.32801
ble_else.32801:
    li      1, $i15                     # |      6,776 |      6,776 |
.count move_args
    mov     $i26, $i17                  # |      6,776 |      6,776 |
    jal     solve_one_or_network.2875, $ra2# |      6,776 |      6,776 |
    li      1, $i18                     # |      6,776 |      6,776 |
.count move_args
    mov     $ig1, $i19                  # |      6,776 |      6,776 |
.count move_args
    mov     $i26, $i20                  # |      6,776 |      6,776 |
    jal     trace_or_matrix.2879, $ra3  # |      6,776 |      6,776 |
ble_cont.32801:
be_cont.32800:
be_cont.32795:
bne_cont.32794:
    load    [$i27 + 2], $i28            # |     23,754 |     23,754 |
    bg      $fg7, $fc7, ble_else.32802  # |     23,754 |     23,754 |
ble_then.32802:
    li      0, $i1
.count b_cont
    b       ble_cont.32802
ble_else.32802:
    bg      $fc13, $fg7, ble_else.32803 # |     23,754 |     23,754 |
ble_then.32803:
    li      0, $i1                      # |      5,258 |      5,258 |
.count b_cont
    b       ble_cont.32803              # |      5,258 |      5,258 |
ble_else.32803:
    li      1, $i1                      # |     18,496 |     18,496 |
ble_cont.32803:
ble_cont.32802:
    bne     $i1, 0, be_else.32804       # |     23,754 |     23,754 |
be_then.32804:
    add     $i0, -1, $i1                # |      5,258 |      5,258 |
.count storer
    add     $i28, $i25, $tmp            # |      5,258 |      5,258 |
    store   $i1, [$tmp + 0]             # |      5,258 |      5,258 |
    bne     $i25, 0, be_else.32805      # |      5,258 |      5,258 |
be_then.32805:
    jr      $ra5
be_else.32805:
    load    [$i26 + 0], $f1             # |      5,258 |      5,258 |
    fmul    $f1, $fg12, $f1             # |      5,258 |      5,258 |
    load    [$i26 + 1], $f2             # |      5,258 |      5,258 |
    fmul    $f2, $fg13, $f2             # |      5,258 |      5,258 |
    fadd    $f1, $f2, $f1               # |      5,258 |      5,258 |
    load    [$i26 + 2], $f2             # |      5,258 |      5,258 |
    fmul    $f2, $fg14, $f2             # |      5,258 |      5,258 |
    fadd_n  $f1, $f2, $f1               # |      5,258 |      5,258 |
    bg      $f1, $f0, ble_else.32806    # |      5,258 |      5,258 |
ble_then.32806:
    jr      $ra5                        # |      3,274 |      3,274 |
ble_else.32806:
    fmul    $f1, $f1, $f2               # |      1,984 |      1,984 |
    fmul    $f2, $f1, $f1               # |      1,984 |      1,984 |
    fmul    $f1, $f16, $f1              # |      1,984 |      1,984 |
    load    [ext_beam + 0], $f2         # |      1,984 |      1,984 |
    fmul    $f1, $f2, $f1               # |      1,984 |      1,984 |
    fadd    $fg4, $f1, $fg4             # |      1,984 |      1,984 |
    fadd    $fg5, $f1, $fg5             # |      1,984 |      1,984 |
    fadd    $fg6, $f1, $fg6             # |      1,984 |      1,984 |
    jr      $ra5                        # |      1,984 |      1,984 |
be_else.32804:
    load    [ext_objects + $ig3], $i29  # |     18,496 |     18,496 |
    load    [$i29 + 1], $i1             # |     18,496 |     18,496 |
    bne     $i1, 1, be_else.32807       # |     18,496 |     18,496 |
be_then.32807:
    store   $f0, [ext_nvector + 0]      # |      7,910 |      7,910 |
    store   $f0, [ext_nvector + 1]      # |      7,910 |      7,910 |
    store   $f0, [ext_nvector + 2]      # |      7,910 |      7,910 |
    sub     $ig2, 1, $i1                # |      7,910 |      7,910 |
    load    [$i26 + $i1], $f1           # |      7,910 |      7,910 |
    bne     $f1, $f0, be_else.32808     # |      7,910 |      7,910 |
be_then.32808:
    store   $f0, [ext_nvector + $i1]
.count b_cont
    b       be_cont.32807
be_else.32808:
    bg      $f1, $f0, ble_else.32809    # |      7,910 |      7,910 |
ble_then.32809:
    store   $fc0, [ext_nvector + $i1]   # |      6,667 |      6,667 |
.count b_cont
    b       be_cont.32807               # |      6,667 |      6,667 |
ble_else.32809:
    store   $fc4, [ext_nvector + $i1]   # |      1,243 |      1,243 |
.count b_cont
    b       be_cont.32807               # |      1,243 |      1,243 |
be_else.32807:
    bne     $i1, 2, be_else.32810       # |     10,586 |     10,586 |
be_then.32810:
    load    [$i29 + 4], $i1             # |      7,226 |      7,226 |
    load    [$i1 + 0], $f1              # |      7,226 |      7,226 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 0]      # |      7,226 |      7,226 |
    load    [$i29 + 4], $i1             # |      7,226 |      7,226 |
    load    [$i1 + 1], $f1              # |      7,226 |      7,226 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 1]      # |      7,226 |      7,226 |
    load    [$i29 + 4], $i1             # |      7,226 |      7,226 |
    load    [$i1 + 2], $f1              # |      7,226 |      7,226 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 2]      # |      7,226 |      7,226 |
.count b_cont
    b       be_cont.32810               # |      7,226 |      7,226 |
be_else.32810:
    load    [$i29 + 3], $i1             # |      3,360 |      3,360 |
    load    [$i29 + 4], $i2             # |      3,360 |      3,360 |
    load    [$i2 + 0], $f1              # |      3,360 |      3,360 |
    load    [ext_intersection_point + 0], $f2# |      3,360 |      3,360 |
    load    [$i29 + 5], $i2             # |      3,360 |      3,360 |
    load    [$i2 + 0], $f3              # |      3,360 |      3,360 |
    fsub    $f2, $f3, $f2               # |      3,360 |      3,360 |
    fmul    $f2, $f1, $f1               # |      3,360 |      3,360 |
    load    [$i29 + 4], $i2             # |      3,360 |      3,360 |
    load    [$i2 + 1], $f3              # |      3,360 |      3,360 |
    load    [ext_intersection_point + 1], $f4# |      3,360 |      3,360 |
    load    [$i29 + 5], $i2             # |      3,360 |      3,360 |
    load    [$i2 + 1], $f5              # |      3,360 |      3,360 |
    fsub    $f4, $f5, $f4               # |      3,360 |      3,360 |
    fmul    $f4, $f3, $f3               # |      3,360 |      3,360 |
    load    [$i29 + 4], $i2             # |      3,360 |      3,360 |
    load    [$i2 + 2], $f5              # |      3,360 |      3,360 |
    load    [ext_intersection_point + 2], $f6# |      3,360 |      3,360 |
    load    [$i29 + 5], $i2             # |      3,360 |      3,360 |
    load    [$i2 + 2], $f7              # |      3,360 |      3,360 |
    fsub    $f6, $f7, $f6               # |      3,360 |      3,360 |
    fmul    $f6, $f5, $f5               # |      3,360 |      3,360 |
    bne     $i1, 0, be_else.32811       # |      3,360 |      3,360 |
be_then.32811:
    store   $f1, [ext_nvector + 0]      # |      3,360 |      3,360 |
    store   $f3, [ext_nvector + 1]      # |      3,360 |      3,360 |
    store   $f5, [ext_nvector + 2]      # |      3,360 |      3,360 |
.count b_cont
    b       be_cont.32811               # |      3,360 |      3,360 |
be_else.32811:
    load    [$i29 + 9], $i1
    load    [$i1 + 2], $f7
    fmul    $f4, $f7, $f7
    load    [$i29 + 9], $i1
    load    [$i1 + 1], $f8
    fmul    $f6, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc3, $f7
    fadd    $f1, $f7, $f1
    store   $f1, [ext_nvector + 0]
    load    [$i29 + 9], $i1
    load    [$i1 + 2], $f1
    fmul    $f2, $f1, $f1
    load    [$i29 + 9], $i1
    load    [$i1 + 0], $f7
    fmul    $f6, $f7, $f6
    fadd    $f1, $f6, $f1
    fmul    $f1, $fc3, $f1
    fadd    $f3, $f1, $f1
    store   $f1, [ext_nvector + 1]
    load    [$i29 + 9], $i1
    load    [$i1 + 1], $f1
    fmul    $f2, $f1, $f1
    load    [$i29 + 9], $i1
    load    [$i1 + 0], $f2
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc3, $f1
    fadd    $f5, $f1, $f1
    store   $f1, [ext_nvector + 2]
be_cont.32811:
    load    [ext_nvector + 0], $f1      # |      3,360 |      3,360 |
    load    [$i29 + 6], $i1             # |      3,360 |      3,360 |
    fmul    $f1, $f1, $f2               # |      3,360 |      3,360 |
    load    [ext_nvector + 1], $f3      # |      3,360 |      3,360 |
    fmul    $f3, $f3, $f3               # |      3,360 |      3,360 |
    fadd    $f2, $f3, $f2               # |      3,360 |      3,360 |
    load    [ext_nvector + 2], $f3      # |      3,360 |      3,360 |
    fmul    $f3, $f3, $f3               # |      3,360 |      3,360 |
    fadd    $f2, $f3, $f2               # |      3,360 |      3,360 |
    fsqrt   $f2, $f2                    # |      3,360 |      3,360 |
    bne     $f2, $f0, be_else.32812     # |      3,360 |      3,360 |
be_then.32812:
    mov     $fc0, $f2
.count b_cont
    b       be_cont.32812
be_else.32812:
    bne     $i1, 0, be_else.32813       # |      3,360 |      3,360 |
be_then.32813:
    finv    $f2, $f2                    # |      3,128 |      3,128 |
.count b_cont
    b       be_cont.32813               # |      3,128 |      3,128 |
be_else.32813:
    finv_n  $f2, $f2                    # |        232 |        232 |
be_cont.32813:
be_cont.32812:
    fmul    $f1, $f2, $f1               # |      3,360 |      3,360 |
    store   $f1, [ext_nvector + 0]      # |      3,360 |      3,360 |
    load    [ext_nvector + 1], $f1      # |      3,360 |      3,360 |
    fmul    $f1, $f2, $f1               # |      3,360 |      3,360 |
    store   $f1, [ext_nvector + 1]      # |      3,360 |      3,360 |
    load    [ext_nvector + 2], $f1      # |      3,360 |      3,360 |
    fmul    $f1, $f2, $f1               # |      3,360 |      3,360 |
    store   $f1, [ext_nvector + 2]      # |      3,360 |      3,360 |
be_cont.32810:
be_cont.32807:
    load    [ext_intersection_point + 0], $fg21# |     18,496 |     18,496 |
    load    [ext_intersection_point + 1], $fg22# |     18,496 |     18,496 |
    load    [ext_intersection_point + 2], $fg23# |     18,496 |     18,496 |
.count move_args
    mov     $i29, $i1                   # |     18,496 |     18,496 |
    jal     utexture.2908, $ra1         # |     18,496 |     18,496 |
    add     $ig3, $ig3, $i1             # |     18,496 |     18,496 |
    add     $i1, $i1, $i1               # |     18,496 |     18,496 |
    add     $i1, $ig2, $i1              # |     18,496 |     18,496 |
.count storer
    add     $i28, $i25, $tmp            # |     18,496 |     18,496 |
    store   $i1, [$tmp + 0]             # |     18,496 |     18,496 |
    load    [$i27 + 1], $i1             # |     18,496 |     18,496 |
    load    [$i1 + $i25], $i1           # |     18,496 |     18,496 |
    load    [ext_intersection_point + 0], $f1# |     18,496 |     18,496 |
    store   $f1, [$i1 + 0]              # |     18,496 |     18,496 |
    load    [ext_intersection_point + 1], $f1# |     18,496 |     18,496 |
    store   $f1, [$i1 + 1]              # |     18,496 |     18,496 |
    load    [ext_intersection_point + 2], $f1# |     18,496 |     18,496 |
    store   $f1, [$i1 + 2]              # |     18,496 |     18,496 |
    load    [$i29 + 7], $i1             # |     18,496 |     18,496 |
    load    [$i27 + 3], $i2             # |     18,496 |     18,496 |
    load    [$i1 + 0], $f1              # |     18,496 |     18,496 |
    fmul    $f1, $f16, $f14             # |     18,496 |     18,496 |
.count storer
    add     $i2, $i25, $tmp             # |     18,496 |     18,496 |
    bg      $fc3, $f1, ble_else.32814   # |     18,496 |     18,496 |
ble_then.32814:
    li      1, $i1                      # |     11,126 |     11,126 |
    store   $i1, [$tmp + 0]             # |     11,126 |     11,126 |
    load    [$i27 + 4], $i1             # |     11,126 |     11,126 |
    load    [$i1 + $i25], $i2           # |     11,126 |     11,126 |
    store   $fg16, [$i2 + 0]            # |     11,126 |     11,126 |
    store   $fg11, [$i2 + 1]            # |     11,126 |     11,126 |
    store   $fg15, [$i2 + 2]            # |     11,126 |     11,126 |
    load    [$i1 + $i25], $i1           # |     11,126 |     11,126 |
.count load_float
    load    [f.31962], $f1              # |     11,126 |     11,126 |
.count load_float
    load    [f.31963], $f1              # |     11,126 |     11,126 |
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
    load    [$i27 + 7], $i1             # |     11,126 |     11,126 |
    load    [$i1 + $i25], $i1           # |     11,126 |     11,126 |
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 0]              # |     11,126 |     11,126 |
    load    [ext_nvector + 1], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 1]              # |     11,126 |     11,126 |
    load    [ext_nvector + 2], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |
.count b_cont
    b       ble_cont.32814              # |     11,126 |     11,126 |
ble_else.32814:
    li      0, $i1                      # |      7,370 |      7,370 |
    store   $i1, [$tmp + 0]             # |      7,370 |      7,370 |
ble_cont.32814:
    load    [ext_nvector + 0], $f1      # |     18,496 |     18,496 |
.count load_float
    load    [f.31964], $f2              # |     18,496 |     18,496 |
    load    [$i26 + 0], $f3             # |     18,496 |     18,496 |
    fmul    $f3, $f1, $f4               # |     18,496 |     18,496 |
    load    [$i26 + 1], $f5             # |     18,496 |     18,496 |
    load    [ext_nvector + 1], $f6      # |     18,496 |     18,496 |
    fmul    $f5, $f6, $f5               # |     18,496 |     18,496 |
    fadd    $f4, $f5, $f4               # |     18,496 |     18,496 |
    load    [$i26 + 2], $f5             # |     18,496 |     18,496 |
    load    [ext_nvector + 2], $f6      # |     18,496 |     18,496 |
    fmul    $f5, $f6, $f5               # |     18,496 |     18,496 |
    fadd    $f4, $f5, $f4               # |     18,496 |     18,496 |
    fmul    $f2, $f4, $f2               # |     18,496 |     18,496 |
    fmul    $f2, $f1, $f1               # |     18,496 |     18,496 |
    fadd    $f3, $f1, $f1               # |     18,496 |     18,496 |
    store   $f1, [$i26 + 0]             # |     18,496 |     18,496 |
    load    [$i26 + 1], $f1             # |     18,496 |     18,496 |
    load    [ext_nvector + 1], $f3      # |     18,496 |     18,496 |
    fmul    $f2, $f3, $f3               # |     18,496 |     18,496 |
    fadd    $f1, $f3, $f1               # |     18,496 |     18,496 |
    store   $f1, [$i26 + 1]             # |     18,496 |     18,496 |
    load    [$i26 + 2], $f1             # |     18,496 |     18,496 |
    load    [ext_nvector + 2], $f3      # |     18,496 |     18,496 |
    fmul    $f2, $f3, $f2               # |     18,496 |     18,496 |
    fadd    $f1, $f2, $f1               # |     18,496 |     18,496 |
    store   $f1, [$i26 + 2]             # |     18,496 |     18,496 |
    load    [$ig1 + 0], $i14            # |     18,496 |     18,496 |
    load    [$i14 + 0], $i1             # |     18,496 |     18,496 |
    bne     $i1, -1, be_else.32815      # |     18,496 |     18,496 |
be_then.32815:
    li      0, $i1
.count b_cont
    b       be_cont.32815
be_else.32815:
    bne     $i1, 99, be_else.32816      # |     18,496 |     18,496 |
be_then.32816:
    li      1, $i1
.count b_cont
    b       be_cont.32816
be_else.32816:
    call    solver_fast.2796            # |     18,496 |     18,496 |
    bne     $i1, 0, be_else.32817       # |     18,496 |     18,496 |
be_then.32817:
    li      0, $i1                      # |     13,405 |     13,405 |
.count b_cont
    b       be_cont.32817               # |     13,405 |     13,405 |
be_else.32817:
    bg      $fc7, $fg0, ble_else.32818  # |      5,091 |      5,091 |
ble_then.32818:
    li      0, $i1                      # |        207 |        207 |
.count b_cont
    b       ble_cont.32818              # |        207 |        207 |
ble_else.32818:
    load    [$i14 + 1], $i1             # |      4,884 |      4,884 |
    bne     $i1, -1, be_else.32819      # |      4,884 |      4,884 |
be_then.32819:
    li      0, $i1
.count b_cont
    b       be_cont.32819
be_else.32819:
    li      0, $i10                     # |      4,884 |      4,884 |
    load    [ext_and_net + $i1], $i11   # |      4,884 |      4,884 |
    jal     shadow_check_and_group.2862, $ra1# |      4,884 |      4,884 |
    bne     $i1, 0, be_else.32820       # |      4,884 |      4,884 |
be_then.32820:
    load    [$i14 + 2], $i1             # |      4,517 |      4,517 |
    bne     $i1, -1, be_else.32821      # |      4,517 |      4,517 |
be_then.32821:
    li      0, $i1
.count b_cont
    b       be_cont.32820
be_else.32821:
    li      0, $i10                     # |      4,517 |      4,517 |
    load    [ext_and_net + $i1], $i11   # |      4,517 |      4,517 |
    jal     shadow_check_and_group.2862, $ra1# |      4,517 |      4,517 |
    bne     $i1, 0, be_else.32822       # |      4,517 |      4,517 |
be_then.32822:
    li      3, $i12                     # |      4,439 |      4,439 |
.count move_args
    mov     $i14, $i13                  # |      4,439 |      4,439 |
    jal     shadow_check_one_or_group.2865, $ra2# |      4,439 |      4,439 |
    bne     $i1, 0, be_else.32823       # |      4,439 |      4,439 |
be_then.32823:
    li      0, $i1                      # |      4,100 |      4,100 |
.count b_cont
    b       be_cont.32820               # |      4,100 |      4,100 |
be_else.32823:
    li      1, $i1                      # |        339 |        339 |
.count b_cont
    b       be_cont.32820               # |        339 |        339 |
be_else.32822:
    li      1, $i1                      # |         78 |         78 |
.count b_cont
    b       be_cont.32820               # |         78 |         78 |
be_else.32820:
    li      1, $i1                      # |        367 |        367 |
be_cont.32820:
be_cont.32819:
ble_cont.32818:
be_cont.32817:
be_cont.32816:
    bne     $i1, 0, be_else.32824       # |     18,496 |     18,496 |
be_then.32824:
    li      1, $i14                     # |     17,712 |     17,712 |
.count move_args
    mov     $ig1, $i15                  # |     17,712 |     17,712 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     17,712 |     17,712 |
.count b_cont
    b       be_cont.32824               # |     17,712 |     17,712 |
be_else.32824:
    load    [$i14 + 1], $i1             # |        784 |        784 |
    bne     $i1, -1, be_else.32825      # |        784 |        784 |
be_then.32825:
    li      1, $i14
.count move_args
    mov     $ig1, $i15
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.32825
be_else.32825:
    li      0, $i10                     # |        784 |        784 |
    load    [ext_and_net + $i1], $i11   # |        784 |        784 |
    jal     shadow_check_and_group.2862, $ra1# |        784 |        784 |
    bne     $i1, 0, be_else.32826       # |        784 |        784 |
be_then.32826:
    load    [$i14 + 2], $i1             # |        417 |        417 |
    bne     $i1, -1, be_else.32827      # |        417 |        417 |
be_then.32827:
    li      1, $i14
.count move_args
    mov     $ig1, $i15
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.32826
be_else.32827:
    li      0, $i10                     # |        417 |        417 |
    load    [ext_and_net + $i1], $i11   # |        417 |        417 |
    jal     shadow_check_and_group.2862, $ra1# |        417 |        417 |
    bne     $i1, 0, be_else.32828       # |        417 |        417 |
be_then.32828:
    li      3, $i12                     # |        339 |        339 |
.count move_args
    mov     $i14, $i13                  # |        339 |        339 |
    jal     shadow_check_one_or_group.2865, $ra2# |        339 |        339 |
    bne     $i1, 0, be_else.32829       # |        339 |        339 |
be_then.32829:
    li      1, $i14
.count move_args
    mov     $ig1, $i15
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.32826
be_else.32829:
    li      1, $i1                      # |        339 |        339 |
.count b_cont
    b       be_cont.32826               # |        339 |        339 |
be_else.32828:
    li      1, $i1                      # |         78 |         78 |
.count b_cont
    b       be_cont.32826               # |         78 |         78 |
be_else.32826:
    li      1, $i1                      # |        367 |        367 |
be_cont.32826:
be_cont.32825:
be_cont.32824:
be_cont.32815:
    load    [$i29 + 7], $i2             # |     18,496 |     18,496 |
    load    [$i2 + 1], $f1              # |     18,496 |     18,496 |
    fmul    $f16, $f1, $f15             # |     18,496 |     18,496 |
    bne     $i1, 0, be_cont.32830       # |     18,496 |     18,496 |
be_then.32830:
    load    [ext_nvector + 0], $f1      # |     17,539 |     17,539 |
    fmul    $f1, $fg12, $f1             # |     17,539 |     17,539 |
    load    [ext_nvector + 1], $f2      # |     17,539 |     17,539 |
    fmul    $f2, $fg13, $f2             # |     17,539 |     17,539 |
    fadd    $f1, $f2, $f1               # |     17,539 |     17,539 |
    load    [ext_nvector + 2], $f2      # |     17,539 |     17,539 |
    fmul    $f2, $fg14, $f2             # |     17,539 |     17,539 |
    fadd_n  $f1, $f2, $f1               # |     17,539 |     17,539 |
    fmul    $f1, $f14, $f1              # |     17,539 |     17,539 |
    load    [$i26 + 0], $f2             # |     17,539 |     17,539 |
    fmul    $f2, $fg12, $f2             # |     17,539 |     17,539 |
    load    [$i26 + 1], $f3             # |     17,539 |     17,539 |
    fmul    $f3, $fg13, $f3             # |     17,539 |     17,539 |
    fadd    $f2, $f3, $f2               # |     17,539 |     17,539 |
    load    [$i26 + 2], $f3             # |     17,539 |     17,539 |
    fmul    $f3, $fg14, $f3             # |     17,539 |     17,539 |
    fadd_n  $f2, $f3, $f2               # |     17,539 |     17,539 |
    ble     $f1, $f0, bg_cont.32831     # |     17,539 |     17,539 |
bg_then.32831:
    fmul    $f1, $fg16, $f3             # |     17,537 |     17,537 |
    fadd    $fg4, $f3, $fg4             # |     17,537 |     17,537 |
    fmul    $f1, $fg11, $f3             # |     17,537 |     17,537 |
    fadd    $fg5, $f3, $fg5             # |     17,537 |     17,537 |
    fmul    $f1, $fg15, $f1             # |     17,537 |     17,537 |
    fadd    $fg6, $f1, $fg6             # |     17,537 |     17,537 |
bg_cont.32831:
    ble     $f2, $f0, bg_cont.32832     # |     17,539 |     17,539 |
bg_then.32832:
    fmul    $f2, $f2, $f1               # |      6,452 |      6,452 |
    fmul    $f1, $f1, $f1               # |      6,452 |      6,452 |
    fmul    $f1, $f15, $f1              # |      6,452 |      6,452 |
    fadd    $fg4, $f1, $fg4             # |      6,452 |      6,452 |
    fadd    $fg5, $f1, $fg5             # |      6,452 |      6,452 |
    fadd    $fg6, $f1, $fg6             # |      6,452 |      6,452 |
bg_cont.32832:
be_cont.32830:
    li      ext_intersection_point, $i2 # |     18,496 |     18,496 |
    load    [ext_intersection_point + 0], $fg8# |     18,496 |     18,496 |
    load    [ext_intersection_point + 1], $fg9# |     18,496 |     18,496 |
    load    [ext_intersection_point + 2], $fg10# |     18,496 |     18,496 |
    sub     $ig0, 1, $i1                # |     18,496 |     18,496 |
    call    setup_startp_constants.2831 # |     18,496 |     18,496 |
    sub     $ig4, 1, $i21               # |     18,496 |     18,496 |
.count move_args
    mov     $i26, $i22                  # |     18,496 |     18,496 |
    jal     trace_reflections.2915, $ra4# |     18,496 |     18,496 |
    bg      $f16, $fc8, ble_else.32833  # |     18,496 |     18,496 |
ble_then.32833:
    jr      $ra5
ble_else.32833:
    bge     $i25, 4, bl_cont.32834      # |     18,496 |     18,496 |
bl_then.32834:
    add     $i25, 1, $i1                # |     18,496 |     18,496 |
    add     $i0, -1, $i2                # |     18,496 |     18,496 |
.count storer
    add     $i28, $i1, $tmp             # |     18,496 |     18,496 |
    store   $i2, [$tmp + 0]             # |     18,496 |     18,496 |
bl_cont.32834:
    load    [$i29 + 2], $i1             # |     18,496 |     18,496 |
    bne     $i1, 2, be_else.32835       # |     18,496 |     18,496 |
be_then.32835:
    load    [$i29 + 7], $i1             # |      7,370 |      7,370 |
    fadd    $f17, $fg7, $f17            # |      7,370 |      7,370 |
    add     $i25, 1, $i25               # |      7,370 |      7,370 |
    load    [$i1 + 0], $f1              # |      7,370 |      7,370 |
    fsub    $fc0, $f1, $f1              # |      7,370 |      7,370 |
    fmul    $f16, $f1, $f16             # |      7,370 |      7,370 |
    b       trace_ray.2920              # |      7,370 |      7,370 |
be_else.32835:
    jr      $ra5                        # |     11,126 |     11,126 |
ble_else.32793:
    jr      $ra5
.end trace_ray

######################################################################
# trace_diffuse_ray($i21, $f14)
# $ra = $ra4
# [$i1 - $i21]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
    mov     $fc14, $fg7                 # |  1,116,120 |  1,116,120 |
    load    [$ig1 + 0], $i16            # |  1,116,120 |  1,116,120 |
    load    [$i16 + 0], $i1             # |  1,116,120 |  1,116,120 |
    be      $i1, -1, bne_cont.32836     # |  1,116,120 |  1,116,120 |
bne_then.32836:
    bne     $i1, 99, be_else.32837      # |  1,116,120 |  1,116,120 |
be_then.32837:
    load    [$i16 + 1], $i1
    bne     $i1, -1, be_else.32838
be_then.32838:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i21, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32837
be_else.32838:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i21, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 2], $i1
    bne     $i1, -1, be_else.32839
be_then.32839:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i21, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32837
be_else.32839:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i21, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 3], $i1
    bne     $i1, -1, be_else.32840
be_then.32840:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i21, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32837
be_else.32840:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i21, $i12
    jal     solve_each_element_fast.2885, $ra1
    load    [$i16 + 4], $i1
    bne     $i1, -1, be_else.32841
be_then.32841:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i21, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32837
be_else.32841:
    li      0, $i10
    load    [ext_and_net + $i1], $i11
.count move_args
    mov     $i21, $i12
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i15
.count move_args
    mov     $i21, $i17
    jal     solve_one_or_network_fast.2889, $ra2
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i21, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.32837
be_else.32837:
.count move_args
    mov     $i21, $i2                   # |  1,116,120 |  1,116,120 |
    call    solver_fast2.2814           # |  1,116,120 |  1,116,120 |
    bne     $i1, 0, be_else.32842       # |  1,116,120 |  1,116,120 |
be_then.32842:
    li      1, $i18                     # |    436,322 |    436,322 |
.count move_args
    mov     $ig1, $i19                  # |    436,322 |    436,322 |
.count move_args
    mov     $i21, $i20                  # |    436,322 |    436,322 |
    jal     trace_or_matrix_fast.2893, $ra3# |    436,322 |    436,322 |
.count b_cont
    b       be_cont.32842               # |    436,322 |    436,322 |
be_else.32842:
    bg      $fg7, $fg0, ble_else.32843  # |    679,798 |    679,798 |
ble_then.32843:
    li      1, $i18
.count move_args
    mov     $ig1, $i19
.count move_args
    mov     $i21, $i20
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       ble_cont.32843
ble_else.32843:
    li      1, $i15                     # |    679,798 |    679,798 |
.count move_args
    mov     $i21, $i17                  # |    679,798 |    679,798 |
    jal     solve_one_or_network_fast.2889, $ra2# |    679,798 |    679,798 |
    li      1, $i18                     # |    679,798 |    679,798 |
.count move_args
    mov     $ig1, $i19                  # |    679,798 |    679,798 |
.count move_args
    mov     $i21, $i20                  # |    679,798 |    679,798 |
    jal     trace_or_matrix_fast.2893, $ra3# |    679,798 |    679,798 |
ble_cont.32843:
be_cont.32842:
be_cont.32837:
bne_cont.32836:
    bg      $fg7, $fc7, ble_else.32844  # |  1,116,120 |  1,116,120 |
ble_then.32844:
    li      0, $i1
.count b_cont
    b       ble_cont.32844
ble_else.32844:
    bg      $fc13, $fg7, ble_else.32845 # |  1,116,120 |  1,116,120 |
ble_then.32845:
    li      0, $i1                      # |    473,955 |    473,955 |
.count b_cont
    b       ble_cont.32845              # |    473,955 |    473,955 |
ble_else.32845:
    li      1, $i1                      # |    642,165 |    642,165 |
ble_cont.32845:
ble_cont.32844:
    bne     $i1, 0, be_else.32846       # |  1,116,120 |  1,116,120 |
be_then.32846:
    jr      $ra4                        # |    473,955 |    473,955 |
be_else.32846:
    load    [$i21 + 0], $i1             # |    642,165 |    642,165 |
    load    [ext_objects + $ig3], $i17  # |    642,165 |    642,165 |
    load    [$i17 + 1], $i2             # |    642,165 |    642,165 |
    bne     $i2, 1, be_else.32847       # |    642,165 |    642,165 |
be_then.32847:
    store   $f0, [ext_nvector + 0]      # |    114,993 |    114,993 |
    store   $f0, [ext_nvector + 1]      # |    114,993 |    114,993 |
    store   $f0, [ext_nvector + 2]      # |    114,993 |    114,993 |
    sub     $ig2, 1, $i2                # |    114,993 |    114,993 |
    load    [$i1 + $i2], $f1            # |    114,993 |    114,993 |
    bne     $f1, $f0, be_else.32848     # |    114,993 |    114,993 |
be_then.32848:
    store   $f0, [ext_nvector + $i2]
.count b_cont
    b       be_cont.32847
be_else.32848:
    bg      $f1, $f0, ble_else.32849    # |    114,993 |    114,993 |
ble_then.32849:
    store   $fc0, [ext_nvector + $i2]   # |     90,204 |     90,204 |
.count b_cont
    b       be_cont.32847               # |     90,204 |     90,204 |
ble_else.32849:
    store   $fc4, [ext_nvector + $i2]   # |     24,789 |     24,789 |
.count b_cont
    b       be_cont.32847               # |     24,789 |     24,789 |
be_else.32847:
    bne     $i2, 2, be_else.32850       # |    527,172 |    527,172 |
be_then.32850:
    load    [$i17 + 4], $i1             # |    391,509 |    391,509 |
    load    [$i1 + 0], $f1              # |    391,509 |    391,509 |
    fneg    $f1, $f1                    # |    391,509 |    391,509 |
    store   $f1, [ext_nvector + 0]      # |    391,509 |    391,509 |
    load    [$i17 + 4], $i1             # |    391,509 |    391,509 |
    load    [$i1 + 1], $f1              # |    391,509 |    391,509 |
    fneg    $f1, $f1                    # |    391,509 |    391,509 |
    store   $f1, [ext_nvector + 1]      # |    391,509 |    391,509 |
    load    [$i17 + 4], $i1             # |    391,509 |    391,509 |
    load    [$i1 + 2], $f1              # |    391,509 |    391,509 |
    fneg    $f1, $f1                    # |    391,509 |    391,509 |
    store   $f1, [ext_nvector + 2]      # |    391,509 |    391,509 |
.count b_cont
    b       be_cont.32850               # |    391,509 |    391,509 |
be_else.32850:
    load    [$i17 + 3], $i1             # |    135,663 |    135,663 |
    load    [$i17 + 4], $i2             # |    135,663 |    135,663 |
    load    [$i2 + 0], $f1              # |    135,663 |    135,663 |
    load    [ext_intersection_point + 0], $f2# |    135,663 |    135,663 |
    load    [$i17 + 5], $i2             # |    135,663 |    135,663 |
    load    [$i2 + 0], $f3              # |    135,663 |    135,663 |
    fsub    $f2, $f3, $f2               # |    135,663 |    135,663 |
    fmul    $f2, $f1, $f1               # |    135,663 |    135,663 |
    load    [$i17 + 4], $i2             # |    135,663 |    135,663 |
    load    [$i2 + 1], $f3              # |    135,663 |    135,663 |
    load    [ext_intersection_point + 1], $f4# |    135,663 |    135,663 |
    load    [$i17 + 5], $i2             # |    135,663 |    135,663 |
    load    [$i2 + 1], $f5              # |    135,663 |    135,663 |
    fsub    $f4, $f5, $f4               # |    135,663 |    135,663 |
    fmul    $f4, $f3, $f3               # |    135,663 |    135,663 |
    load    [$i17 + 4], $i2             # |    135,663 |    135,663 |
    load    [$i2 + 2], $f5              # |    135,663 |    135,663 |
    load    [ext_intersection_point + 2], $f6# |    135,663 |    135,663 |
    load    [$i17 + 5], $i2             # |    135,663 |    135,663 |
    load    [$i2 + 2], $f7              # |    135,663 |    135,663 |
    fsub    $f6, $f7, $f6               # |    135,663 |    135,663 |
    fmul    $f6, $f5, $f5               # |    135,663 |    135,663 |
    bne     $i1, 0, be_else.32851       # |    135,663 |    135,663 |
be_then.32851:
    store   $f1, [ext_nvector + 0]      # |    135,663 |    135,663 |
    store   $f3, [ext_nvector + 1]      # |    135,663 |    135,663 |
    store   $f5, [ext_nvector + 2]      # |    135,663 |    135,663 |
.count b_cont
    b       be_cont.32851               # |    135,663 |    135,663 |
be_else.32851:
    load    [$i17 + 9], $i1
    load    [$i1 + 2], $f7
    fmul    $f4, $f7, $f7
    load    [$i17 + 9], $i1
    load    [$i1 + 1], $f8
    fmul    $f6, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc3, $f7
    fadd    $f1, $f7, $f1
    store   $f1, [ext_nvector + 0]
    load    [$i17 + 9], $i1
    load    [$i1 + 2], $f1
    fmul    $f2, $f1, $f1
    load    [$i17 + 9], $i1
    load    [$i1 + 0], $f7
    fmul    $f6, $f7, $f6
    fadd    $f1, $f6, $f1
    fmul    $f1, $fc3, $f1
    fadd    $f3, $f1, $f1
    store   $f1, [ext_nvector + 1]
    load    [$i17 + 9], $i1
    load    [$i1 + 1], $f1
    fmul    $f2, $f1, $f1
    load    [$i17 + 9], $i1
    load    [$i1 + 0], $f2
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc3, $f1
    fadd    $f5, $f1, $f1
    store   $f1, [ext_nvector + 2]
be_cont.32851:
    load    [ext_nvector + 0], $f1      # |    135,663 |    135,663 |
    load    [$i17 + 6], $i1             # |    135,663 |    135,663 |
    fmul    $f1, $f1, $f2               # |    135,663 |    135,663 |
    load    [ext_nvector + 1], $f3      # |    135,663 |    135,663 |
    fmul    $f3, $f3, $f3               # |    135,663 |    135,663 |
    fadd    $f2, $f3, $f2               # |    135,663 |    135,663 |
    load    [ext_nvector + 2], $f3      # |    135,663 |    135,663 |
    fmul    $f3, $f3, $f3               # |    135,663 |    135,663 |
    fadd    $f2, $f3, $f2               # |    135,663 |    135,663 |
    fsqrt   $f2, $f2                    # |    135,663 |    135,663 |
    bne     $f2, $f0, be_else.32852     # |    135,663 |    135,663 |
be_then.32852:
    mov     $fc0, $f2
.count b_cont
    b       be_cont.32852
be_else.32852:
    bne     $i1, 0, be_else.32853       # |    135,663 |    135,663 |
be_then.32853:
    finv    $f2, $f2                    # |    103,786 |    103,786 |
.count b_cont
    b       be_cont.32853               # |    103,786 |    103,786 |
be_else.32853:
    finv_n  $f2, $f2                    # |     31,877 |     31,877 |
be_cont.32853:
be_cont.32852:
    fmul    $f1, $f2, $f1               # |    135,663 |    135,663 |
    store   $f1, [ext_nvector + 0]      # |    135,663 |    135,663 |
    load    [ext_nvector + 1], $f1      # |    135,663 |    135,663 |
    fmul    $f1, $f2, $f1               # |    135,663 |    135,663 |
    store   $f1, [ext_nvector + 1]      # |    135,663 |    135,663 |
    load    [ext_nvector + 2], $f1      # |    135,663 |    135,663 |
    fmul    $f1, $f2, $f1               # |    135,663 |    135,663 |
    store   $f1, [ext_nvector + 2]      # |    135,663 |    135,663 |
be_cont.32850:
be_cont.32847:
.count move_args
    mov     $i17, $i1                   # |    642,165 |    642,165 |
    jal     utexture.2908, $ra1         # |    642,165 |    642,165 |
    load    [$ig1 + 0], $i14            # |    642,165 |    642,165 |
    load    [$i14 + 0], $i1             # |    642,165 |    642,165 |
    bne     $i1, -1, be_else.32854      # |    642,165 |    642,165 |
be_then.32854:
    li      0, $i1
.count b_cont
    b       be_cont.32854
be_else.32854:
    bne     $i1, 99, be_else.32855      # |    642,165 |    642,165 |
be_then.32855:
    li      1, $i1
.count b_cont
    b       be_cont.32855
be_else.32855:
    call    solver_fast.2796            # |    642,165 |    642,165 |
    bne     $i1, 0, be_else.32856       # |    642,165 |    642,165 |
be_then.32856:
    li      0, $i1                      # |    441,283 |    441,283 |
.count b_cont
    b       be_cont.32856               # |    441,283 |    441,283 |
be_else.32856:
    bg      $fc7, $fg0, ble_else.32857  # |    200,882 |    200,882 |
ble_then.32857:
    li      0, $i1                      # |      6,953 |      6,953 |
.count b_cont
    b       ble_cont.32857              # |      6,953 |      6,953 |
ble_else.32857:
    load    [$i14 + 1], $i1             # |    193,929 |    193,929 |
    bne     $i1, -1, be_else.32858      # |    193,929 |    193,929 |
be_then.32858:
    li      0, $i1
.count b_cont
    b       be_cont.32858
be_else.32858:
    li      0, $i10                     # |    193,929 |    193,929 |
    load    [ext_and_net + $i1], $i11   # |    193,929 |    193,929 |
    jal     shadow_check_and_group.2862, $ra1# |    193,929 |    193,929 |
    bne     $i1, 0, be_else.32859       # |    193,929 |    193,929 |
be_then.32859:
    load    [$i14 + 2], $i1             # |    153,646 |    153,646 |
    bne     $i1, -1, be_else.32860      # |    153,646 |    153,646 |
be_then.32860:
    li      0, $i1
.count b_cont
    b       be_cont.32859
be_else.32860:
    li      0, $i10                     # |    153,646 |    153,646 |
    load    [ext_and_net + $i1], $i11   # |    153,646 |    153,646 |
    jal     shadow_check_and_group.2862, $ra1# |    153,646 |    153,646 |
    bne     $i1, 0, be_else.32861       # |    153,646 |    153,646 |
be_then.32861:
    li      3, $i12                     # |    143,513 |    143,513 |
.count move_args
    mov     $i14, $i13                  # |    143,513 |    143,513 |
    jal     shadow_check_one_or_group.2865, $ra2# |    143,513 |    143,513 |
    bne     $i1, 0, be_else.32862       # |    143,513 |    143,513 |
be_then.32862:
    li      0, $i1                      # |     78,657 |     78,657 |
.count b_cont
    b       be_cont.32859               # |     78,657 |     78,657 |
be_else.32862:
    li      1, $i1                      # |     64,856 |     64,856 |
.count b_cont
    b       be_cont.32859               # |     64,856 |     64,856 |
be_else.32861:
    li      1, $i1                      # |     10,133 |     10,133 |
.count b_cont
    b       be_cont.32859               # |     10,133 |     10,133 |
be_else.32859:
    li      1, $i1                      # |     40,283 |     40,283 |
be_cont.32859:
be_cont.32858:
ble_cont.32857:
be_cont.32856:
be_cont.32855:
    bne     $i1, 0, be_else.32863       # |    642,165 |    642,165 |
be_then.32863:
    li      1, $i14                     # |    526,893 |    526,893 |
.count move_args
    mov     $ig1, $i15                  # |    526,893 |    526,893 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |    526,893 |    526,893 |
.count b_cont
    b       be_cont.32863               # |    526,893 |    526,893 |
be_else.32863:
    load    [$i14 + 1], $i1             # |    115,272 |    115,272 |
    bne     $i1, -1, be_else.32864      # |    115,272 |    115,272 |
be_then.32864:
    li      1, $i14
.count move_args
    mov     $ig1, $i15
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.32864
be_else.32864:
    li      0, $i10                     # |    115,272 |    115,272 |
    load    [ext_and_net + $i1], $i11   # |    115,272 |    115,272 |
    jal     shadow_check_and_group.2862, $ra1# |    115,272 |    115,272 |
    bne     $i1, 0, be_else.32865       # |    115,272 |    115,272 |
be_then.32865:
    load    [$i14 + 2], $i1             # |     74,989 |     74,989 |
    bne     $i1, -1, be_else.32866      # |     74,989 |     74,989 |
be_then.32866:
    li      1, $i14
.count move_args
    mov     $ig1, $i15
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.32865
be_else.32866:
    li      0, $i10                     # |     74,989 |     74,989 |
    load    [ext_and_net + $i1], $i11   # |     74,989 |     74,989 |
    jal     shadow_check_and_group.2862, $ra1# |     74,989 |     74,989 |
    bne     $i1, 0, be_else.32867       # |     74,989 |     74,989 |
be_then.32867:
    li      3, $i12                     # |     64,856 |     64,856 |
.count move_args
    mov     $i14, $i13                  # |     64,856 |     64,856 |
    jal     shadow_check_one_or_group.2865, $ra2# |     64,856 |     64,856 |
    bne     $i1, 0, be_else.32868       # |     64,856 |     64,856 |
be_then.32868:
    li      1, $i14
.count move_args
    mov     $ig1, $i15
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.32865
be_else.32868:
    li      1, $i1                      # |     64,856 |     64,856 |
.count b_cont
    b       be_cont.32865               # |     64,856 |     64,856 |
be_else.32867:
    li      1, $i1                      # |     10,133 |     10,133 |
.count b_cont
    b       be_cont.32865               # |     10,133 |     10,133 |
be_else.32865:
    li      1, $i1                      # |     40,283 |     40,283 |
be_cont.32865:
be_cont.32864:
be_cont.32863:
be_cont.32854:
    bne     $i1, 0, be_else.32869       # |    642,165 |    642,165 |
be_then.32869:
    load    [$i17 + 7], $i1             # |    523,116 |    523,116 |
    load    [ext_nvector + 0], $f1      # |    523,116 |    523,116 |
    fmul    $f1, $fg12, $f1             # |    523,116 |    523,116 |
    load    [ext_nvector + 1], $f2      # |    523,116 |    523,116 |
    fmul    $f2, $fg13, $f2             # |    523,116 |    523,116 |
    fadd    $f1, $f2, $f1               # |    523,116 |    523,116 |
    load    [ext_nvector + 2], $f2      # |    523,116 |    523,116 |
    fmul    $f2, $fg14, $f2             # |    523,116 |    523,116 |
    fadd_n  $f1, $f2, $f1               # |    523,116 |    523,116 |
    bg      $f1, $f0, ble_cont.32870    # |    523,116 |    523,116 |
ble_then.32870:
    mov     $f0, $f1                    # |        709 |        709 |
ble_cont.32870:
    fmul    $f14, $f1, $f1              # |    523,116 |    523,116 |
    load    [$i1 + 0], $f2              # |    523,116 |    523,116 |
    fmul    $f1, $f2, $f1               # |    523,116 |    523,116 |
    fmul    $f1, $fg16, $f2             # |    523,116 |    523,116 |
    fadd    $fg1, $f2, $fg1             # |    523,116 |    523,116 |
    fmul    $f1, $fg11, $f2             # |    523,116 |    523,116 |
    fadd    $fg2, $f2, $fg2             # |    523,116 |    523,116 |
    fmul    $f1, $fg15, $f1             # |    523,116 |    523,116 |
    fadd    $fg3, $f1, $fg3             # |    523,116 |    523,116 |
    jr      $ra4                        # |    523,116 |    523,116 |
be_else.32869:
    jr      $ra4                        # |    119,049 |    119,049 |
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i22, $i23, $i24)
# $ra = $ra5
# [$i1 - $i24]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
    bl      $i24, 0, bge_else.32871     # |    558,060 |    558,060 |
bge_then.32871:
    load    [$i22 + $i24], $i1          # |    558,060 |    558,060 |
    load    [$i1 + 0], $i1              # |    558,060 |    558,060 |
    load    [$i1 + 0], $f1              # |    558,060 |    558,060 |
    load    [$i23 + 0], $f2             # |    558,060 |    558,060 |
    fmul    $f1, $f2, $f1               # |    558,060 |    558,060 |
    load    [$i1 + 1], $f2              # |    558,060 |    558,060 |
    load    [$i23 + 1], $f3             # |    558,060 |    558,060 |
    fmul    $f2, $f3, $f2               # |    558,060 |    558,060 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |
    load    [$i1 + 2], $f2              # |    558,060 |    558,060 |
    load    [$i23 + 2], $f3             # |    558,060 |    558,060 |
    fmul    $f2, $f3, $f2               # |    558,060 |    558,060 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |
    bg      $f0, $f1, ble_else.32872    # |    558,060 |    558,060 |
ble_then.32872:
    fmul    $f1, $fc1, $f14             # |    381,307 |    381,307 |
    load    [$i22 + $i24], $i21         # |    381,307 |    381,307 |
    jal     trace_diffuse_ray.2926, $ra4# |    381,307 |    381,307 |
    sub     $i24, 2, $i24               # |    381,307 |    381,307 |
    bl      $i24, 0, bge_else.32873     # |    381,307 |    381,307 |
bge_then.32873:
    load    [$i22 + $i24], $i1          # |    365,736 |    365,736 |
    load    [$i1 + 0], $i1              # |    365,736 |    365,736 |
    load    [$i1 + 0], $f1              # |    365,736 |    365,736 |
    load    [$i23 + 0], $f2             # |    365,736 |    365,736 |
    fmul    $f1, $f2, $f1               # |    365,736 |    365,736 |
    load    [$i1 + 1], $f2              # |    365,736 |    365,736 |
    load    [$i23 + 1], $f3             # |    365,736 |    365,736 |
    fmul    $f2, $f3, $f2               # |    365,736 |    365,736 |
    fadd    $f1, $f2, $f1               # |    365,736 |    365,736 |
    load    [$i1 + 2], $f2              # |    365,736 |    365,736 |
    load    [$i23 + 2], $f3             # |    365,736 |    365,736 |
    fmul    $f2, $f3, $f2               # |    365,736 |    365,736 |
    fadd    $f1, $f2, $f1               # |    365,736 |    365,736 |
    bg      $f0, $f1, ble_else.32874    # |    365,736 |    365,736 |
ble_then.32874:
    fmul    $f1, $fc1, $f14             # |    191,017 |    191,017 |
    load    [$i22 + $i24], $i21         # |    191,017 |    191,017 |
    jal     trace_diffuse_ray.2926, $ra4# |    191,017 |    191,017 |
    sub     $i24, 2, $i24               # |    191,017 |    191,017 |
    b       iter_trace_diffuse_rays.2929# |    191,017 |    191,017 |
ble_else.32874:
    fmul    $f1, $fc2, $f14             # |    174,719 |    174,719 |
    add     $i24, 1, $i1                # |    174,719 |    174,719 |
    load    [$i22 + $i1], $i21          # |    174,719 |    174,719 |
    jal     trace_diffuse_ray.2926, $ra4# |    174,719 |    174,719 |
    sub     $i24, 2, $i24               # |    174,719 |    174,719 |
    b       iter_trace_diffuse_rays.2929# |    174,719 |    174,719 |
bge_else.32873:
    jr      $ra5                        # |     15,571 |     15,571 |
ble_else.32872:
    fmul    $f1, $fc2, $f14             # |    176,753 |    176,753 |
    add     $i24, 1, $i1                # |    176,753 |    176,753 |
    load    [$i22 + $i1], $i21          # |    176,753 |    176,753 |
    jal     trace_diffuse_ray.2926, $ra4# |    176,753 |    176,753 |
    sub     $i24, 2, $i24               # |    176,753 |    176,753 |
    bl      $i24, 0, bge_else.32875     # |    176,753 |    176,753 |
bge_then.32875:
    load    [$i22 + $i24], $i1          # |    173,722 |    173,722 |
    load    [$i1 + 0], $i1              # |    173,722 |    173,722 |
    load    [$i1 + 0], $f1              # |    173,722 |    173,722 |
    load    [$i23 + 0], $f2             # |    173,722 |    173,722 |
    fmul    $f1, $f2, $f1               # |    173,722 |    173,722 |
    load    [$i1 + 1], $f2              # |    173,722 |    173,722 |
    load    [$i23 + 1], $f3             # |    173,722 |    173,722 |
    fmul    $f2, $f3, $f2               # |    173,722 |    173,722 |
    fadd    $f1, $f2, $f1               # |    173,722 |    173,722 |
    load    [$i1 + 2], $f2              # |    173,722 |    173,722 |
    load    [$i23 + 2], $f3             # |    173,722 |    173,722 |
    fmul    $f2, $f3, $f2               # |    173,722 |    173,722 |
    fadd    $f1, $f2, $f1               # |    173,722 |    173,722 |
    bg      $f0, $f1, ble_else.32876    # |    173,722 |    173,722 |
ble_then.32876:
    fmul    $f1, $fc1, $f14             # |     20,153 |     20,153 |
    load    [$i22 + $i24], $i21         # |     20,153 |     20,153 |
    jal     trace_diffuse_ray.2926, $ra4# |     20,153 |     20,153 |
    sub     $i24, 2, $i24               # |     20,153 |     20,153 |
    b       iter_trace_diffuse_rays.2929# |     20,153 |     20,153 |
ble_else.32876:
    fmul    $f1, $fc2, $f14             # |    153,569 |    153,569 |
    add     $i24, 1, $i1                # |    153,569 |    153,569 |
    load    [$i22 + $i1], $i21          # |    153,569 |    153,569 |
    jal     trace_diffuse_ray.2926, $ra4# |    153,569 |    153,569 |
    sub     $i24, 2, $i24               # |    153,569 |    153,569 |
    b       iter_trace_diffuse_rays.2929# |    153,569 |    153,569 |
bge_else.32875:
    jr      $ra5                        # |      3,031 |      3,031 |
bge_else.32871:
    jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i25, $i26)
# $ra = $ra6
# [$i1 - $i29]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
    load    [$i25 + 5], $i1             # |      1,737 |      1,737 |
    load    [$i1 + $i26], $i1           # |      1,737 |      1,737 |
    load    [$i1 + 0], $fg1             # |      1,737 |      1,737 |
    load    [$i1 + 1], $fg2             # |      1,737 |      1,737 |
    load    [$i1 + 2], $fg3             # |      1,737 |      1,737 |
    load    [$i25 + 7], $i1             # |      1,737 |      1,737 |
    load    [$i25 + 1], $i2             # |      1,737 |      1,737 |
    load    [$i25 + 6], $i3             # |      1,737 |      1,737 |
    load    [$i1 + $i26], $i27          # |      1,737 |      1,737 |
    load    [$i2 + $i26], $i28          # |      1,737 |      1,737 |
    load    [$i3 + 0], $i29             # |      1,737 |      1,737 |
    be      $i29, 0, bne_cont.32877     # |      1,737 |      1,737 |
bne_then.32877:
    load    [ext_dirvecs + 0], $i22     # |      1,389 |      1,389 |
    load    [$i28 + 0], $fg8            # |      1,389 |      1,389 |
    load    [$i28 + 1], $fg9            # |      1,389 |      1,389 |
    load    [$i28 + 2], $fg10           # |      1,389 |      1,389 |
    sub     $ig0, 1, $i1                # |      1,389 |      1,389 |
.count move_args
    mov     $i28, $i2                   # |      1,389 |      1,389 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |
    load    [$i22 + 118], $i1           # |      1,389 |      1,389 |
    load    [$i1 + 0], $i1              # |      1,389 |      1,389 |
    load    [$i1 + 0], $f1              # |      1,389 |      1,389 |
    load    [$i27 + 0], $f2             # |      1,389 |      1,389 |
    fmul    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 1], $f2              # |      1,389 |      1,389 |
    load    [$i27 + 1], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 2], $f2              # |      1,389 |      1,389 |
    load    [$i27 + 2], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    bg      $f0, $f1, ble_else.32878    # |      1,389 |      1,389 |
ble_then.32878:
    load    [$i22 + 118], $i21          # |         89 |         89 |
    fmul    $f1, $fc1, $f14             # |         89 |         89 |
    jal     trace_diffuse_ray.2926, $ra4# |         89 |         89 |
    li      116, $i24                   # |         89 |         89 |
.count move_args
    mov     $i27, $i23                  # |         89 |         89 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         89 |         89 |
.count b_cont
    b       ble_cont.32878              # |         89 |         89 |
ble_else.32878:
    load    [$i22 + 119], $i21          # |      1,300 |      1,300 |
    fmul    $f1, $fc2, $f14             # |      1,300 |      1,300 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,300 |      1,300 |
    li      116, $i24                   # |      1,300 |      1,300 |
.count move_args
    mov     $i27, $i23                  # |      1,300 |      1,300 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,300 |      1,300 |
ble_cont.32878:
bne_cont.32877:
    be      $i29, 1, bne_cont.32879     # |      1,737 |      1,737 |
bne_then.32879:
    load    [ext_dirvecs + 1], $i22     # |      1,389 |      1,389 |
    load    [$i28 + 0], $fg8            # |      1,389 |      1,389 |
    load    [$i28 + 1], $fg9            # |      1,389 |      1,389 |
    load    [$i28 + 2], $fg10           # |      1,389 |      1,389 |
    sub     $ig0, 1, $i1                # |      1,389 |      1,389 |
.count move_args
    mov     $i28, $i2                   # |      1,389 |      1,389 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |
    load    [$i22 + 118], $i1           # |      1,389 |      1,389 |
    load    [$i1 + 0], $i1              # |      1,389 |      1,389 |
    load    [$i1 + 0], $f1              # |      1,389 |      1,389 |
    load    [$i27 + 0], $f2             # |      1,389 |      1,389 |
    fmul    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 1], $f2              # |      1,389 |      1,389 |
    load    [$i27 + 1], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 2], $f2              # |      1,389 |      1,389 |
    load    [$i27 + 2], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    bg      $f0, $f1, ble_else.32880    # |      1,389 |      1,389 |
ble_then.32880:
    load    [$i22 + 118], $i21          # |         96 |         96 |
    fmul    $f1, $fc1, $f14             # |         96 |         96 |
    jal     trace_diffuse_ray.2926, $ra4# |         96 |         96 |
    li      116, $i24                   # |         96 |         96 |
.count move_args
    mov     $i27, $i23                  # |         96 |         96 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         96 |         96 |
.count b_cont
    b       ble_cont.32880              # |         96 |         96 |
ble_else.32880:
    load    [$i22 + 119], $i21          # |      1,293 |      1,293 |
    fmul    $f1, $fc2, $f14             # |      1,293 |      1,293 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,293 |      1,293 |
    li      116, $i24                   # |      1,293 |      1,293 |
.count move_args
    mov     $i27, $i23                  # |      1,293 |      1,293 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,293 |      1,293 |
ble_cont.32880:
bne_cont.32879:
    be      $i29, 2, bne_cont.32881     # |      1,737 |      1,737 |
bne_then.32881:
    load    [ext_dirvecs + 2], $i22     # |      1,400 |      1,400 |
    load    [$i28 + 0], $fg8            # |      1,400 |      1,400 |
    load    [$i28 + 1], $fg9            # |      1,400 |      1,400 |
    load    [$i28 + 2], $fg10           # |      1,400 |      1,400 |
    sub     $ig0, 1, $i1                # |      1,400 |      1,400 |
.count move_args
    mov     $i28, $i2                   # |      1,400 |      1,400 |
    call    setup_startp_constants.2831 # |      1,400 |      1,400 |
    load    [$i22 + 118], $i1           # |      1,400 |      1,400 |
    load    [$i1 + 0], $i1              # |      1,400 |      1,400 |
    load    [$i1 + 0], $f1              # |      1,400 |      1,400 |
    load    [$i27 + 0], $f2             # |      1,400 |      1,400 |
    fmul    $f1, $f2, $f1               # |      1,400 |      1,400 |
    load    [$i1 + 1], $f2              # |      1,400 |      1,400 |
    load    [$i27 + 1], $f3             # |      1,400 |      1,400 |
    fmul    $f2, $f3, $f2               # |      1,400 |      1,400 |
    fadd    $f1, $f2, $f1               # |      1,400 |      1,400 |
    load    [$i1 + 2], $f2              # |      1,400 |      1,400 |
    load    [$i27 + 2], $f3             # |      1,400 |      1,400 |
    fmul    $f2, $f3, $f2               # |      1,400 |      1,400 |
    fadd    $f1, $f2, $f1               # |      1,400 |      1,400 |
    bg      $f0, $f1, ble_else.32882    # |      1,400 |      1,400 |
ble_then.32882:
    load    [$i22 + 118], $i21          # |        125 |        125 |
    fmul    $f1, $fc1, $f14             # |        125 |        125 |
    jal     trace_diffuse_ray.2926, $ra4# |        125 |        125 |
    li      116, $i24                   # |        125 |        125 |
.count move_args
    mov     $i27, $i23                  # |        125 |        125 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        125 |        125 |
.count b_cont
    b       ble_cont.32882              # |        125 |        125 |
ble_else.32882:
    load    [$i22 + 119], $i21          # |      1,275 |      1,275 |
    fmul    $f1, $fc2, $f14             # |      1,275 |      1,275 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,275 |      1,275 |
    li      116, $i24                   # |      1,275 |      1,275 |
.count move_args
    mov     $i27, $i23                  # |      1,275 |      1,275 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,275 |      1,275 |
ble_cont.32882:
bne_cont.32881:
    be      $i29, 3, bne_cont.32883     # |      1,737 |      1,737 |
bne_then.32883:
    load    [ext_dirvecs + 3], $i22     # |      1,385 |      1,385 |
    load    [$i28 + 0], $fg8            # |      1,385 |      1,385 |
    load    [$i28 + 1], $fg9            # |      1,385 |      1,385 |
    load    [$i28 + 2], $fg10           # |      1,385 |      1,385 |
    sub     $ig0, 1, $i1                # |      1,385 |      1,385 |
.count move_args
    mov     $i28, $i2                   # |      1,385 |      1,385 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |
    load    [$i22 + 118], $i1           # |      1,385 |      1,385 |
    load    [$i1 + 0], $i1              # |      1,385 |      1,385 |
    load    [$i1 + 0], $f1              # |      1,385 |      1,385 |
    load    [$i27 + 0], $f2             # |      1,385 |      1,385 |
    fmul    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 1], $f2              # |      1,385 |      1,385 |
    load    [$i27 + 1], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 2], $f2              # |      1,385 |      1,385 |
    load    [$i27 + 2], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    bg      $f0, $f1, ble_else.32884    # |      1,385 |      1,385 |
ble_then.32884:
    load    [$i22 + 118], $i21          # |        114 |        114 |
    fmul    $f1, $fc1, $f14             # |        114 |        114 |
    jal     trace_diffuse_ray.2926, $ra4# |        114 |        114 |
    li      116, $i24                   # |        114 |        114 |
.count move_args
    mov     $i27, $i23                  # |        114 |        114 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        114 |        114 |
.count b_cont
    b       ble_cont.32884              # |        114 |        114 |
ble_else.32884:
    load    [$i22 + 119], $i21          # |      1,271 |      1,271 |
    fmul    $f1, $fc2, $f14             # |      1,271 |      1,271 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,271 |      1,271 |
    li      116, $i24                   # |      1,271 |      1,271 |
.count move_args
    mov     $i27, $i23                  # |      1,271 |      1,271 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,271 |      1,271 |
ble_cont.32884:
bne_cont.32883:
    be      $i29, 4, bne_cont.32885     # |      1,737 |      1,737 |
bne_then.32885:
    load    [ext_dirvecs + 4], $i22     # |      1,385 |      1,385 |
    load    [$i28 + 0], $fg8            # |      1,385 |      1,385 |
    load    [$i28 + 1], $fg9            # |      1,385 |      1,385 |
    load    [$i28 + 2], $fg10           # |      1,385 |      1,385 |
    sub     $ig0, 1, $i1                # |      1,385 |      1,385 |
.count move_args
    mov     $i28, $i2                   # |      1,385 |      1,385 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |
    load    [$i22 + 118], $i1           # |      1,385 |      1,385 |
    load    [$i1 + 0], $i1              # |      1,385 |      1,385 |
    load    [$i1 + 0], $f1              # |      1,385 |      1,385 |
    load    [$i27 + 0], $f2             # |      1,385 |      1,385 |
    fmul    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 1], $f2              # |      1,385 |      1,385 |
    load    [$i27 + 1], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 2], $f2              # |      1,385 |      1,385 |
    load    [$i27 + 2], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    bg      $f0, $f1, ble_else.32886    # |      1,385 |      1,385 |
ble_then.32886:
    load    [$i22 + 118], $i21          # |         97 |         97 |
    fmul    $f1, $fc1, $f14             # |         97 |         97 |
    jal     trace_diffuse_ray.2926, $ra4# |         97 |         97 |
    li      116, $i24                   # |         97 |         97 |
.count move_args
    mov     $i27, $i23                  # |         97 |         97 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         97 |         97 |
.count b_cont
    b       ble_cont.32886              # |         97 |         97 |
ble_else.32886:
    load    [$i22 + 119], $i21          # |      1,288 |      1,288 |
    fmul    $f1, $fc2, $f14             # |      1,288 |      1,288 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,288 |      1,288 |
    li      116, $i24                   # |      1,288 |      1,288 |
.count move_args
    mov     $i27, $i23                  # |      1,288 |      1,288 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,288 |      1,288 |
ble_cont.32886:
bne_cont.32885:
    load    [$i25 + 4], $i1             # |      1,737 |      1,737 |
    load    [$i1 + $i26], $i1           # |      1,737 |      1,737 |
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
# do_without_neighbors($i30, $i25)
# $ra = $ra7
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
    bg      $i25, 4, ble_else.32887     # |      2,430 |      2,430 |
ble_then.32887:
    load    [$i30 + 2], $i26            # |      2,430 |      2,430 |
    load    [$i26 + $i25], $i1          # |      2,430 |      2,430 |
    bl      $i1, 0, bge_else.32888      # |      2,430 |      2,430 |
bge_then.32888:
    load    [$i30 + 3], $i27            # |        143 |        143 |
    load    [$i27 + $i25], $i1          # |        143 |        143 |
    bne     $i1, 0, be_else.32889       # |        143 |        143 |
be_then.32889:
    add     $i25, 1, $i31               # |         11 |         11 |
    bg      $i31, 4, ble_else.32890     # |         11 |         11 |
ble_then.32890:
    load    [$i26 + $i31], $i1          # |         11 |         11 |
    bl      $i1, 0, bge_else.32891      # |         11 |         11 |
bge_then.32891:
    load    [$i27 + $i31], $i1          # |          1 |          1 |
    bne     $i1, 0, be_else.32892       # |          1 |          1 |
be_then.32892:
    add     $i31, 1, $i25
    b       do_without_neighbors.2951
be_else.32892:
.count move_args
    mov     $i30, $i25                  # |          1 |          1 |
.count move_args
    mov     $i31, $i26                  # |          1 |          1 |
    jal     calc_diffuse_using_1point.2942, $ra6# |          1 |          1 |
    add     $i31, 1, $i25               # |          1 |          1 |
    b       do_without_neighbors.2951   # |          1 |          1 |
bge_else.32891:
    jr      $ra7                        # |         10 |         10 |
ble_else.32890:
    jr      $ra7
be_else.32889:
    load    [$i30 + 5], $i1             # |        132 |        132 |
    load    [$i1 + $i25], $i1           # |        132 |        132 |
    load    [$i1 + 0], $fg1             # |        132 |        132 |
    load    [$i1 + 1], $fg2             # |        132 |        132 |
    load    [$i1 + 2], $fg3             # |        132 |        132 |
    load    [$i30 + 7], $i1             # |        132 |        132 |
    load    [$i30 + 1], $i2             # |        132 |        132 |
    load    [$i30 + 6], $i3             # |        132 |        132 |
    load    [$i1 + $i25], $i28          # |        132 |        132 |
    load    [$i2 + $i25], $i29          # |        132 |        132 |
    load    [$i3 + 0], $i31             # |        132 |        132 |
    be      $i31, 0, bne_cont.32893     # |        132 |        132 |
bne_then.32893:
    load    [ext_dirvecs + 0], $i22     # |        107 |        107 |
    load    [$i29 + 0], $fg8            # |        107 |        107 |
    load    [$i29 + 1], $fg9            # |        107 |        107 |
    load    [$i29 + 2], $fg10           # |        107 |        107 |
    sub     $ig0, 1, $i1                # |        107 |        107 |
.count move_args
    mov     $i29, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i22 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $i1              # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i28 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i28 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i28 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, ble_else.32894    # |        107 |        107 |
ble_then.32894:
    fmul    $f1, $fc1, $f14
    load    [$i22 + 118], $i21
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i24
.count move_args
    mov     $i28, $i23
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.32894
ble_else.32894:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i22 + 119], $i21          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i24                   # |        107 |        107 |
.count move_args
    mov     $i28, $i23                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
ble_cont.32894:
bne_cont.32893:
    be      $i31, 1, bne_cont.32895     # |        132 |        132 |
bne_then.32895:
    load    [ext_dirvecs + 1], $i22     # |        104 |        104 |
    load    [$i29 + 0], $fg8            # |        104 |        104 |
    load    [$i29 + 1], $fg9            # |        104 |        104 |
    load    [$i29 + 2], $fg10           # |        104 |        104 |
    sub     $ig0, 1, $i1                # |        104 |        104 |
.count move_args
    mov     $i29, $i2                   # |        104 |        104 |
    call    setup_startp_constants.2831 # |        104 |        104 |
    load    [$i22 + 118], $i1           # |        104 |        104 |
    load    [$i1 + 0], $i1              # |        104 |        104 |
    load    [$i1 + 0], $f1              # |        104 |        104 |
    load    [$i28 + 0], $f2             # |        104 |        104 |
    fmul    $f1, $f2, $f1               # |        104 |        104 |
    load    [$i1 + 1], $f2              # |        104 |        104 |
    load    [$i28 + 1], $f3             # |        104 |        104 |
    fmul    $f2, $f3, $f2               # |        104 |        104 |
    fadd    $f1, $f2, $f1               # |        104 |        104 |
    load    [$i1 + 2], $f2              # |        104 |        104 |
    load    [$i28 + 2], $f3             # |        104 |        104 |
    fmul    $f2, $f3, $f2               # |        104 |        104 |
    fadd    $f1, $f2, $f1               # |        104 |        104 |
    bg      $f0, $f1, ble_else.32896    # |        104 |        104 |
ble_then.32896:
    fmul    $f1, $fc1, $f14
    load    [$i22 + 118], $i21
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i24
.count move_args
    mov     $i28, $i23
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.32896
ble_else.32896:
    fmul    $f1, $fc2, $f14             # |        104 |        104 |
    load    [$i22 + 119], $i21          # |        104 |        104 |
    jal     trace_diffuse_ray.2926, $ra4# |        104 |        104 |
    li      116, $i24                   # |        104 |        104 |
.count move_args
    mov     $i28, $i23                  # |        104 |        104 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        104 |        104 |
ble_cont.32896:
bne_cont.32895:
    be      $i31, 2, bne_cont.32897     # |        132 |        132 |
bne_then.32897:
    load    [ext_dirvecs + 2], $i22     # |        107 |        107 |
    load    [$i29 + 0], $fg8            # |        107 |        107 |
    load    [$i29 + 1], $fg9            # |        107 |        107 |
    load    [$i29 + 2], $fg10           # |        107 |        107 |
    sub     $ig0, 1, $i1                # |        107 |        107 |
.count move_args
    mov     $i29, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i22 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $i1              # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i28 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i28 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i28 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, ble_else.32898    # |        107 |        107 |
ble_then.32898:
    fmul    $f1, $fc1, $f14
    load    [$i22 + 118], $i21
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i24
.count move_args
    mov     $i28, $i23
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.32898
ble_else.32898:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i22 + 119], $i21          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i24                   # |        107 |        107 |
.count move_args
    mov     $i28, $i23                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
ble_cont.32898:
bne_cont.32897:
    be      $i31, 3, bne_cont.32899     # |        132 |        132 |
bne_then.32899:
    load    [ext_dirvecs + 3], $i22     # |        103 |        103 |
    load    [$i29 + 0], $fg8            # |        103 |        103 |
    load    [$i29 + 1], $fg9            # |        103 |        103 |
    load    [$i29 + 2], $fg10           # |        103 |        103 |
    sub     $ig0, 1, $i1                # |        103 |        103 |
.count move_args
    mov     $i29, $i2                   # |        103 |        103 |
    call    setup_startp_constants.2831 # |        103 |        103 |
    load    [$i22 + 118], $i1           # |        103 |        103 |
    load    [$i1 + 0], $i1              # |        103 |        103 |
    load    [$i1 + 0], $f1              # |        103 |        103 |
    load    [$i28 + 0], $f2             # |        103 |        103 |
    fmul    $f1, $f2, $f1               # |        103 |        103 |
    load    [$i1 + 1], $f2              # |        103 |        103 |
    load    [$i28 + 1], $f3             # |        103 |        103 |
    fmul    $f2, $f3, $f2               # |        103 |        103 |
    fadd    $f1, $f2, $f1               # |        103 |        103 |
    load    [$i1 + 2], $f2              # |        103 |        103 |
    load    [$i28 + 2], $f3             # |        103 |        103 |
    fmul    $f2, $f3, $f2               # |        103 |        103 |
    fadd    $f1, $f2, $f1               # |        103 |        103 |
    bg      $f0, $f1, ble_else.32900    # |        103 |        103 |
ble_then.32900:
    fmul    $f1, $fc1, $f14
    load    [$i22 + 118], $i21
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i24
.count move_args
    mov     $i28, $i23
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.32900
ble_else.32900:
    fmul    $f1, $fc2, $f14             # |        103 |        103 |
    load    [$i22 + 119], $i21          # |        103 |        103 |
    jal     trace_diffuse_ray.2926, $ra4# |        103 |        103 |
    li      116, $i24                   # |        103 |        103 |
.count move_args
    mov     $i28, $i23                  # |        103 |        103 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        103 |        103 |
ble_cont.32900:
bne_cont.32899:
    be      $i31, 4, bne_cont.32901     # |        132 |        132 |
bne_then.32901:
    load    [ext_dirvecs + 4], $i22     # |        107 |        107 |
    load    [$i29 + 0], $fg8            # |        107 |        107 |
    load    [$i29 + 1], $fg9            # |        107 |        107 |
    load    [$i29 + 2], $fg10           # |        107 |        107 |
    sub     $ig0, 1, $i1                # |        107 |        107 |
.count move_args
    mov     $i29, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i22 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $i1              # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i28 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i28 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i28 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, ble_else.32902    # |        107 |        107 |
ble_then.32902:
    fmul    $f1, $fc1, $f14
    load    [$i22 + 118], $i21
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i24
.count move_args
    mov     $i28, $i23
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.32902
ble_else.32902:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i22 + 119], $i21          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i24                   # |        107 |        107 |
.count move_args
    mov     $i28, $i23                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
ble_cont.32902:
bne_cont.32901:
    load    [$i30 + 4], $i1             # |        132 |        132 |
    load    [$i1 + $i25], $i1           # |        132 |        132 |
    load    [$i1 + 0], $f1              # |        132 |        132 |
    fmul    $f1, $fg1, $f1              # |        132 |        132 |
    fadd    $fg4, $f1, $fg4             # |        132 |        132 |
    load    [$i1 + 1], $f1              # |        132 |        132 |
    fmul    $f1, $fg2, $f1              # |        132 |        132 |
    fadd    $fg5, $f1, $fg5             # |        132 |        132 |
    load    [$i1 + 2], $f1              # |        132 |        132 |
    fmul    $f1, $fg3, $f1              # |        132 |        132 |
    fadd    $fg6, $f1, $fg6             # |        132 |        132 |
    add     $i25, 1, $i31               # |        132 |        132 |
    bg      $i31, 4, ble_else.32903     # |        132 |        132 |
ble_then.32903:
    load    [$i26 + $i31], $i1          # |        132 |        132 |
    bl      $i1, 0, bge_else.32904      # |        132 |        132 |
bge_then.32904:
    load    [$i27 + $i31], $i1
    bne     $i1, 0, be_else.32905
be_then.32905:
    add     $i31, 1, $i25
    b       do_without_neighbors.2951
be_else.32905:
.count move_args
    mov     $i30, $i25
.count move_args
    mov     $i31, $i26
    jal     calc_diffuse_using_1point.2942, $ra6
    add     $i31, 1, $i25
    b       do_without_neighbors.2951
bge_else.32904:
    jr      $ra7                        # |        132 |        132 |
ble_else.32903:
    jr      $ra7
bge_else.32888:
    jr      $ra7                        # |      2,287 |      2,287 |
ble_else.32887:
    jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i30)
# $ra = $ra7
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
    bg      $i30, 4, ble_else.32906     # |     23,861 |     23,861 |
ble_then.32906:
    load    [$i4 + $i2], $i1            # |     23,861 |     23,861 |
    load    [$i1 + 2], $i6              # |     23,861 |     23,861 |
    load    [$i6 + $i30], $i6           # |     23,861 |     23,861 |
    bl      $i6, 0, bge_else.32907      # |     23,861 |     23,861 |
bge_then.32907:
    load    [$i3 + $i2], $i7            # |      9,906 |      9,906 |
    load    [$i7 + 2], $i8              # |      9,906 |      9,906 |
    load    [$i8 + $i30], $i8           # |      9,906 |      9,906 |
    bne     $i8, $i6, be_else.32908     # |      9,906 |      9,906 |
be_then.32908:
    load    [$i5 + $i2], $i8            # |      9,429 |      9,429 |
    load    [$i8 + 2], $i8              # |      9,429 |      9,429 |
    load    [$i8 + $i30], $i8           # |      9,429 |      9,429 |
    bne     $i8, $i6, be_else.32909     # |      9,429 |      9,429 |
be_then.32909:
    sub     $i2, 1, $i8                 # |      9,028 |      9,028 |
    load    [$i4 + $i8], $i8            # |      9,028 |      9,028 |
    load    [$i8 + 2], $i8              # |      9,028 |      9,028 |
    load    [$i8 + $i30], $i8           # |      9,028 |      9,028 |
    bne     $i8, $i6, be_else.32910     # |      9,028 |      9,028 |
be_then.32910:
    add     $i2, 1, $i8                 # |      8,880 |      8,880 |
    load    [$i4 + $i8], $i8            # |      8,880 |      8,880 |
    load    [$i8 + 2], $i8              # |      8,880 |      8,880 |
    load    [$i8 + $i30], $i8           # |      8,880 |      8,880 |
    bne     $i8, $i6, be_else.32911     # |      8,880 |      8,880 |
be_then.32911:
    li      1, $i6                      # |      8,752 |      8,752 |
.count b_cont
    b       be_cont.32908               # |      8,752 |      8,752 |
be_else.32911:
    li      0, $i6                      # |        128 |        128 |
.count b_cont
    b       be_cont.32908               # |        128 |        128 |
be_else.32910:
    li      0, $i6                      # |        148 |        148 |
.count b_cont
    b       be_cont.32908               # |        148 |        148 |
be_else.32909:
    li      0, $i6                      # |        401 |        401 |
.count b_cont
    b       be_cont.32908               # |        401 |        401 |
be_else.32908:
    li      0, $i6                      # |        477 |        477 |
be_cont.32908:
    bne     $i6, 0, be_else.32912       # |      9,906 |      9,906 |
be_then.32912:
    bg      $i30, 4, ble_else.32913     # |      1,154 |      1,154 |
ble_then.32913:
    load    [$i4 + $i2], $i31           # |      1,154 |      1,154 |
    load    [$i31 + 2], $i1             # |      1,154 |      1,154 |
    load    [$i1 + $i30], $i1           # |      1,154 |      1,154 |
    bl      $i1, 0, bge_else.32914      # |      1,154 |      1,154 |
bge_then.32914:
    load    [$i31 + 3], $i1             # |      1,154 |      1,154 |
    load    [$i1 + $i30], $i1           # |      1,154 |      1,154 |
    bne     $i1, 0, be_else.32915       # |      1,154 |      1,154 |
be_then.32915:
    add     $i30, 1, $i25               # |        178 |        178 |
.count move_args
    mov     $i31, $i30                  # |        178 |        178 |
    b       do_without_neighbors.2951   # |        178 |        178 |
be_else.32915:
.count move_args
    mov     $i31, $i25                  # |        976 |        976 |
.count move_args
    mov     $i30, $i26                  # |        976 |        976 |
    jal     calc_diffuse_using_1point.2942, $ra6# |        976 |        976 |
    add     $i30, 1, $i25               # |        976 |        976 |
.count move_args
    mov     $i31, $i30                  # |        976 |        976 |
    b       do_without_neighbors.2951   # |        976 |        976 |
bge_else.32914:
    jr      $ra7
ble_else.32913:
    jr      $ra7
be_else.32912:
    load    [$i1 + 3], $i1              # |      8,752 |      8,752 |
    load    [$i1 + $i30], $i1           # |      8,752 |      8,752 |
    bne     $i1, 0, be_else.32916       # |      8,752 |      8,752 |
be_then.32916:
    add     $i30, 1, $i30               # |      3,348 |      3,348 |
    b       try_exploit_neighbors.2967  # |      3,348 |      3,348 |
be_else.32916:
    load    [$i7 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i30], $i1           # |      5,404 |      5,404 |
    load    [$i1 + 0], $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $fg3             # |      5,404 |      5,404 |
    sub     $i2, 1, $i1                 # |      5,404 |      5,404 |
    load    [$i4 + $i1], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i30], $i1           # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fadd    $fg1, $f1, $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fadd    $fg2, $f1, $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fadd    $fg3, $f1, $fg3             # |      5,404 |      5,404 |
    load    [$i4 + $i2], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i30], $i1           # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fadd    $fg1, $f1, $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fadd    $fg2, $f1, $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fadd    $fg3, $f1, $fg3             # |      5,404 |      5,404 |
    add     $i2, 1, $i1                 # |      5,404 |      5,404 |
    load    [$i4 + $i1], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i30], $i1           # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fadd    $fg1, $f1, $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fadd    $fg2, $f1, $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fadd    $fg3, $f1, $fg3             # |      5,404 |      5,404 |
    load    [$i5 + $i2], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i30], $i1           # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fadd    $fg1, $f1, $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fadd    $fg2, $f1, $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fadd    $fg3, $f1, $fg3             # |      5,404 |      5,404 |
    load    [$i4 + $i2], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 4], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i30], $i1           # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fmul    $f1, $fg1, $f1              # |      5,404 |      5,404 |
    fadd    $fg4, $f1, $fg4             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fmul    $f1, $fg2, $f1              # |      5,404 |      5,404 |
    fadd    $fg5, $f1, $fg5             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fmul    $f1, $fg3, $f1              # |      5,404 |      5,404 |
    fadd    $fg6, $f1, $fg6             # |      5,404 |      5,404 |
    add     $i30, 1, $i30               # |      5,404 |      5,404 |
    b       try_exploit_neighbors.2967  # |      5,404 |      5,404 |
bge_else.32907:
    jr      $ra7                        # |     13,955 |     13,955 |
ble_else.32906:
    jr      $ra7
.end try_exploit_neighbors

######################################################################
# pretrace_diffuse_rays($i25, $i26)
# $ra = $ra6
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
    bg      $i26, 4, ble_else.32917     # |     16,395 |     16,395 |
ble_then.32917:
    load    [$i25 + 2], $i27            # |     16,395 |     16,395 |
    load    [$i27 + $i26], $i1          # |     16,395 |     16,395 |
    bl      $i1, 0, bge_else.32918      # |     16,395 |     16,395 |
bge_then.32918:
    load    [$i25 + 3], $i28            # |      2,101 |      2,101 |
    load    [$i28 + $i26], $i1          # |      2,101 |      2,101 |
    bne     $i1, 0, be_else.32919       # |      2,101 |      2,101 |
be_then.32919:
    add     $i26, 1, $i26               # |         67 |         67 |
    bg      $i26, 4, ble_else.32920     # |         67 |         67 |
ble_then.32920:
    load    [$i27 + $i26], $i1          # |         67 |         67 |
    bl      $i1, 0, bge_else.32921      # |         67 |         67 |
bge_then.32921:
    load    [$i28 + $i26], $i1          # |         11 |         11 |
    bne     $i1, 0, be_else.32922       # |         11 |         11 |
be_then.32922:
    add     $i26, 1, $i26               # |          2 |          2 |
    b       pretrace_diffuse_rays.2980  # |          2 |          2 |
be_else.32922:
    mov     $f0, $fg1                   # |          9 |          9 |
    mov     $f0, $fg2                   # |          9 |          9 |
    mov     $f0, $fg3                   # |          9 |          9 |
    load    [$i25 + 6], $i10            # |          9 |          9 |
    load    [$i25 + 7], $i11            # |          9 |          9 |
    load    [$i25 + 1], $i1             # |          9 |          9 |
    load    [$i1 + $i26], $i2           # |          9 |          9 |
    load    [$i2 + 0], $fg8             # |          9 |          9 |
    load    [$i2 + 1], $fg9             # |          9 |          9 |
    load    [$i2 + 2], $fg10            # |          9 |          9 |
    sub     $ig0, 1, $i1                # |          9 |          9 |
    call    setup_startp_constants.2831 # |          9 |          9 |
    load    [$i10 + 0], $i1             # |          9 |          9 |
    load    [ext_dirvecs + $i1], $i22   # |          9 |          9 |
    load    [$i22 + 118], $i1           # |          9 |          9 |
    load    [$i1 + 0], $i1              # |          9 |          9 |
    load    [$i11 + $i26], $i23         # |          9 |          9 |
    load    [$i1 + 0], $f1              # |          9 |          9 |
    load    [$i23 + 0], $f2             # |          9 |          9 |
    fmul    $f1, $f2, $f1               # |          9 |          9 |
    load    [$i1 + 1], $f2              # |          9 |          9 |
    load    [$i23 + 1], $f3             # |          9 |          9 |
    fmul    $f2, $f3, $f2               # |          9 |          9 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |
    load    [$i1 + 2], $f2              # |          9 |          9 |
    load    [$i23 + 2], $f3             # |          9 |          9 |
    fmul    $f2, $f3, $f2               # |          9 |          9 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |
    bg      $f0, $f1, ble_else.32923    # |          9 |          9 |
ble_then.32923:
    fmul    $f1, $fc1, $f14
    load    [$i22 + 118], $i21
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i24
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.32923
ble_else.32923:
    fmul    $f1, $fc2, $f14             # |          9 |          9 |
    load    [$i22 + 119], $i21          # |          9 |          9 |
    jal     trace_diffuse_ray.2926, $ra4# |          9 |          9 |
    li      116, $i24                   # |          9 |          9 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |          9 |          9 |
ble_cont.32923:
    load    [$i25 + 5], $i1             # |          9 |          9 |
    load    [$i1 + $i26], $i1           # |          9 |          9 |
    store   $fg1, [$i1 + 0]             # |          9 |          9 |
    store   $fg2, [$i1 + 1]             # |          9 |          9 |
    store   $fg3, [$i1 + 2]             # |          9 |          9 |
    add     $i26, 1, $i26               # |          9 |          9 |
    b       pretrace_diffuse_rays.2980  # |          9 |          9 |
bge_else.32921:
    jr      $ra6                        # |         56 |         56 |
ble_else.32920:
    jr      $ra6
be_else.32919:
    mov     $f0, $fg1                   # |      2,034 |      2,034 |
    mov     $f0, $fg2                   # |      2,034 |      2,034 |
    mov     $f0, $fg3                   # |      2,034 |      2,034 |
    load    [$i25 + 6], $i10            # |      2,034 |      2,034 |
    load    [$i25 + 7], $i29            # |      2,034 |      2,034 |
    load    [$i25 + 1], $i30            # |      2,034 |      2,034 |
    load    [$i30 + $i26], $i2          # |      2,034 |      2,034 |
    load    [$i2 + 0], $fg8             # |      2,034 |      2,034 |
    load    [$i2 + 1], $fg9             # |      2,034 |      2,034 |
    load    [$i2 + 2], $fg10            # |      2,034 |      2,034 |
    sub     $ig0, 1, $i1                # |      2,034 |      2,034 |
    call    setup_startp_constants.2831 # |      2,034 |      2,034 |
    load    [$i10 + 0], $i1             # |      2,034 |      2,034 |
    load    [ext_dirvecs + $i1], $i22   # |      2,034 |      2,034 |
    load    [$i22 + 118], $i1           # |      2,034 |      2,034 |
    load    [$i1 + 0], $i1              # |      2,034 |      2,034 |
    load    [$i1 + 0], $f1              # |      2,034 |      2,034 |
    load    [$i29 + $i26], $i23         # |      2,034 |      2,034 |
    load    [$i23 + 0], $f2             # |      2,034 |      2,034 |
    fmul    $f1, $f2, $f1               # |      2,034 |      2,034 |
    load    [$i1 + 1], $f2              # |      2,034 |      2,034 |
    load    [$i23 + 1], $f3             # |      2,034 |      2,034 |
    fmul    $f2, $f3, $f2               # |      2,034 |      2,034 |
    fadd    $f1, $f2, $f1               # |      2,034 |      2,034 |
    load    [$i1 + 2], $f2              # |      2,034 |      2,034 |
    load    [$i23 + 2], $f3             # |      2,034 |      2,034 |
    fmul    $f2, $f3, $f2               # |      2,034 |      2,034 |
    fadd    $f1, $f2, $f1               # |      2,034 |      2,034 |
    bg      $f0, $f1, ble_else.32924    # |      2,034 |      2,034 |
ble_then.32924:
    load    [$i22 + 118], $i21          # |        292 |        292 |
    fmul    $f1, $fc1, $f14             # |        292 |        292 |
    jal     trace_diffuse_ray.2926, $ra4# |        292 |        292 |
.count b_cont
    b       ble_cont.32924              # |        292 |        292 |
ble_else.32924:
    load    [$i22 + 119], $i21          # |      1,742 |      1,742 |
    fmul    $f1, $fc2, $f14             # |      1,742 |      1,742 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,742 |      1,742 |
ble_cont.32924:
    li      116, $i24                   # |      2,034 |      2,034 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      2,034 |      2,034 |
    load    [$i25 + 5], $i31            # |      2,034 |      2,034 |
    load    [$i31 + $i26], $i1          # |      2,034 |      2,034 |
    store   $fg1, [$i1 + 0]             # |      2,034 |      2,034 |
    store   $fg2, [$i1 + 1]             # |      2,034 |      2,034 |
    store   $fg3, [$i1 + 2]             # |      2,034 |      2,034 |
    add     $i26, 1, $i26               # |      2,034 |      2,034 |
    bg      $i26, 4, ble_else.32925     # |      2,034 |      2,034 |
ble_then.32925:
    load    [$i27 + $i26], $i1          # |      2,034 |      2,034 |
    bl      $i1, 0, bge_else.32926      # |      2,034 |      2,034 |
bge_then.32926:
    load    [$i28 + $i26], $i1
    bne     $i1, 0, be_else.32927
be_then.32927:
    add     $i26, 1, $i26
    b       pretrace_diffuse_rays.2980
be_else.32927:
    mov     $f0, $fg1
    mov     $f0, $fg2
    mov     $f0, $fg3
    load    [$i25 + 6], $i10
    load    [$i30 + $i26], $i2
    load    [$i2 + 0], $fg8
    load    [$i2 + 1], $fg9
    load    [$i2 + 2], $fg10
    sub     $ig0, 1, $i1
    call    setup_startp_constants.2831
    load    [$i10 + 0], $i1
    load    [ext_dirvecs + $i1], $i22
    load    [$i22 + 118], $i1
    load    [$i1 + 0], $i1
    load    [$i29 + $i26], $i23
    load    [$i1 + 0], $f1
    load    [$i23 + 0], $f2
    fmul    $f1, $f2, $f1
    load    [$i1 + 1], $f2
    load    [$i23 + 1], $f3
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 2], $f2
    load    [$i23 + 2], $f3
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    bg      $f0, $f1, ble_else.32928
ble_then.32928:
    fmul    $f1, $fc1, $f14
    load    [$i22 + 118], $i21
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i24
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.32928
ble_else.32928:
    fmul    $f1, $fc2, $f14
    load    [$i22 + 119], $i21
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i24
    jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.32928:
    load    [$i31 + $i26], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    add     $i26, 1, $i26
    b       pretrace_diffuse_rays.2980
bge_else.32926:
    jr      $ra6                        # |      2,034 |      2,034 |
ble_else.32925:
    jr      $ra6
bge_else.32918:
    jr      $ra6                        # |     14,294 |     14,294 |
ble_else.32917:
    jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i32, $i33, $i34, $f18, $f1, $f2)
# $ra = $ra7
# [$i1 - $i35]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
    bl      $i33, 0, bge_else.32929     # |     16,512 |     16,512 |
bge_then.32929:
.count stack_move
    sub     $sp, 2, $sp                 # |     16,384 |     16,384 |
.count stack_store
    store   $f2, [$sp + 0]              # |     16,384 |     16,384 |
.count stack_store
    store   $f1, [$sp + 1]              # |     16,384 |     16,384 |
    load    [ext_screenx_dir + 0], $f4  # |     16,384 |     16,384 |
    sub     $i33, 64, $i2               # |     16,384 |     16,384 |
    call    ext_float_of_int            # |     16,384 |     16,384 |
    fmul    $fg17, $f1, $f1             # |     16,384 |     16,384 |
    fmul    $f1, $f4, $f2               # |     16,384 |     16,384 |
    fadd    $f2, $f18, $f2              # |     16,384 |     16,384 |
    store   $f2, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |
.count stack_load
    load    [$sp + 1], $i35             # |     16,384 |     16,384 |
    store   $i35, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |
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
    bne     $f2, $f0, be_else.32930     # |     16,384 |     16,384 |
be_then.32930:
    mov     $fc0, $f2
.count b_cont
    b       be_cont.32930
be_else.32930:
    finv    $f2, $f2                    # |     16,384 |     16,384 |
be_cont.32930:
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
    load    [ext_viewpoint + 0], $fg21  # |     16,384 |     16,384 |
    load    [ext_viewpoint + 1], $fg22  # |     16,384 |     16,384 |
    load    [ext_viewpoint + 2], $fg23  # |     16,384 |     16,384 |
    li      ext_ptrace_dirvec, $i26     # |     16,384 |     16,384 |
    li      0, $i25                     # |     16,384 |     16,384 |
    load    [$i32 + $i33], $i27         # |     16,384 |     16,384 |
.count move_args
    mov     $fc0, $f16                  # |     16,384 |     16,384 |
.count move_args
    mov     $f0, $f17                   # |     16,384 |     16,384 |
    jal     trace_ray.2920, $ra5        # |     16,384 |     16,384 |
    load    [$i32 + $i33], $i1          # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    store   $fg4, [$i1 + 0]             # |     16,384 |     16,384 |
    store   $fg5, [$i1 + 1]             # |     16,384 |     16,384 |
    store   $fg6, [$i1 + 2]             # |     16,384 |     16,384 |
    load    [$i32 + $i33], $i1          # |     16,384 |     16,384 |
    load    [$i1 + 6], $i1              # |     16,384 |     16,384 |
    store   $i34, [$i1 + 0]             # |     16,384 |     16,384 |
    load    [$i32 + $i33], $i25         # |     16,384 |     16,384 |
    load    [$i25 + 2], $i1             # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    bl      $i1, 0, bge_cont.32931      # |     16,384 |     16,384 |
bge_then.32931:
    load    [$i25 + 3], $i1             # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    bne     $i1, 0, be_else.32932       # |     16,384 |     16,384 |
be_then.32932:
    li      1, $i26                     # |      7,301 |      7,301 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      7,301 |      7,301 |
.count b_cont
    b       be_cont.32932               # |      7,301 |      7,301 |
be_else.32932:
    load    [$i25 + 6], $i1             # |      9,083 |      9,083 |
    load    [$i1 + 0], $i1              # |      9,083 |      9,083 |
    mov     $f0, $fg1                   # |      9,083 |      9,083 |
    mov     $f0, $fg2                   # |      9,083 |      9,083 |
    mov     $f0, $fg3                   # |      9,083 |      9,083 |
    load    [$i25 + 7], $i2             # |      9,083 |      9,083 |
    load    [$i25 + 1], $i3             # |      9,083 |      9,083 |
    load    [ext_dirvecs + $i1], $i22   # |      9,083 |      9,083 |
    load    [$i2 + 0], $i23             # |      9,083 |      9,083 |
    load    [$i3 + 0], $i2              # |      9,083 |      9,083 |
    load    [$i2 + 0], $fg8             # |      9,083 |      9,083 |
    load    [$i2 + 1], $fg9             # |      9,083 |      9,083 |
    load    [$i2 + 2], $fg10            # |      9,083 |      9,083 |
    sub     $ig0, 1, $i1                # |      9,083 |      9,083 |
    call    setup_startp_constants.2831 # |      9,083 |      9,083 |
    load    [$i22 + 118], $i1           # |      9,083 |      9,083 |
    load    [$i1 + 0], $i1              # |      9,083 |      9,083 |
    load    [$i1 + 0], $f1              # |      9,083 |      9,083 |
    load    [$i23 + 0], $f2             # |      9,083 |      9,083 |
    fmul    $f1, $f2, $f1               # |      9,083 |      9,083 |
    load    [$i1 + 1], $f2              # |      9,083 |      9,083 |
    load    [$i23 + 1], $f3             # |      9,083 |      9,083 |
    fmul    $f2, $f3, $f2               # |      9,083 |      9,083 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |
    load    [$i1 + 2], $f2              # |      9,083 |      9,083 |
    load    [$i23 + 2], $f3             # |      9,083 |      9,083 |
    fmul    $f2, $f3, $f2               # |      9,083 |      9,083 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |
    bg      $f0, $f1, ble_else.32933    # |      9,083 |      9,083 |
ble_then.32933:
    fmul    $f1, $fc1, $f14             # |         14 |         14 |
    load    [$i22 + 118], $i21          # |         14 |         14 |
    jal     trace_diffuse_ray.2926, $ra4# |         14 |         14 |
    li      116, $i24                   # |         14 |         14 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         14 |         14 |
.count b_cont
    b       ble_cont.32933              # |         14 |         14 |
ble_else.32933:
    fmul    $f1, $fc2, $f14             # |      9,069 |      9,069 |
    load    [$i22 + 119], $i21          # |      9,069 |      9,069 |
    jal     trace_diffuse_ray.2926, $ra4# |      9,069 |      9,069 |
    li      116, $i24                   # |      9,069 |      9,069 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      9,069 |      9,069 |
ble_cont.32933:
    load    [$i25 + 5], $i1             # |      9,083 |      9,083 |
    load    [$i1 + 0], $i1              # |      9,083 |      9,083 |
    store   $fg1, [$i1 + 0]             # |      9,083 |      9,083 |
    store   $fg2, [$i1 + 1]             # |      9,083 |      9,083 |
    store   $fg3, [$i1 + 2]             # |      9,083 |      9,083 |
    li      1, $i26                     # |      9,083 |      9,083 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      9,083 |      9,083 |
be_cont.32932:
bge_cont.32931:
.count stack_move
    add     $sp, 2, $sp                 # |     16,384 |     16,384 |
    sub     $i33, 1, $i33               # |     16,384 |     16,384 |
    add     $i34, 1, $i34               # |     16,384 |     16,384 |
.count move_args
    mov     $i35, $f1                   # |     16,384 |     16,384 |
.count stack_load
    load    [$sp - 2], $f2              # |     16,384 |     16,384 |
    bl      $i34, 5, pretrace_pixels.2983# |     16,384 |     16,384 |
    sub     $i34, 5, $i34               # |      3,277 |      3,277 |
    b       pretrace_pixels.2983        # |      3,277 |      3,277 |
bge_else.32929:
    jr      $ra7                        # |        128 |        128 |
.end pretrace_pixels

######################################################################
# scan_pixel($i32, $i33, $i34, $i35, $i36)
# $ra = $ra8
# [$i1 - $i37]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin scan_pixel
scan_pixel.2994:
    li      128, $i1                    # |      8,256 |      8,256 |
    bg      $i1, $i32, ble_else.32935   # |      8,256 |      8,256 |
ble_then.32935:
    jr      $ra8                        # |         64 |         64 |
ble_else.32935:
    load    [$i35 + $i32], $i1          # |      8,192 |      8,192 |
    load    [$i1 + 0], $i1              # |      8,192 |      8,192 |
    load    [$i1 + 0], $fg4             # |      8,192 |      8,192 |
    load    [$i1 + 1], $fg5             # |      8,192 |      8,192 |
    load    [$i1 + 2], $fg6             # |      8,192 |      8,192 |
    li      128, $i1                    # |      8,192 |      8,192 |
    add     $i33, 1, $i37               # |      8,192 |      8,192 |
    bg      $i1, $i37, ble_else.32936   # |      8,192 |      8,192 |
ble_then.32936:
    li      0, $i1                      # |         64 |         64 |
.count b_cont
    b       ble_cont.32936              # |         64 |         64 |
ble_else.32936:
    bg      $i33, 0, ble_else.32937     # |      8,128 |      8,128 |
ble_then.32937:
    li      0, $i1                      # |         64 |         64 |
.count b_cont
    b       ble_cont.32937              # |         64 |         64 |
ble_else.32937:
    li      128, $i1                    # |      8,064 |      8,064 |
    add     $i32, 1, $i2                # |      8,064 |      8,064 |
    bg      $i1, $i2, ble_else.32938    # |      8,064 |      8,064 |
ble_then.32938:
    li      0, $i1                      # |         63 |         63 |
.count b_cont
    b       ble_cont.32938              # |         63 |         63 |
ble_else.32938:
    bg      $i32, 0, ble_else.32939     # |      8,001 |      8,001 |
ble_then.32939:
    li      0, $i1                      # |         63 |         63 |
.count b_cont
    b       ble_cont.32939              # |         63 |         63 |
ble_else.32939:
    li      1, $i1                      # |      7,938 |      7,938 |
ble_cont.32939:
ble_cont.32938:
ble_cont.32937:
ble_cont.32936:
    li      0, $i26                     # |      8,192 |      8,192 |
    bne     $i1, 0, be_else.32940       # |      8,192 |      8,192 |
be_then.32940:
    load    [$i35 + $i32], $i30         # |        254 |        254 |
    load    [$i30 + 2], $i1             # |        254 |        254 |
    load    [$i1 + 0], $i1              # |        254 |        254 |
    bl      $i1, 0, be_cont.32940       # |        254 |        254 |
bge_then.32941:
    load    [$i30 + 3], $i1             # |        254 |        254 |
    load    [$i1 + 0], $i1              # |        254 |        254 |
    bne     $i1, 0, be_else.32942       # |        254 |        254 |
be_then.32942:
    li      1, $i25                     # |        180 |        180 |
    jal     do_without_neighbors.2951, $ra7# |        180 |        180 |
.count b_cont
    b       be_cont.32940               # |        180 |        180 |
be_else.32942:
.count move_args
    mov     $i30, $i25                  # |         74 |         74 |
    jal     calc_diffuse_using_1point.2942, $ra6# |         74 |         74 |
    li      1, $i25                     # |         74 |         74 |
    jal     do_without_neighbors.2951, $ra7# |         74 |         74 |
.count b_cont
    b       be_cont.32940               # |         74 |         74 |
be_else.32940:
    load    [$i35 + $i32], $i1          # |      7,938 |      7,938 |
    load    [$i1 + 2], $i2              # |      7,938 |      7,938 |
    load    [$i2 + 0], $i2              # |      7,938 |      7,938 |
    bl      $i2, 0, bge_cont.32943      # |      7,938 |      7,938 |
bge_then.32943:
    load    [$i34 + $i32], $i3          # |      7,938 |      7,938 |
    load    [$i3 + 2], $i4              # |      7,938 |      7,938 |
    load    [$i4 + 0], $i4              # |      7,938 |      7,938 |
    bne     $i4, $i2, be_else.32944     # |      7,938 |      7,938 |
be_then.32944:
    load    [$i36 + $i32], $i4          # |      7,620 |      7,620 |
    load    [$i4 + 2], $i4              # |      7,620 |      7,620 |
    load    [$i4 + 0], $i4              # |      7,620 |      7,620 |
    bne     $i4, $i2, be_else.32945     # |      7,620 |      7,620 |
be_then.32945:
    sub     $i32, 1, $i4                # |      7,330 |      7,330 |
    load    [$i35 + $i4], $i4           # |      7,330 |      7,330 |
    load    [$i4 + 2], $i4              # |      7,330 |      7,330 |
    load    [$i4 + 0], $i4              # |      7,330 |      7,330 |
    bne     $i4, $i2, be_else.32946     # |      7,330 |      7,330 |
be_then.32946:
    add     $i32, 1, $i4                # |      7,251 |      7,251 |
    load    [$i35 + $i4], $i4           # |      7,251 |      7,251 |
    load    [$i4 + 2], $i4              # |      7,251 |      7,251 |
    load    [$i4 + 0], $i4              # |      7,251 |      7,251 |
    bne     $i4, $i2, be_else.32947     # |      7,251 |      7,251 |
be_then.32947:
    li      1, $i2                      # |      7,171 |      7,171 |
.count b_cont
    b       be_cont.32944               # |      7,171 |      7,171 |
be_else.32947:
    li      0, $i2                      # |         80 |         80 |
.count b_cont
    b       be_cont.32944               # |         80 |         80 |
be_else.32946:
    li      0, $i2                      # |         79 |         79 |
.count b_cont
    b       be_cont.32944               # |         79 |         79 |
be_else.32945:
    li      0, $i2                      # |        290 |        290 |
.count b_cont
    b       be_cont.32944               # |        290 |        290 |
be_else.32944:
    li      0, $i2                      # |        318 |        318 |
be_cont.32944:
    bne     $i2, 0, be_else.32948       # |      7,938 |      7,938 |
be_then.32948:
    load    [$i35 + $i32], $i30         # |        767 |        767 |
    load    [$i30 + 2], $i1             # |        767 |        767 |
    load    [$i1 + 0], $i1              # |        767 |        767 |
    bl      $i1, 0, be_cont.32948       # |        767 |        767 |
bge_then.32949:
    load    [$i30 + 3], $i1             # |        767 |        767 |
    load    [$i1 + 0], $i1              # |        767 |        767 |
    bne     $i1, 0, be_else.32950       # |        767 |        767 |
be_then.32950:
    li      1, $i25                     # |        155 |        155 |
    jal     do_without_neighbors.2951, $ra7# |        155 |        155 |
.count b_cont
    b       be_cont.32948               # |        155 |        155 |
be_else.32950:
.count move_args
    mov     $i30, $i25                  # |        612 |        612 |
    jal     calc_diffuse_using_1point.2942, $ra6# |        612 |        612 |
    li      1, $i25                     # |        612 |        612 |
    jal     do_without_neighbors.2951, $ra7# |        612 |        612 |
.count b_cont
    b       be_cont.32948               # |        612 |        612 |
be_else.32948:
    load    [$i1 + 3], $i1              # |      7,171 |      7,171 |
    load    [$i1 + 0], $i1              # |      7,171 |      7,171 |
.count move_args
    mov     $i36, $i5                   # |      7,171 |      7,171 |
.count move_args
    mov     $i35, $i4                   # |      7,171 |      7,171 |
.count move_args
    mov     $i32, $i2                   # |      7,171 |      7,171 |
    li      1, $i30                     # |      7,171 |      7,171 |
    bne     $i1, 0, be_else.32951       # |      7,171 |      7,171 |
be_then.32951:
.count move_args
    mov     $i34, $i3                   # |      3,318 |      3,318 |
    jal     try_exploit_neighbors.2967, $ra7# |      3,318 |      3,318 |
.count b_cont
    b       be_cont.32951               # |      3,318 |      3,318 |
be_else.32951:
    load    [$i3 + 5], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $fg1             # |      3,853 |      3,853 |
    load    [$i1 + 1], $fg2             # |      3,853 |      3,853 |
    load    [$i1 + 2], $fg3             # |      3,853 |      3,853 |
    sub     $i32, 1, $i1                # |      3,853 |      3,853 |
    load    [$i35 + $i1], $i1           # |      3,853 |      3,853 |
    load    [$i1 + 5], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $f1              # |      3,853 |      3,853 |
    fadd    $fg1, $f1, $fg1             # |      3,853 |      3,853 |
    load    [$i1 + 1], $f1              # |      3,853 |      3,853 |
    fadd    $fg2, $f1, $fg2             # |      3,853 |      3,853 |
    load    [$i1 + 2], $f1              # |      3,853 |      3,853 |
    fadd    $fg3, $f1, $fg3             # |      3,853 |      3,853 |
    load    [$i35 + $i32], $i1          # |      3,853 |      3,853 |
    load    [$i1 + 5], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $f1              # |      3,853 |      3,853 |
    fadd    $fg1, $f1, $fg1             # |      3,853 |      3,853 |
    load    [$i1 + 1], $f1              # |      3,853 |      3,853 |
    fadd    $fg2, $f1, $fg2             # |      3,853 |      3,853 |
    load    [$i1 + 2], $f1              # |      3,853 |      3,853 |
    fadd    $fg3, $f1, $fg3             # |      3,853 |      3,853 |
    add     $i32, 1, $i1                # |      3,853 |      3,853 |
    load    [$i35 + $i1], $i1           # |      3,853 |      3,853 |
    load    [$i1 + 5], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $f1              # |      3,853 |      3,853 |
    fadd    $fg1, $f1, $fg1             # |      3,853 |      3,853 |
    load    [$i1 + 1], $f1              # |      3,853 |      3,853 |
    fadd    $fg2, $f1, $fg2             # |      3,853 |      3,853 |
    load    [$i1 + 2], $f1              # |      3,853 |      3,853 |
    fadd    $fg3, $f1, $fg3             # |      3,853 |      3,853 |
    load    [$i36 + $i32], $i1          # |      3,853 |      3,853 |
    load    [$i1 + 5], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $f1              # |      3,853 |      3,853 |
    fadd    $fg1, $f1, $fg1             # |      3,853 |      3,853 |
    load    [$i1 + 1], $f1              # |      3,853 |      3,853 |
    fadd    $fg2, $f1, $fg2             # |      3,853 |      3,853 |
    load    [$i1 + 2], $f1              # |      3,853 |      3,853 |
    fadd    $fg3, $f1, $fg3             # |      3,853 |      3,853 |
    load    [$i35 + $i32], $i1          # |      3,853 |      3,853 |
    load    [$i1 + 4], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $i1              # |      3,853 |      3,853 |
    load    [$i1 + 0], $f1              # |      3,853 |      3,853 |
    fmul    $f1, $fg1, $f1              # |      3,853 |      3,853 |
    fadd    $fg4, $f1, $fg4             # |      3,853 |      3,853 |
    load    [$i1 + 1], $f1              # |      3,853 |      3,853 |
    fmul    $f1, $fg2, $f1              # |      3,853 |      3,853 |
    fadd    $fg5, $f1, $fg5             # |      3,853 |      3,853 |
    load    [$i1 + 2], $f1              # |      3,853 |      3,853 |
    fmul    $f1, $fg3, $f1              # |      3,853 |      3,853 |
    fadd    $fg6, $f1, $fg6             # |      3,853 |      3,853 |
.count move_args
    mov     $i34, $i3                   # |      3,853 |      3,853 |
    jal     try_exploit_neighbors.2967, $ra7# |      3,853 |      3,853 |
be_cont.32951:
be_cont.32948:
bge_cont.32943:
be_cont.32940:
    li      255, $i4                    # |      8,192 |      8,192 |
.count move_args
    mov     $fg4, $f2                   # |      8,192 |      8,192 |
    call    ext_int_of_float            # |      8,192 |      8,192 |
    bg      $i1, $i4, ble_else.32952    # |      8,192 |      8,192 |
ble_then.32952:
    bl      $i1, 0, bge_else.32953      # |      5,132 |      5,132 |
bge_then.32953:
.count move_args
    mov     $i1, $i2                    # |      5,132 |      5,132 |
    call    ext_write                   # |      5,132 |      5,132 |
.count b_cont
    b       ble_cont.32952              # |      5,132 |      5,132 |
bge_else.32953:
    li      0, $i2
    call    ext_write
.count b_cont
    b       ble_cont.32952
ble_else.32952:
    li      255, $i2                    # |      3,060 |      3,060 |
    call    ext_write                   # |      3,060 |      3,060 |
ble_cont.32952:
    li      255, $i4                    # |      8,192 |      8,192 |
.count move_args
    mov     $fg5, $f2                   # |      8,192 |      8,192 |
    call    ext_int_of_float            # |      8,192 |      8,192 |
    bg      $i1, $i4, ble_else.32954    # |      8,192 |      8,192 |
ble_then.32954:
    bl      $i1, 0, bge_else.32955      # |      6,128 |      6,128 |
bge_then.32955:
.count move_args
    mov     $i1, $i2                    # |      6,128 |      6,128 |
    call    ext_write                   # |      6,128 |      6,128 |
.count b_cont
    b       ble_cont.32954              # |      6,128 |      6,128 |
bge_else.32955:
    li      0, $i2
    call    ext_write
.count b_cont
    b       ble_cont.32954
ble_else.32954:
    li      255, $i2                    # |      2,064 |      2,064 |
    call    ext_write                   # |      2,064 |      2,064 |
ble_cont.32954:
    li      255, $i4                    # |      8,192 |      8,192 |
.count move_args
    mov     $fg6, $f2                   # |      8,192 |      8,192 |
    call    ext_int_of_float            # |      8,192 |      8,192 |
    bg      $i1, $i4, ble_else.32956    # |      8,192 |      8,192 |
ble_then.32956:
    bl      $i1, 0, bge_else.32957      # |      5,450 |      5,450 |
bge_then.32957:
.count move_args
    mov     $i1, $i2                    # |      5,450 |      5,450 |
    call    ext_write                   # |      5,450 |      5,450 |
.count b_cont
    b       ble_cont.32956              # |      5,450 |      5,450 |
bge_else.32957:
    li      0, $i2
    call    ext_write
.count b_cont
    b       ble_cont.32956
ble_else.32956:
    li      255, $i2                    # |      2,742 |      2,742 |
    call    ext_write                   # |      2,742 |      2,742 |
ble_cont.32956:
    li      128, $i1                    # |      8,192 |      8,192 |
    add     $i32, 1, $i32               # |      8,192 |      8,192 |
    bg      $i1, $i32, ble_else.32958   # |      8,192 |      8,192 |
ble_then.32958:
    jr      $ra8                        # |         64 |         64 |
ble_else.32958:
    load    [$i35 + $i32], $i1          # |      8,128 |      8,128 |
    load    [$i1 + 0], $i1              # |      8,128 |      8,128 |
    load    [$i1 + 0], $fg4             # |      8,128 |      8,128 |
    load    [$i1 + 1], $fg5             # |      8,128 |      8,128 |
    load    [$i1 + 2], $fg6             # |      8,128 |      8,128 |
    li      128, $i1                    # |      8,128 |      8,128 |
    bg      $i1, $i37, ble_else.32959   # |      8,128 |      8,128 |
ble_then.32959:
    li      0, $i1                      # |         64 |         64 |
.count b_cont
    b       ble_cont.32959              # |         64 |         64 |
ble_else.32959:
    bg      $i33, 0, ble_else.32960     # |      8,064 |      8,064 |
ble_then.32960:
    li      0, $i1                      # |         63 |         63 |
.count b_cont
    b       ble_cont.32960              # |         63 |         63 |
ble_else.32960:
    li      128, $i1                    # |      8,001 |      8,001 |
    add     $i32, 1, $i2                # |      8,001 |      8,001 |
    bg      $i1, $i2, ble_else.32961    # |      8,001 |      8,001 |
ble_then.32961:
    li      0, $i1                      # |         63 |         63 |
.count b_cont
    b       ble_cont.32961              # |         63 |         63 |
ble_else.32961:
    bg      $i32, 0, ble_else.32962     # |      7,938 |      7,938 |
ble_then.32962:
    li      0, $i1
.count b_cont
    b       ble_cont.32962
ble_else.32962:
    li      1, $i1                      # |      7,938 |      7,938 |
ble_cont.32962:
ble_cont.32961:
ble_cont.32960:
ble_cont.32959:
    bne     $i1, 0, be_else.32963       # |      8,128 |      8,128 |
be_then.32963:
    load    [$i35 + $i32], $i30         # |        190 |        190 |
    li      0, $i26                     # |        190 |        190 |
    load    [$i30 + 2], $i1             # |        190 |        190 |
    load    [$i1 + 0], $i1              # |        190 |        190 |
    bl      $i1, 0, be_cont.32963       # |        190 |        190 |
bge_then.32964:
    load    [$i30 + 3], $i1             # |        190 |        190 |
    load    [$i1 + 0], $i1              # |        190 |        190 |
    bne     $i1, 0, be_else.32965       # |        190 |        190 |
be_then.32965:
    li      1, $i25                     # |        123 |        123 |
    jal     do_without_neighbors.2951, $ra7# |        123 |        123 |
.count b_cont
    b       be_cont.32963               # |        123 |        123 |
be_else.32965:
.count move_args
    mov     $i30, $i25                  # |         67 |         67 |
    jal     calc_diffuse_using_1point.2942, $ra6# |         67 |         67 |
    li      1, $i25                     # |         67 |         67 |
    jal     do_without_neighbors.2951, $ra7# |         67 |         67 |
.count b_cont
    b       be_cont.32963               # |         67 |         67 |
be_else.32963:
    li      0, $i30                     # |      7,938 |      7,938 |
.count move_args
    mov     $i32, $i2                   # |      7,938 |      7,938 |
.count move_args
    mov     $i34, $i3                   # |      7,938 |      7,938 |
.count move_args
    mov     $i35, $i4                   # |      7,938 |      7,938 |
.count move_args
    mov     $i36, $i5                   # |      7,938 |      7,938 |
    jal     try_exploit_neighbors.2967, $ra7# |      7,938 |      7,938 |
be_cont.32963:
    li      255, $i4                    # |      8,128 |      8,128 |
.count move_args
    mov     $fg4, $f2                   # |      8,128 |      8,128 |
    call    ext_int_of_float            # |      8,128 |      8,128 |
    bg      $i1, $i4, ble_else.32966    # |      8,128 |      8,128 |
ble_then.32966:
    bl      $i1, 0, bge_else.32967      # |      5,076 |      5,076 |
bge_then.32967:
    mov     $i1, $i2                    # |      5,076 |      5,076 |
.count b_cont
    b       ble_cont.32966              # |      5,076 |      5,076 |
bge_else.32967:
    li      0, $i2
.count b_cont
    b       ble_cont.32966
ble_else.32966:
    li      255, $i2                    # |      3,052 |      3,052 |
ble_cont.32966:
    call    ext_write                   # |      8,128 |      8,128 |
    li      255, $i4                    # |      8,128 |      8,128 |
.count move_args
    mov     $fg5, $f2                   # |      8,128 |      8,128 |
    call    ext_int_of_float            # |      8,128 |      8,128 |
    bg      $i1, $i4, ble_else.32968    # |      8,128 |      8,128 |
ble_then.32968:
    bl      $i1, 0, bge_else.32969      # |      6,031 |      6,031 |
bge_then.32969:
    mov     $i1, $i2                    # |      6,031 |      6,031 |
.count b_cont
    b       ble_cont.32968              # |      6,031 |      6,031 |
bge_else.32969:
    li      0, $i2
.count b_cont
    b       ble_cont.32968
ble_else.32968:
    li      255, $i2                    # |      2,097 |      2,097 |
ble_cont.32968:
    call    ext_write                   # |      8,128 |      8,128 |
    li      255, $i4                    # |      8,128 |      8,128 |
.count move_args
    mov     $fg6, $f2                   # |      8,128 |      8,128 |
    call    ext_int_of_float            # |      8,128 |      8,128 |
    bg      $i1, $i4, ble_else.32970    # |      8,128 |      8,128 |
ble_then.32970:
    bl      $i1, 0, bge_else.32971      # |      5,384 |      5,384 |
bge_then.32971:
    mov     $i1, $i2                    # |      5,384 |      5,384 |
.count b_cont
    b       ble_cont.32970              # |      5,384 |      5,384 |
bge_else.32971:
    li      0, $i2
.count b_cont
    b       ble_cont.32970
ble_else.32970:
    li      255, $i2                    # |      2,744 |      2,744 |
ble_cont.32970:
    call    ext_write                   # |      8,128 |      8,128 |
    add     $i32, 1, $i32               # |      8,128 |      8,128 |
    b       scan_pixel.2994             # |      8,128 |      8,128 |
.end scan_pixel

######################################################################
# scan_line($i37, $i38, $i39, $i40, $i41)
# $ra = $ra9
# [$i1 - $i42]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin scan_line
scan_line.3000:
    li      128, $i1                    # |         65 |         65 |
    bg      $i1, $i37, ble_else.32972   # |         65 |         65 |
ble_then.32972:
    jr      $ra9                        # |          1 |          1 |
ble_else.32972:
    bge     $i37, 127, bl_cont.32973    # |         64 |         64 |
bl_then.32973:
    add     $i37, 1, $i1                # |         64 |         64 |
    sub     $i1, 64, $i2                # |         64 |         64 |
    call    ext_float_of_int            # |         64 |         64 |
    fmul    $fg17, $f1, $f1             # |         64 |         64 |
    fmul    $f1, $fg24, $f2             # |         64 |         64 |
    fadd    $f2, $fg18, $f18            # |         64 |         64 |
    load    [ext_screeny_dir + 1], $f2  # |         64 |         64 |
    fmul    $f1, $f2, $f2               # |         64 |         64 |
    fadd    $f2, $fg19, $f3             # |         64 |         64 |
    load    [ext_screeny_dir + 2], $f2  # |         64 |         64 |
    fmul    $f1, $f2, $f1               # |         64 |         64 |
    fadd    $f1, $fg20, $f2             # |         64 |         64 |
    li      127, $i33                   # |         64 |         64 |
.count move_args
    mov     $i40, $i32                  # |         64 |         64 |
.count move_args
    mov     $i41, $i34                  # |         64 |         64 |
.count move_args
    mov     $f3, $f1                    # |         64 |         64 |
    jal     pretrace_pixels.2983, $ra7  # |         64 |         64 |
bl_cont.32973:
    li      0, $i2                      # |         64 |         64 |
    load    [$i39 + 0], $i1             # |         64 |         64 |
    load    [$i1 + 0], $i1              # |         64 |         64 |
    load    [$i1 + 0], $fg4             # |         64 |         64 |
    load    [$i1 + 1], $fg5             # |         64 |         64 |
    load    [$i1 + 2], $fg6             # |         64 |         64 |
    li      128, $i1                    # |         64 |         64 |
    add     $i37, 1, $i42               # |         64 |         64 |
    bg      $i1, $i42, ble_else.32974   # |         64 |         64 |
ble_then.32974:
    li      0, $i1
.count b_cont
    b       ble_cont.32974
ble_else.32974:
    li      0, $i1                      # |         64 |         64 |
ble_cont.32974:
    bne     $i1, 0, be_else.32975       # |         64 |         64 |
be_then.32975:
    load    [$i39 + 0], $i30            # |         64 |         64 |
    li      0, $i26                     # |         64 |         64 |
    load    [$i30 + 2], $i1             # |         64 |         64 |
    load    [$i1 + 0], $i1              # |         64 |         64 |
    bl      $i1, 0, be_cont.32975       # |         64 |         64 |
bge_then.32976:
    load    [$i30 + 3], $i1             # |         64 |         64 |
    load    [$i1 + 0], $i1              # |         64 |         64 |
    bne     $i1, 0, be_else.32977       # |         64 |         64 |
be_then.32977:
    li      1, $i25                     # |         57 |         57 |
    jal     do_without_neighbors.2951, $ra7# |         57 |         57 |
.count b_cont
    b       be_cont.32975               # |         57 |         57 |
be_else.32977:
.count move_args
    mov     $i30, $i25                  # |          7 |          7 |
    jal     calc_diffuse_using_1point.2942, $ra6# |          7 |          7 |
    li      1, $i25                     # |          7 |          7 |
    jal     do_without_neighbors.2951, $ra7# |          7 |          7 |
.count b_cont
    b       be_cont.32975               # |          7 |          7 |
be_else.32975:
    li      0, $i30
.count move_args
    mov     $i38, $i3
.count move_args
    mov     $i39, $i4
.count move_args
    mov     $i40, $i5
    jal     try_exploit_neighbors.2967, $ra7
be_cont.32975:
    li      255, $i4                    # |         64 |         64 |
.count move_args
    mov     $fg4, $f2                   # |         64 |         64 |
    call    ext_int_of_float            # |         64 |         64 |
    bg      $i1, $i4, ble_else.32978    # |         64 |         64 |
ble_then.32978:
    bl      $i1, 0, bge_else.32979      # |         47 |         47 |
bge_then.32979:
    mov     $i1, $i2                    # |         47 |         47 |
.count b_cont
    b       ble_cont.32978              # |         47 |         47 |
bge_else.32979:
    li      0, $i2
.count b_cont
    b       ble_cont.32978
ble_else.32978:
    li      255, $i2                    # |         17 |         17 |
ble_cont.32978:
    call    ext_write                   # |         64 |         64 |
    li      255, $i4                    # |         64 |         64 |
.count move_args
    mov     $fg5, $f2                   # |         64 |         64 |
    call    ext_int_of_float            # |         64 |         64 |
    bg      $i1, $i4, ble_else.32980    # |         64 |         64 |
ble_then.32980:
    bl      $i1, 0, bge_else.32981      # |         56 |         56 |
bge_then.32981:
    mov     $i1, $i2                    # |         56 |         56 |
.count b_cont
    b       ble_cont.32980              # |         56 |         56 |
bge_else.32981:
    li      0, $i2
.count b_cont
    b       ble_cont.32980
ble_else.32980:
    li      255, $i2                    # |          8 |          8 |
ble_cont.32980:
    call    ext_write                   # |         64 |         64 |
    li      255, $i4                    # |         64 |         64 |
.count move_args
    mov     $fg6, $f2                   # |         64 |         64 |
    call    ext_int_of_float            # |         64 |         64 |
    bg      $i1, $i4, ble_else.32982    # |         64 |         64 |
ble_then.32982:
    bl      $i1, 0, bge_else.32983      # |         59 |         59 |
bge_then.32983:
    mov     $i1, $i2                    # |         59 |         59 |
.count b_cont
    b       ble_cont.32982              # |         59 |         59 |
bge_else.32983:
    li      0, $i2
.count b_cont
    b       ble_cont.32982
ble_else.32982:
    li      255, $i2                    # |          5 |          5 |
ble_cont.32982:
    call    ext_write                   # |         64 |         64 |
    li      1, $i32                     # |         64 |         64 |
.count move_args
    mov     $i37, $i33                  # |         64 |         64 |
.count move_args
    mov     $i38, $i34                  # |         64 |         64 |
.count move_args
    mov     $i39, $i35                  # |         64 |         64 |
.count move_args
    mov     $i40, $i36                  # |         64 |         64 |
    jal     scan_pixel.2994, $ra8       # |         64 |         64 |
    li      128, $i1                    # |         64 |         64 |
    bg      $i1, $i42, ble_else.32984   # |         64 |         64 |
ble_then.32984:
    jr      $ra9
ble_else.32984:
    add     $i41, 2, $i1                # |         64 |         64 |
    bl      $i1, 5, bge_else.32985      # |         64 |         64 |
bge_then.32985:
    sub     $i1, 5, $i41                # |         25 |         25 |
.count b_cont
    b       bge_cont.32985              # |         25 |         25 |
bge_else.32985:
    mov     $i1, $i41                   # |         39 |         39 |
bge_cont.32985:
    bge     $i42, 127, bl_cont.32986    # |         64 |         64 |
bl_then.32986:
    add     $i42, 1, $i1                # |         63 |         63 |
    li      127, $i33                   # |         63 |         63 |
    sub     $i1, 64, $i2                # |         63 |         63 |
    call    ext_float_of_int            # |         63 |         63 |
    fmul    $fg17, $f1, $f1             # |         63 |         63 |
    fmul    $f1, $fg24, $f2             # |         63 |         63 |
    fadd    $f2, $fg18, $f18            # |         63 |         63 |
    load    [ext_screeny_dir + 1], $f2  # |         63 |         63 |
    fmul    $f1, $f2, $f2               # |         63 |         63 |
    fadd    $f2, $fg19, $f3             # |         63 |         63 |
    load    [ext_screeny_dir + 2], $f2  # |         63 |         63 |
    fmul    $f1, $f2, $f1               # |         63 |         63 |
    fadd    $f1, $fg20, $f2             # |         63 |         63 |
.count move_args
    mov     $i38, $i32                  # |         63 |         63 |
.count move_args
    mov     $i41, $i34                  # |         63 |         63 |
.count move_args
    mov     $f3, $f1                    # |         63 |         63 |
    jal     pretrace_pixels.2983, $ra7  # |         63 |         63 |
bl_cont.32986:
    li      0, $i32                     # |         64 |         64 |
.count move_args
    mov     $i42, $i33                  # |         64 |         64 |
.count move_args
    mov     $i39, $i34                  # |         64 |         64 |
.count move_args
    mov     $i40, $i35                  # |         64 |         64 |
.count move_args
    mov     $i38, $i36                  # |         64 |         64 |
    jal     scan_pixel.2994, $ra8       # |         64 |         64 |
    add     $i42, 1, $i37               # |         64 |         64 |
    add     $i41, 2, $i41               # |         64 |         64 |
.count move_args
    mov     $i38, $tmp                  # |         64 |         64 |
.count move_args
    mov     $i40, $i38                  # |         64 |         64 |
.count move_args
    mov     $i39, $i40                  # |         64 |         64 |
.count move_args
    mov     $tmp, $i39                  # |         64 |         64 |
    bl      $i41, 5, scan_line.3000     # |         64 |         64 |
    sub     $i41, 5, $i41               # |         26 |         26 |
    b       scan_line.3000              # |         26 |         26 |
.end scan_line

######################################################################
# $i1 = create_pixel()
# $ra = $ra1
# [$i1 - $i11]
# [$f2]
# []
# []
######################################################################
.begin create_pixel
create_pixel.3008:
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
.count move_ret
    mov     $i1, $i4                    # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
.count move_args
    mov     $i1, $i3                    # |        192 |        192 |
    call    ext_create_array_int        # |        192 |        192 |
.count move_ret
    mov     $i1, $i5                    # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i5 + 1]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i5 + 2]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i5 + 3]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i5 + 4]              # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
    li      0, $i3                      # |        192 |        192 |
    call    ext_create_array_int        # |        192 |        192 |
.count move_ret
    mov     $i1, $i6                    # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
    li      0, $i3                      # |        192 |        192 |
    call    ext_create_array_int        # |        192 |        192 |
.count move_ret
    mov     $i1, $i7                    # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
.count move_args
    mov     $i1, $i3                    # |        192 |        192 |
    call    ext_create_array_int        # |        192 |        192 |
.count move_ret
    mov     $i1, $i8                    # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i8 + 1]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i8 + 2]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i8 + 3]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i8 + 4]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
.count move_args
    mov     $i1, $i3                    # |        192 |        192 |
    call    ext_create_array_int        # |        192 |        192 |
.count move_ret
    mov     $i1, $i9                    # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i9 + 1]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i9 + 2]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i9 + 3]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i9 + 4]              # |        192 |        192 |
    li      1, $i2                      # |        192 |        192 |
    li      0, $i3                      # |        192 |        192 |
    call    ext_create_array_int        # |        192 |        192 |
.count move_ret
    mov     $i1, $i10                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
.count move_args
    mov     $i1, $i3                    # |        192 |        192 |
    call    ext_create_array_int        # |        192 |        192 |
.count move_ret
    mov     $i1, $i11                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i11 + 1]             # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i11 + 2]             # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i11 + 3]             # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    ext_create_array_float      # |        192 |        192 |
    store   $i1, [$i11 + 4]             # |        192 |        192 |
    mov     $hp, $i1                    # |        192 |        192 |
    add     $hp, 8, $hp                 # |        192 |        192 |
    store   $i11, [$i1 + 7]             # |        192 |        192 |
    store   $i10, [$i1 + 6]             # |        192 |        192 |
    store   $i9, [$i1 + 5]              # |        192 |        192 |
    store   $i8, [$i1 + 4]              # |        192 |        192 |
    store   $i7, [$i1 + 3]              # |        192 |        192 |
    store   $i6, [$i1 + 2]              # |        192 |        192 |
    store   $i5, [$i1 + 1]              # |        192 |        192 |
    store   $i4, [$i1 + 0]              # |        192 |        192 |
    jr      $ra1                        # |        192 |        192 |
.end create_pixel

######################################################################
# $i1 = init_line_elements($i12, $i4)
# $ra = $ra2
# [$i1 - $i13]
# [$f2]
# []
# []
######################################################################
.begin init_line_elements
init_line_elements.3010:
    bl      $i4, 0, bge_else.32988      # |         96 |         96 |
bge_then.32988:
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
.count move_ret
    mov     $i1, $i5                    # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
.count move_args
    mov     $i1, $i3                    # |         96 |         96 |
    call    ext_create_array_int        # |         96 |         96 |
.count move_ret
    mov     $i1, $i6                    # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i6 + 1]              # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i6 + 2]              # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i6 + 3]              # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i6 + 4]              # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
    li      0, $i3                      # |         96 |         96 |
    call    ext_create_array_int        # |         96 |         96 |
.count move_ret
    mov     $i1, $i7                    # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
    li      0, $i3                      # |         96 |         96 |
    call    ext_create_array_int        # |         96 |         96 |
.count move_ret
    mov     $i1, $i8                    # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
.count move_args
    mov     $i1, $i3                    # |         96 |         96 |
    call    ext_create_array_int        # |         96 |         96 |
.count move_ret
    mov     $i1, $i9                    # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i9 + 1]              # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i9 + 2]              # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i9 + 3]              # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i9 + 4]              # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
.count move_args
    mov     $i1, $i3                    # |         96 |         96 |
    call    ext_create_array_int        # |         96 |         96 |
.count move_ret
    mov     $i1, $i10                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i10 + 1]             # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i10 + 2]             # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i10 + 3]             # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i10 + 4]             # |         96 |         96 |
    li      1, $i2                      # |         96 |         96 |
    li      0, $i3                      # |         96 |         96 |
    call    ext_create_array_int        # |         96 |         96 |
.count move_ret
    mov     $i1, $i11                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
.count move_args
    mov     $i1, $i3                    # |         96 |         96 |
    call    ext_create_array_int        # |         96 |         96 |
.count move_ret
    mov     $i1, $i13                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i13 + 1]             # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i13 + 2]             # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i13 + 3]             # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    ext_create_array_float      # |         96 |         96 |
    store   $i1, [$i13 + 4]             # |         96 |         96 |
    mov     $hp, $i1                    # |         96 |         96 |
    add     $hp, 8, $hp                 # |         96 |         96 |
    store   $i13, [$i1 + 7]             # |         96 |         96 |
    store   $i11, [$i1 + 6]             # |         96 |         96 |
    store   $i10, [$i1 + 5]             # |         96 |         96 |
    store   $i9, [$i1 + 4]              # |         96 |         96 |
    store   $i8, [$i1 + 3]              # |         96 |         96 |
    store   $i7, [$i1 + 2]              # |         96 |         96 |
    store   $i6, [$i1 + 1]              # |         96 |         96 |
    store   $i5, [$i1 + 0]              # |         96 |         96 |
.count storer
    add     $i12, $i4, $tmp             # |         96 |         96 |
    store   $i1, [$tmp + 0]             # |         96 |         96 |
    sub     $i4, 1, $i13                # |         96 |         96 |
    bl      $i13, 0, bge_else.32989     # |         96 |         96 |
bge_then.32989:
    jal     create_pixel.3008, $ra1     # |         96 |         96 |
.count storer
    add     $i12, $i13, $tmp            # |         96 |         96 |
    store   $i1, [$tmp + 0]             # |         96 |         96 |
    sub     $i13, 1, $i4                # |         96 |         96 |
    bl      $i4, 0, bge_else.32990      # |         96 |         96 |
bge_then.32990:
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
.count move_ret
    mov     $i1, $i5                    # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
.count move_args
    mov     $i1, $i3                    # |         93 |         93 |
    call    ext_create_array_int        # |         93 |         93 |
.count move_ret
    mov     $i1, $i6                    # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i6 + 1]              # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i6 + 2]              # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i6 + 3]              # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i6 + 4]              # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
    li      0, $i3                      # |         93 |         93 |
    call    ext_create_array_int        # |         93 |         93 |
.count move_ret
    mov     $i1, $i7                    # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
    li      0, $i3                      # |         93 |         93 |
    call    ext_create_array_int        # |         93 |         93 |
.count move_ret
    mov     $i1, $i8                    # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
.count move_args
    mov     $i1, $i3                    # |         93 |         93 |
    call    ext_create_array_int        # |         93 |         93 |
.count move_ret
    mov     $i1, $i9                    # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i9 + 1]              # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i9 + 2]              # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i9 + 3]              # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i9 + 4]              # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
.count move_args
    mov     $i1, $i3                    # |         93 |         93 |
    call    ext_create_array_int        # |         93 |         93 |
.count move_ret
    mov     $i1, $i10                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i10 + 1]             # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i10 + 2]             # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i10 + 3]             # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i10 + 4]             # |         93 |         93 |
    li      1, $i2                      # |         93 |         93 |
    li      0, $i3                      # |         93 |         93 |
    call    ext_create_array_int        # |         93 |         93 |
.count move_ret
    mov     $i1, $i11                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
.count move_args
    mov     $i1, $i3                    # |         93 |         93 |
    call    ext_create_array_int        # |         93 |         93 |
.count move_ret
    mov     $i1, $i13                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i13 + 1]             # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i13 + 2]             # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i13 + 3]             # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    ext_create_array_float      # |         93 |         93 |
    store   $i1, [$i13 + 4]             # |         93 |         93 |
    mov     $hp, $i1                    # |         93 |         93 |
    add     $hp, 8, $hp                 # |         93 |         93 |
    store   $i13, [$i1 + 7]             # |         93 |         93 |
    store   $i11, [$i1 + 6]             # |         93 |         93 |
    store   $i10, [$i1 + 5]             # |         93 |         93 |
    store   $i9, [$i1 + 4]              # |         93 |         93 |
    store   $i8, [$i1 + 3]              # |         93 |         93 |
    store   $i7, [$i1 + 2]              # |         93 |         93 |
    store   $i6, [$i1 + 1]              # |         93 |         93 |
    store   $i5, [$i1 + 0]              # |         93 |         93 |
.count storer
    add     $i12, $i4, $tmp             # |         93 |         93 |
    store   $i1, [$tmp + 0]             # |         93 |         93 |
    sub     $i4, 1, $i13                # |         93 |         93 |
    bl      $i13, 0, bge_else.32991     # |         93 |         93 |
bge_then.32991:
    jal     create_pixel.3008, $ra1     # |         93 |         93 |
.count storer
    add     $i12, $i13, $tmp            # |         93 |         93 |
    store   $i1, [$tmp + 0]             # |         93 |         93 |
    sub     $i13, 1, $i4                # |         93 |         93 |
    b       init_line_elements.3010     # |         93 |         93 |
bge_else.32991:
    mov     $i12, $i1
    jr      $ra2
bge_else.32990:
    mov     $i12, $i1                   # |          3 |          3 |
    jr      $ra2                        # |          3 |          3 |
bge_else.32989:
    mov     $i12, $i1
    jr      $ra2
bge_else.32988:
    mov     $i12, $i1
    jr      $ra2
.end init_line_elements

######################################################################
# calc_dirvec($i1, $f1, $f2, $f9, $f10, $i3, $i4)
# $ra = $ra1
# [$i1 - $i4]
# [$f1 - $f13]
# []
# []
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
    bl      $i1, 5, bge_else.32992      # |        600 |        600 |
bge_then.32992:
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
bge_else.32992:
    fmul    $f2, $f2, $f1               # |        500 |        500 |
    fadd    $f1, $fc8, $f1              # |        500 |        500 |
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
    fadd    $f1, $fc8, $f1              # |        500 |        500 |
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
# [$f1 - $f15]
# []
# []
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
    bl      $i5, 0, bge_else.32993      # |         11 |         11 |
bge_then.32993:
    li      0, $i1                      # |         11 |         11 |
.count move_args
    mov     $i5, $i2                    # |         11 |         11 |
    call    ext_float_of_int            # |         11 |         11 |
    fmul    $f1, $fc12, $f15            # |         11 |         11 |
    fsub    $f15, $fc11, $f9            # |         11 |         11 |
.count move_args
    mov     $f0, $f1                    # |         11 |         11 |
.count move_args
    mov     $f0, $f2                    # |         11 |         11 |
.count move_args
    mov     $f14, $f10                  # |         11 |         11 |
.count move_args
    mov     $i6, $i3                    # |         11 |         11 |
.count move_args
    mov     $i7, $i4                    # |         11 |         11 |
    jal     calc_dirvec.3020, $ra1      # |         11 |         11 |
    li      0, $i1                      # |         11 |         11 |
    add     $i7, 2, $i8                 # |         11 |         11 |
    fadd    $f15, $fc8, $f9             # |         11 |         11 |
.count move_args
    mov     $f0, $f1                    # |         11 |         11 |
.count move_args
    mov     $f0, $f2                    # |         11 |         11 |
.count move_args
    mov     $f14, $f10                  # |         11 |         11 |
.count move_args
    mov     $i6, $i3                    # |         11 |         11 |
.count move_args
    mov     $i8, $i4                    # |         11 |         11 |
    jal     calc_dirvec.3020, $ra1      # |         11 |         11 |
    sub     $i5, 1, $i5                 # |         11 |         11 |
    bl      $i5, 0, bge_else.32994      # |         11 |         11 |
bge_then.32994:
    li      0, $i1                      # |         10 |         10 |
    add     $i6, 1, $i2                 # |         10 |         10 |
    bl      $i2, 5, bge_else.32995      # |         10 |         10 |
bge_then.32995:
    sub     $i2, 5, $i6                 # |          2 |          2 |
.count b_cont
    b       bge_cont.32995              # |          2 |          2 |
bge_else.32995:
    mov     $i2, $i6                    # |          8 |          8 |
bge_cont.32995:
.count move_args
    mov     $i5, $i2                    # |         10 |         10 |
    call    ext_float_of_int            # |         10 |         10 |
    fmul    $f1, $fc12, $f15            # |         10 |         10 |
    fsub    $f15, $fc11, $f9            # |         10 |         10 |
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
    fadd    $f15, $fc8, $f9             # |         10 |         10 |
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
    bl      $i5, 0, bge_else.32996      # |         10 |         10 |
bge_then.32996:
    li      0, $i1                      # |          5 |          5 |
    add     $i6, 1, $i2                 # |          5 |          5 |
    bl      $i2, 5, bge_else.32997      # |          5 |          5 |
bge_then.32997:
    sub     $i2, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.32997              # |          1 |          1 |
bge_else.32997:
    mov     $i2, $i6                    # |          4 |          4 |
bge_cont.32997:
.count move_args
    mov     $i5, $i2                    # |          5 |          5 |
    call    ext_float_of_int            # |          5 |          5 |
    fmul    $f1, $fc12, $f15            # |          5 |          5 |
    fsub    $f15, $fc11, $f9            # |          5 |          5 |
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
    fadd    $f15, $fc8, $f9             # |          5 |          5 |
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
    bl      $i5, 0, bge_else.32998      # |          5 |          5 |
bge_then.32998:
    li      0, $i1                      # |          1 |          1 |
    add     $i6, 1, $i2                 # |          1 |          1 |
    bl      $i2, 5, bge_else.32999      # |          1 |          1 |
bge_then.32999:
    sub     $i2, 5, $i6
.count b_cont
    b       bge_cont.32999
bge_else.32999:
    mov     $i2, $i6                    # |          1 |          1 |
bge_cont.32999:
.count move_args
    mov     $i5, $i2                    # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    fmul    $f1, $fc12, $f15            # |          1 |          1 |
    fsub    $f15, $fc11, $f9            # |          1 |          1 |
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
    fadd    $f15, $fc8, $f9             # |          1 |          1 |
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
    sub     $i5, 1, $i5                 # |          1 |          1 |
    add     $i6, 1, $i6                 # |          1 |          1 |
    bl      $i6, 5, calc_dirvecs.3028   # |          1 |          1 |
    sub     $i6, 5, $i6
    b       calc_dirvecs.3028
bge_else.32998:
    jr      $ra2                        # |          4 |          4 |
bge_else.32996:
    jr      $ra2                        # |          5 |          5 |
bge_else.32994:
    jr      $ra2                        # |          1 |          1 |
bge_else.32993:
    jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i9, $i10, $i11)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f18]
# []
# []
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
    bl      $i9, 0, bge_else.33001      # |          5 |          5 |
bge_then.33001:
.count stack_move
    sub     $sp, 1, $sp                 # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    li      4, $i2                      # |          5 |          5 |
    call    ext_float_of_int            # |          5 |          5 |
    fmul    $f1, $fc12, $f14            # |          5 |          5 |
    fsub    $f14, $fc11, $f16           # |          5 |          5 |
.count move_args
    mov     $i9, $i2                    # |          5 |          5 |
    call    ext_float_of_int            # |          5 |          5 |
    fmul    $f1, $fc12, $f1             # |          5 |          5 |
    fsub    $f1, $fc11, $f15            # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f16, $f9                   # |          5 |          5 |
.count move_args
    mov     $f15, $f10                  # |          5 |          5 |
.count move_args
    mov     $i10, $i3                   # |          5 |          5 |
.count move_args
    mov     $i11, $i4                   # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    add     $i11, 2, $i5                # |          5 |          5 |
    fadd    $f14, $fc8, $f17            # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f17, $f9                   # |          5 |          5 |
.count move_args
    mov     $f15, $f10                  # |          5 |          5 |
.count move_args
    mov     $i10, $i3                   # |          5 |          5 |
.count move_args
    mov     $i5, $i4                    # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    add     $i10, 1, $i2                # |          5 |          5 |
    bl      $i2, 5, bge_else.33002      # |          5 |          5 |
bge_then.33002:
    sub     $i2, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.33002              # |          1 |          1 |
bge_else.33002:
    mov     $i2, $i6                    # |          4 |          4 |
bge_cont.33002:
    li      3, $i2                      # |          5 |          5 |
    call    ext_float_of_int            # |          5 |          5 |
    fmul    $f1, $fc12, $f14            # |          5 |          5 |
    fsub    $f14, $fc11, $f18           # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f18, $f9                   # |          5 |          5 |
.count move_args
    mov     $f15, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i4                   # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    fadd    $f14, $fc8, $f9             # |          5 |          5 |
.count stack_store
    store   $f9, [$sp + 0]              # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f15, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i5, $i4                    # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    add     $i6, 1, $i2                 # |          5 |          5 |
    bl      $i2, 5, bge_cont.33003      # |          5 |          5 |
bge_then.33003:
    sub     $i2, 5, $i2                 # |          1 |          1 |
bge_cont.33003:
    mov     $i2, $i6                    # |          5 |          5 |
    li      2, $i2                      # |          5 |          5 |
    call    ext_float_of_int            # |          5 |          5 |
    fmul    $f1, $fc12, $f14            # |          5 |          5 |
    fsub    $f14, $fc11, $f9            # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f15, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i4                   # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    fadd    $f14, $fc8, $f9             # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f15, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i5, $i4                    # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      1, $i5                      # |          5 |          5 |
    add     $i6, 1, $i1                 # |          5 |          5 |
    bl      $i1, 5, bge_cont.33004      # |          5 |          5 |
bge_then.33004:
    sub     $i1, 5, $i1                 # |          1 |          1 |
bge_cont.33004:
    mov     $i1, $i6                    # |          5 |          5 |
.count move_args
    mov     $f15, $f14                  # |          5 |          5 |
.count move_args
    mov     $i11, $i7                   # |          5 |          5 |
    jal     calc_dirvecs.3028, $ra2     # |          5 |          5 |
    sub     $i9, 1, $i9                 # |          5 |          5 |
    bl      $i9, 0, bge_else.33005      # |          5 |          5 |
bge_then.33005:
    add     $i10, 2, $i1                # |          4 |          4 |
    bl      $i1, 5, bge_cont.33006      # |          4 |          4 |
bge_then.33006:
    sub     $i1, 5, $i1                 # |          1 |          1 |
bge_cont.33006:
    mov     $i1, $i10                   # |          4 |          4 |
    add     $i11, 4, $i11               # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
.count move_args
    mov     $i9, $i2                    # |          4 |          4 |
    call    ext_float_of_int            # |          4 |          4 |
    fmul    $f1, $fc12, $f1             # |          4 |          4 |
    fsub    $f1, $fc11, $f14            # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f16, $f9                   # |          4 |          4 |
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
    mov     $f17, $f9                   # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i10, $i3                   # |          4 |          4 |
.count move_args
    mov     $i5, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
    add     $i10, 1, $i2                # |          4 |          4 |
    bl      $i2, 5, bge_cont.33007      # |          4 |          4 |
bge_then.33007:
    sub     $i2, 5, $i2                 # |          1 |          1 |
bge_cont.33007:
    mov     $i2, $i6                    # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f18, $f9                   # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i11, $i4                   # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
.count stack_load
    load    [$sp + 0], $f9              # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i5, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      2, $i5                      # |          4 |          4 |
    add     $i6, 1, $i1                 # |          4 |          4 |
    bl      $i1, 5, bge_else.33008      # |          4 |          4 |
bge_then.33008:
    sub     $i1, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.33008              # |          1 |          1 |
bge_else.33008:
    mov     $i1, $i6                    # |          3 |          3 |
bge_cont.33008:
.count move_args
    mov     $i11, $i7                   # |          4 |          4 |
    jal     calc_dirvecs.3028, $ra2     # |          4 |          4 |
.count stack_move
    add     $sp, 1, $sp                 # |          4 |          4 |
    sub     $i9, 1, $i9                 # |          4 |          4 |
    add     $i10, 2, $i10               # |          4 |          4 |
    add     $i11, 4, $i11               # |          4 |          4 |
    bl      $i10, 5, calc_dirvec_rows.3033# |          4 |          4 |
    sub     $i10, 5, $i10               # |          2 |          2 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |
bge_else.33005:
.count stack_move
    add     $sp, 1, $sp                 # |          1 |          1 |
    jr      $ra3                        # |          1 |          1 |
bge_else.33001:
    jr      $ra3
.end calc_dirvec_rows

######################################################################
# create_dirvec_elements($i4, $i5)
# $ra = $ra1
# [$i1 - $i6]
# [$f2]
# []
# []
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
    bl      $i5, 0, bge_else.33010      # |        150 |        150 |
bge_then.33010:
    li      3, $i2                      # |        148 |        148 |
.count move_args
    mov     $f0, $f2                    # |        148 |        148 |
    call    ext_create_array_float      # |        148 |        148 |
.count move_ret
    mov     $i1, $i6                    # |        148 |        148 |
.count move_args
    mov     $ig0, $i2                   # |        148 |        148 |
.count move_args
    mov     $i6, $i3                    # |        148 |        148 |
    call    ext_create_array_int        # |        148 |        148 |
    mov     $hp, $i2                    # |        148 |        148 |
    add     $hp, 2, $hp                 # |        148 |        148 |
    store   $i1, [$i2 + 1]              # |        148 |        148 |
    store   $i6, [$i2 + 0]              # |        148 |        148 |
.count storer
    add     $i4, $i5, $tmp              # |        148 |        148 |
    store   $i2, [$tmp + 0]             # |        148 |        148 |
    sub     $i5, 1, $i5                 # |        148 |        148 |
    bl      $i5, 0, bge_else.33011      # |        148 |        148 |
bge_then.33011:
    li      3, $i2                      # |        146 |        146 |
.count move_args
    mov     $f0, $f2                    # |        146 |        146 |
    call    ext_create_array_float      # |        146 |        146 |
.count move_ret
    mov     $i1, $i6                    # |        146 |        146 |
.count move_args
    mov     $ig0, $i2                   # |        146 |        146 |
.count move_args
    mov     $i6, $i3                    # |        146 |        146 |
    call    ext_create_array_int        # |        146 |        146 |
    mov     $hp, $i2                    # |        146 |        146 |
    add     $hp, 2, $hp                 # |        146 |        146 |
    store   $i1, [$i2 + 1]              # |        146 |        146 |
    store   $i6, [$i2 + 0]              # |        146 |        146 |
.count storer
    add     $i4, $i5, $tmp              # |        146 |        146 |
    store   $i2, [$tmp + 0]             # |        146 |        146 |
    sub     $i5, 1, $i5                 # |        146 |        146 |
    bl      $i5, 0, bge_else.33012      # |        146 |        146 |
bge_then.33012:
    li      3, $i2                      # |        146 |        146 |
.count move_args
    mov     $f0, $f2                    # |        146 |        146 |
    call    ext_create_array_float      # |        146 |        146 |
.count move_ret
    mov     $i1, $i6                    # |        146 |        146 |
.count move_args
    mov     $ig0, $i2                   # |        146 |        146 |
.count move_args
    mov     $i6, $i3                    # |        146 |        146 |
    call    ext_create_array_int        # |        146 |        146 |
    mov     $hp, $i2                    # |        146 |        146 |
    add     $hp, 2, $hp                 # |        146 |        146 |
    store   $i1, [$i2 + 1]              # |        146 |        146 |
    store   $i6, [$i2 + 0]              # |        146 |        146 |
.count storer
    add     $i4, $i5, $tmp              # |        146 |        146 |
    store   $i2, [$tmp + 0]             # |        146 |        146 |
    sub     $i5, 1, $i5                 # |        146 |        146 |
    bl      $i5, 0, bge_else.33013      # |        146 |        146 |
bge_then.33013:
    li      3, $i2                      # |        145 |        145 |
.count move_args
    mov     $f0, $f2                    # |        145 |        145 |
    call    ext_create_array_float      # |        145 |        145 |
.count move_ret
    mov     $i1, $i6                    # |        145 |        145 |
.count move_args
    mov     $ig0, $i2                   # |        145 |        145 |
.count move_args
    mov     $i6, $i3                    # |        145 |        145 |
    call    ext_create_array_int        # |        145 |        145 |
    mov     $hp, $i2                    # |        145 |        145 |
    add     $hp, 2, $hp                 # |        145 |        145 |
    store   $i1, [$i2 + 1]              # |        145 |        145 |
    store   $i6, [$i2 + 0]              # |        145 |        145 |
.count storer
    add     $i4, $i5, $tmp              # |        145 |        145 |
    store   $i2, [$tmp + 0]             # |        145 |        145 |
    sub     $i5, 1, $i5                 # |        145 |        145 |
    b       create_dirvec_elements.3039 # |        145 |        145 |
bge_else.33013:
    jr      $ra1                        # |          1 |          1 |
bge_else.33012:
    jr      $ra1
bge_else.33011:
    jr      $ra1                        # |          2 |          2 |
bge_else.33010:
    jr      $ra1                        # |          2 |          2 |
.end create_dirvec_elements

######################################################################
# create_dirvecs($i7)
# $ra = $ra2
# [$i1 - $i7]
# [$f2]
# []
# []
######################################################################
.begin create_dirvecs
create_dirvecs.3042:
    bl      $i7, 0, bge_else.33014      # |          3 |          3 |
bge_then.33014:
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    ext_create_array_float      # |          2 |          2 |
.count move_ret
    mov     $i1, $i4                    # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
.count move_args
    mov     $i4, $i3                    # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    li      120, $i2                    # |          2 |          2 |
    mov     $hp, $i3                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i1, [$i3 + 1]              # |          2 |          2 |
    store   $i4, [$i3 + 0]              # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    store   $i1, [ext_dirvecs + $i7]    # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    ext_create_array_float      # |          2 |          2 |
.count move_ret
    mov     $i1, $i4                    # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
.count move_args
    mov     $i4, $i3                    # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    load    [ext_dirvecs + $i7], $i6    # |          2 |          2 |
    mov     $hp, $i2                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i1, [$i2 + 1]              # |          2 |          2 |
    store   $i4, [$i2 + 0]              # |          2 |          2 |
    store   $i2, [$i6 + 118]            # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    ext_create_array_float      # |          2 |          2 |
.count move_ret
    mov     $i1, $i4                    # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
.count move_args
    mov     $i4, $i3                    # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    mov     $hp, $i2                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i1, [$i2 + 1]              # |          2 |          2 |
    store   $i4, [$i2 + 0]              # |          2 |          2 |
    store   $i2, [$i6 + 117]            # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    ext_create_array_float      # |          2 |          2 |
.count move_ret
    mov     $i1, $i4                    # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
.count move_args
    mov     $i4, $i3                    # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    mov     $hp, $i2                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i1, [$i2 + 1]              # |          2 |          2 |
    store   $i4, [$i2 + 0]              # |          2 |          2 |
    store   $i2, [$i6 + 116]            # |          2 |          2 |
    li      115, $i5                    # |          2 |          2 |
.count move_args
    mov     $i6, $i4                    # |          2 |          2 |
    jal     create_dirvec_elements.3039, $ra1# |          2 |          2 |
    sub     $i7, 1, $i7                 # |          2 |          2 |
    bl      $i7, 0, bge_else.33015      # |          2 |          2 |
bge_then.33015:
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    ext_create_array_float      # |          2 |          2 |
.count move_ret
    mov     $i1, $i4                    # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
.count move_args
    mov     $i4, $i3                    # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    li      120, $i2                    # |          2 |          2 |
    mov     $hp, $i3                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i1, [$i3 + 1]              # |          2 |          2 |
    store   $i4, [$i3 + 0]              # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    store   $i1, [ext_dirvecs + $i7]    # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    ext_create_array_float      # |          2 |          2 |
.count move_ret
    mov     $i1, $i4                    # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
.count move_args
    mov     $i4, $i3                    # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    load    [ext_dirvecs + $i7], $i6    # |          2 |          2 |
    mov     $hp, $i2                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i1, [$i2 + 1]              # |          2 |          2 |
    store   $i4, [$i2 + 0]              # |          2 |          2 |
    store   $i2, [$i6 + 118]            # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    ext_create_array_float      # |          2 |          2 |
.count move_ret
    mov     $i1, $i4                    # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
.count move_args
    mov     $i4, $i3                    # |          2 |          2 |
    call    ext_create_array_int        # |          2 |          2 |
    mov     $hp, $i2                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i1, [$i2 + 1]              # |          2 |          2 |
    store   $i4, [$i2 + 0]              # |          2 |          2 |
    store   $i2, [$i6 + 117]            # |          2 |          2 |
    li      116, $i5                    # |          2 |          2 |
.count move_args
    mov     $i6, $i4                    # |          2 |          2 |
    jal     create_dirvec_elements.3039, $ra1# |          2 |          2 |
    sub     $i7, 1, $i7                 # |          2 |          2 |
    b       create_dirvecs.3042         # |          2 |          2 |
bge_else.33015:
    jr      $ra2
bge_else.33014:
    jr      $ra2                        # |          1 |          1 |
.end create_dirvecs

######################################################################
# init_dirvec_constants($i11, $i12)
# $ra = $ra2
# [$i1 - $i12]
# [$f1 - $f8]
# []
# []
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
    bl      $i12, 0, bge_else.33016     # |        152 |        152 |
bge_then.33016:
    sub     $ig0, 1, $i4                # |        150 |        150 |
    load    [$i11 + $i12], $i6          # |        150 |        150 |
    bl      $i4, 0, bge_cont.33017      # |        150 |        150 |
bge_then.33017:
    load    [$i6 + 1], $i5              # |        150 |        150 |
    load    [ext_objects + $i4], $i7    # |        150 |        150 |
    load    [$i7 + 1], $i1              # |        150 |        150 |
    load    [$i6 + 0], $i8              # |        150 |        150 |
.count move_args
    mov     $f0, $f2                    # |        150 |        150 |
    bne     $i1, 1, be_else.33018       # |        150 |        150 |
be_then.33018:
    li      6, $i2
    call    ext_create_array_float
    load    [$i8 + 0], $f1
    bne     $f1, $f0, be_else.33019
be_then.33019:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.33019
be_else.33019:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33020
ble_then.33020:
    li      0, $i3
.count b_cont
    b       ble_cont.33020
ble_else.33020:
    li      1, $i3
ble_cont.33020:
    bne     $i2, 0, be_else.33021
be_then.33021:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33021
be_else.33021:
    bne     $i3, 0, be_else.33022
be_then.33022:
    li      1, $i2
.count b_cont
    b       be_cont.33022
be_else.33022:
    li      0, $i2
be_cont.33022:
be_cont.33021:
    load    [$i7 + 4], $i3
    load    [$i3 + 0], $f1
    bne     $i2, 0, be_else.33023
be_then.33023:
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
.count b_cont
    b       be_cont.33023
be_else.33023:
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
be_cont.33023:
be_cont.33019:
    load    [$i8 + 1], $f1
    bne     $f1, $f0, be_else.33024
be_then.33024:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.33024
be_else.33024:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33025
ble_then.33025:
    li      0, $i3
.count b_cont
    b       ble_cont.33025
ble_else.33025:
    li      1, $i3
ble_cont.33025:
    bne     $i2, 0, be_else.33026
be_then.33026:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33026
be_else.33026:
    bne     $i3, 0, be_else.33027
be_then.33027:
    li      1, $i2
.count b_cont
    b       be_cont.33027
be_else.33027:
    li      0, $i2
be_cont.33027:
be_cont.33026:
    load    [$i7 + 4], $i3
    load    [$i3 + 1], $f1
    bne     $i2, 0, be_else.33028
be_then.33028:
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
.count b_cont
    b       be_cont.33028
be_else.33028:
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
be_cont.33028:
be_cont.33024:
    load    [$i8 + 2], $f1
    bne     $f1, $f0, be_else.33029
be_then.33029:
    store   $f0, [$i1 + 5]
.count storer
    add     $i5, $i4, $tmp
    store   $i1, [$tmp + 0]
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33018
be_else.33029:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33030
ble_then.33030:
    li      0, $i3
.count b_cont
    b       ble_cont.33030
ble_else.33030:
    li      1, $i3
ble_cont.33030:
    bne     $i2, 0, be_else.33031
be_then.33031:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33031
be_else.33031:
    bne     $i3, 0, be_else.33032
be_then.33032:
    li      1, $i2
.count b_cont
    b       be_cont.33032
be_else.33032:
    li      0, $i2
be_cont.33032:
be_cont.33031:
    load    [$i7 + 4], $i3
    load    [$i3 + 2], $f1
    bne     $i2, 0, be_cont.33033
be_then.33033:
    fneg    $f1, $f1
be_cont.33033:
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
.count storer
    add     $i5, $i4, $tmp
    store   $i1, [$tmp + 0]
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33018
be_else.33018:
    bne     $i1, 2, be_else.33034       # |        150 |        150 |
be_then.33034:
    li      4, $i2                      # |        150 |        150 |
    call    ext_create_array_float      # |        150 |        150 |
    load    [$i7 + 4], $i2              # |        150 |        150 |
    load    [$i7 + 4], $i3              # |        150 |        150 |
    load    [$i7 + 4], $i9              # |        150 |        150 |
    load    [$i8 + 0], $f1              # |        150 |        150 |
    load    [$i2 + 0], $f2              # |        150 |        150 |
    fmul    $f1, $f2, $f1               # |        150 |        150 |
    load    [$i8 + 1], $f2              # |        150 |        150 |
    load    [$i3 + 1], $f3              # |        150 |        150 |
    fmul    $f2, $f3, $f2               # |        150 |        150 |
    fadd    $f1, $f2, $f1               # |        150 |        150 |
    load    [$i8 + 2], $f2              # |        150 |        150 |
    load    [$i9 + 2], $f3              # |        150 |        150 |
    fmul    $f2, $f3, $f2               # |        150 |        150 |
    fadd    $f1, $f2, $f1               # |        150 |        150 |
.count storer
    add     $i5, $i4, $tmp              # |        150 |        150 |
    sub     $i4, 1, $i5                 # |        150 |        150 |
.count move_args
    mov     $i6, $i4                    # |        150 |        150 |
    bg      $f1, $f0, ble_else.33035    # |        150 |        150 |
ble_then.33035:
    store   $f0, [$i1 + 0]              # |         80 |         80 |
    store   $i1, [$tmp + 0]             # |         80 |         80 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |         80 |         80 |
.count b_cont
    b       be_cont.33034               # |         80 |         80 |
ble_else.33035:
    finv    $f1, $f1                    # |         70 |         70 |
    fneg    $f1, $f2                    # |         70 |         70 |
    store   $f2, [$i1 + 0]              # |         70 |         70 |
    load    [$i7 + 4], $i2              # |         70 |         70 |
    load    [$i2 + 0], $f2              # |         70 |         70 |
    fmul_n  $f2, $f1, $f2               # |         70 |         70 |
    store   $f2, [$i1 + 1]              # |         70 |         70 |
    load    [$i7 + 4], $i2              # |         70 |         70 |
    load    [$i2 + 1], $f2              # |         70 |         70 |
    fmul_n  $f2, $f1, $f2               # |         70 |         70 |
    store   $f2, [$i1 + 2]              # |         70 |         70 |
    load    [$i7 + 4], $i2              # |         70 |         70 |
    load    [$i2 + 2], $f2              # |         70 |         70 |
    fmul_n  $f2, $f1, $f1               # |         70 |         70 |
    store   $f1, [$i1 + 3]              # |         70 |         70 |
    store   $i1, [$tmp + 0]             # |         70 |         70 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |         70 |         70 |
.count b_cont
    b       be_cont.33034               # |         70 |         70 |
be_else.33034:
    li      5, $i2
    call    ext_create_array_float
    load    [$i7 + 3], $i2
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f1
    load    [$i8 + 1], $f2
    load    [$i8 + 2], $f3
    fmul    $f1, $f1, $f4
    load    [$i3 + 0], $f5
    fmul    $f4, $f5, $f4
    fmul    $f2, $f2, $f5
    load    [$i9 + 1], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    bne     $i2, 0, be_else.33036
be_then.33036:
    mov     $f4, $f1
.count b_cont
    b       be_cont.33036
be_else.33036:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.33036:
    store   $f1, [$i1 + 0]
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 1], $f3
    load    [$i9 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i8 + 2], $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33037
be_then.33037:
    store   $f2, [$i1 + 1]
    store   $f4, [$i1 + 2]
    store   $f6, [$i1 + 3]
    bne     $f1, $f0, be_else.33038
be_then.33038:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33037
be_else.33038:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33037
be_else.33037:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.33039
be_then.33039:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33039
be_else.33039:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
be_cont.33039:
be_cont.33037:
be_cont.33034:
be_cont.33018:
bge_cont.33017:
    sub     $i12, 1, $i12               # |        150 |        150 |
    bl      $i12, 0, bge_else.33040     # |        150 |        150 |
bge_then.33040:
    sub     $ig0, 1, $i4                # |        149 |        149 |
    load    [$i11 + $i12], $i6          # |        149 |        149 |
    bl      $i4, 0, bge_cont.33041      # |        149 |        149 |
bge_then.33041:
    load    [$i6 + 1], $i5              # |        149 |        149 |
    load    [ext_objects + $i4], $i7    # |        149 |        149 |
    load    [$i7 + 1], $i1              # |        149 |        149 |
    load    [$i6 + 0], $i8              # |        149 |        149 |
.count move_args
    mov     $f0, $f2                    # |        149 |        149 |
    bne     $i1, 1, be_else.33042       # |        149 |        149 |
be_then.33042:
    li      6, $i2
    call    ext_create_array_float
    load    [$i8 + 0], $f1
    bne     $f1, $f0, be_else.33043
be_then.33043:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.33043
be_else.33043:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33044
ble_then.33044:
    li      0, $i3
.count b_cont
    b       ble_cont.33044
ble_else.33044:
    li      1, $i3
ble_cont.33044:
    bne     $i2, 0, be_else.33045
be_then.33045:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33045
be_else.33045:
    bne     $i3, 0, be_else.33046
be_then.33046:
    li      1, $i2
.count b_cont
    b       be_cont.33046
be_else.33046:
    li      0, $i2
be_cont.33046:
be_cont.33045:
    load    [$i7 + 4], $i3
    load    [$i3 + 0], $f1
    bne     $i2, 0, be_else.33047
be_then.33047:
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
.count b_cont
    b       be_cont.33047
be_else.33047:
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
be_cont.33047:
be_cont.33043:
    load    [$i8 + 1], $f1
    bne     $f1, $f0, be_else.33048
be_then.33048:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.33048
be_else.33048:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33049
ble_then.33049:
    li      0, $i3
.count b_cont
    b       ble_cont.33049
ble_else.33049:
    li      1, $i3
ble_cont.33049:
    bne     $i2, 0, be_else.33050
be_then.33050:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33050
be_else.33050:
    bne     $i3, 0, be_else.33051
be_then.33051:
    li      1, $i2
.count b_cont
    b       be_cont.33051
be_else.33051:
    li      0, $i2
be_cont.33051:
be_cont.33050:
    load    [$i7 + 4], $i3
    load    [$i3 + 1], $f1
    bne     $i2, 0, be_else.33052
be_then.33052:
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
.count b_cont
    b       be_cont.33052
be_else.33052:
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
be_cont.33052:
be_cont.33048:
    load    [$i8 + 2], $f1
    bne     $f1, $f0, be_else.33053
be_then.33053:
    store   $f0, [$i1 + 5]
.count storer
    add     $i5, $i4, $tmp
    store   $i1, [$tmp + 0]
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33042
be_else.33053:
    load    [$i7 + 6], $i2
    load    [$i7 + 4], $i3
    bg      $f0, $f1, ble_else.33054
ble_then.33054:
    li      0, $i7
.count b_cont
    b       ble_cont.33054
ble_else.33054:
    li      1, $i7
ble_cont.33054:
    bne     $i2, 0, be_else.33055
be_then.33055:
    mov     $i7, $i2
.count b_cont
    b       be_cont.33055
be_else.33055:
    bne     $i7, 0, be_else.33056
be_then.33056:
    li      1, $i2
.count b_cont
    b       be_cont.33056
be_else.33056:
    li      0, $i2
be_cont.33056:
be_cont.33055:
    load    [$i3 + 2], $f1
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33057
be_then.33057:
    fneg    $f1, $f1
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33042
be_else.33057:
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33042
be_else.33042:
    bne     $i1, 2, be_else.33058       # |        149 |        149 |
be_then.33058:
    li      4, $i2                      # |        149 |        149 |
    call    ext_create_array_float      # |        149 |        149 |
    load    [$i7 + 4], $i2              # |        149 |        149 |
    load    [$i7 + 4], $i3              # |        149 |        149 |
    load    [$i7 + 4], $i9              # |        149 |        149 |
    load    [$i8 + 0], $f1              # |        149 |        149 |
    load    [$i2 + 0], $f2              # |        149 |        149 |
    fmul    $f1, $f2, $f1               # |        149 |        149 |
    load    [$i8 + 1], $f2              # |        149 |        149 |
    load    [$i3 + 1], $f3              # |        149 |        149 |
    fmul    $f2, $f3, $f2               # |        149 |        149 |
    fadd    $f1, $f2, $f1               # |        149 |        149 |
    load    [$i8 + 2], $f2              # |        149 |        149 |
    load    [$i9 + 2], $f3              # |        149 |        149 |
    fmul    $f2, $f3, $f2               # |        149 |        149 |
    fadd    $f1, $f2, $f1               # |        149 |        149 |
.count storer
    add     $i5, $i4, $tmp              # |        149 |        149 |
    sub     $i4, 1, $i5                 # |        149 |        149 |
.count move_args
    mov     $i6, $i4                    # |        149 |        149 |
    bg      $f1, $f0, ble_else.33059    # |        149 |        149 |
ble_then.33059:
    store   $f0, [$i1 + 0]              # |         69 |         69 |
    store   $i1, [$tmp + 0]             # |         69 |         69 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |         69 |         69 |
.count b_cont
    b       be_cont.33058               # |         69 |         69 |
ble_else.33059:
    finv    $f1, $f1                    # |         80 |         80 |
    fneg    $f1, $f2                    # |         80 |         80 |
    store   $f2, [$i1 + 0]              # |         80 |         80 |
    load    [$i7 + 4], $i2              # |         80 |         80 |
    load    [$i2 + 0], $f2              # |         80 |         80 |
    fmul_n  $f2, $f1, $f2               # |         80 |         80 |
    store   $f2, [$i1 + 1]              # |         80 |         80 |
    load    [$i7 + 4], $i2              # |         80 |         80 |
    load    [$i2 + 1], $f2              # |         80 |         80 |
    fmul_n  $f2, $f1, $f2               # |         80 |         80 |
    store   $f2, [$i1 + 2]              # |         80 |         80 |
    load    [$i7 + 4], $i2              # |         80 |         80 |
    load    [$i2 + 2], $f2              # |         80 |         80 |
    fmul_n  $f2, $f1, $f1               # |         80 |         80 |
    store   $f1, [$i1 + 3]              # |         80 |         80 |
    store   $i1, [$tmp + 0]             # |         80 |         80 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |         80 |         80 |
.count b_cont
    b       be_cont.33058               # |         80 |         80 |
be_else.33058:
    li      5, $i2
    call    ext_create_array_float
    load    [$i7 + 3], $i2
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f1
    load    [$i8 + 1], $f2
    load    [$i8 + 2], $f3
    fmul    $f1, $f1, $f4
    load    [$i3 + 0], $f5
    fmul    $f4, $f5, $f4
    fmul    $f2, $f2, $f5
    load    [$i9 + 1], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    bne     $i2, 0, be_else.33060
be_then.33060:
    mov     $f4, $f1
.count b_cont
    b       be_cont.33060
be_else.33060:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.33060:
    store   $f1, [$i1 + 0]
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 1], $f3
    load    [$i9 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i8 + 2], $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33061
be_then.33061:
    store   $f2, [$i1 + 1]
    store   $f4, [$i1 + 2]
    store   $f6, [$i1 + 3]
    bne     $f1, $f0, be_else.33062
be_then.33062:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33061
be_else.33062:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33061
be_else.33061:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.33063
be_then.33063:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33063
be_else.33063:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
be_cont.33063:
be_cont.33061:
be_cont.33058:
be_cont.33042:
bge_cont.33041:
    sub     $i12, 1, $i12               # |        149 |        149 |
    bl      $i12, 0, bge_else.33064     # |        149 |        149 |
bge_then.33064:
    sub     $ig0, 1, $i5                # |        148 |        148 |
    load    [$i11 + $i12], $i4          # |        148 |        148 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |        148 |        148 |
    sub     $i12, 1, $i12               # |        148 |        148 |
    bl      $i12, 0, bge_else.33065     # |        148 |        148 |
bge_then.33065:
    sub     $ig0, 1, $i4                # |        147 |        147 |
    bl      $i4, 0, bge_else.33066      # |        147 |        147 |
bge_then.33066:
    load    [$i11 + $i12], $i6          # |        147 |        147 |
    load    [$i6 + 1], $i5              # |        147 |        147 |
    load    [ext_objects + $i4], $i7    # |        147 |        147 |
    load    [$i7 + 1], $i1              # |        147 |        147 |
    load    [$i6 + 0], $i8              # |        147 |        147 |
.count move_args
    mov     $f0, $f2                    # |        147 |        147 |
    bne     $i1, 1, be_else.33067       # |        147 |        147 |
be_then.33067:
    li      6, $i2
    call    ext_create_array_float
    load    [$i8 + 0], $f1
    bne     $f1, $f0, be_else.33068
be_then.33068:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.33068
be_else.33068:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33069
ble_then.33069:
    li      0, $i3
.count b_cont
    b       ble_cont.33069
ble_else.33069:
    li      1, $i3
ble_cont.33069:
    bne     $i2, 0, be_else.33070
be_then.33070:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33070
be_else.33070:
    bne     $i3, 0, be_else.33071
be_then.33071:
    li      1, $i2
.count b_cont
    b       be_cont.33071
be_else.33071:
    li      0, $i2
be_cont.33071:
be_cont.33070:
    load    [$i7 + 4], $i3
    load    [$i3 + 0], $f1
    bne     $i2, 0, be_else.33072
be_then.33072:
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
.count b_cont
    b       be_cont.33072
be_else.33072:
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
be_cont.33072:
be_cont.33068:
    load    [$i8 + 1], $f1
    bne     $f1, $f0, be_else.33073
be_then.33073:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.33073
be_else.33073:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33074
ble_then.33074:
    li      0, $i3
.count b_cont
    b       ble_cont.33074
ble_else.33074:
    li      1, $i3
ble_cont.33074:
    bne     $i2, 0, be_else.33075
be_then.33075:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33075
be_else.33075:
    bne     $i3, 0, be_else.33076
be_then.33076:
    li      1, $i2
.count b_cont
    b       be_cont.33076
be_else.33076:
    li      0, $i2
be_cont.33076:
be_cont.33075:
    load    [$i7 + 4], $i3
    load    [$i3 + 1], $f1
    bne     $i2, 0, be_else.33077
be_then.33077:
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
.count b_cont
    b       be_cont.33077
be_else.33077:
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
be_cont.33077:
be_cont.33073:
    load    [$i8 + 2], $f1
    bne     $f1, $f0, be_else.33078
be_then.33078:
    store   $f0, [$i1 + 5]
.count b_cont
    b       be_cont.33078
be_else.33078:
    load    [$i7 + 6], $i2
    load    [$i7 + 4], $i3
    bg      $f0, $f1, ble_else.33079
ble_then.33079:
    li      0, $i7
.count b_cont
    b       ble_cont.33079
ble_else.33079:
    li      1, $i7
ble_cont.33079:
    bne     $i2, 0, be_else.33080
be_then.33080:
    mov     $i7, $i2
.count b_cont
    b       be_cont.33080
be_else.33080:
    bne     $i7, 0, be_else.33081
be_then.33081:
    li      1, $i2
.count b_cont
    b       be_cont.33081
be_else.33081:
    li      0, $i2
be_cont.33081:
be_cont.33080:
    load    [$i3 + 2], $f1
    bne     $i2, 0, be_else.33082
be_then.33082:
    fneg    $f1, $f1
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
.count b_cont
    b       be_cont.33082
be_else.33082:
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
be_cont.33082:
be_cont.33078:
.count storer
    add     $i5, $i4, $tmp
    store   $i1, [$tmp + 0]
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
    sub     $i12, 1, $i12
    b       init_dirvec_constants.3044
be_else.33067:
    bne     $i1, 2, be_else.33083       # |        147 |        147 |
be_then.33083:
    li      4, $i2                      # |        147 |        147 |
    call    ext_create_array_float      # |        147 |        147 |
    load    [$i7 + 4], $i2              # |        147 |        147 |
    load    [$i7 + 4], $i3              # |        147 |        147 |
    load    [$i7 + 4], $i9              # |        147 |        147 |
    load    [$i8 + 0], $f1              # |        147 |        147 |
    load    [$i2 + 0], $f2              # |        147 |        147 |
    fmul    $f1, $f2, $f1               # |        147 |        147 |
    load    [$i8 + 1], $f2              # |        147 |        147 |
    load    [$i3 + 1], $f3              # |        147 |        147 |
    fmul    $f2, $f3, $f2               # |        147 |        147 |
    fadd    $f1, $f2, $f1               # |        147 |        147 |
    load    [$i8 + 2], $f2              # |        147 |        147 |
    load    [$i9 + 2], $f3              # |        147 |        147 |
    fmul    $f2, $f3, $f2               # |        147 |        147 |
    fadd    $f1, $f2, $f1               # |        147 |        147 |
.count storer
    add     $i5, $i4, $tmp              # |        147 |        147 |
    bg      $f1, $f0, ble_else.33084    # |        147 |        147 |
ble_then.33084:
    store   $f0, [$i1 + 0]              # |         68 |         68 |
    store   $i1, [$tmp + 0]             # |         68 |         68 |
.count b_cont
    b       be_cont.33083               # |         68 |         68 |
ble_else.33084:
    finv    $f1, $f1                    # |         79 |         79 |
    fneg    $f1, $f2                    # |         79 |         79 |
    store   $f2, [$i1 + 0]              # |         79 |         79 |
    load    [$i7 + 4], $i2              # |         79 |         79 |
    load    [$i2 + 0], $f2              # |         79 |         79 |
    fmul_n  $f2, $f1, $f2               # |         79 |         79 |
    store   $f2, [$i1 + 1]              # |         79 |         79 |
    load    [$i7 + 4], $i2              # |         79 |         79 |
    load    [$i2 + 1], $f2              # |         79 |         79 |
    fmul_n  $f2, $f1, $f2               # |         79 |         79 |
    store   $f2, [$i1 + 2]              # |         79 |         79 |
    load    [$i7 + 4], $i2              # |         79 |         79 |
    load    [$i2 + 2], $f2              # |         79 |         79 |
    fmul_n  $f2, $f1, $f1               # |         79 |         79 |
    store   $f1, [$i1 + 3]              # |         79 |         79 |
    store   $i1, [$tmp + 0]             # |         79 |         79 |
.count b_cont
    b       be_cont.33083               # |         79 |         79 |
be_else.33083:
    li      5, $i2
    call    ext_create_array_float
    load    [$i7 + 3], $i2
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f1
    load    [$i8 + 1], $f2
    load    [$i8 + 2], $f3
    fmul    $f1, $f1, $f4
    load    [$i3 + 0], $f5
    fmul    $f4, $f5, $f4
    fmul    $f2, $f2, $f5
    load    [$i9 + 1], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    bne     $i2, 0, be_else.33085
be_then.33085:
    mov     $f4, $f1
.count b_cont
    b       be_cont.33085
be_else.33085:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.33085:
    store   $f1, [$i1 + 0]
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 1], $f3
    load    [$i9 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i8 + 2], $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
.count storer
    add     $i5, $i4, $tmp
    bne     $i2, 0, be_else.33086
be_then.33086:
    store   $f2, [$i1 + 1]
    store   $f4, [$i1 + 2]
    store   $f6, [$i1 + 3]
    bne     $f1, $f0, be_else.33087
be_then.33087:
    store   $i1, [$tmp + 0]
.count b_cont
    b       be_cont.33086
be_else.33087:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
.count b_cont
    b       be_cont.33086
be_else.33086:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.33088
be_then.33088:
    store   $i1, [$tmp + 0]
.count b_cont
    b       be_cont.33088
be_else.33088:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
be_cont.33088:
be_cont.33086:
be_cont.33083:
    sub     $i4, 1, $i5                 # |        147 |        147 |
.count move_args
    mov     $i6, $i4                    # |        147 |        147 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |        147 |        147 |
    sub     $i12, 1, $i12               # |        147 |        147 |
    b       init_dirvec_constants.3044  # |        147 |        147 |
bge_else.33066:
    sub     $i12, 1, $i12
    b       init_dirvec_constants.3044
bge_else.33065:
    jr      $ra2                        # |          1 |          1 |
bge_else.33064:
    jr      $ra2                        # |          1 |          1 |
bge_else.33040:
    jr      $ra2                        # |          1 |          1 |
bge_else.33016:
    jr      $ra2                        # |          2 |          2 |
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i13)
# $ra = $ra3
# [$i1 - $i13]
# [$f1 - $f8]
# []
# []
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
    bl      $i13, 0, bge_else.33089     # |          2 |          2 |
bge_then.33089:
    sub     $ig0, 1, $i4                # |          1 |          1 |
    load    [ext_dirvecs + $i13], $i11  # |          1 |          1 |
    load    [$i11 + 119], $i6           # |          1 |          1 |
    bl      $i4, 0, bge_cont.33090      # |          1 |          1 |
bge_then.33090:
    load    [$i6 + 1], $i5              # |          1 |          1 |
    load    [ext_objects + $i4], $i7    # |          1 |          1 |
    load    [$i7 + 1], $i1              # |          1 |          1 |
    load    [$i6 + 0], $i8              # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i1, 1, be_else.33091       # |          1 |          1 |
be_then.33091:
    li      6, $i2
    call    ext_create_array_float
    load    [$i8 + 0], $f1
    bne     $f1, $f0, be_else.33092
be_then.33092:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.33092
be_else.33092:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33093
ble_then.33093:
    li      0, $i3
.count b_cont
    b       ble_cont.33093
ble_else.33093:
    li      1, $i3
ble_cont.33093:
    bne     $i2, 0, be_else.33094
be_then.33094:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33094
be_else.33094:
    bne     $i3, 0, be_else.33095
be_then.33095:
    li      1, $i2
.count b_cont
    b       be_cont.33095
be_else.33095:
    li      0, $i2
be_cont.33095:
be_cont.33094:
    load    [$i7 + 4], $i3
    load    [$i3 + 0], $f1
    bne     $i2, 0, be_else.33096
be_then.33096:
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
.count b_cont
    b       be_cont.33096
be_else.33096:
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
be_cont.33096:
be_cont.33092:
    load    [$i8 + 1], $f1
    bne     $f1, $f0, be_else.33097
be_then.33097:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.33097
be_else.33097:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33098
ble_then.33098:
    li      0, $i3
.count b_cont
    b       ble_cont.33098
ble_else.33098:
    li      1, $i3
ble_cont.33098:
    bne     $i2, 0, be_else.33099
be_then.33099:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33099
be_else.33099:
    bne     $i3, 0, be_else.33100
be_then.33100:
    li      1, $i2
.count b_cont
    b       be_cont.33100
be_else.33100:
    li      0, $i2
be_cont.33100:
be_cont.33099:
    load    [$i7 + 4], $i3
    load    [$i3 + 1], $f1
    bne     $i2, 0, be_else.33101
be_then.33101:
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
.count b_cont
    b       be_cont.33101
be_else.33101:
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
be_cont.33101:
be_cont.33097:
    load    [$i8 + 2], $f1
    bne     $f1, $f0, be_else.33102
be_then.33102:
    store   $f0, [$i1 + 5]
.count storer
    add     $i5, $i4, $tmp
    store   $i1, [$tmp + 0]
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33091
be_else.33102:
    load    [$i7 + 6], $i2
    load    [$i7 + 4], $i3
    bg      $f0, $f1, ble_else.33103
ble_then.33103:
    li      0, $i7
.count b_cont
    b       ble_cont.33103
ble_else.33103:
    li      1, $i7
ble_cont.33103:
    bne     $i2, 0, be_else.33104
be_then.33104:
    mov     $i7, $i2
.count b_cont
    b       be_cont.33104
be_else.33104:
    bne     $i7, 0, be_else.33105
be_then.33105:
    li      1, $i2
.count b_cont
    b       be_cont.33105
be_else.33105:
    li      0, $i2
be_cont.33105:
be_cont.33104:
    load    [$i3 + 2], $f1
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33106
be_then.33106:
    fneg    $f1, $f1
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33091
be_else.33106:
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33091
be_else.33091:
    bne     $i1, 2, be_else.33107       # |          1 |          1 |
be_then.33107:
    li      4, $i2                      # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    load    [$i7 + 4], $i2              # |          1 |          1 |
    load    [$i7 + 4], $i3              # |          1 |          1 |
    load    [$i7 + 4], $i9              # |          1 |          1 |
    load    [$i8 + 0], $f1              # |          1 |          1 |
    load    [$i2 + 0], $f2              # |          1 |          1 |
    fmul    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i8 + 1], $f2              # |          1 |          1 |
    load    [$i3 + 1], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i8 + 2], $f2              # |          1 |          1 |
    load    [$i9 + 2], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
.count storer
    add     $i5, $i4, $tmp              # |          1 |          1 |
    sub     $i4, 1, $i5                 # |          1 |          1 |
.count move_args
    mov     $i6, $i4                    # |          1 |          1 |
    bg      $f1, $f0, ble_else.33108    # |          1 |          1 |
ble_then.33108:
    store   $f0, [$i1 + 0]              # |          1 |          1 |
    store   $i1, [$tmp + 0]             # |          1 |          1 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |          1 |          1 |
.count b_cont
    b       be_cont.33107               # |          1 |          1 |
ble_else.33108:
    finv    $f1, $f1
    fneg    $f1, $f2
    store   $f2, [$i1 + 0]
    load    [$i7 + 4], $i2
    load    [$i2 + 0], $f2
    fmul_n  $f2, $f1, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 4], $i2
    load    [$i2 + 1], $f2
    fmul_n  $f2, $f1, $f2
    store   $f2, [$i1 + 2]
    load    [$i7 + 4], $i2
    load    [$i2 + 2], $f2
    fmul_n  $f2, $f1, $f1
    store   $f1, [$i1 + 3]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33107
be_else.33107:
    li      5, $i2
    call    ext_create_array_float
    load    [$i7 + 3], $i2
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f1
    load    [$i8 + 1], $f2
    load    [$i8 + 2], $f3
    fmul    $f1, $f1, $f4
    load    [$i3 + 0], $f5
    fmul    $f4, $f5, $f4
    fmul    $f2, $f2, $f5
    load    [$i9 + 1], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    bne     $i2, 0, be_else.33109
be_then.33109:
    mov     $f4, $f1
.count b_cont
    b       be_cont.33109
be_else.33109:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.33109:
    store   $f1, [$i1 + 0]
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 1], $f3
    load    [$i9 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i8 + 2], $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33110
be_then.33110:
    store   $f2, [$i1 + 1]
    store   $f4, [$i1 + 2]
    store   $f6, [$i1 + 3]
    bne     $f1, $f0, be_else.33111
be_then.33111:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33110
be_else.33111:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33110
be_else.33110:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.33112
be_then.33112:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33112
be_else.33112:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
be_cont.33112:
be_cont.33110:
be_cont.33107:
be_cont.33091:
bge_cont.33090:
    sub     $ig0, 1, $i5                # |          1 |          1 |
    load    [$i11 + 118], $i4           # |          1 |          1 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |          1 |          1 |
    sub     $ig0, 1, $i4                # |          1 |          1 |
    load    [$i11 + 117], $i6           # |          1 |          1 |
    bl      $i4, 0, bge_cont.33113      # |          1 |          1 |
bge_then.33113:
    load    [$i6 + 1], $i5              # |          1 |          1 |
    load    [ext_objects + $i4], $i7    # |          1 |          1 |
    load    [$i7 + 1], $i1              # |          1 |          1 |
    load    [$i6 + 0], $i8              # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i1, 1, be_else.33114       # |          1 |          1 |
be_then.33114:
    li      6, $i2
    call    ext_create_array_float
    load    [$i8 + 0], $f1
    bne     $f1, $f0, be_else.33115
be_then.33115:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.33115
be_else.33115:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33116
ble_then.33116:
    li      0, $i3
.count b_cont
    b       ble_cont.33116
ble_else.33116:
    li      1, $i3
ble_cont.33116:
    bne     $i2, 0, be_else.33117
be_then.33117:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33117
be_else.33117:
    bne     $i3, 0, be_else.33118
be_then.33118:
    li      1, $i2
.count b_cont
    b       be_cont.33118
be_else.33118:
    li      0, $i2
be_cont.33118:
be_cont.33117:
    load    [$i7 + 4], $i3
    load    [$i3 + 0], $f1
    bne     $i2, 0, be_else.33119
be_then.33119:
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
.count b_cont
    b       be_cont.33119
be_else.33119:
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
be_cont.33119:
be_cont.33115:
    load    [$i8 + 1], $f1
    bne     $f1, $f0, be_else.33120
be_then.33120:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.33120
be_else.33120:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33121
ble_then.33121:
    li      0, $i3
.count b_cont
    b       ble_cont.33121
ble_else.33121:
    li      1, $i3
ble_cont.33121:
    bne     $i2, 0, be_else.33122
be_then.33122:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33122
be_else.33122:
    bne     $i3, 0, be_else.33123
be_then.33123:
    li      1, $i2
.count b_cont
    b       be_cont.33123
be_else.33123:
    li      0, $i2
be_cont.33123:
be_cont.33122:
    load    [$i7 + 4], $i3
    load    [$i3 + 1], $f1
    bne     $i2, 0, be_else.33124
be_then.33124:
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
.count b_cont
    b       be_cont.33124
be_else.33124:
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
be_cont.33124:
be_cont.33120:
    load    [$i8 + 2], $f1
    bne     $f1, $f0, be_else.33125
be_then.33125:
    store   $f0, [$i1 + 5]
.count storer
    add     $i5, $i4, $tmp
    store   $i1, [$tmp + 0]
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33114
be_else.33125:
    load    [$i7 + 6], $i2
    load    [$i7 + 4], $i3
    bg      $f0, $f1, ble_else.33126
ble_then.33126:
    li      0, $i7
.count b_cont
    b       ble_cont.33126
ble_else.33126:
    li      1, $i7
ble_cont.33126:
    bne     $i2, 0, be_else.33127
be_then.33127:
    mov     $i7, $i2
.count b_cont
    b       be_cont.33127
be_else.33127:
    bne     $i7, 0, be_else.33128
be_then.33128:
    li      1, $i2
.count b_cont
    b       be_cont.33128
be_else.33128:
    li      0, $i2
be_cont.33128:
be_cont.33127:
    load    [$i3 + 2], $f1
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33129
be_then.33129:
    fneg    $f1, $f1
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33114
be_else.33129:
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33114
be_else.33114:
    bne     $i1, 2, be_else.33130       # |          1 |          1 |
be_then.33130:
    li      4, $i2                      # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    load    [$i7 + 4], $i2              # |          1 |          1 |
    load    [$i7 + 4], $i3              # |          1 |          1 |
    load    [$i7 + 4], $i9              # |          1 |          1 |
    load    [$i8 + 0], $f1              # |          1 |          1 |
    load    [$i2 + 0], $f2              # |          1 |          1 |
    fmul    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i8 + 1], $f2              # |          1 |          1 |
    load    [$i3 + 1], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i8 + 2], $f2              # |          1 |          1 |
    load    [$i9 + 2], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
.count storer
    add     $i5, $i4, $tmp              # |          1 |          1 |
    sub     $i4, 1, $i5                 # |          1 |          1 |
.count move_args
    mov     $i6, $i4                    # |          1 |          1 |
    bg      $f1, $f0, ble_else.33131    # |          1 |          1 |
ble_then.33131:
    store   $f0, [$i1 + 0]              # |          1 |          1 |
    store   $i1, [$tmp + 0]             # |          1 |          1 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |          1 |          1 |
.count b_cont
    b       be_cont.33130               # |          1 |          1 |
ble_else.33131:
    finv    $f1, $f1
    fneg    $f1, $f2
    store   $f2, [$i1 + 0]
    load    [$i7 + 4], $i2
    load    [$i2 + 0], $f2
    fmul_n  $f2, $f1, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 4], $i2
    load    [$i2 + 1], $f2
    fmul_n  $f2, $f1, $f2
    store   $f2, [$i1 + 2]
    load    [$i7 + 4], $i2
    load    [$i2 + 2], $f2
    fmul_n  $f2, $f1, $f1
    store   $f1, [$i1 + 3]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33130
be_else.33130:
    li      5, $i2
    call    ext_create_array_float
    load    [$i7 + 3], $i2
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f1
    load    [$i8 + 1], $f2
    load    [$i8 + 2], $f3
    fmul    $f1, $f1, $f4
    load    [$i3 + 0], $f5
    fmul    $f4, $f5, $f4
    fmul    $f2, $f2, $f5
    load    [$i9 + 1], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    bne     $i2, 0, be_else.33132
be_then.33132:
    mov     $f4, $f1
.count b_cont
    b       be_cont.33132
be_else.33132:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.33132:
    store   $f1, [$i1 + 0]
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 1], $f3
    load    [$i9 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i8 + 2], $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33133
be_then.33133:
    store   $f2, [$i1 + 1]
    store   $f4, [$i1 + 2]
    store   $f6, [$i1 + 3]
    bne     $f1, $f0, be_else.33134
be_then.33134:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33133
be_else.33134:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33133
be_else.33133:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.33135
be_then.33135:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33135
be_else.33135:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
be_cont.33135:
be_cont.33133:
be_cont.33130:
be_cont.33114:
bge_cont.33113:
    li      116, $i12                   # |          1 |          1 |
    jal     init_dirvec_constants.3044, $ra2# |          1 |          1 |
    sub     $i13, 1, $i13               # |          1 |          1 |
    bl      $i13, 0, bge_else.33136     # |          1 |          1 |
bge_then.33136:
    sub     $ig0, 1, $i5                # |          1 |          1 |
    load    [ext_dirvecs + $i13], $i11  # |          1 |          1 |
    load    [$i11 + 119], $i4           # |          1 |          1 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |          1 |          1 |
    sub     $ig0, 1, $i4                # |          1 |          1 |
    load    [$i11 + 118], $i6           # |          1 |          1 |
    bl      $i4, 0, bge_cont.33137      # |          1 |          1 |
bge_then.33137:
    load    [$i6 + 1], $i5              # |          1 |          1 |
    load    [ext_objects + $i4], $i7    # |          1 |          1 |
    load    [$i7 + 1], $i1              # |          1 |          1 |
    load    [$i6 + 0], $i8              # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i1, 1, be_else.33138       # |          1 |          1 |
be_then.33138:
    li      6, $i2
    call    ext_create_array_float
    load    [$i8 + 0], $f1
    bne     $f1, $f0, be_else.33139
be_then.33139:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.33139
be_else.33139:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33140
ble_then.33140:
    li      0, $i3
.count b_cont
    b       ble_cont.33140
ble_else.33140:
    li      1, $i3
ble_cont.33140:
    bne     $i2, 0, be_else.33141
be_then.33141:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33141
be_else.33141:
    bne     $i3, 0, be_else.33142
be_then.33142:
    li      1, $i2
.count b_cont
    b       be_cont.33142
be_else.33142:
    li      0, $i2
be_cont.33142:
be_cont.33141:
    load    [$i7 + 4], $i3
    load    [$i3 + 0], $f1
    bne     $i2, 0, be_else.33143
be_then.33143:
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
.count b_cont
    b       be_cont.33143
be_else.33143:
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
be_cont.33143:
be_cont.33139:
    load    [$i8 + 1], $f1
    bne     $f1, $f0, be_else.33144
be_then.33144:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.33144
be_else.33144:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33145
ble_then.33145:
    li      0, $i3
.count b_cont
    b       ble_cont.33145
ble_else.33145:
    li      1, $i3
ble_cont.33145:
    bne     $i2, 0, be_else.33146
be_then.33146:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33146
be_else.33146:
    bne     $i3, 0, be_else.33147
be_then.33147:
    li      1, $i2
.count b_cont
    b       be_cont.33147
be_else.33147:
    li      0, $i2
be_cont.33147:
be_cont.33146:
    load    [$i7 + 4], $i3
    load    [$i3 + 1], $f1
    bne     $i2, 0, be_else.33148
be_then.33148:
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
.count b_cont
    b       be_cont.33148
be_else.33148:
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
be_cont.33148:
be_cont.33144:
    load    [$i8 + 2], $f1
    bne     $f1, $f0, be_else.33149
be_then.33149:
    store   $f0, [$i1 + 5]
.count storer
    add     $i5, $i4, $tmp
    store   $i1, [$tmp + 0]
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33138
be_else.33149:
    load    [$i7 + 6], $i2
    load    [$i7 + 4], $i3
    bg      $f0, $f1, ble_else.33150
ble_then.33150:
    li      0, $i7
.count b_cont
    b       ble_cont.33150
ble_else.33150:
    li      1, $i7
ble_cont.33150:
    bne     $i2, 0, be_else.33151
be_then.33151:
    mov     $i7, $i2
.count b_cont
    b       be_cont.33151
be_else.33151:
    bne     $i7, 0, be_else.33152
be_then.33152:
    li      1, $i2
.count b_cont
    b       be_cont.33152
be_else.33152:
    li      0, $i2
be_cont.33152:
be_cont.33151:
    load    [$i3 + 2], $f1
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33153
be_then.33153:
    fneg    $f1, $f1
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33138
be_else.33153:
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33138
be_else.33138:
    bne     $i1, 2, be_else.33154       # |          1 |          1 |
be_then.33154:
    li      4, $i2                      # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    load    [$i7 + 4], $i2              # |          1 |          1 |
    load    [$i7 + 4], $i3              # |          1 |          1 |
    load    [$i7 + 4], $i9              # |          1 |          1 |
    load    [$i8 + 0], $f1              # |          1 |          1 |
    load    [$i2 + 0], $f2              # |          1 |          1 |
    fmul    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i8 + 1], $f2              # |          1 |          1 |
    load    [$i3 + 1], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i8 + 2], $f2              # |          1 |          1 |
    load    [$i9 + 2], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
.count storer
    add     $i5, $i4, $tmp              # |          1 |          1 |
    sub     $i4, 1, $i5                 # |          1 |          1 |
.count move_args
    mov     $i6, $i4                    # |          1 |          1 |
    bg      $f1, $f0, ble_else.33155    # |          1 |          1 |
ble_then.33155:
    store   $f0, [$i1 + 0]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33154
ble_else.33155:
    finv    $f1, $f1                    # |          1 |          1 |
    fneg    $f1, $f2                    # |          1 |          1 |
    store   $f2, [$i1 + 0]              # |          1 |          1 |
    load    [$i7 + 4], $i2              # |          1 |          1 |
    load    [$i2 + 0], $f2              # |          1 |          1 |
    fmul_n  $f2, $f1, $f2               # |          1 |          1 |
    store   $f2, [$i1 + 1]              # |          1 |          1 |
    load    [$i7 + 4], $i2              # |          1 |          1 |
    load    [$i2 + 1], $f2              # |          1 |          1 |
    fmul_n  $f2, $f1, $f2               # |          1 |          1 |
    store   $f2, [$i1 + 2]              # |          1 |          1 |
    load    [$i7 + 4], $i2              # |          1 |          1 |
    load    [$i2 + 2], $f2              # |          1 |          1 |
    fmul_n  $f2, $f1, $f1               # |          1 |          1 |
    store   $f1, [$i1 + 3]              # |          1 |          1 |
    store   $i1, [$tmp + 0]             # |          1 |          1 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |          1 |          1 |
.count b_cont
    b       be_cont.33154               # |          1 |          1 |
be_else.33154:
    li      5, $i2
    call    ext_create_array_float
    load    [$i7 + 3], $i2
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f1
    load    [$i8 + 1], $f2
    load    [$i8 + 2], $f3
    fmul    $f1, $f1, $f4
    load    [$i3 + 0], $f5
    fmul    $f4, $f5, $f4
    fmul    $f2, $f2, $f5
    load    [$i9 + 1], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    bne     $i2, 0, be_else.33156
be_then.33156:
    mov     $f4, $f1
.count b_cont
    b       be_cont.33156
be_else.33156:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.33156:
    store   $f1, [$i1 + 0]
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 1], $f3
    load    [$i9 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i8 + 2], $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33157
be_then.33157:
    store   $f2, [$i1 + 1]
    store   $f4, [$i1 + 2]
    store   $f6, [$i1 + 3]
    bne     $f1, $f0, be_else.33158
be_then.33158:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33157
be_else.33158:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33157
be_else.33157:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.33159
be_then.33159:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33159
be_else.33159:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
be_cont.33159:
be_cont.33157:
be_cont.33154:
be_cont.33138:
bge_cont.33137:
    li      117, $i12                   # |          1 |          1 |
    jal     init_dirvec_constants.3044, $ra2# |          1 |          1 |
    sub     $i13, 1, $i13               # |          1 |          1 |
    bl      $i13, 0, bge_else.33160     # |          1 |          1 |
bge_then.33160:
    sub     $ig0, 1, $i4                # |          1 |          1 |
    load    [ext_dirvecs + $i13], $i11  # |          1 |          1 |
    load    [$i11 + 119], $i6           # |          1 |          1 |
    bl      $i4, 0, bge_cont.33161      # |          1 |          1 |
bge_then.33161:
    load    [$i6 + 1], $i5              # |          1 |          1 |
    load    [ext_objects + $i4], $i7    # |          1 |          1 |
    load    [$i7 + 1], $i1              # |          1 |          1 |
    load    [$i6 + 0], $i8              # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i1, 1, be_else.33162       # |          1 |          1 |
be_then.33162:
    li      6, $i2
    call    ext_create_array_float
    load    [$i8 + 0], $f1
    bne     $f1, $f0, be_else.33163
be_then.33163:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.33163
be_else.33163:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33164
ble_then.33164:
    li      0, $i3
.count b_cont
    b       ble_cont.33164
ble_else.33164:
    li      1, $i3
ble_cont.33164:
    bne     $i2, 0, be_else.33165
be_then.33165:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33165
be_else.33165:
    bne     $i3, 0, be_else.33166
be_then.33166:
    li      1, $i2
.count b_cont
    b       be_cont.33166
be_else.33166:
    li      0, $i2
be_cont.33166:
be_cont.33165:
    load    [$i7 + 4], $i3
    load    [$i3 + 0], $f1
    bne     $i2, 0, be_else.33167
be_then.33167:
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
.count b_cont
    b       be_cont.33167
be_else.33167:
    store   $f1, [$i1 + 0]
    load    [$i8 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
be_cont.33167:
be_cont.33163:
    load    [$i8 + 1], $f1
    bne     $f1, $f0, be_else.33168
be_then.33168:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.33168
be_else.33168:
    load    [$i7 + 6], $i2
    bg      $f0, $f1, ble_else.33169
ble_then.33169:
    li      0, $i3
.count b_cont
    b       ble_cont.33169
ble_else.33169:
    li      1, $i3
ble_cont.33169:
    bne     $i2, 0, be_else.33170
be_then.33170:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33170
be_else.33170:
    bne     $i3, 0, be_else.33171
be_then.33171:
    li      1, $i2
.count b_cont
    b       be_cont.33171
be_else.33171:
    li      0, $i2
be_cont.33171:
be_cont.33170:
    load    [$i7 + 4], $i3
    load    [$i3 + 1], $f1
    bne     $i2, 0, be_else.33172
be_then.33172:
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
.count b_cont
    b       be_cont.33172
be_else.33172:
    store   $f1, [$i1 + 2]
    load    [$i8 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
be_cont.33172:
be_cont.33168:
    load    [$i8 + 2], $f1
    bne     $f1, $f0, be_else.33173
be_then.33173:
    store   $f0, [$i1 + 5]
.count storer
    add     $i5, $i4, $tmp
    store   $i1, [$tmp + 0]
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33162
be_else.33173:
    load    [$i7 + 6], $i2
    load    [$i7 + 4], $i3
    bg      $f0, $f1, ble_else.33174
ble_then.33174:
    li      0, $i7
.count b_cont
    b       ble_cont.33174
ble_else.33174:
    li      1, $i7
ble_cont.33174:
    bne     $i2, 0, be_else.33175
be_then.33175:
    mov     $i7, $i2
.count b_cont
    b       be_cont.33175
be_else.33175:
    bne     $i7, 0, be_else.33176
be_then.33176:
    li      1, $i2
.count b_cont
    b       be_cont.33176
be_else.33176:
    li      0, $i2
be_cont.33176:
be_cont.33175:
    load    [$i3 + 2], $f1
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33177
be_then.33177:
    fneg    $f1, $f1
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33162
be_else.33177:
    store   $f1, [$i1 + 4]
    load    [$i8 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33162
be_else.33162:
    bne     $i1, 2, be_else.33178       # |          1 |          1 |
be_then.33178:
    li      4, $i2                      # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    load    [$i7 + 4], $i2              # |          1 |          1 |
    load    [$i7 + 4], $i3              # |          1 |          1 |
    load    [$i7 + 4], $i9              # |          1 |          1 |
    load    [$i8 + 0], $f1              # |          1 |          1 |
    load    [$i2 + 0], $f2              # |          1 |          1 |
    fmul    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i8 + 1], $f2              # |          1 |          1 |
    load    [$i3 + 1], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i8 + 2], $f2              # |          1 |          1 |
    load    [$i9 + 2], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
.count storer
    add     $i5, $i4, $tmp              # |          1 |          1 |
    sub     $i4, 1, $i5                 # |          1 |          1 |
.count move_args
    mov     $i6, $i4                    # |          1 |          1 |
    bg      $f1, $f0, ble_else.33179    # |          1 |          1 |
ble_then.33179:
    store   $f0, [$i1 + 0]              # |          1 |          1 |
    store   $i1, [$tmp + 0]             # |          1 |          1 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |          1 |          1 |
.count b_cont
    b       be_cont.33178               # |          1 |          1 |
ble_else.33179:
    finv    $f1, $f1
    fneg    $f1, $f2
    store   $f2, [$i1 + 0]
    load    [$i7 + 4], $i2
    load    [$i2 + 0], $f2
    fmul_n  $f2, $f1, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 4], $i2
    load    [$i2 + 1], $f2
    fmul_n  $f2, $f1, $f2
    store   $f2, [$i1 + 2]
    load    [$i7 + 4], $i2
    load    [$i2 + 2], $f2
    fmul_n  $f2, $f1, $f1
    store   $f1, [$i1 + 3]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33178
be_else.33178:
    li      5, $i2
    call    ext_create_array_float
    load    [$i7 + 3], $i2
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f1
    load    [$i8 + 1], $f2
    load    [$i8 + 2], $f3
    fmul    $f1, $f1, $f4
    load    [$i3 + 0], $f5
    fmul    $f4, $f5, $f4
    fmul    $f2, $f2, $f5
    load    [$i9 + 1], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    bne     $i2, 0, be_else.33180
be_then.33180:
    mov     $f4, $f1
.count b_cont
    b       be_cont.33180
be_else.33180:
    fmul    $f2, $f3, $f5
    load    [$i7 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i7 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.33180:
    store   $f1, [$i1 + 0]
    load    [$i7 + 4], $i3
    load    [$i7 + 4], $i9
    load    [$i7 + 4], $i10
    load    [$i8 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 1], $f3
    load    [$i9 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i8 + 2], $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
.count storer
    add     $i5, $i4, $tmp
    sub     $i4, 1, $i5
.count move_args
    mov     $i6, $i4
    bne     $i2, 0, be_else.33181
be_then.33181:
    store   $f2, [$i1 + 1]
    store   $f4, [$i1 + 2]
    store   $f6, [$i1 + 3]
    bne     $f1, $f0, be_else.33182
be_then.33182:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33181
be_else.33182:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33181
be_else.33181:
    load    [$i7 + 9], $i2
    load    [$i7 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i7 + 9], $i2
    load    [$i8 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i8 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i8 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.33183
be_then.33183:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33183
be_else.33183:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
be_cont.33183:
be_cont.33181:
be_cont.33178:
be_cont.33162:
bge_cont.33161:
    li      118, $i12                   # |          1 |          1 |
    jal     init_dirvec_constants.3044, $ra2# |          1 |          1 |
    sub     $i13, 1, $i13               # |          1 |          1 |
    bl      $i13, 0, bge_else.33184     # |          1 |          1 |
bge_then.33184:
    load    [ext_dirvecs + $i13], $i11  # |          1 |          1 |
    li      119, $i12                   # |          1 |          1 |
    jal     init_dirvec_constants.3044, $ra2# |          1 |          1 |
    sub     $i13, 1, $i13               # |          1 |          1 |
    b       init_vecset_constants.3047  # |          1 |          1 |
bge_else.33184:
    jr      $ra3
bge_else.33160:
    jr      $ra3
bge_else.33136:
    jr      $ra3
bge_else.33089:
    jr      $ra3                        # |          1 |          1 |
.end init_vecset_constants

######################################################################
# setup_reflections($i11)
# $ra = $ra2
# [$i1 - $i13]
# [$f1 - $f12]
# [$ig4]
# []
######################################################################
.begin setup_reflections
setup_reflections.3064:
    bl      $i11, 0, bge_else.33185     # |          1 |          1 |
bge_then.33185:
    load    [ext_objects + $i11], $i1   # |          1 |          1 |
    load    [$i1 + 2], $i2              # |          1 |          1 |
    bne     $i2, 2, be_else.33186       # |          1 |          1 |
be_then.33186:
    load    [$i1 + 7], $i2              # |          1 |          1 |
    load    [$i2 + 0], $f9              # |          1 |          1 |
    bg      $fc0, $f9, ble_else.33187   # |          1 |          1 |
ble_then.33187:
    jr      $ra2
ble_else.33187:
    load    [$i1 + 1], $i2              # |          1 |          1 |
    bne     $i2, 1, be_else.33188       # |          1 |          1 |
be_then.33188:
    load    [$i1 + 7], $i12
    li      3, $i2
.count move_args
    mov     $f0, $f2
    call    ext_create_array_float
.count move_ret
    mov     $i1, $i4
.count move_args
    mov     $ig0, $i2
.count move_args
    mov     $i4, $i3
    call    ext_create_array_int
    store   $fg12, [$i4 + 0]
    fneg    $fg13, $f9
    store   $f9, [$i4 + 1]
    fneg    $fg14, $f10
    store   $f10, [$i4 + 2]
    sub     $ig0, 1, $i5
    mov     $hp, $i13
    add     $hp, 2, $hp
    store   $i1, [$i13 + 1]
    store   $i4, [$i13 + 0]
.count move_args
    mov     $i13, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
    add     $i11, $i11, $i1
    add     $i1, $i1, $i11
    add     $i11, 1, $i1
    load    [$i12 + 0], $f1
    fsub    $fc0, $f1, $f11
    mov     $hp, $i2
    add     $hp, 3, $hp
    store   $f11, [$i2 + 2]
    store   $i13, [$i2 + 1]
    store   $i1, [$i2 + 0]
    store   $i2, [ext_reflections + $ig4]
    li      3, $i2
.count move_args
    mov     $f0, $f2
    call    ext_create_array_float
.count move_ret
    mov     $i1, $i4
.count move_args
    mov     $ig0, $i2
.count move_args
    mov     $i4, $i3
    call    ext_create_array_int
    fneg    $fg12, $f12
    store   $f12, [$i4 + 0]
    store   $fg13, [$i4 + 1]
    store   $f10, [$i4 + 2]
    sub     $ig0, 1, $i5
    mov     $hp, $i12
    add     $hp, 2, $hp
    store   $i1, [$i12 + 1]
    store   $i4, [$i12 + 0]
.count move_args
    mov     $i12, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
    add     $ig4, 1, $i1
    add     $i11, 2, $i2
    mov     $hp, $i3
    add     $hp, 3, $hp
    store   $f11, [$i3 + 2]
    store   $i12, [$i3 + 1]
    store   $i2, [$i3 + 0]
    store   $i3, [ext_reflections + $i1]
    li      3, $i2
.count move_args
    mov     $f0, $f2
    call    ext_create_array_float
.count move_ret
    mov     $i1, $i4
.count move_args
    mov     $ig0, $i2
.count move_args
    mov     $i4, $i3
    call    ext_create_array_int
    store   $f12, [$i4 + 0]
    store   $f9, [$i4 + 1]
    store   $fg14, [$i4 + 2]
    sub     $ig0, 1, $i5
    mov     $hp, $i12
    add     $hp, 2, $hp
    store   $i1, [$i12 + 1]
    store   $i4, [$i12 + 0]
.count move_args
    mov     $i12, $i4
    jal     iter_setup_dirvec_constants.2826, $ra1
    add     $ig4, 2, $i1
    add     $i11, 3, $i2
    mov     $hp, $i3
    add     $hp, 3, $hp
    store   $f11, [$i3 + 2]
    store   $i12, [$i3 + 1]
    store   $i2, [$i3 + 0]
    store   $i3, [ext_reflections + $i1]
    add     $ig4, 3, $ig4
    jr      $ra2
be_else.33188:
    bne     $i2, 2, be_else.33189       # |          1 |          1 |
be_then.33189:
    load    [$i1 + 4], $i4              # |          1 |          1 |
    load    [$i1 + 4], $i5              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
.count move_ret
    mov     $i1, $i6                    # |          1 |          1 |
.count move_args
    mov     $ig0, $i2                   # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
    load    [$i4 + 0], $f1              # |          1 |          1 |
    fmul    $fc10, $f1, $f2             # |          1 |          1 |
    fmul    $fg12, $f1, $f1             # |          1 |          1 |
    load    [$i5 + 1], $f3              # |          1 |          1 |
    fmul    $fg13, $f3, $f4             # |          1 |          1 |
    fadd    $f1, $f4, $f1               # |          1 |          1 |
    load    [$i5 + 2], $f4              # |          1 |          1 |
    fmul    $fg14, $f4, $f5             # |          1 |          1 |
    fadd    $f1, $f5, $f1               # |          1 |          1 |
    fmul    $f2, $f1, $f2               # |          1 |          1 |
    fsub    $f2, $fg12, $f2             # |          1 |          1 |
    store   $f2, [$i6 + 0]              # |          1 |          1 |
    fmul    $fc10, $f3, $f2             # |          1 |          1 |
    fmul    $f2, $f1, $f2               # |          1 |          1 |
    fsub    $f2, $fg13, $f2             # |          1 |          1 |
    store   $f2, [$i6 + 1]              # |          1 |          1 |
    fmul    $fc10, $f4, $f2             # |          1 |          1 |
    fmul    $f2, $f1, $f1               # |          1 |          1 |
    fsub    $f1, $fg14, $f1             # |          1 |          1 |
    store   $f1, [$i6 + 2]              # |          1 |          1 |
    sub     $ig0, 1, $i5                # |          1 |          1 |
    mov     $hp, $i12                   # |          1 |          1 |
    add     $hp, 2, $hp                 # |          1 |          1 |
    store   $i1, [$i12 + 1]             # |          1 |          1 |
    store   $i6, [$i12 + 0]             # |          1 |          1 |
.count move_args
    mov     $i12, $i4                   # |          1 |          1 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |          1 |          1 |
    fsub    $fc0, $f9, $f1              # |          1 |          1 |
    add     $i11, $i11, $i1             # |          1 |          1 |
    add     $i1, $i1, $i1               # |          1 |          1 |
    add     $i1, 1, $i1                 # |          1 |          1 |
    mov     $hp, $i2                    # |          1 |          1 |
    add     $hp, 3, $hp                 # |          1 |          1 |
    store   $f1, [$i2 + 2]              # |          1 |          1 |
    store   $i12, [$i2 + 1]             # |          1 |          1 |
    store   $i1, [$i2 + 0]              # |          1 |          1 |
    store   $i2, [ext_reflections + $ig4]# |          1 |          1 |
    add     $ig4, 1, $ig4               # |          1 |          1 |
    jr      $ra2                        # |          1 |          1 |
be_else.33189:
    jr      $ra2
be_else.33186:
    jr      $ra2
bge_else.33185:
    jr      $ra2
.end setup_reflections

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i42]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
######################################################################
.begin main
ext_main:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |          1 |          1 |
.count stack_move
    sub     $sp, 1, $sp                 # |          1 |          1 |
    load    [ext_n_objects + 0], $ig0   # |          1 |          1 |
    load    [ext_solver_dist + 0], $fg0 # |          1 |          1 |
    load    [ext_diffuse_ray + 0], $fg1 # |          1 |          1 |
    load    [ext_diffuse_ray + 1], $fg2 # |          1 |          1 |
    load    [ext_diffuse_ray + 2], $fg3 # |          1 |          1 |
    load    [ext_rgb + 0], $fg4         # |          1 |          1 |
    load    [ext_rgb + 1], $fg5         # |          1 |          1 |
    load    [ext_rgb + 2], $fg6         # |          1 |          1 |
    load    [ext_tmin + 0], $fg7        # |          1 |          1 |
    load    [ext_startp_fast + 0], $fg8 # |          1 |          1 |
    load    [ext_startp_fast + 1], $fg9 # |          1 |          1 |
    load    [ext_startp_fast + 2], $fg10# |          1 |          1 |
    load    [ext_texture_color + 1], $fg11# |          1 |          1 |
    load    [ext_light + 0], $fg12      # |          1 |          1 |
    load    [ext_light + 1], $fg13      # |          1 |          1 |
    load    [ext_light + 2], $fg14      # |          1 |          1 |
    load    [ext_texture_color + 2], $fg15# |          1 |          1 |
    load    [ext_or_net + 0], $ig1      # |          1 |          1 |
    load    [ext_intsec_rectside + 0], $ig2# |          1 |          1 |
    load    [ext_texture_color + 0], $fg16# |          1 |          1 |
    load    [ext_intersected_object_id + 0], $ig3# |          1 |          1 |
    load    [ext_n_reflections + 0], $ig4# |          1 |          1 |
    load    [ext_scan_pitch + 0], $fg17 # |          1 |          1 |
    load    [ext_screenz_dir + 0], $fg18# |          1 |          1 |
    load    [ext_screenz_dir + 1], $fg19# |          1 |          1 |
    load    [ext_screenz_dir + 2], $fg20# |          1 |          1 |
    load    [ext_startp + 0], $fg21     # |          1 |          1 |
    load    [ext_startp + 1], $fg22     # |          1 |          1 |
    load    [ext_startp + 2], $fg23     # |          1 |          1 |
    load    [ext_screeny_dir + 0], $fg24# |          1 |          1 |
    load    [f.31942 + 0], $fc0         # |          1 |          1 |
    load    [f.31966 + 0], $fc1         # |          1 |          1 |
    load    [f.31965 + 0], $fc2         # |          1 |          1 |
    load    [f.31943 + 0], $fc3         # |          1 |          1 |
    load    [f.31941 + 0], $fc4         # |          1 |          1 |
    load    [f.31968 + 0], $fc5         # |          1 |          1 |
    load    [f.31967 + 0], $fc6         # |          1 |          1 |
    load    [f.31946 + 0], $fc7         # |          1 |          1 |
    load    [f.31955 + 0], $fc8         # |          1 |          1 |
    load    [f.31953 + 0], $fc9         # |          1 |          1 |
    load    [f.31940 + 0], $fc10        # |          1 |          1 |
    load    [f.31997 + 0], $fc11        # |          1 |          1 |
    load    [f.31996 + 0], $fc12        # |          1 |          1 |
    load    [f.31961 + 0], $fc13        # |          1 |          1 |
    load    [f.31960 + 0], $fc14        # |          1 |          1 |
    load    [f.31950 + 0], $fc15        # |          1 |          1 |
    load    [f.31945 + 0], $fc16        # |          1 |          1 |
    load    [f.31951 + 0], $fc17        # |          1 |          1 |
    load    [f.31949 + 0], $fc18        # |          1 |          1 |
    load    [f.31948 + 0], $fc19        # |          1 |          1 |
.count load_float
    load    [f.32059], $f4              # |          1 |          1 |
    li      128, $i2                    # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    finv    $f1, $f1                    # |          1 |          1 |
    fmul    $f4, $f1, $fg17             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
.count move_ret
    mov     $i1, $i4                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i5                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 4]              # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i6                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i7                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i8                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 4]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i9                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 4]              # |          1 |          1 |
    li      1, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 1]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 2]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 3]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 4]             # |          1 |          1 |
    li      128, $i2                    # |          1 |          1 |
    mov     $hp, $i3                    # |          1 |          1 |
    add     $hp, 8, $hp                 # |          1 |          1 |
    store   $i11, [$i3 + 7]             # |          1 |          1 |
    store   $i10, [$i3 + 6]             # |          1 |          1 |
    store   $i9, [$i3 + 5]              # |          1 |          1 |
    store   $i8, [$i3 + 4]              # |          1 |          1 |
    store   $i7, [$i3 + 3]              # |          1 |          1 |
    store   $i6, [$i3 + 2]              # |          1 |          1 |
    store   $i5, [$i3 + 1]              # |          1 |          1 |
    store   $i4, [$i3 + 0]              # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    jal     create_pixel.3008, $ra1     # |          1 |          1 |
    store   $i1, [$i12 + 126]           # |          1 |          1 |
    li      125, $i4                    # |          1 |          1 |
    jal     init_line_elements.3010, $ra2# |          1 |          1 |
.count move_ret
    mov     $i1, $i38                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
.count move_ret
    mov     $i1, $i4                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i5                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 4]              # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i6                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i7                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i8                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 4]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i9                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 4]              # |          1 |          1 |
    li      1, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 1]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 2]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 3]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 4]             # |          1 |          1 |
    li      128, $i2                    # |          1 |          1 |
    mov     $hp, $i3                    # |          1 |          1 |
    add     $hp, 8, $hp                 # |          1 |          1 |
    store   $i11, [$i3 + 7]             # |          1 |          1 |
    store   $i10, [$i3 + 6]             # |          1 |          1 |
    store   $i9, [$i3 + 5]              # |          1 |          1 |
    store   $i8, [$i3 + 4]              # |          1 |          1 |
    store   $i7, [$i3 + 3]              # |          1 |          1 |
    store   $i6, [$i3 + 2]              # |          1 |          1 |
    store   $i5, [$i3 + 1]              # |          1 |          1 |
    store   $i4, [$i3 + 0]              # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    jal     create_pixel.3008, $ra1     # |          1 |          1 |
    store   $i1, [$i12 + 126]           # |          1 |          1 |
    li      125, $i4                    # |          1 |          1 |
    jal     init_line_elements.3010, $ra2# |          1 |          1 |
.count move_ret
    mov     $i1, $i39                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
.count move_ret
    mov     $i1, $i4                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i5                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i5 + 4]              # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i6                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i7                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i8                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i8 + 4]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i9                    # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 1]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 2]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 3]              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i9 + 4]              # |          1 |          1 |
    li      1, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 1]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 2]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 3]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    store   $i1, [$i11 + 4]             # |          1 |          1 |
    li      128, $i2                    # |          1 |          1 |
    mov     $hp, $i3                    # |          1 |          1 |
    add     $hp, 8, $hp                 # |          1 |          1 |
    store   $i11, [$i3 + 7]             # |          1 |          1 |
    store   $i10, [$i3 + 6]             # |          1 |          1 |
    store   $i9, [$i3 + 5]              # |          1 |          1 |
    store   $i8, [$i3 + 4]              # |          1 |          1 |
    store   $i7, [$i3 + 3]              # |          1 |          1 |
    store   $i6, [$i3 + 2]              # |          1 |          1 |
    store   $i5, [$i3 + 1]              # |          1 |          1 |
    store   $i4, [$i3 + 0]              # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    jal     create_pixel.3008, $ra1     # |          1 |          1 |
    store   $i1, [$i12 + 126]           # |          1 |          1 |
    li      125, $i4                    # |          1 |          1 |
    jal     init_line_elements.3010, $ra2# |          1 |          1 |
.count move_ret
    mov     $i1, $i40                   # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 0]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 1]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 2]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
.count load_float
    load    [f.31927], $f9              # |          1 |          1 |
    fmul    $f1, $f9, $f10              # |          1 |          1 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f11                   # |          1 |          1 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    fmul    $f1, $f9, $f12              # |          1 |          1 |
.count move_args
    mov     $f12, $f2                   # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f8                    # |          1 |          1 |
.count move_args
    mov     $f12, $f2                   # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
    fmul    $f11, $f1, $f2              # |          1 |          1 |
.count load_float
    load    [f.32087], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $fg18             # |          1 |          1 |
.count load_float
    load    [f.32088], $f2              # |          1 |          1 |
    fmul    $f10, $f2, $fg19            # |          1 |          1 |
    fmul    $f11, $f8, $f2              # |          1 |          1 |
    fmul    $f2, $f3, $fg20             # |          1 |          1 |
    store   $f8, [ext_screenx_dir + 0]  # |          1 |          1 |
    fneg    $f1, $f2                    # |          1 |          1 |
    store   $f2, [ext_screenx_dir + 2]  # |          1 |          1 |
    fneg    $f10, $f2                   # |          1 |          1 |
    fmul    $f2, $f1, $fg24             # |          1 |          1 |
    fneg    $f11, $f1                   # |          1 |          1 |
    store   $f1, [ext_screeny_dir + 1]  # |          1 |          1 |
    fmul    $f2, $f8, $f1               # |          1 |          1 |
    store   $f1, [ext_screeny_dir + 2]  # |          1 |          1 |
    load    [ext_screen + 0], $f1       # |          1 |          1 |
    fsub    $f1, $fg18, $f1             # |          1 |          1 |
    store   $f1, [ext_viewpoint + 0]    # |          1 |          1 |
    load    [ext_screen + 1], $f1       # |          1 |          1 |
    fsub    $f1, $fg19, $f1             # |          1 |          1 |
    store   $f1, [ext_viewpoint + 1]    # |          1 |          1 |
    load    [ext_screen + 2], $f1       # |          1 |          1 |
    fsub    $f1, $fg20, $f1             # |          1 |          1 |
    store   $f1, [ext_viewpoint + 2]    # |          1 |          1 |
    call    ext_read_int                # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    fmul    $f1, $f9, $f8               # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
    fneg    $f1, $fg13                  # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f11                   # |          1 |          1 |
    fmul    $f10, $f9, $f8              # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
    fmul    $f11, $f1, $fg12            # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
    fmul    $f11, $f1, $fg14            # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_beam + 0]         # |          1 |          1 |
    li      0, $i16                     # |          1 |          1 |
.count move_args
    mov     $i16, $i6                   # |          1 |          1 |
    jal     read_nth_object.2719, $ra1  # |          1 |          1 |
    bne     $i1, 0, be_else.33190       # |          1 |          1 |
be_then.33190:
    mov     $i16, $ig0
.count b_cont
    b       be_cont.33190
be_else.33190:
    li      1, $i16                     # |          1 |          1 |
.count move_args
    mov     $i16, $i6                   # |          1 |          1 |
    jal     read_nth_object.2719, $ra1  # |          1 |          1 |
    bne     $i1, 0, be_else.33191       # |          1 |          1 |
be_then.33191:
    mov     $i16, $ig0
.count b_cont
    b       be_cont.33191
be_else.33191:
    li      2, $i16                     # |          1 |          1 |
.count move_args
    mov     $i16, $i6                   # |          1 |          1 |
    jal     read_nth_object.2719, $ra1  # |          1 |          1 |
    bne     $i1, 0, be_else.33192       # |          1 |          1 |
be_then.33192:
    mov     $i16, $ig0
.count b_cont
    b       be_cont.33192
be_else.33192:
    li      3, $i16                     # |          1 |          1 |
.count move_args
    mov     $i16, $i6                   # |          1 |          1 |
    jal     read_nth_object.2719, $ra1  # |          1 |          1 |
    bne     $i1, 0, be_else.33193       # |          1 |          1 |
be_then.33193:
    mov     $i16, $ig0
.count b_cont
    b       be_cont.33193
be_else.33193:
    li      4, $i16                     # |          1 |          1 |
    jal     read_object.2721, $ra2      # |          1 |          1 |
be_cont.33193:
be_cont.33192:
be_cont.33191:
be_cont.33190:
    call    ext_read_int                # |          1 |          1 |
.count move_ret
    mov     $i1, $i6                    # |          1 |          1 |
    bne     $i6, -1, be_else.33194      # |          1 |          1 |
be_then.33194:
    li      1, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
.count b_cont
    b       be_cont.33194
be_else.33194:
    call    ext_read_int                # |          1 |          1 |
.count move_ret
    mov     $i1, $i7                    # |          1 |          1 |
    bne     $i7, -1, be_else.33195      # |          1 |          1 |
be_then.33195:
    li      2, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
    store   $i6, [$i1 + 0]
.count b_cont
    b       be_cont.33195
be_else.33195:
    li      2, $i1                      # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
    store   $i7, [$i1 + 1]              # |          1 |          1 |
    store   $i6, [$i1 + 0]              # |          1 |          1 |
be_cont.33195:
be_cont.33194:
    load    [$i1 + 0], $i2              # |          1 |          1 |
    be      $i2, -1, bne_cont.33196     # |          1 |          1 |
bne_then.33196:
    store   $i1, [ext_and_net + 0]      # |          1 |          1 |
    li      1, $i6                      # |          1 |          1 |
    jal     read_and_network.2729, $ra1 # |          1 |          1 |
bne_cont.33196:
    call    ext_read_int                # |          1 |          1 |
.count move_ret
    mov     $i1, $i6                    # |          1 |          1 |
    bne     $i6, -1, be_else.33197      # |          1 |          1 |
be_then.33197:
    li      1, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
.count move_ret
    mov     $i1, $i9
.count b_cont
    b       be_cont.33197
be_else.33197:
    call    ext_read_int                # |          1 |          1 |
.count move_ret
    mov     $i1, $i7                    # |          1 |          1 |
    bne     $i7, -1, be_else.33198      # |          1 |          1 |
be_then.33198:
    li      2, $i2
    add     $i0, -1, $i3
    call    ext_create_array_int
    store   $i6, [$i1 + 0]
    mov     $i1, $i9
.count b_cont
    b       be_cont.33198
be_else.33198:
    li      2, $i1                      # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
    store   $i7, [$i1 + 1]              # |          1 |          1 |
    store   $i6, [$i1 + 0]              # |          1 |          1 |
    mov     $i1, $i9                    # |          1 |          1 |
be_cont.33198:
be_cont.33197:
    load    [$i9 + 0], $i1              # |          1 |          1 |
    bne     $i1, -1, be_else.33199      # |          1 |          1 |
be_then.33199:
    li      1, $i2
.count move_args
    mov     $i9, $i3
    call    ext_create_array_int
.count move_ret
    mov     $i1, $ig1
.count b_cont
    b       be_cont.33199
be_else.33199:
    li      1, $i1                      # |          1 |          1 |
    call    read_or_network.2727        # |          1 |          1 |
    store   $i9, [$i1 + 0]              # |          1 |          1 |
    mov     $i1, $ig1                   # |          1 |          1 |
be_cont.33199:
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
    li      10, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
.count move_ret
    mov     $i1, $i4                    # |          1 |          1 |
.count move_args
    mov     $ig0, $i2                   # |          1 |          1 |
.count move_args
    mov     $i4, $i3                    # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
    li      120, $i2                    # |          1 |          1 |
    mov     $hp, $i3                    # |          1 |          1 |
    add     $hp, 2, $hp                 # |          1 |          1 |
    store   $i1, [$i3 + 1]              # |          1 |          1 |
    store   $i4, [$i3 + 0]              # |          1 |          1 |
    call    ext_create_array_int        # |          1 |          1 |
    store   $i1, [ext_dirvecs + 4]      # |          1 |          1 |
    load    [ext_dirvecs + 4], $i4      # |          1 |          1 |
    li      118, $i5                    # |          1 |          1 |
    jal     create_dirvec_elements.3039, $ra1# |          1 |          1 |
    li      3, $i7                      # |          1 |          1 |
    jal     create_dirvecs.3042, $ra2   # |          1 |          1 |
    li      0, $i6                      # |          1 |          1 |
    li      0, $i7                      # |          1 |          1 |
    li      4, $i5                      # |          1 |          1 |
    li      9, $i2                      # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    fmul    $f1, $fc12, $f1             # |          1 |          1 |
    fsub    $f1, $fc11, $f14            # |          1 |          1 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |
    li      8, $i9                      # |          1 |          1 |
    li      2, $i10                     # |          1 |          1 |
    li      4, $i11                     # |          1 |          1 |
    jal     calc_dirvec_rows.3033, $ra3 # |          1 |          1 |
    load    [ext_dirvecs + 4], $i11     # |          1 |          1 |
    li      119, $i12                   # |          1 |          1 |
    jal     init_dirvec_constants.3044, $ra2# |          1 |          1 |
    li      3, $i13                     # |          1 |          1 |
    jal     init_vecset_constants.3047, $ra3# |          1 |          1 |
    li      ext_light_dirvec, $i4       # |          1 |          1 |
    load    [ext_light_dirvec + 0], $i5 # |          1 |          1 |
    store   $fg12, [$i5 + 0]            # |          1 |          1 |
    store   $fg13, [$i5 + 1]            # |          1 |          1 |
    store   $fg14, [$i5 + 2]            # |          1 |          1 |
    sub     $ig0, 1, $i6                # |          1 |          1 |
    bl      $i6, 0, bge_cont.33200      # |          1 |          1 |
bge_then.33200:
    load    [ext_light_dirvec + 1], $i7 # |          1 |          1 |
    load    [ext_objects + $i6], $i8    # |          1 |          1 |
    load    [$i8 + 1], $i1              # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i1, 1, be_else.33201       # |          1 |          1 |
be_then.33201:
    li      6, $i2
    call    ext_create_array_float
    load    [$i5 + 0], $f1
    bne     $f1, $f0, be_else.33202
be_then.33202:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.33202
be_else.33202:
    load    [$i8 + 6], $i2
    bg      $f0, $f1, ble_else.33203
ble_then.33203:
    li      0, $i3
.count b_cont
    b       ble_cont.33203
ble_else.33203:
    li      1, $i3
ble_cont.33203:
    bne     $i2, 0, be_else.33204
be_then.33204:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33204
be_else.33204:
    bne     $i3, 0, be_else.33205
be_then.33205:
    li      1, $i2
.count b_cont
    b       be_cont.33205
be_else.33205:
    li      0, $i2
be_cont.33205:
be_cont.33204:
    load    [$i8 + 4], $i3
    load    [$i3 + 0], $f1
    bne     $i2, 0, be_else.33206
be_then.33206:
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i5 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
.count b_cont
    b       be_cont.33206
be_else.33206:
    store   $f1, [$i1 + 0]
    load    [$i5 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
be_cont.33206:
be_cont.33202:
    load    [$i5 + 1], $f1
    bne     $f1, $f0, be_else.33207
be_then.33207:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.33207
be_else.33207:
    load    [$i8 + 6], $i2
    bg      $f0, $f1, ble_else.33208
ble_then.33208:
    li      0, $i3
.count b_cont
    b       ble_cont.33208
ble_else.33208:
    li      1, $i3
ble_cont.33208:
    bne     $i2, 0, be_else.33209
be_then.33209:
    mov     $i3, $i2
.count b_cont
    b       be_cont.33209
be_else.33209:
    bne     $i3, 0, be_else.33210
be_then.33210:
    li      1, $i2
.count b_cont
    b       be_cont.33210
be_else.33210:
    li      0, $i2
be_cont.33210:
be_cont.33209:
    load    [$i8 + 4], $i3
    load    [$i3 + 1], $f1
    bne     $i2, 0, be_else.33211
be_then.33211:
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i5 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
.count b_cont
    b       be_cont.33211
be_else.33211:
    store   $f1, [$i1 + 2]
    load    [$i5 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
be_cont.33211:
be_cont.33207:
    load    [$i5 + 2], $f1
    bne     $f1, $f0, be_else.33212
be_then.33212:
    store   $f0, [$i1 + 5]
.count storer
    add     $i7, $i6, $tmp
    store   $i1, [$tmp + 0]
    sub     $i6, 1, $i5
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33201
be_else.33212:
    load    [$i8 + 6], $i2
    load    [$i8 + 4], $i3
    bg      $f0, $f1, ble_else.33213
ble_then.33213:
    li      0, $i8
.count b_cont
    b       ble_cont.33213
ble_else.33213:
    li      1, $i8
ble_cont.33213:
    bne     $i2, 0, be_else.33214
be_then.33214:
    mov     $i8, $i2
.count b_cont
    b       be_cont.33214
be_else.33214:
    bne     $i8, 0, be_else.33215
be_then.33215:
    li      1, $i2
.count b_cont
    b       be_cont.33215
be_else.33215:
    li      0, $i2
be_cont.33215:
be_cont.33214:
    load    [$i3 + 2], $f1
.count storer
    add     $i7, $i6, $tmp
    bne     $i2, 0, be_else.33216
be_then.33216:
    fneg    $f1, $f1
    store   $f1, [$i1 + 4]
    load    [$i5 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    sub     $i6, 1, $i5
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33201
be_else.33216:
    store   $f1, [$i1 + 4]
    load    [$i5 + 2], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 5]
    store   $i1, [$tmp + 0]
    sub     $i6, 1, $i5
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33201
be_else.33201:
    bne     $i1, 2, be_else.33217       # |          1 |          1 |
be_then.33217:
    li      4, $i2                      # |          1 |          1 |
    call    ext_create_array_float      # |          1 |          1 |
    load    [$i8 + 4], $i2              # |          1 |          1 |
    load    [$i8 + 4], $i3              # |          1 |          1 |
    load    [$i8 + 4], $i9              # |          1 |          1 |
    load    [$i5 + 0], $f1              # |          1 |          1 |
    load    [$i2 + 0], $f2              # |          1 |          1 |
    fmul    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i5 + 1], $f2              # |          1 |          1 |
    load    [$i3 + 1], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
    load    [$i5 + 2], $f2              # |          1 |          1 |
    load    [$i9 + 2], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |
    fadd    $f1, $f2, $f1               # |          1 |          1 |
    sub     $i6, 1, $i5                 # |          1 |          1 |
.count storer
    add     $i7, $i6, $tmp              # |          1 |          1 |
    bg      $f1, $f0, ble_else.33218    # |          1 |          1 |
ble_then.33218:
    store   $f0, [$i1 + 0]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33217
ble_else.33218:
    finv    $f1, $f1                    # |          1 |          1 |
    fneg    $f1, $f2                    # |          1 |          1 |
    store   $f2, [$i1 + 0]              # |          1 |          1 |
    load    [$i8 + 4], $i2              # |          1 |          1 |
    load    [$i2 + 0], $f2              # |          1 |          1 |
    fmul_n  $f2, $f1, $f2               # |          1 |          1 |
    store   $f2, [$i1 + 1]              # |          1 |          1 |
    load    [$i8 + 4], $i2              # |          1 |          1 |
    load    [$i2 + 1], $f2              # |          1 |          1 |
    fmul_n  $f2, $f1, $f2               # |          1 |          1 |
    store   $f2, [$i1 + 2]              # |          1 |          1 |
    load    [$i8 + 4], $i2              # |          1 |          1 |
    load    [$i2 + 2], $f2              # |          1 |          1 |
    fmul_n  $f2, $f1, $f1               # |          1 |          1 |
    store   $f1, [$i1 + 3]              # |          1 |          1 |
    store   $i1, [$tmp + 0]             # |          1 |          1 |
    jal     iter_setup_dirvec_constants.2826, $ra1# |          1 |          1 |
.count b_cont
    b       be_cont.33217               # |          1 |          1 |
be_else.33217:
    li      5, $i2
    call    ext_create_array_float
    load    [$i8 + 3], $i2
    load    [$i8 + 4], $i3
    load    [$i8 + 4], $i9
    load    [$i8 + 4], $i10
    load    [$i5 + 0], $f1
    load    [$i5 + 1], $f2
    load    [$i5 + 2], $f3
    fmul    $f1, $f1, $f4
    load    [$i3 + 0], $f5
    fmul    $f4, $f5, $f4
    fmul    $f2, $f2, $f5
    load    [$i9 + 1], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    bne     $i2, 0, be_else.33219
be_then.33219:
    mov     $f4, $f1
.count b_cont
    b       be_cont.33219
be_else.33219:
    fmul    $f2, $f3, $f5
    load    [$i8 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i8 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i8 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.33219:
    store   $f1, [$i1 + 0]
    load    [$i8 + 4], $i3
    load    [$i8 + 4], $i9
    load    [$i8 + 4], $i10
    load    [$i5 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i5 + 1], $f3
    load    [$i9 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i5 + 2], $f5
    load    [$i10 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
.count storer
    add     $i7, $i6, $tmp
    bne     $i2, 0, be_else.33220
be_then.33220:
    store   $f2, [$i1 + 1]
    store   $f4, [$i1 + 2]
    store   $f6, [$i1 + 3]
    sub     $i6, 1, $i5
    bne     $f1, $f0, be_else.33221
be_then.33221:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33220
be_else.33221:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33220
be_else.33220:
    load    [$i8 + 9], $i2
    load    [$i8 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i8 + 9], $i2
    load    [$i5 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i5 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i5 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i5 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    sub     $i6, 1, $i5
    bne     $f1, $f0, be_else.33222
be_then.33222:
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
.count b_cont
    b       be_cont.33222
be_else.33222:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
    jal     iter_setup_dirvec_constants.2826, $ra1
be_cont.33222:
be_cont.33220:
be_cont.33217:
be_cont.33201:
bge_cont.33200:
    sub     $ig0, 1, $i11               # |          1 |          1 |
    jal     setup_reflections.3064, $ra2# |          1 |          1 |
    li      0, $i34                     # |          1 |          1 |
    li      127, $i33                   # |          1 |          1 |
    add     $i0, -64, $i2               # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    fmul    $fg17, $f1, $f1             # |          1 |          1 |
    fmul    $f1, $fg24, $f2             # |          1 |          1 |
    fadd    $f2, $fg18, $f18            # |          1 |          1 |
    load    [ext_screeny_dir + 1], $f2  # |          1 |          1 |
    fmul    $f1, $f2, $f2               # |          1 |          1 |
    fadd    $f2, $fg19, $f3             # |          1 |          1 |
    load    [ext_screeny_dir + 2], $f2  # |          1 |          1 |
    fmul    $f1, $f2, $f1               # |          1 |          1 |
    fadd    $f1, $fg20, $f2             # |          1 |          1 |
.count move_args
    mov     $i39, $i32                  # |          1 |          1 |
.count move_args
    mov     $f3, $f1                    # |          1 |          1 |
    jal     pretrace_pixels.2983, $ra7  # |          1 |          1 |
    li      0, $i37                     # |          1 |          1 |
    li      2, $i41                     # |          1 |          1 |
    jal     scan_line.3000, $ra9        # |          1 |          1 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 1, $sp                 # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    ret                                 # |          1 |          1 |
.end main
                                        # | Instructions | Clocks     |
