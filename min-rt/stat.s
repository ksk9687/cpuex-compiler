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
    li      0, $i0                      # |          1 |          1 |
    mov     $i0, $f0                    # |          1 |          1 |
    li      0x2000, $hp                 # |          1 |          1 |
    sll     $hp, $sp                    # |          1 |          1 |
    sll     $sp, $sp                    # |          1 |          1 |
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
    bge $i2, 0, ITOF_MAIN               # |     16,547 |     16,547 |
    neg $i2, $i2                        # |      8,255 |      8,255 |
    mov $ra, $tmp                       # |      8,255 |      8,255 |
    call ITOF_MAIN                      # |      8,255 |      8,255 |
    fneg $f1, $f1                       # |      8,255 |      8,255 |
    jr $tmp                             # |      8,255 |      8,255 |
ITOF_MAIN:
    load [FLOAT_MAGICF], $f2            # |     16,547 |     16,547 |
    load [FLOAT_MAGICFHX], $i3          # |     16,547 |     16,547 |
    load [FLOAT_MAGICI], $i4            # |     16,547 |     16,547 |
    bge $i2, $i4, ITOF_BIG              # |     16,547 |     16,547 |
    add $i2, $i3, $i2                   # |     16,547 |     16,547 |
    mov $i2, $f1                        # |     16,547 |     16,547 |
    fsub $f1, $f2, $f1                  # |     16,547 |     16,547 |
    ret                                 # |     16,547 |     16,547 |
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
# []
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
# [$i1 - $i2]
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
# []
######################################################################
ext_create_array_float:
    mov $f2, $i3                        # |     19,001 |     19,001 |
    jal ext_create_array_int $tmp       # |     19,001 |     19,001 |
.end create_array

######################################################################
# 三角関数用テーブル
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

######################################################################
#
#       ↑　ここまで lib_asm.s
#
######################################################################
f._164: .float  6.2831853072E+00
f._163: .float  3.1415926536E+00
f._162: .float  1.5707963268E+00
f._161: .float  6.0725293501E-01
f._160: .float  1.0000000000E+00
f._159: .float  5.0000000000E-01

######################################################################
# $f1 = cordic_atan_rec($i2, $f2, $f3, $f4, $f5)
# $ra = $ra
# [$i2]
# [$f1 - $f5]
# []
# []
# []
######################################################################
.begin cordic_atan_rec
ext_cordic_atan_rec:
    bne     $i2, 25, bne._165           # |     26,000 |     26,000 |
be._165:
    mov     $f4, $f1                    # |      1,000 |      1,000 |
    ret                                 # |      1,000 |      1,000 |
bne._165:
    fmul    $f5, $f3, $f1               # |     25,000 |     25,000 |
    bg      $f3, $f0, bg._166           # |     25,000 |     25,000 |
ble._166:
    fsub    $f2, $f1, $f1               # |     12,268 |     12,268 |
    fmul    $f5, $f2, $f2               # |     12,268 |     12,268 |
    fadd    $f3, $f2, $f3               # |     12,268 |     12,268 |
    load    [ext_atan_table + $i2], $f2 # |     12,268 |     12,268 |
    fsub    $f4, $f2, $f4               # |     12,268 |     12,268 |
.count load_float
    load    [f._159], $f2               # |     12,268 |     12,268 |
    fmul    $f5, $f2, $f5               # |     12,268 |     12,268 |
    add     $i2, 1, $i2                 # |     12,268 |     12,268 |
.count move_args
    mov     $f1, $f2                    # |     12,268 |     12,268 |
    b       ext_cordic_atan_rec         # |     12,268 |     12,268 |
bg._166:
    fadd    $f2, $f1, $f1               # |     12,732 |     12,732 |
    fmul    $f5, $f2, $f2               # |     12,732 |     12,732 |
    fsub    $f3, $f2, $f3               # |     12,732 |     12,732 |
    load    [ext_atan_table + $i2], $f2 # |     12,732 |     12,732 |
    fadd    $f4, $f2, $f4               # |     12,732 |     12,732 |
.count load_float
    load    [f._159], $f2               # |     12,732 |     12,732 |
    fmul    $f5, $f2, $f5               # |     12,732 |     12,732 |
    add     $i2, 1, $i2                 # |     12,732 |     12,732 |
.count move_args
    mov     $f1, $f2                    # |     12,732 |     12,732 |
    b       ext_cordic_atan_rec         # |     12,732 |     12,732 |
.end cordic_atan_rec

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f5]
# []
# []
# []
######################################################################
.begin atan
ext_atan:
.count load_float
    load    [f._160], $f5               # |      1,000 |      1,000 |
    li      0, $i2                      # |      1,000 |      1,000 |
.count move_args
    mov     $f2, $f3                    # |      1,000 |      1,000 |
.count move_args
    mov     $f0, $f4                    # |      1,000 |      1,000 |
.count move_args
    mov     $f5, $f2                    # |      1,000 |      1,000 |
    b       ext_cordic_atan_rec         # |      1,000 |      1,000 |
.end atan

######################################################################
# $f1 = cordic_sin_rec($f2, $i2, $f3, $f4, $f5, $f6)
# $ra = $ra
# [$i2]
# [$f1, $f3 - $f6]
# []
# []
# []
######################################################################
.begin cordic_sin_rec
ext_cordic_sin_rec:
    bne     $i2, 25, bne._167           # |    127,244 |    127,244 |
be._167:
    mov     $f4, $f1                    # |      4,894 |      4,894 |
    ret                                 # |      4,894 |      4,894 |
bne._167:
    fmul    $f6, $f4, $f1               # |    122,350 |    122,350 |
    bg      $f2, $f5, bg._168           # |    122,350 |    122,350 |
ble._168:
    fadd    $f3, $f1, $f1               # |     59,218 |     59,218 |
    fmul    $f6, $f3, $f3               # |     59,218 |     59,218 |
    fsub    $f4, $f3, $f4               # |     59,218 |     59,218 |
    load    [ext_atan_table + $i2], $f3 # |     59,218 |     59,218 |
    fsub    $f5, $f3, $f5               # |     59,218 |     59,218 |
.count load_float
    load    [f._159], $f3               # |     59,218 |     59,218 |
    fmul    $f6, $f3, $f6               # |     59,218 |     59,218 |
    add     $i2, 1, $i2                 # |     59,218 |     59,218 |
.count move_args
    mov     $f1, $f3                    # |     59,218 |     59,218 |
    b       ext_cordic_sin_rec          # |     59,218 |     59,218 |
bg._168:
    fsub    $f3, $f1, $f1               # |     63,132 |     63,132 |
    fmul    $f6, $f3, $f3               # |     63,132 |     63,132 |
    fadd    $f4, $f3, $f4               # |     63,132 |     63,132 |
    load    [ext_atan_table + $i2], $f3 # |     63,132 |     63,132 |
    fadd    $f5, $f3, $f5               # |     63,132 |     63,132 |
.count load_float
    load    [f._159], $f3               # |     63,132 |     63,132 |
    fmul    $f6, $f3, $f6               # |     63,132 |     63,132 |
    add     $i2, 1, $i2                 # |     63,132 |     63,132 |
.count move_args
    mov     $f1, $f3                    # |     63,132 |     63,132 |
    b       ext_cordic_sin_rec          # |     63,132 |     63,132 |
.end cordic_sin_rec

######################################################################
# $f1 = cordic_sin($f2)
# $ra = $ra
# [$i2]
# [$f1, $f3 - $f6]
# []
# []
# []
######################################################################
.begin cordic_sin
ext_cordic_sin:
.count load_float
    load    [f._161], $f3               # |      4,894 |      4,894 |
.count load_float
    load    [f._160], $f6               # |      4,894 |      4,894 |
    li      0, $i2                      # |      4,894 |      4,894 |
.count move_args
    mov     $f0, $f4                    # |      4,894 |      4,894 |
.count move_args
    mov     $f0, $f5                    # |      4,894 |      4,894 |
    b       ext_cordic_sin_rec          # |      4,894 |      4,894 |
.end cordic_sin

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f6]
# []
# []
# [$ra]
######################################################################
.begin sin
ext_sin:
    bg      $f0, $f2, bg._169           # |      9,153 |      9,153 |
ble._169:
.count load_float
    load    [f._162], $f1               # |      8,653 |      8,653 |
    bg      $f1, $f2, ext_cordic_sin    # |      8,653 |      8,653 |
ble._170:
.count load_float
    load    [f._163], $f1               # |      5,304 |      5,304 |
    bg      $f1, $f2, bg._171           # |      5,304 |      5,304 |
ble._171:
.count load_float
    load    [f._164], $f1               # |      3,759 |      3,759 |
    bg      $f1, $f2, bg._172           # |      3,759 |      3,759 |
ble._172:
    fsub    $f2, $f1, $f2               # |      2,416 |      2,416 |
    b       ext_sin                     # |      2,416 |      2,416 |
bg._172:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |      1,343 |      1,343 |
.count stack_move
    add     $sp, -1, $sp                # |      1,343 |      1,343 |
    fsub    $f1, $f2, $f2               # |      1,343 |      1,343 |
    call    ext_sin                     # |      1,343 |      1,343 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      1,343 |      1,343 |
.count stack_move
    add     $sp, 1, $sp                 # |      1,343 |      1,343 |
    fneg    $f1, $f1                    # |      1,343 |      1,343 |
    ret                                 # |      1,343 |      1,343 |
bg._171:
    fsub    $f1, $f2, $f2               # |      1,545 |      1,545 |
    b       ext_cordic_sin              # |      1,545 |      1,545 |
bg._169:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |        500 |        500 |
.count stack_move
    add     $sp, -1, $sp                # |        500 |        500 |
    fneg    $f2, $f2                    # |        500 |        500 |
    call    ext_sin                     # |        500 |        500 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |        500 |        500 |
.count stack_move
    add     $sp, 1, $sp                 # |        500 |        500 |
    fneg    $f1, $f1                    # |        500 |        500 |
    ret                                 # |        500 |        500 |
.end sin

######################################################################
# $f1 = cos($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f6]
# []
# []
# [$ra]
######################################################################
.begin cos
ext_cos:
.count load_float
    load    [f._162], $f1               # |      1,004 |      1,004 |
    fsub    $f1, $f2, $f2               # |      1,004 |      1,004 |
    b       ext_sin                     # |      1,004 |      1,004 |
.end cos
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
    bne     $i7, -1, bne.22113          # |         18 |         18 |
be.22113:
    li      0, $i1                      # |          1 |          1 |
    jr      $ra1                        # |          1 |          1 |
bne.22113:
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
    bne     $i10, 0, bne.22114          # |         17 |         17 |
be.22114:
    li      4, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
    ble     $f0, $f3, ble.22115         # |         17 |         17 |
.count dual_jmp
    b       bg.22115                    # |          2 |          2 |
bne.22114:
    call    ext_read_float
.count load_float
    load    [f.21933], $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i15 + 0]
    call    ext_read_float
    fmul    $f1, $f2, $f1
    store   $f1, [$i15 + 1]
    call    ext_read_float
    fmul    $f1, $f2, $f1
    store   $f1, [$i15 + 2]
    li      4, $i2
.count move_args
    mov     $f0, $f2
    call    ext_create_array_float
    bg      $f0, $f3, bg.22115
ble.22115:
    li      0, $i2                      # |         15 |         15 |
    be      $i8, 2, be.22116            # |         15 |         15 |
.count dual_jmp
    b       bne.22116                   # |         13 |         13 |
bg.22115:
    li      1, $i2                      # |          2 |          2 |
    bne     $i8, 2, bne.22116           # |          2 |          2 |
be.22116:
    li      1, $i3                      # |          2 |          2 |
    mov     $hp, $i4                    # |          2 |          2 |
    add     $hp, 23, $hp                # |          2 |          2 |
    store   $i7, [$i4 + 0]              # |          2 |          2 |
    store   $i8, [$i4 + 1]              # |          2 |          2 |
    store   $i9, [$i4 + 2]              # |          2 |          2 |
    store   $i10, [$i4 + 3]             # |          2 |          2 |
    load    [$i11 + 0], $i5             # |          2 |          2 |
    store   $i5, [$i4 + 4]              # |          2 |          2 |
    load    [$i11 + 1], $i5             # |          2 |          2 |
    store   $i5, [$i4 + 5]              # |          2 |          2 |
    load    [$i11 + 2], $i5             # |          2 |          2 |
    store   $i5, [$i4 + 6]              # |          2 |          2 |
    add     $i4, 4, $i11                # |          2 |          2 |
    load    [$i12 + 0], $i5             # |          2 |          2 |
    store   $i5, [$i4 + 7]              # |          2 |          2 |
    load    [$i12 + 1], $i5             # |          2 |          2 |
    store   $i5, [$i4 + 8]              # |          2 |          2 |
    load    [$i12 + 2], $i5             # |          2 |          2 |
    store   $i5, [$i4 + 9]              # |          2 |          2 |
    store   $i3, [$i4 + 10]             # |          2 |          2 |
    load    [$i13 + 0], $i3             # |          2 |          2 |
    store   $i3, [$i4 + 11]             # |          2 |          2 |
    load    [$i13 + 1], $i3             # |          2 |          2 |
    store   $i3, [$i4 + 12]             # |          2 |          2 |
    load    [$i14 + 0], $i3             # |          2 |          2 |
    store   $i3, [$i4 + 13]             # |          2 |          2 |
    load    [$i14 + 1], $i3             # |          2 |          2 |
    store   $i3, [$i4 + 14]             # |          2 |          2 |
    load    [$i14 + 2], $i3             # |          2 |          2 |
    store   $i3, [$i4 + 15]             # |          2 |          2 |
    load    [$i15 + 0], $i3             # |          2 |          2 |
    store   $i3, [$i4 + 16]             # |          2 |          2 |
    load    [$i15 + 1], $i3             # |          2 |          2 |
    store   $i3, [$i4 + 17]             # |          2 |          2 |
    load    [$i15 + 2], $i3             # |          2 |          2 |
    store   $i3, [$i4 + 18]             # |          2 |          2 |
    add     $i4, 16, $i15               # |          2 |          2 |
    load    [$i1 + 0], $i3              # |          2 |          2 |
    store   $i3, [$i4 + 19]             # |          2 |          2 |
    load    [$i1 + 1], $i3              # |          2 |          2 |
    store   $i3, [$i4 + 20]             # |          2 |          2 |
    load    [$i1 + 2], $i3              # |          2 |          2 |
    store   $i3, [$i4 + 21]             # |          2 |          2 |
    load    [$i1 + 3], $i1              # |          2 |          2 |
    store   $i1, [$i4 + 22]             # |          2 |          2 |
    store   $i4, [ext_objects + $i6]    # |          2 |          2 |
    be      $i8, 3, be.22117            # |          2 |          2 |
.count dual_jmp
    b       bne.22117                   # |          2 |          2 |
bne.22116:
    mov     $i2, $i3                    # |         15 |         15 |
    mov     $hp, $i4                    # |         15 |         15 |
    add     $hp, 23, $hp                # |         15 |         15 |
    store   $i7, [$i4 + 0]              # |         15 |         15 |
    store   $i8, [$i4 + 1]              # |         15 |         15 |
    store   $i9, [$i4 + 2]              # |         15 |         15 |
    store   $i10, [$i4 + 3]             # |         15 |         15 |
    load    [$i11 + 0], $i5             # |         15 |         15 |
    store   $i5, [$i4 + 4]              # |         15 |         15 |
    load    [$i11 + 1], $i5             # |         15 |         15 |
    store   $i5, [$i4 + 5]              # |         15 |         15 |
    load    [$i11 + 2], $i5             # |         15 |         15 |
    store   $i5, [$i4 + 6]              # |         15 |         15 |
    add     $i4, 4, $i11                # |         15 |         15 |
    load    [$i12 + 0], $i5             # |         15 |         15 |
    store   $i5, [$i4 + 7]              # |         15 |         15 |
    load    [$i12 + 1], $i5             # |         15 |         15 |
    store   $i5, [$i4 + 8]              # |         15 |         15 |
    load    [$i12 + 2], $i5             # |         15 |         15 |
    store   $i5, [$i4 + 9]              # |         15 |         15 |
    store   $i3, [$i4 + 10]             # |         15 |         15 |
    load    [$i13 + 0], $i3             # |         15 |         15 |
    store   $i3, [$i4 + 11]             # |         15 |         15 |
    load    [$i13 + 1], $i3             # |         15 |         15 |
    store   $i3, [$i4 + 12]             # |         15 |         15 |
    load    [$i14 + 0], $i3             # |         15 |         15 |
    store   $i3, [$i4 + 13]             # |         15 |         15 |
    load    [$i14 + 1], $i3             # |         15 |         15 |
    store   $i3, [$i4 + 14]             # |         15 |         15 |
    load    [$i14 + 2], $i3             # |         15 |         15 |
    store   $i3, [$i4 + 15]             # |         15 |         15 |
    load    [$i15 + 0], $i3             # |         15 |         15 |
    store   $i3, [$i4 + 16]             # |         15 |         15 |
    load    [$i15 + 1], $i3             # |         15 |         15 |
    store   $i3, [$i4 + 17]             # |         15 |         15 |
    load    [$i15 + 2], $i3             # |         15 |         15 |
    store   $i3, [$i4 + 18]             # |         15 |         15 |
    add     $i4, 16, $i15               # |         15 |         15 |
    load    [$i1 + 0], $i3              # |         15 |         15 |
    store   $i3, [$i4 + 19]             # |         15 |         15 |
    load    [$i1 + 1], $i3              # |         15 |         15 |
    store   $i3, [$i4 + 20]             # |         15 |         15 |
    load    [$i1 + 2], $i3              # |         15 |         15 |
    store   $i3, [$i4 + 21]             # |         15 |         15 |
    load    [$i1 + 3], $i1              # |         15 |         15 |
    store   $i1, [$i4 + 22]             # |         15 |         15 |
    store   $i4, [ext_objects + $i6]    # |         15 |         15 |
    bne     $i8, 3, bne.22117           # |         15 |         15 |
be.22117:
    load    [$i11 + 0], $f1             # |          9 |          9 |
    be      $f1, $f0, be.22119          # |          9 |          9 |
bne.22118:
    bne     $f1, $f0, bne.22119         # |          7 |          7 |
be.22119:
    mov     $f0, $f1                    # |          2 |          2 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |
    load    [$i11 + 1], $f1             # |          2 |          2 |
    be      $f1, $f0, be.22122          # |          2 |          2 |
.count dual_jmp
    b       bne.22121                   # |          2 |          2 |
bne.22119:
    bg      $f1, $f0, bg.22120          # |          7 |          7 |
ble.22120:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    be      $f1, $f0, be.22122
.count dual_jmp
    b       bne.22121
bg.22120:
    fmul    $f1, $f1, $f1               # |          7 |          7 |
    finv    $f1, $f1                    # |          7 |          7 |
    store   $f1, [$i11 + 0]             # |          7 |          7 |
    load    [$i11 + 1], $f1             # |          7 |          7 |
    be      $f1, $f0, be.22122          # |          7 |          7 |
bne.22121:
    bne     $f1, $f0, bne.22122         # |          9 |          9 |
be.22122:
    mov     $f0, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    be      $f1, $f0, be.22125
.count dual_jmp
    b       bne.22124
bne.22122:
    bg      $f1, $f0, bg.22123          # |          9 |          9 |
ble.22123:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    be      $f1, $f0, be.22125
.count dual_jmp
    b       bne.22124
bg.22123:
    fmul    $f1, $f1, $f1               # |          9 |          9 |
    finv    $f1, $f1                    # |          9 |          9 |
    store   $f1, [$i11 + 1]             # |          9 |          9 |
    load    [$i11 + 2], $f1             # |          9 |          9 |
    be      $f1, $f0, be.22125          # |          9 |          9 |
bne.22124:
    bne     $f1, $f0, bne.22125         # |          9 |          9 |
be.22125:
    mov     $f0, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.22133
.count dual_jmp
    b       bne.22133
bne.22125:
    bg      $f1, $f0, bg.22126          # |          9 |          9 |
ble.22126:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.22133
.count dual_jmp
    b       bne.22133
bg.22126:
    fmul    $f1, $f1, $f1               # |          9 |          9 |
    finv    $f1, $f1                    # |          9 |          9 |
    store   $f1, [$i11 + 2]             # |          9 |          9 |
    be      $i10, 0, be.22133           # |          9 |          9 |
.count dual_jmp
    b       bne.22133
bne.22117:
    bne     $i8, 2, bne.22128           # |          8 |          8 |
be.22128:
    load    [$i11 + 0], $f1             # |          2 |          2 |
    load    [$i11 + 1], $f3             # |          2 |          2 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |
    fmul    $f1, $f1, $f2               # |          2 |          2 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |
    load    [$i11 + 2], $f3             # |          2 |          2 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |
    fsqrt   $f2, $f2                    # |          2 |          2 |
    bne     $i2, 0, bne.22129           # |          2 |          2 |
be.22129:
    li      1, $i1                      # |          2 |          2 |
    be      $f2, $f0, be.22130          # |          2 |          2 |
.count dual_jmp
    b       bne.22130                   # |          2 |          2 |
bne.22129:
    li      0, $i1
    bne     $f2, $f0, bne.22130
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
.count dual_jmp
    b       bne.22133
bne.22130:
    bne     $i1, 0, bne.22131           # |          2 |          2 |
be.22131:
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
bne.22131:
    finv_n  $f2, $f2                    # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |
    load    [$i11 + 1], $f1             # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 1]             # |          2 |          2 |
    load    [$i11 + 2], $f1             # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 2]             # |          2 |          2 |
    be      $i10, 0, be.22133           # |          2 |          2 |
.count dual_jmp
    b       bne.22133
bne.22128:
    bne     $i10, 0, bne.22133          # |          6 |          6 |
be.22133:
    li      1, $i1                      # |         17 |         17 |
    jr      $ra1                        # |         17 |         17 |
bne.22133:
    load    [$i15 + 0], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f7
    load    [$i15 + 0], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f8
    load    [$i15 + 1], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f9
    load    [$i15 + 1], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f10
    load    [$i15 + 2], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f11
    load    [$i15 + 2], $f2
    call    ext_sin
    fmul    $f9, $f11, $f2
    fmul    $f2, $f2, $f3
    load    [$i11 + 0], $f4
    fmul    $f4, $f3, $f3
    fmul    $f9, $f1, $f5
    fmul    $f5, $f5, $f6
    load    [$i11 + 1], $f12
    fmul    $f12, $f6, $f6
    fadd    $f3, $f6, $f3
    fneg    $f10, $f6
    fmul    $f6, $f6, $f13
    load    [$i11 + 2], $f14
    fmul    $f14, $f13, $f13
    fadd    $f3, $f13, $f3
    store   $f3, [$i11 + 0]
    fmul    $f8, $f10, $f3
    fmul    $f3, $f11, $f13
    fmul    $f7, $f1, $f15
    fsub    $f13, $f15, $f13
    fmul    $f13, $f13, $f15
    fmul    $f4, $f15, $f15
    fmul    $f3, $f1, $f3
    fmul    $f7, $f11, $f16
    fadd    $f3, $f16, $f3
    fmul    $f3, $f3, $f16
    fmul    $f12, $f16, $f16
    fadd    $f15, $f16, $f15
    fmul    $f8, $f9, $f16
    fmul    $f16, $f16, $f17
    fmul    $f14, $f17, $f17
    fadd    $f15, $f17, $f15
    store   $f15, [$i11 + 1]
    fmul    $f7, $f10, $f10
    fmul    $f10, $f11, $f15
    fmul    $f8, $f1, $f17
    fadd    $f15, $f17, $f15
    fmul    $f15, $f15, $f17
    fmul    $f4, $f17, $f17
    fmul    $f10, $f1, $f1
    fmul    $f8, $f11, $f8
    fsub    $f1, $f8, $f1
    fmul    $f1, $f1, $f8
    fmul    $f12, $f8, $f8
    fadd    $f17, $f8, $f8
    fmul    $f7, $f9, $f7
    fmul    $f7, $f7, $f9
    fmul    $f14, $f9, $f9
    fadd    $f8, $f9, $f8
    store   $f8, [$i11 + 2]
    fmul    $f4, $f13, $f8
    fmul    $f8, $f15, $f8
    fmul    $f12, $f3, $f9
    fmul    $f9, $f1, $f9
    fadd    $f8, $f9, $f8
    fmul    $f14, $f16, $f9
    fmul    $f9, $f7, $f9
    fadd    $f8, $f9, $f8
    fmul    $fc10, $f8, $f8
    store   $f8, [$i15 + 0]
    fmul    $f4, $f2, $f2
    fmul    $f2, $f15, $f4
    fmul    $f12, $f5, $f5
    fmul    $f5, $f1, $f1
    fadd    $f4, $f1, $f1
    fmul    $f14, $f6, $f4
    fmul    $f4, $f7, $f6
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
# read_object($i6)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f17]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.begin read_object
read_object.2721:
    bl      $i6, 60, bl.22134           # |         18 |         18 |
bge.22134:
    jr      $ra2
bl.22134:
    jal     read_nth_object.2719, $ra1  # |         18 |         18 |
    bne     $i1, 0, bne.22135           # |         18 |         18 |
be.22135:
    mov     $i6, $ig0                   # |          1 |          1 |
    jr      $ra2                        # |          1 |          1 |
bne.22135:
    add     $i6, 1, $i6                 # |         17 |         17 |
    b       read_object.2721            # |         17 |         17 |
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
.begin read_net_item
read_net_item.2725:
.count stack_store_ra
    store   $ra, [$sp - 3]              # |         43 |         43 |
.count stack_move
    add     $sp, -3, $sp                # |         43 |         43 |
.count stack_store
    store   $i1, [$sp + 1]              # |         43 |         43 |
    call    ext_read_int                # |         43 |         43 |
    bne     $i1, -1, bne.22137          # |         43 |         43 |
be.22137:
.count stack_load_ra
    load    [$sp + 0], $ra              # |         14 |         14 |
.count stack_move
    add     $sp, 3, $sp                 # |         14 |         14 |
.count stack_load
    load    [$sp - 2], $i1              # |         14 |         14 |
    add     $i1, 1, $i2                 # |         14 |         14 |
    add     $i0, -1, $i3                # |         14 |         14 |
    b       ext_create_array_int        # |         14 |         14 |
bne.22137:
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
    bne     $i2, -1, bne.22141          # |          3 |          3 |
be.22141:
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
bne.22141:
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
    bne     $i2, -1, bne.22144          # |         11 |         11 |
be.22144:
    jr      $ra1                        # |          1 |          1 |
bne.22144:
    store   $i1, [ext_and_net + $i6]    # |         10 |         10 |
    add     $i6, 1, $i6                 # |         10 |         10 |
    b       read_and_network.2729       # |         10 |         10 |
.end read_and_network

######################################################################
# $i1 = solver($i1, $i2)
# $ra = $ra
# [$i1 - $i4]
# [$f1 - $f13]
# []
# [$fg0]
# []
######################################################################
.begin solver
solver.2773:
    load    [ext_objects + $i1], $i1    # |     23,754 |     23,754 |
    load    [$i1 + 1], $i3              # |     23,754 |     23,754 |
    load    [$i1 + 7], $f1              # |     23,754 |     23,754 |
    load    [$i1 + 8], $f2              # |     23,754 |     23,754 |
    load    [$i1 + 9], $f3              # |     23,754 |     23,754 |
    fsub    $fg17, $f1, $f1             # |     23,754 |     23,754 |
    fsub    $fg18, $f2, $f2             # |     23,754 |     23,754 |
    fsub    $fg19, $f3, $f3             # |     23,754 |     23,754 |
    load    [$i2 + 0], $f4              # |     23,754 |     23,754 |
    bne     $i3, 1, bne.22145           # |     23,754 |     23,754 |
be.22145:
    be      $f4, $f0, ble.22152         # |     23,754 |     23,754 |
bne.22146:
    load    [$i1 + 5], $f5              # |     23,754 |     23,754 |
    load    [$i2 + 1], $f6              # |     23,754 |     23,754 |
    load    [$i1 + 10], $i3             # |     23,754 |     23,754 |
    bg      $f0, $f4, bg.22147          # |     23,754 |     23,754 |
ble.22147:
    li      0, $i4                      # |     23,580 |     23,580 |
    be      $i3, 0, be.22148            # |     23,580 |     23,580 |
.count dual_jmp
    b       bne.22148
bg.22147:
    li      1, $i4                      # |        174 |        174 |
    bne     $i3, 0, bne.22148           # |        174 |        174 |
be.22148:
    mov     $i4, $i3                    # |     23,754 |     23,754 |
    load    [$i1 + 4], $f7              # |     23,754 |     23,754 |
    finv    $f4, $f4                    # |     23,754 |     23,754 |
    be      $i3, 0, bne.22149           # |     23,754 |     23,754 |
.count dual_jmp
    b       be.22149                    # |        174 |        174 |
bne.22148:
    load    [$i1 + 4], $f7
    finv    $f4, $f4
    bne     $i4, 0, bne.22149
be.22149:
    fsub    $f7, $f1, $f7               # |        174 |        174 |
    fmul    $f7, $f4, $f4               # |        174 |        174 |
    fmul    $f4, $f6, $f6               # |        174 |        174 |
    fadd_a  $f6, $f2, $f6               # |        174 |        174 |
    ble     $f5, $f6, ble.22152         # |        174 |        174 |
.count dual_jmp
    b       bg.22151                    # |        127 |        127 |
bne.22149:
    fneg    $f7, $f7                    # |     23,580 |     23,580 |
    fsub    $f7, $f1, $f7               # |     23,580 |     23,580 |
    fmul    $f7, $f4, $f4               # |     23,580 |     23,580 |
    fmul    $f4, $f6, $f6               # |     23,580 |     23,580 |
    fadd_a  $f6, $f2, $f6               # |     23,580 |     23,580 |
    ble     $f5, $f6, ble.22152         # |     23,580 |     23,580 |
bg.22151:
    load    [$i1 + 6], $f5              # |      8,790 |      8,790 |
    load    [$i2 + 2], $f6              # |      8,790 |      8,790 |
    fmul    $f4, $f6, $f6               # |      8,790 |      8,790 |
    fadd_a  $f6, $f3, $f6               # |      8,790 |      8,790 |
    bg      $f5, $f6, bg.22152          # |      8,790 |      8,790 |
ble.22152:
    load    [$i2 + 1], $f4              # |     20,087 |     20,087 |
    be      $f4, $f0, ble.22160         # |     20,087 |     20,087 |
bne.22154:
    load    [$i1 + 6], $f5              # |     20,087 |     20,087 |
    load    [$i2 + 2], $f6              # |     20,087 |     20,087 |
    load    [$i1 + 10], $i3             # |     20,087 |     20,087 |
    bg      $f0, $f4, bg.22155          # |     20,087 |     20,087 |
ble.22155:
    li      0, $i4                      # |         38 |         38 |
    be      $i3, 0, be.22156            # |         38 |         38 |
.count dual_jmp
    b       bne.22156
bg.22155:
    li      1, $i4                      # |     20,049 |     20,049 |
    bne     $i3, 0, bne.22156           # |     20,049 |     20,049 |
be.22156:
    mov     $i4, $i3                    # |     20,087 |     20,087 |
    load    [$i1 + 5], $f7              # |     20,087 |     20,087 |
    finv    $f4, $f4                    # |     20,087 |     20,087 |
    be      $i3, 0, bne.22157           # |     20,087 |     20,087 |
.count dual_jmp
    b       be.22157                    # |     20,049 |     20,049 |
bne.22156:
    load    [$i1 + 5], $f7
    finv    $f4, $f4
    bne     $i4, 0, bne.22157
be.22157:
    fsub    $f7, $f2, $f7               # |     20,049 |     20,049 |
    fmul    $f7, $f4, $f4               # |     20,049 |     20,049 |
    fmul    $f4, $f6, $f6               # |     20,049 |     20,049 |
    fadd_a  $f6, $f3, $f6               # |     20,049 |     20,049 |
    ble     $f5, $f6, ble.22160         # |     20,049 |     20,049 |
.count dual_jmp
    b       bg.22159                    # |      3,574 |      3,574 |
bne.22157:
    fneg    $f7, $f7                    # |         38 |         38 |
    fsub    $f7, $f2, $f7               # |         38 |         38 |
    fmul    $f7, $f4, $f4               # |         38 |         38 |
    fmul    $f4, $f6, $f6               # |         38 |         38 |
    fadd_a  $f6, $f3, $f6               # |         38 |         38 |
    ble     $f5, $f6, ble.22160         # |         38 |         38 |
bg.22159:
    load    [$i1 + 4], $f5              # |      3,575 |      3,575 |
    load    [$i2 + 0], $f6              # |      3,575 |      3,575 |
    fmul    $f4, $f6, $f6               # |      3,575 |      3,575 |
    fadd_a  $f6, $f1, $f6               # |      3,575 |      3,575 |
    bg      $f5, $f6, bg.22160          # |      3,575 |      3,575 |
ble.22160:
    load    [$i2 + 2], $f4              # |     19,143 |     19,143 |
    be      $f4, $f0, ble.22176         # |     19,143 |     19,143 |
bne.22162:
    load    [$i1 + 10], $i3             # |     19,143 |     19,143 |
    load    [$i1 + 4], $f5              # |     19,143 |     19,143 |
    load    [$i2 + 0], $f6              # |     19,143 |     19,143 |
    bg      $f0, $f4, bg.22163          # |     19,143 |     19,143 |
ble.22163:
    li      0, $i4                      # |     12,429 |     12,429 |
    be      $i3, 0, be.22164            # |     12,429 |     12,429 |
.count dual_jmp
    b       bne.22164
bg.22163:
    li      1, $i4                      # |      6,714 |      6,714 |
    bne     $i3, 0, bne.22164           # |      6,714 |      6,714 |
be.22164:
    mov     $i4, $i3                    # |     19,143 |     19,143 |
    load    [$i1 + 6], $f7              # |     19,143 |     19,143 |
    finv    $f4, $f4                    # |     19,143 |     19,143 |
    be      $i3, 0, bne.22165           # |     19,143 |     19,143 |
.count dual_jmp
    b       be.22165                    # |      6,714 |      6,714 |
bne.22164:
    load    [$i1 + 6], $f7
    finv    $f4, $f4
    bne     $i4, 0, bne.22165
be.22165:
    fsub    $f7, $f3, $f3               # |      6,714 |      6,714 |
    fmul    $f3, $f4, $f3               # |      6,714 |      6,714 |
    fmul    $f3, $f6, $f4               # |      6,714 |      6,714 |
    fadd_a  $f4, $f1, $f1               # |      6,714 |      6,714 |
    ble     $f5, $f1, ble.22176         # |      6,714 |      6,714 |
.count dual_jmp
    b       bg.22167                    # |      1,198 |      1,198 |
bne.22165:
    fneg    $f7, $f7                    # |     12,429 |     12,429 |
    fsub    $f7, $f3, $f3               # |     12,429 |     12,429 |
    fmul    $f3, $f4, $f3               # |     12,429 |     12,429 |
    fmul    $f3, $f6, $f4               # |     12,429 |     12,429 |
    fadd_a  $f4, $f1, $f1               # |     12,429 |     12,429 |
    ble     $f5, $f1, ble.22176         # |     12,429 |     12,429 |
bg.22167:
    load    [$i1 + 5], $f1              # |      3,882 |      3,882 |
    load    [$i2 + 1], $f4              # |      3,882 |      3,882 |
    fmul    $f3, $f4, $f4               # |      3,882 |      3,882 |
    fadd_a  $f4, $f2, $f2               # |      3,882 |      3,882 |
    ble     $f1, $f2, ble.22176         # |      3,882 |      3,882 |
bg.22168:
    mov     $f3, $fg0                   # |      2,165 |      2,165 |
    li      3, $i1                      # |      2,165 |      2,165 |
    ret                                 # |      2,165 |      2,165 |
bg.22160:
    mov     $f4, $fg0                   # |        944 |        944 |
    li      2, $i1                      # |        944 |        944 |
    ret                                 # |        944 |        944 |
bg.22152:
    mov     $f4, $fg0                   # |      3,667 |      3,667 |
    li      1, $i1                      # |      3,667 |      3,667 |
    ret                                 # |      3,667 |      3,667 |
bne.22145:
    bne     $i3, 2, bne.22169
be.22169:
    load    [$i1 + 4], $f5
    fmul    $f4, $f5, $f4
    load    [$i2 + 1], $f6
    load    [$i1 + 5], $f7
    fmul    $f6, $f7, $f6
    fadd    $f4, $f6, $f4
    load    [$i2 + 2], $f6
    load    [$i1 + 6], $f8
    fmul    $f6, $f8, $f6
    fadd    $f4, $f6, $f4
    ble     $f4, $f0, ble.22176
bg.22170:
    fmul    $f5, $f1, $f1
    fmul    $f7, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f8, $f3, $f2
    fadd_n  $f1, $f2, $f1
    finv    $f4, $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
bne.22169:
    load    [$i1 + 3], $i4
    load    [$i2 + 1], $f5
    load    [$i2 + 2], $f6
    fmul    $f4, $f4, $f7
    load    [$i1 + 4], $f8
    fmul    $f7, $f8, $f7
    fmul    $f5, $f5, $f9
    load    [$i1 + 5], $f10
    fmul    $f9, $f10, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f6, $f9
    load    [$i1 + 6], $f11
    fmul    $f9, $f11, $f9
    fadd    $f7, $f9, $f7
    bne     $i4, 0, bne.22171
be.22171:
    be      $f7, $f0, ble.22176
.count dual_jmp
    b       bne.22172
bne.22171:
    fmul    $f5, $f6, $f9
    load    [$i1 + 16], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f4, $f9
    load    [$i1 + 17], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f4, $f5, $f9
    load    [$i1 + 18], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    be      $f7, $f0, ble.22176
bne.22172:
    fmul    $f4, $f1, $f9
    fmul    $f9, $f8, $f9
    fmul    $f5, $f2, $f12
    fmul    $f12, $f10, $f12
    fadd    $f9, $f12, $f9
    fmul    $f6, $f3, $f12
    fmul    $f12, $f11, $f12
    fadd    $f9, $f12, $f9
    bne     $i4, 0, bne.22173
be.22173:
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
    be      $i4, 0, be.22174
.count dual_jmp
    b       bne.22174
bne.22173:
    fmul    $f6, $f2, $f12
    fmul    $f5, $f3, $f13
    fadd    $f12, $f13, $f12
    load    [$i1 + 16], $f13
    fmul    $f12, $f13, $f12
    fmul    $f4, $f3, $f13
    fmul    $f6, $f1, $f6
    fadd    $f13, $f6, $f6
    load    [$i1 + 17], $f13
    fmul    $f6, $f13, $f6
    fadd    $f12, $f6, $f6
    fmul    $f4, $f2, $f4
    fmul    $f5, $f1, $f5
    fadd    $f4, $f5, $f4
    load    [$i1 + 18], $f5
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
    bne     $i4, 0, bne.22174
be.22174:
    mov     $f6, $f1
    be      $i3, 3, be.22175
.count dual_jmp
    b       bne.22175
bne.22174:
    fmul    $f2, $f3, $f8
    load    [$i1 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f1, $f3
    load    [$i1 + 17], $f8
    fmul    $f3, $f8, $f3
    fadd    $f6, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i1 + 18], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
    bne     $i3, 3, bne.22175
be.22175:
    fsub    $f1, $fc0, $f1
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    ble     $f1, $f0, ble.22176
.count dual_jmp
    b       bg.22176
bne.22175:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    bg      $f1, $f0, bg.22176
ble.22176:
    li      0, $i1                      # |     16,978 |     16,978 |
    ret                                 # |     16,978 |     16,978 |
bg.22176:
    load    [$i1 + 10], $i1
    fsqrt   $f1, $f1
    finv    $f7, $f2
    bne     $i1, 0, bne.22177
be.22177:
    fneg    $f1, $f1
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
bne.22177:
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i4]
# [$f1 - $f9]
# []
# [$fg0]
# []
######################################################################
.begin solver_fast
solver_fast.2796:
    load    [ext_objects + $i1], $i2    # |    660,729 |    660,729 |
    load    [ext_light_dirvec + 3], $i3 # |    660,729 |    660,729 |
    load    [$i2 + 1], $i4              # |    660,729 |    660,729 |
    load    [ext_intersection_point + 0], $f1# |    660,729 |    660,729 |
    load    [$i2 + 7], $f2              # |    660,729 |    660,729 |
    load    [ext_intersection_point + 1], $f3# |    660,729 |    660,729 |
    load    [$i2 + 8], $f4              # |    660,729 |    660,729 |
    load    [ext_intersection_point + 2], $f5# |    660,729 |    660,729 |
    load    [$i2 + 9], $f6              # |    660,729 |    660,729 |
    fsub    $f1, $f2, $f1               # |    660,729 |    660,729 |
    fsub    $f3, $f4, $f2               # |    660,729 |    660,729 |
    fsub    $f5, $f6, $f3               # |    660,729 |    660,729 |
    load    [$i3 + $i1], $i1            # |    660,729 |    660,729 |
    bne     $i4, 1, bne.22178           # |    660,729 |    660,729 |
be.22178:
    load    [$i2 + 5], $f4              # |    660,729 |    660,729 |
    load    [%{ext_light_dirvec + 0} + 1], $f5# |    660,729 |    660,729 |
    load    [$i1 + 0], $f6              # |    660,729 |    660,729 |
    fsub    $f6, $f1, $f6               # |    660,729 |    660,729 |
    load    [$i1 + 1], $f7              # |    660,729 |    660,729 |
    fmul    $f6, $f7, $f6               # |    660,729 |    660,729 |
    fmul    $f6, $f5, $f5               # |    660,729 |    660,729 |
    fadd_a  $f5, $f2, $f5               # |    660,729 |    660,729 |
    ble     $f4, $f5, be.22181          # |    660,729 |    660,729 |
bg.22179:
    load    [$i2 + 6], $f5              # |    223,135 |    223,135 |
    load    [%{ext_light_dirvec + 0} + 2], $f7# |    223,135 |    223,135 |
    fmul    $f6, $f7, $f7               # |    223,135 |    223,135 |
    fadd_a  $f7, $f3, $f7               # |    223,135 |    223,135 |
    ble     $f5, $f7, be.22181          # |    223,135 |    223,135 |
bg.22180:
    load    [$i1 + 1], $f5              # |    146,877 |    146,877 |
    bne     $f5, $f0, bne.22181         # |    146,877 |    146,877 |
be.22181:
    load    [$i2 + 4], $f5              # |    513,852 |    513,852 |
    load    [%{ext_light_dirvec + 0} + 0], $f6# |    513,852 |    513,852 |
    load    [$i1 + 2], $f7              # |    513,852 |    513,852 |
    fsub    $f7, $f2, $f7               # |    513,852 |    513,852 |
    load    [$i1 + 3], $f8              # |    513,852 |    513,852 |
    fmul    $f7, $f8, $f7               # |    513,852 |    513,852 |
    fmul    $f7, $f6, $f6               # |    513,852 |    513,852 |
    fadd_a  $f6, $f1, $f6               # |    513,852 |    513,852 |
    ble     $f5, $f6, be.22185          # |    513,852 |    513,852 |
bg.22183:
    load    [$i2 + 6], $f6              # |     75,031 |     75,031 |
    load    [%{ext_light_dirvec + 0} + 2], $f8# |     75,031 |     75,031 |
    fmul    $f7, $f8, $f8               # |     75,031 |     75,031 |
    fadd_a  $f8, $f3, $f8               # |     75,031 |     75,031 |
    ble     $f6, $f8, be.22185          # |     75,031 |     75,031 |
bg.22184:
    load    [$i1 + 3], $f6              # |     34,836 |     34,836 |
    bne     $f6, $f0, bne.22185         # |     34,836 |     34,836 |
be.22185:
    load    [%{ext_light_dirvec + 0} + 0], $f6# |    479,016 |    479,016 |
    load    [$i1 + 4], $f7              # |    479,016 |    479,016 |
    fsub    $f7, $f3, $f3               # |    479,016 |    479,016 |
    load    [$i1 + 5], $f7              # |    479,016 |    479,016 |
    fmul    $f3, $f7, $f3               # |    479,016 |    479,016 |
    fmul    $f3, $f6, $f6               # |    479,016 |    479,016 |
    fadd_a  $f6, $f1, $f1               # |    479,016 |    479,016 |
    ble     $f5, $f1, ble.22195         # |    479,016 |    479,016 |
bg.22187:
    load    [%{ext_light_dirvec + 0} + 1], $f1# |     32,006 |     32,006 |
    fmul    $f3, $f1, $f1               # |     32,006 |     32,006 |
    fadd_a  $f1, $f2, $f1               # |     32,006 |     32,006 |
    ble     $f4, $f1, ble.22195         # |     32,006 |     32,006 |
bg.22188:
    load    [$i1 + 5], $f1              # |     24,354 |     24,354 |
    be      $f1, $f0, ble.22195         # |     24,354 |     24,354 |
bne.22189:
    mov     $f3, $fg0                   # |     24,354 |     24,354 |
    li      3, $i1                      # |     24,354 |     24,354 |
    ret                                 # |     24,354 |     24,354 |
bne.22185:
    mov     $f7, $fg0                   # |     34,836 |     34,836 |
    li      2, $i1                      # |     34,836 |     34,836 |
    ret                                 # |     34,836 |     34,836 |
bne.22181:
    mov     $f6, $fg0                   # |    146,877 |    146,877 |
    li      1, $i1                      # |    146,877 |    146,877 |
    ret                                 # |    146,877 |    146,877 |
bne.22178:
    load    [$i1 + 0], $f4
    bne     $i4, 2, bne.22190
be.22190:
    ble     $f0, $f4, ble.22195
bg.22191:
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
bne.22190:
    be      $f4, $f0, ble.22195
bne.22192:
    load    [$i2 + 3], $i3
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
    load    [$i2 + 4], $f8
    fmul    $f7, $f8, $f7
    fmul    $f2, $f2, $f8
    load    [$i2 + 5], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f3, $f8
    load    [$i2 + 6], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    bne     $i3, 0, bne.22193
be.22193:
    mov     $f7, $f1
    be      $i4, 3, be.22194
.count dual_jmp
    b       bne.22194
bne.22193:
    fmul    $f2, $f3, $f8
    load    [$i2 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i2 + 18], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
    bne     $i4, 3, bne.22194
be.22194:
    fsub    $f1, $fc0, $f1
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    ble     $f1, $f0, ble.22195
.count dual_jmp
    b       bg.22195
bne.22194:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    bg      $f1, $f0, bg.22195
ble.22195:
    li      0, $i1                      # |    454,662 |    454,662 |
    ret                                 # |    454,662 |    454,662 |
bg.22195:
    load    [$i2 + 10], $i2
    load    [$i1 + 4], $f2
    li      1, $i1
    fsqrt   $f1, $f1
    bne     $i2, 0, bne.22196
be.22196:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ret     
bne.22196:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ret     
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
.begin solver_fast2
solver_fast2.2814:
    load    [ext_objects + $i1], $i3    # |  1,134,616 |  1,134,616 |
    load    [$i2 + 3], $i4              # |  1,134,616 |  1,134,616 |
    load    [$i3 + 1], $i5              # |  1,134,616 |  1,134,616 |
    load    [$i3 + 19], $f1             # |  1,134,616 |  1,134,616 |
    load    [$i3 + 20], $f2             # |  1,134,616 |  1,134,616 |
    load    [$i3 + 21], $f3             # |  1,134,616 |  1,134,616 |
    load    [$i4 + $i1], $i1            # |  1,134,616 |  1,134,616 |
    bne     $i5, 1, bne.22197           # |  1,134,616 |  1,134,616 |
be.22197:
    load    [$i3 + 5], $f4              # |  1,134,616 |  1,134,616 |
    load    [$i2 + 1], $f5              # |  1,134,616 |  1,134,616 |
    load    [$i1 + 0], $f6              # |  1,134,616 |  1,134,616 |
    fsub    $f6, $f1, $f6               # |  1,134,616 |  1,134,616 |
    load    [$i1 + 1], $f7              # |  1,134,616 |  1,134,616 |
    fmul    $f6, $f7, $f6               # |  1,134,616 |  1,134,616 |
    fmul    $f6, $f5, $f5               # |  1,134,616 |  1,134,616 |
    fadd_a  $f5, $f2, $f5               # |  1,134,616 |  1,134,616 |
    ble     $f4, $f5, be.22200          # |  1,134,616 |  1,134,616 |
bg.22198:
    load    [$i3 + 6], $f5              # |    494,435 |    494,435 |
    load    [$i2 + 2], $f7              # |    494,435 |    494,435 |
    fmul    $f6, $f7, $f7               # |    494,435 |    494,435 |
    fadd_a  $f7, $f3, $f7               # |    494,435 |    494,435 |
    ble     $f5, $f7, be.22200          # |    494,435 |    494,435 |
bg.22199:
    load    [$i1 + 1], $f5              # |    329,995 |    329,995 |
    bne     $f5, $f0, bne.22200         # |    329,995 |    329,995 |
be.22200:
    load    [$i3 + 4], $f5              # |    804,621 |    804,621 |
    load    [$i2 + 0], $f6              # |    804,621 |    804,621 |
    load    [$i1 + 2], $f7              # |    804,621 |    804,621 |
    fsub    $f7, $f2, $f7               # |    804,621 |    804,621 |
    load    [$i1 + 3], $f8              # |    804,621 |    804,621 |
    fmul    $f7, $f8, $f7               # |    804,621 |    804,621 |
    fmul    $f7, $f6, $f6               # |    804,621 |    804,621 |
    fadd_a  $f6, $f1, $f6               # |    804,621 |    804,621 |
    ble     $f5, $f6, be.22204          # |    804,621 |    804,621 |
bg.22202:
    load    [$i3 + 6], $f6              # |    350,982 |    350,982 |
    load    [$i2 + 2], $f8              # |    350,982 |    350,982 |
    fmul    $f7, $f8, $f8               # |    350,982 |    350,982 |
    fadd_a  $f8, $f3, $f8               # |    350,982 |    350,982 |
    ble     $f6, $f8, be.22204          # |    350,982 |    350,982 |
bg.22203:
    load    [$i1 + 3], $f6              # |    227,327 |    227,327 |
    bne     $f6, $f0, bne.22204         # |    227,327 |    227,327 |
be.22204:
    load    [$i2 + 0], $f6              # |    577,294 |    577,294 |
    load    [$i1 + 4], $f7              # |    577,294 |    577,294 |
    fsub    $f7, $f3, $f3               # |    577,294 |    577,294 |
    load    [$i1 + 5], $f7              # |    577,294 |    577,294 |
    fmul    $f3, $f7, $f3               # |    577,294 |    577,294 |
    fmul    $f3, $f6, $f6               # |    577,294 |    577,294 |
    fadd_a  $f6, $f1, $f1               # |    577,294 |    577,294 |
    ble     $f5, $f1, ble.22212         # |    577,294 |    577,294 |
bg.22206:
    load    [$i2 + 1], $f1              # |    164,980 |    164,980 |
    fmul    $f3, $f1, $f1               # |    164,980 |    164,980 |
    fadd_a  $f1, $f2, $f1               # |    164,980 |    164,980 |
    ble     $f4, $f1, ble.22212         # |    164,980 |    164,980 |
bg.22207:
    load    [$i1 + 5], $f1              # |    127,502 |    127,502 |
    be      $f1, $f0, ble.22212         # |    127,502 |    127,502 |
bne.22208:
    mov     $f3, $fg0                   # |    127,502 |    127,502 |
    li      3, $i1                      # |    127,502 |    127,502 |
    ret                                 # |    127,502 |    127,502 |
bne.22204:
    mov     $f7, $fg0                   # |    227,327 |    227,327 |
    li      2, $i1                      # |    227,327 |    227,327 |
    ret                                 # |    227,327 |    227,327 |
bne.22200:
    mov     $f6, $fg0                   # |    329,995 |    329,995 |
    li      1, $i1                      # |    329,995 |    329,995 |
    ret                                 # |    329,995 |    329,995 |
bne.22197:
    bne     $i5, 2, bne.22209
be.22209:
    load    [$i1 + 0], $f1
    ble     $f0, $f1, ble.22212
bg.22210:
    load    [$i3 + 22], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
bne.22209:
    load    [$i1 + 0], $f4
    be      $f4, $f0, ble.22212
bne.22211:
    load    [$i1 + 1], $f5
    fmul    $f5, $f1, $f1
    load    [$i1 + 2], $f5
    fmul    $f5, $f2, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 3], $f2
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $f1, $f2
    load    [$i3 + 22], $f3
    fmul    $f4, $f3, $f3
    fsub    $f2, $f3, $f2
    bg      $f2, $f0, bg.22212
ble.22212:
    li      0, $i1                      # |    449,792 |    449,792 |
    ret                                 # |    449,792 |    449,792 |
bg.22212:
    load    [$i3 + 10], $i2
    fsqrt   $f2, $f2
    bne     $i2, 0, bne.22213
be.22213:
    fsub    $f1, $f2, $f1
    load    [$i1 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
bne.22213:
    fadd    $f1, $f2, $f1
    load    [$i1 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
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
.begin setup_rect_table
setup_rect_table.2817:
    li      6, $i2                      # |      3,612 |      3,612 |
.count move_args
    mov     $f0, $f2                    # |      3,612 |      3,612 |
    call    ext_create_array_float      # |      3,612 |      3,612 |
    load    [$i4 + 0], $f1              # |      3,612 |      3,612 |
    bne     $f1, $f0, bne.22214         # |      3,612 |      3,612 |
be.22214:
    store   $f0, [$i1 + 1]
    load    [$i4 + 1], $f1
    be      $f1, $f0, be.22219
.count dual_jmp
    b       bne.22219
bne.22214:
    load    [$i5 + 10], $i2             # |      3,612 |      3,612 |
    bg      $f0, $f1, bg.22215          # |      3,612 |      3,612 |
ble.22215:
    li      0, $i3                      # |      1,806 |      1,806 |
    be      $i2, 0, be.22216            # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.22216
bg.22215:
    li      1, $i3                      # |      1,806 |      1,806 |
    bne     $i2, 0, bne.22216           # |      1,806 |      1,806 |
be.22216:
    mov     $i3, $i2                    # |      3,612 |      3,612 |
    load    [$i5 + 4], $f1              # |      3,612 |      3,612 |
    be      $i2, 0, bne.22217           # |      3,612 |      3,612 |
.count dual_jmp
    b       be.22217                    # |      1,806 |      1,806 |
bne.22216:
    load    [$i5 + 4], $f1
    bne     $i3, 0, bne.22217
be.22217:
    store   $f1, [$i1 + 0]              # |      1,806 |      1,806 |
    load    [$i4 + 0], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 1]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    be      $f1, $f0, be.22219          # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.22219                   # |      1,806 |      1,806 |
bne.22217:
    fneg    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 0]              # |      1,806 |      1,806 |
    load    [$i4 + 0], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 1]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    bne     $f1, $f0, bne.22219         # |      1,806 |      1,806 |
be.22219:
    store   $f0, [$i1 + 3]
    load    [$i4 + 2], $f1
    be      $f1, $f0, be.22224
.count dual_jmp
    b       bne.22224
bne.22219:
    load    [$i5 + 10], $i2             # |      3,612 |      3,612 |
    bg      $f0, $f1, bg.22220          # |      3,612 |      3,612 |
ble.22220:
    li      0, $i3                      # |      1,806 |      1,806 |
    be      $i2, 0, be.22221            # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.22221
bg.22220:
    li      1, $i3                      # |      1,806 |      1,806 |
    bne     $i2, 0, bne.22221           # |      1,806 |      1,806 |
be.22221:
    mov     $i3, $i2                    # |      3,612 |      3,612 |
    load    [$i5 + 5], $f1              # |      3,612 |      3,612 |
    be      $i2, 0, bne.22222           # |      3,612 |      3,612 |
.count dual_jmp
    b       be.22222                    # |      1,806 |      1,806 |
bne.22221:
    load    [$i5 + 5], $f1
    bne     $i3, 0, bne.22222
be.22222:
    store   $f1, [$i1 + 2]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 3]              # |      1,806 |      1,806 |
    load    [$i4 + 2], $f1              # |      1,806 |      1,806 |
    be      $f1, $f0, be.22224          # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.22224                   # |      1,806 |      1,806 |
bne.22222:
    fneg    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 2]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 3]              # |      1,806 |      1,806 |
    load    [$i4 + 2], $f1              # |      1,806 |      1,806 |
    bne     $f1, $f0, bne.22224         # |      1,806 |      1,806 |
be.22224:
    store   $f0, [$i1 + 5]
    jr      $ra1
bne.22224:
    load    [$i5 + 10], $i2             # |      3,612 |      3,612 |
    bg      $f0, $f1, bg.22225          # |      3,612 |      3,612 |
ble.22225:
    li      0, $i3                      # |      1,812 |      1,812 |
    be      $i2, 0, be.22226            # |      1,812 |      1,812 |
.count dual_jmp
    b       bne.22226
bg.22225:
    li      1, $i3                      # |      1,800 |      1,800 |
    bne     $i2, 0, bne.22226           # |      1,800 |      1,800 |
be.22226:
    mov     $i3, $i2                    # |      3,612 |      3,612 |
    load    [$i5 + 6], $f1              # |      3,612 |      3,612 |
    be      $i2, 0, bne.22227           # |      3,612 |      3,612 |
.count dual_jmp
    b       be.22227                    # |      1,800 |      1,800 |
bne.22226:
    load    [$i5 + 6], $f1
    bne     $i3, 0, bne.22227
be.22227:
    store   $f1, [$i1 + 4]              # |      1,800 |      1,800 |
    load    [$i4 + 2], $f1              # |      1,800 |      1,800 |
    finv    $f1, $f1                    # |      1,800 |      1,800 |
    store   $f1, [$i1 + 5]              # |      1,800 |      1,800 |
    jr      $ra1                        # |      1,800 |      1,800 |
bne.22227:
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
# [$i1 - $i3]
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
    load    [$i4 + 0], $f1              # |      1,204 |      1,204 |
    load    [$i5 + 4], $f2              # |      1,204 |      1,204 |
    fmul    $f1, $f2, $f1               # |      1,204 |      1,204 |
    load    [$i4 + 1], $f2              # |      1,204 |      1,204 |
    load    [$i5 + 5], $f3              # |      1,204 |      1,204 |
    fmul    $f2, $f3, $f2               # |      1,204 |      1,204 |
    fadd    $f1, $f2, $f1               # |      1,204 |      1,204 |
    load    [$i4 + 2], $f2              # |      1,204 |      1,204 |
    load    [$i5 + 6], $f3              # |      1,204 |      1,204 |
    fmul    $f2, $f3, $f2               # |      1,204 |      1,204 |
    fadd    $f1, $f2, $f1               # |      1,204 |      1,204 |
    bg      $f1, $f0, bg.22229          # |      1,204 |      1,204 |
ble.22229:
    store   $f0, [$i1 + 0]              # |        601 |        601 |
    jr      $ra1                        # |        601 |        601 |
bg.22229:
    finv    $f1, $f1                    # |        603 |        603 |
    fneg    $f1, $f2                    # |        603 |        603 |
    store   $f2, [$i1 + 0]              # |        603 |        603 |
    load    [$i5 + 4], $f2              # |        603 |        603 |
    fmul_n  $f2, $f1, $f2               # |        603 |        603 |
    store   $f2, [$i1 + 1]              # |        603 |        603 |
    load    [$i5 + 5], $f2              # |        603 |        603 |
    fmul_n  $f2, $f1, $f2               # |        603 |        603 |
    store   $f2, [$i1 + 2]              # |        603 |        603 |
    load    [$i5 + 6], $f2              # |        603 |        603 |
    fmul_n  $f2, $f1, $f1               # |        603 |        603 |
    store   $f1, [$i1 + 3]              # |        603 |        603 |
    jr      $ra1                        # |        603 |        603 |
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
.begin setup_second_table
setup_second_table.2823:
    li      5, $i2                      # |      5,418 |      5,418 |
.count move_args
    mov     $f0, $f2                    # |      5,418 |      5,418 |
    call    ext_create_array_float      # |      5,418 |      5,418 |
    load    [$i5 + 3], $i2              # |      5,418 |      5,418 |
    load    [$i4 + 0], $f1              # |      5,418 |      5,418 |
    load    [$i4 + 1], $f2              # |      5,418 |      5,418 |
    load    [$i4 + 2], $f3              # |      5,418 |      5,418 |
    fmul    $f1, $f1, $f4               # |      5,418 |      5,418 |
    load    [$i5 + 4], $f5              # |      5,418 |      5,418 |
    fmul    $f4, $f5, $f4               # |      5,418 |      5,418 |
    fmul    $f2, $f2, $f5               # |      5,418 |      5,418 |
    load    [$i5 + 5], $f6              # |      5,418 |      5,418 |
    fmul    $f5, $f6, $f5               # |      5,418 |      5,418 |
    fadd    $f4, $f5, $f4               # |      5,418 |      5,418 |
    fmul    $f3, $f3, $f5               # |      5,418 |      5,418 |
    load    [$i5 + 6], $f6              # |      5,418 |      5,418 |
    fmul    $f5, $f6, $f5               # |      5,418 |      5,418 |
    fadd    $f4, $f5, $f4               # |      5,418 |      5,418 |
    bne     $i2, 0, bne.22230           # |      5,418 |      5,418 |
be.22230:
    mov     $f4, $f1                    # |      5,418 |      5,418 |
    store   $f1, [$i1 + 0]              # |      5,418 |      5,418 |
    load    [$i4 + 0], $f2              # |      5,418 |      5,418 |
    load    [$i5 + 4], $f3              # |      5,418 |      5,418 |
    fmul    $f2, $f3, $f2               # |      5,418 |      5,418 |
    load    [$i4 + 1], $f3              # |      5,418 |      5,418 |
    load    [$i5 + 5], $f4              # |      5,418 |      5,418 |
    fmul    $f3, $f4, $f4               # |      5,418 |      5,418 |
    load    [$i4 + 2], $f5              # |      5,418 |      5,418 |
    load    [$i5 + 6], $f6              # |      5,418 |      5,418 |
    fmul    $f5, $f6, $f6               # |      5,418 |      5,418 |
    fneg    $f2, $f2                    # |      5,418 |      5,418 |
    fneg    $f4, $f4                    # |      5,418 |      5,418 |
    fneg    $f6, $f6                    # |      5,418 |      5,418 |
    be      $i2, 0, be.22231            # |      5,418 |      5,418 |
.count dual_jmp
    b       bne.22231
bne.22230:
    fmul    $f2, $f3, $f5
    load    [$i5 + 16], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i5 + 17], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i5 + 18], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i4 + 0], $f2
    load    [$i5 + 4], $f3
    fmul    $f2, $f3, $f2
    load    [$i4 + 1], $f3
    load    [$i5 + 5], $f4
    fmul    $f3, $f4, $f4
    load    [$i4 + 2], $f5
    load    [$i5 + 6], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
    bne     $i2, 0, bne.22231
be.22231:
    store   $f2, [$i1 + 1]              # |      5,418 |      5,418 |
    store   $f4, [$i1 + 2]              # |      5,418 |      5,418 |
    store   $f6, [$i1 + 3]              # |      5,418 |      5,418 |
    be      $f1, $f0, be.22233          # |      5,418 |      5,418 |
.count dual_jmp
    b       bne.22233                   # |      5,418 |      5,418 |
bne.22231:
    load    [$i5 + 17], $f7
    fmul    $f5, $f7, $f5
    load    [$i5 + 18], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc4, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i4 + 2], $f2
    load    [$i5 + 16], $f3
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
    bne     $f1, $f0, bne.22233
be.22233:
    jr      $ra1
bne.22233:
    finv    $f1, $f1                    # |      5,418 |      5,418 |
    store   $f1, [$i1 + 4]              # |      5,418 |      5,418 |
    jr      $ra1                        # |      5,418 |      5,418 |
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
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
    bl      $i6, 0, bl.22234            # |     10,836 |     10,836 |
bge.22234:
    load    [$i4 + 3], $i7              # |     10,234 |     10,234 |
    load    [ext_objects + $i6], $i5    # |     10,234 |     10,234 |
    load    [$i5 + 1], $i1              # |     10,234 |     10,234 |
    bne     $i1, 1, bne.22235           # |     10,234 |     10,234 |
be.22235:
    jal     setup_rect_table.2817, $ra1 # |      3,612 |      3,612 |
.count storer
    add     $i7, $i6, $tmp              # |      3,612 |      3,612 |
    store   $i1, [$tmp + 0]             # |      3,612 |      3,612 |
    add     $i6, -1, $i6                # |      3,612 |      3,612 |
    b       iter_setup_dirvec_constants.2826# |      3,612 |      3,612 |
bne.22235:
    bne     $i1, 2, bne.22236           # |      6,622 |      6,622 |
be.22236:
    jal     setup_surface_table.2820, $ra1# |      1,204 |      1,204 |
.count storer
    add     $i7, $i6, $tmp              # |      1,204 |      1,204 |
    store   $i1, [$tmp + 0]             # |      1,204 |      1,204 |
    add     $i6, -1, $i6                # |      1,204 |      1,204 |
    b       iter_setup_dirvec_constants.2826# |      1,204 |      1,204 |
bne.22236:
    jal     setup_second_table.2823, $ra1# |      5,418 |      5,418 |
.count storer
    add     $i7, $i6, $tmp              # |      5,418 |      5,418 |
    store   $i1, [$tmp + 0]             # |      5,418 |      5,418 |
    add     $i6, -1, $i6                # |      5,418 |      5,418 |
    b       iter_setup_dirvec_constants.2826# |      5,418 |      5,418 |
bl.22234:
    jr      $ra2                        # |        602 |        602 |
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
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
    add     $ig0, -1, $i6               # |        602 |        602 |
    b       iter_setup_dirvec_constants.2826# |        602 |        602 |
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1, $i3 - $i5]
# [$f1 - $f6]
# []
# []
# []
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
    bl      $i1, 0, bl.22237            # |    667,764 |    667,764 |
bge.22237:
    load    [ext_objects + $i1], $i3    # |    630,666 |    630,666 |
    load    [$i2 + 0], $f1              # |    630,666 |    630,666 |
    load    [$i3 + 7], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i3 + 19]             # |    630,666 |    630,666 |
    load    [$i2 + 1], $f1              # |    630,666 |    630,666 |
    load    [$i3 + 8], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i3 + 20]             # |    630,666 |    630,666 |
    load    [$i2 + 2], $f1              # |    630,666 |    630,666 |
    load    [$i3 + 9], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i3 + 21]             # |    630,666 |    630,666 |
    load    [$i3 + 1], $i4              # |    630,666 |    630,666 |
    bne     $i4, 2, bne.22238           # |    630,666 |    630,666 |
be.22238:
    load    [$i3 + 19], $f1             # |     74,196 |     74,196 |
    load    [$i3 + 4], $f2              # |     74,196 |     74,196 |
    fmul    $f2, $f1, $f1               # |     74,196 |     74,196 |
    load    [$i3 + 20], $f2             # |     74,196 |     74,196 |
    load    [$i3 + 5], $f3              # |     74,196 |     74,196 |
    fmul    $f3, $f2, $f2               # |     74,196 |     74,196 |
    fadd    $f1, $f2, $f1               # |     74,196 |     74,196 |
    load    [$i3 + 21], $f2             # |     74,196 |     74,196 |
    load    [$i3 + 6], $f3              # |     74,196 |     74,196 |
    fmul    $f3, $f2, $f2               # |     74,196 |     74,196 |
    fadd    $f1, $f2, $f1               # |     74,196 |     74,196 |
    store   $f1, [$i3 + 22]             # |     74,196 |     74,196 |
    add     $i1, -1, $i1                # |     74,196 |     74,196 |
    b       setup_startp_constants.2831 # |     74,196 |     74,196 |
bne.22238:
    bg      $i4, 2, bg.22239            # |    556,470 |    556,470 |
ble.22239:
    add     $i1, -1, $i1                # |    222,588 |    222,588 |
    b       setup_startp_constants.2831 # |    222,588 |    222,588 |
bg.22239:
    load    [$i3 + 3], $i5              # |    333,882 |    333,882 |
    load    [$i3 + 19], $f1             # |    333,882 |    333,882 |
    load    [$i3 + 20], $f2             # |    333,882 |    333,882 |
    load    [$i3 + 21], $f3             # |    333,882 |    333,882 |
    fmul    $f1, $f1, $f4               # |    333,882 |    333,882 |
    load    [$i3 + 4], $f5              # |    333,882 |    333,882 |
    fmul    $f4, $f5, $f4               # |    333,882 |    333,882 |
    fmul    $f2, $f2, $f5               # |    333,882 |    333,882 |
    load    [$i3 + 5], $f6              # |    333,882 |    333,882 |
    fmul    $f5, $f6, $f5               # |    333,882 |    333,882 |
    fadd    $f4, $f5, $f4               # |    333,882 |    333,882 |
    fmul    $f3, $f3, $f5               # |    333,882 |    333,882 |
    load    [$i3 + 6], $f6              # |    333,882 |    333,882 |
    fmul    $f5, $f6, $f5               # |    333,882 |    333,882 |
    fadd    $f4, $f5, $f4               # |    333,882 |    333,882 |
    bne     $i5, 0, bne.22240           # |    333,882 |    333,882 |
be.22240:
    mov     $f4, $f1                    # |    333,882 |    333,882 |
    be      $i4, 3, be.22241            # |    333,882 |    333,882 |
.count dual_jmp
    b       bne.22241
bne.22240:
    fmul    $f2, $f3, $f5
    load    [$i3 + 16], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i3 + 17], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i3 + 18], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
    bne     $i4, 3, bne.22241
be.22241:
    fsub    $f1, $fc0, $f1              # |    333,882 |    333,882 |
    store   $f1, [$i3 + 22]             # |    333,882 |    333,882 |
    add     $i1, -1, $i1                # |    333,882 |    333,882 |
    b       setup_startp_constants.2831 # |    333,882 |    333,882 |
bne.22241:
    store   $f1, [$i3 + 22]
    add     $i1, -1, $i1
    b       setup_startp_constants.2831
bl.22237:
    ret                                 # |     37,098 |     37,098 |
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i2, $i4 - $i7]
# [$f1, $f5 - $f9]
# []
# []
# []
######################################################################
.begin check_all_inside
check_all_inside.2856:
    load    [$i3 + $i1], $i2            # |  1,716,699 |  1,716,699 |
    be      $i2, -1, be.22296           # |  1,716,699 |  1,716,699 |
bne.22242:
    load    [ext_objects + $i2], $i2    # |  1,694,570 |  1,694,570 |
    load    [$i2 + 1], $i4              # |  1,694,570 |  1,694,570 |
    load    [$i2 + 7], $f1              # |  1,694,570 |  1,694,570 |
    fsub    $f2, $f1, $f1               # |  1,694,570 |  1,694,570 |
    load    [$i2 + 8], $f5              # |  1,694,570 |  1,694,570 |
    fsub    $f3, $f5, $f5               # |  1,694,570 |  1,694,570 |
    load    [$i2 + 9], $f6              # |  1,694,570 |  1,694,570 |
    fsub    $f4, $f6, $f6               # |  1,694,570 |  1,694,570 |
    bne     $i4, 1, bne.22243           # |  1,694,570 |  1,694,570 |
be.22243:
    load    [$i2 + 4], $f7              # |    716,988 |    716,988 |
    fabs    $f1, $f1                    # |    716,988 |    716,988 |
    ble     $f7, $f1, ble.22246         # |    716,988 |    716,988 |
bg.22244:
    load    [$i2 + 5], $f1              # |    518,776 |    518,776 |
    fabs    $f5, $f5                    # |    518,776 |    518,776 |
    bg      $f1, $f5, bg.22246          # |    518,776 |    518,776 |
ble.22246:
    load    [$i2 + 10], $i2             # |    253,532 |    253,532 |
    be      $i2, 0, bne.22258           # |    253,532 |    253,532 |
.count dual_jmp
    b       be.22258
bg.22246:
    load    [$i2 + 6], $f1              # |    463,456 |    463,456 |
    fabs    $f6, $f5                    # |    463,456 |    463,456 |
    load    [$i2 + 10], $i2             # |    463,456 |    463,456 |
    bg      $f1, $f5, bg.22248          # |    463,456 |    463,456 |
ble.22248:
    be      $i2, 0, bne.22258           # |     17,095 |     17,095 |
.count dual_jmp
    b       be.22258
bg.22248:
    be      $i2, 0, be.22258            # |    446,361 |    446,361 |
.count dual_jmp
    b       bne.22258
bne.22243:
    bne     $i4, 2, bne.22250           # |    977,582 |    977,582 |
be.22250:
    load    [$i2 + 10], $i4             # |    460,717 |    460,717 |
    load    [$i2 + 4], $f7              # |    460,717 |    460,717 |
    fmul    $f7, $f1, $f1               # |    460,717 |    460,717 |
    load    [$i2 + 5], $f7              # |    460,717 |    460,717 |
    fmul    $f7, $f5, $f5               # |    460,717 |    460,717 |
    fadd    $f1, $f5, $f1               # |    460,717 |    460,717 |
    load    [$i2 + 6], $f5              # |    460,717 |    460,717 |
    fmul    $f5, $f6, $f5               # |    460,717 |    460,717 |
    fadd    $f1, $f5, $f1               # |    460,717 |    460,717 |
    bg      $f0, $f1, bg.22251          # |    460,717 |    460,717 |
ble.22251:
    be      $i4, 0, bne.22258           # |    460,717 |    460,717 |
.count dual_jmp
    b       be.22258                    # |    460,717 |    460,717 |
bg.22251:
    be      $i4, 0, be.22258
.count dual_jmp
    b       bne.22258
bne.22250:
    load    [$i2 + 10], $i5             # |    516,865 |    516,865 |
    fmul    $f1, $f1, $f7               # |    516,865 |    516,865 |
    load    [$i2 + 4], $f8              # |    516,865 |    516,865 |
    fmul    $f7, $f8, $f7               # |    516,865 |    516,865 |
    fmul    $f5, $f5, $f8               # |    516,865 |    516,865 |
    load    [$i2 + 5], $f9              # |    516,865 |    516,865 |
    fmul    $f8, $f9, $f8               # |    516,865 |    516,865 |
    fadd    $f7, $f8, $f7               # |    516,865 |    516,865 |
    fmul    $f6, $f6, $f8               # |    516,865 |    516,865 |
    load    [$i2 + 6], $f9              # |    516,865 |    516,865 |
    fmul    $f8, $f9, $f8               # |    516,865 |    516,865 |
    fadd    $f7, $f8, $f7               # |    516,865 |    516,865 |
    load    [$i2 + 3], $i6              # |    516,865 |    516,865 |
    bne     $i6, 0, bne.22254           # |    516,865 |    516,865 |
be.22254:
    mov     $f7, $f1                    # |    516,865 |    516,865 |
    be      $i4, 3, be.22255            # |    516,865 |    516,865 |
.count dual_jmp
    b       bne.22255
bne.22254:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 18], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
    bne     $i4, 3, bne.22255
be.22255:
    fsub    $f1, $fc0, $f1              # |    516,865 |    516,865 |
    ble     $f0, $f1, ble.22256         # |    516,865 |    516,865 |
.count dual_jmp
    b       bg.22256                    # |    332,169 |    332,169 |
bne.22255:
    bg      $f0, $f1, bg.22256
ble.22256:
    be      $i5, 0, bne.22258           # |    184,696 |    184,696 |
.count dual_jmp
    b       be.22258
bg.22256:
    bne     $i5, 0, bne.22258           # |    332,169 |    332,169 |
be.22258:
    add     $i1, 1, $i2                 # |  1,239,247 |  1,239,247 |
    load    [$i3 + $i2], $i2            # |  1,239,247 |  1,239,247 |
    be      $i2, -1, be.22296           # |  1,239,247 |  1,239,247 |
bne.22260:
    load    [ext_objects + $i2], $i2    # |    642,309 |    642,309 |
    load    [$i2 + 1], $i4              # |    642,309 |    642,309 |
    load    [$i2 + 7], $f1              # |    642,309 |    642,309 |
    fsub    $f2, $f1, $f1               # |    642,309 |    642,309 |
    load    [$i2 + 8], $f5              # |    642,309 |    642,309 |
    fsub    $f3, $f5, $f5               # |    642,309 |    642,309 |
    load    [$i2 + 9], $f6              # |    642,309 |    642,309 |
    fsub    $f4, $f6, $f6               # |    642,309 |    642,309 |
    bne     $i4, 1, bne.22261           # |    642,309 |    642,309 |
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
    bg      $f1, $f5, bg.22266
ble.22266:
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22276
bg.22266:
    be      $i2, 0, be.22276
.count dual_jmp
    b       bne.22258
bne.22261:
    bne     $i4, 2, bne.22268           # |    642,309 |    642,309 |
be.22268:
    load    [$i2 + 10], $i4             # |     31,832 |     31,832 |
    load    [$i2 + 4], $f7              # |     31,832 |     31,832 |
    fmul    $f7, $f1, $f1               # |     31,832 |     31,832 |
    load    [$i2 + 5], $f7              # |     31,832 |     31,832 |
    fmul    $f7, $f5, $f5               # |     31,832 |     31,832 |
    fadd    $f1, $f5, $f1               # |     31,832 |     31,832 |
    load    [$i2 + 6], $f5              # |     31,832 |     31,832 |
    fmul    $f5, $f6, $f5               # |     31,832 |     31,832 |
    fadd    $f1, $f5, $f1               # |     31,832 |     31,832 |
    bg      $f0, $f1, bg.22269          # |     31,832 |     31,832 |
ble.22269:
    be      $i4, 0, bne.22258           # |     20,424 |     20,424 |
.count dual_jmp
    b       be.22276                    # |     20,424 |     20,424 |
bg.22269:
    be      $i4, 0, be.22276            # |     11,408 |     11,408 |
.count dual_jmp
    b       bne.22258                   # |     11,408 |     11,408 |
bne.22268:
    load    [$i2 + 10], $i5             # |    610,477 |    610,477 |
    load    [$i2 + 3], $i6              # |    610,477 |    610,477 |
    fmul    $f1, $f1, $f7               # |    610,477 |    610,477 |
    load    [$i2 + 4], $f8              # |    610,477 |    610,477 |
    fmul    $f7, $f8, $f7               # |    610,477 |    610,477 |
    fmul    $f5, $f5, $f8               # |    610,477 |    610,477 |
    load    [$i2 + 5], $f9              # |    610,477 |    610,477 |
    fmul    $f8, $f9, $f8               # |    610,477 |    610,477 |
    fadd    $f7, $f8, $f7               # |    610,477 |    610,477 |
    fmul    $f6, $f6, $f8               # |    610,477 |    610,477 |
    load    [$i2 + 6], $f9              # |    610,477 |    610,477 |
    fmul    $f8, $f9, $f8               # |    610,477 |    610,477 |
    fadd    $f7, $f8, $f7               # |    610,477 |    610,477 |
    bne     $i6, 0, bne.22272           # |    610,477 |    610,477 |
be.22272:
    mov     $f7, $f1                    # |    610,477 |    610,477 |
    be      $i4, 3, be.22273            # |    610,477 |    610,477 |
.count dual_jmp
    b       bne.22273
bne.22272:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 18], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
    bne     $i4, 3, bne.22273
be.22273:
    fsub    $f1, $fc0, $f1              # |    610,477 |    610,477 |
    ble     $f0, $f1, ble.22274         # |    610,477 |    610,477 |
.count dual_jmp
    b       bg.22274                    # |    310,524 |    310,524 |
bne.22273:
    bg      $f0, $f1, bg.22274
ble.22274:
    be      $i5, 0, bne.22258           # |    299,953 |    299,953 |
.count dual_jmp
    b       be.22276                    # |    191,572 |    191,572 |
bg.22274:
    bne     $i5, 0, bne.22258           # |    310,524 |    310,524 |
be.22276:
    add     $i1, 2, $i2                 # |    455,457 |    455,457 |
    load    [$i3 + $i2], $i2            # |    455,457 |    455,457 |
    be      $i2, -1, be.22296           # |    455,457 |    455,457 |
bne.22278:
    load    [ext_objects + $i2], $i2    # |    235,790 |    235,790 |
    load    [$i2 + 1], $i4              # |    235,790 |    235,790 |
    load    [$i2 + 7], $f1              # |    235,790 |    235,790 |
    fsub    $f2, $f1, $f1               # |    235,790 |    235,790 |
    load    [$i2 + 8], $f5              # |    235,790 |    235,790 |
    fsub    $f3, $f5, $f5               # |    235,790 |    235,790 |
    load    [$i2 + 9], $f6              # |    235,790 |    235,790 |
    fsub    $f4, $f6, $f6               # |    235,790 |    235,790 |
    bne     $i4, 1, bne.22279           # |    235,790 |    235,790 |
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
    bg      $f1, $f5, bg.22284
ble.22284:
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22294
bg.22284:
    be      $i2, 0, be.22294
.count dual_jmp
    b       bne.22258
bne.22279:
    bne     $i4, 2, bne.22286           # |    235,790 |    235,790 |
be.22286:
    load    [$i2 + 10], $i4             # |     46,329 |     46,329 |
    load    [$i2 + 4], $f7              # |     46,329 |     46,329 |
    fmul    $f7, $f1, $f1               # |     46,329 |     46,329 |
    load    [$i2 + 5], $f7              # |     46,329 |     46,329 |
    fmul    $f7, $f5, $f5               # |     46,329 |     46,329 |
    fadd    $f1, $f5, $f1               # |     46,329 |     46,329 |
    load    [$i2 + 6], $f5              # |     46,329 |     46,329 |
    fmul    $f5, $f6, $f5               # |     46,329 |     46,329 |
    fadd    $f1, $f5, $f1               # |     46,329 |     46,329 |
    bg      $f0, $f1, bg.22287          # |     46,329 |     46,329 |
ble.22287:
    be      $i4, 0, bne.22258           # |     26,054 |     26,054 |
.count dual_jmp
    b       be.22294                    # |     26,054 |     26,054 |
bg.22287:
    be      $i4, 0, be.22294            # |     20,275 |     20,275 |
.count dual_jmp
    b       bne.22258                   # |     20,275 |     20,275 |
bne.22286:
    load    [$i2 + 10], $i5             # |    189,461 |    189,461 |
    load    [$i2 + 3], $i6              # |    189,461 |    189,461 |
    fmul    $f1, $f1, $f7               # |    189,461 |    189,461 |
    load    [$i2 + 4], $f8              # |    189,461 |    189,461 |
    fmul    $f7, $f8, $f7               # |    189,461 |    189,461 |
    fmul    $f5, $f5, $f8               # |    189,461 |    189,461 |
    load    [$i2 + 5], $f9              # |    189,461 |    189,461 |
    fmul    $f8, $f9, $f8               # |    189,461 |    189,461 |
    fadd    $f7, $f8, $f7               # |    189,461 |    189,461 |
    fmul    $f6, $f6, $f8               # |    189,461 |    189,461 |
    load    [$i2 + 6], $f9              # |    189,461 |    189,461 |
    fmul    $f8, $f9, $f8               # |    189,461 |    189,461 |
    fadd    $f7, $f8, $f7               # |    189,461 |    189,461 |
    bne     $i6, 0, bne.22290           # |    189,461 |    189,461 |
be.22290:
    mov     $f7, $f1                    # |    189,461 |    189,461 |
    be      $i4, 3, be.22291            # |    189,461 |    189,461 |
.count dual_jmp
    b       bne.22291
bne.22290:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 18], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
    bne     $i4, 3, bne.22291
be.22291:
    fsub    $f1, $fc0, $f1              # |    189,461 |    189,461 |
    ble     $f0, $f1, ble.22292         # |    189,461 |    189,461 |
.count dual_jmp
    b       bg.22292                    # |     36,240 |     36,240 |
bne.22291:
    bg      $f0, $f1, bg.22292
ble.22292:
    be      $i5, 0, bne.22258           # |    153,221 |    153,221 |
.count dual_jmp
    b       be.22294                    # |    153,221 |    153,221 |
bg.22292:
    bne     $i5, 0, bne.22258           # |     36,240 |     36,240 |
be.22294:
    add     $i1, 3, $i2                 # |    179,275 |    179,275 |
    load    [$i3 + $i2], $i2            # |    179,275 |    179,275 |
    bne     $i2, -1, bne.22296          # |    179,275 |    179,275 |
be.22296:
    li      1, $i1                      # |  1,018,009 |  1,018,009 |
    ret                                 # |  1,018,009 |  1,018,009 |
bne.22296:
    load    [ext_objects + $i2], $i2
    load    [$i2 + 1], $i4
    load    [$i2 + 7], $f1
    load    [$i2 + 8], $f5
    load    [$i2 + 9], $f6
    fsub    $f2, $f1, $f1
    fsub    $f3, $f5, $f5
    fsub    $f4, $f6, $f6
    bne     $i4, 1, bne.22297
be.22297:
    load    [$i2 + 4], $f7
    fabs    $f1, $f1
    ble     $f7, $f1, ble.22300
bg.22298:
    load    [$i2 + 5], $f1
    fabs    $f5, $f5
    ble     $f1, $f5, ble.22300
bg.22299:
    load    [$i2 + 6], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, bg.22300
ble.22300:
    load    [$i2 + 10], $i2
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22312
bg.22300:
    load    [$i2 + 10], $i2
    be      $i2, 0, be.22312
.count dual_jmp
    b       bne.22258
bne.22297:
    bne     $i4, 2, bne.22304
be.22304:
    load    [$i2 + 10], $i4
    load    [$i2 + 4], $f7
    fmul    $f7, $f1, $f1
    load    [$i2 + 5], $f7
    fmul    $f7, $f5, $f5
    fadd    $f1, $f5, $f1
    load    [$i2 + 6], $f5
    fmul    $f5, $f6, $f5
    fadd    $f1, $f5, $f1
    bg      $f0, $f1, bg.22305
ble.22305:
    be      $i4, 0, bne.22258
.count dual_jmp
    b       be.22312
bg.22305:
    be      $i4, 0, be.22312
.count dual_jmp
    b       bne.22258
bne.22304:
    load    [$i2 + 10], $i5
    load    [$i2 + 3], $i6
    fmul    $f1, $f1, $f7
    load    [$i2 + 4], $f8
    fmul    $f7, $f8, $f7
    fmul    $f5, $f5, $f8
    load    [$i2 + 5], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f6, $f8
    load    [$i2 + 6], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    bne     $i6, 0, bne.22308
be.22308:
    mov     $f7, $f1
    be      $i4, 3, be.22309
.count dual_jmp
    b       bne.22309
bne.22308:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 18], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
    bne     $i4, 3, bne.22309
be.22309:
    fsub    $f1, $fc0, $f1
    ble     $f0, $f1, ble.22310
.count dual_jmp
    b       bg.22310
bne.22309:
    bg      $f0, $f1, bg.22310
ble.22310:
    be      $i5, 0, bne.22258
.count dual_jmp
    b       be.22312
bg.22310:
    bne     $i5, 0, bne.22258
be.22312:
    add     $i1, 4, $i1
    b       check_all_inside.2856
bne.22258:
    li      0, $i1                      # |    698,690 |    698,690 |
    ret                                 # |    698,690 |    698,690 |
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i8, $i3)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i8]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
    load    [$i3 + $i8], $i1            # |  4,223,804 |  4,223,804 |
    be      $i1, -1, be.22336           # |  4,223,804 |  4,223,804 |
bne.22313:
    load    [ext_objects + $i1], $i2    # |  3,595,854 |  3,595,854 |
    load    [ext_light_dirvec + 3], $i4 # |  3,595,854 |  3,595,854 |
    load    [$i2 + 1], $i5              # |  3,595,854 |  3,595,854 |
    load    [ext_intersection_point + 0], $f1# |  3,595,854 |  3,595,854 |
    load    [$i2 + 7], $f2              # |  3,595,854 |  3,595,854 |
    fsub    $f1, $f2, $f1               # |  3,595,854 |  3,595,854 |
    load    [ext_intersection_point + 1], $f2# |  3,595,854 |  3,595,854 |
    load    [$i2 + 8], $f3              # |  3,595,854 |  3,595,854 |
    fsub    $f2, $f3, $f2               # |  3,595,854 |  3,595,854 |
    load    [ext_intersection_point + 2], $f3# |  3,595,854 |  3,595,854 |
    load    [$i2 + 9], $f4              # |  3,595,854 |  3,595,854 |
    fsub    $f3, $f4, $f3               # |  3,595,854 |  3,595,854 |
    load    [$i4 + $i1], $i4            # |  3,595,854 |  3,595,854 |
    bne     $i5, 1, bne.22314           # |  3,595,854 |  3,595,854 |
be.22314:
    load    [$i2 + 5], $f4              # |  1,410,052 |  1,410,052 |
    load    [%{ext_light_dirvec + 0} + 1], $f5# |  1,410,052 |  1,410,052 |
    load    [$i4 + 0], $f6              # |  1,410,052 |  1,410,052 |
    fsub    $f6, $f1, $f6               # |  1,410,052 |  1,410,052 |
    load    [$i4 + 1], $f7              # |  1,410,052 |  1,410,052 |
    fmul    $f6, $f7, $f6               # |  1,410,052 |  1,410,052 |
    fmul    $f6, $f5, $f5               # |  1,410,052 |  1,410,052 |
    fadd_a  $f5, $f2, $f5               # |  1,410,052 |  1,410,052 |
    ble     $f4, $f5, be.22317          # |  1,410,052 |  1,410,052 |
bg.22315:
    load    [$i2 + 6], $f4              # |    411,504 |    411,504 |
    load    [%{ext_light_dirvec + 0} + 2], $f5# |    411,504 |    411,504 |
    fmul    $f6, $f5, $f5               # |    411,504 |    411,504 |
    fadd_a  $f5, $f3, $f5               # |    411,504 |    411,504 |
    ble     $f4, $f5, be.22317          # |    411,504 |    411,504 |
bg.22316:
    load    [$i4 + 1], $f4              # |    275,106 |    275,106 |
    bne     $f4, $f0, bne.22317         # |    275,106 |    275,106 |
be.22317:
    load    [$i2 + 4], $f4              # |  1,134,946 |  1,134,946 |
    load    [%{ext_light_dirvec + 0} + 0], $f5# |  1,134,946 |  1,134,946 |
    load    [$i4 + 2], $f6              # |  1,134,946 |  1,134,946 |
    fsub    $f6, $f2, $f6               # |  1,134,946 |  1,134,946 |
    load    [$i4 + 3], $f7              # |  1,134,946 |  1,134,946 |
    fmul    $f6, $f7, $f6               # |  1,134,946 |  1,134,946 |
    fmul    $f6, $f5, $f5               # |  1,134,946 |  1,134,946 |
    fadd_a  $f5, $f1, $f5               # |  1,134,946 |  1,134,946 |
    ble     $f4, $f5, be.22321          # |  1,134,946 |  1,134,946 |
bg.22319:
    load    [$i2 + 6], $f4              # |    502,266 |    502,266 |
    load    [%{ext_light_dirvec + 0} + 2], $f5# |    502,266 |    502,266 |
    fmul    $f6, $f5, $f5               # |    502,266 |    502,266 |
    fadd_a  $f5, $f3, $f5               # |    502,266 |    502,266 |
    ble     $f4, $f5, be.22321          # |    502,266 |    502,266 |
bg.22320:
    load    [$i4 + 3], $f4              # |    363,230 |    363,230 |
    bne     $f4, $f0, bne.22317         # |    363,230 |    363,230 |
be.22321:
    load    [$i2 + 4], $f4              # |    771,716 |    771,716 |
    load    [%{ext_light_dirvec + 0} + 0], $f5# |    771,716 |    771,716 |
    load    [$i4 + 4], $f6              # |    771,716 |    771,716 |
    fsub    $f6, $f3, $f3               # |    771,716 |    771,716 |
    load    [$i4 + 5], $f6              # |    771,716 |    771,716 |
    fmul    $f3, $f6, $f3               # |    771,716 |    771,716 |
    fmul    $f3, $f5, $f5               # |    771,716 |    771,716 |
    fadd_a  $f5, $f1, $f1               # |    771,716 |    771,716 |
    ble     $f4, $f1, ble.22334         # |    771,716 |    771,716 |
bg.22323:
    load    [$i2 + 5], $f1              # |    129,341 |    129,341 |
    load    [%{ext_light_dirvec + 0} + 1], $f4# |    129,341 |    129,341 |
    fmul    $f3, $f4, $f4               # |    129,341 |    129,341 |
    fadd_a  $f4, $f2, $f2               # |    129,341 |    129,341 |
    ble     $f1, $f2, ble.22334         # |    129,341 |    129,341 |
bg.22324:
    load    [$i4 + 5], $f1              # |     50,883 |     50,883 |
    be      $f1, $f0, ble.22334         # |     50,883 |     50,883 |
bne.22325:
    mov     $f3, $fg0                   # |     50,883 |     50,883 |
.count load_float
    load    [f.21980], $f1              # |     50,883 |     50,883 |
    ble     $f1, $fg0, ble.22334        # |     50,883 |     50,883 |
.count dual_jmp
    b       bg.22334                    # |     46,385 |     46,385 |
bne.22317:
    mov     $f6, $fg0                   # |    638,336 |    638,336 |
.count load_float
    load    [f.21980], $f1              # |    638,336 |    638,336 |
    ble     $f1, $fg0, ble.22334        # |    638,336 |    638,336 |
.count dual_jmp
    b       bg.22334                    # |    285,773 |    285,773 |
bne.22314:
    load    [$i4 + 0], $f4              # |  2,185,802 |  2,185,802 |
    bne     $i5, 2, bne.22326           # |  2,185,802 |  2,185,802 |
be.22326:
    ble     $f0, $f4, ble.22334         # |    566,304 |    566,304 |
bg.22327:
    load    [$i4 + 1], $f4              # |    554,887 |    554,887 |
    fmul    $f4, $f1, $f1               # |    554,887 |    554,887 |
    load    [$i4 + 2], $f4              # |    554,887 |    554,887 |
    fmul    $f4, $f2, $f2               # |    554,887 |    554,887 |
    fadd    $f1, $f2, $f1               # |    554,887 |    554,887 |
    load    [$i4 + 3], $f2              # |    554,887 |    554,887 |
    fmul    $f2, $f3, $f2               # |    554,887 |    554,887 |
    fadd    $f1, $f2, $fg0              # |    554,887 |    554,887 |
.count load_float
    load    [f.21980], $f1              # |    554,887 |    554,887 |
    ble     $f1, $fg0, ble.22334        # |    554,887 |    554,887 |
.count dual_jmp
    b       bg.22334
bne.22326:
    be      $f4, $f0, ble.22334         # |  1,619,498 |  1,619,498 |
bne.22328:
    load    [$i4 + 1], $f5              # |  1,619,498 |  1,619,498 |
    fmul    $f5, $f1, $f5               # |  1,619,498 |  1,619,498 |
    load    [$i4 + 2], $f6              # |  1,619,498 |  1,619,498 |
    fmul    $f6, $f2, $f6               # |  1,619,498 |  1,619,498 |
    fadd    $f5, $f6, $f5               # |  1,619,498 |  1,619,498 |
    load    [$i4 + 3], $f6              # |  1,619,498 |  1,619,498 |
    fmul    $f6, $f3, $f6               # |  1,619,498 |  1,619,498 |
    fadd    $f5, $f6, $f5               # |  1,619,498 |  1,619,498 |
    fmul    $f5, $f5, $f6               # |  1,619,498 |  1,619,498 |
    fmul    $f1, $f1, $f7               # |  1,619,498 |  1,619,498 |
    load    [$i2 + 4], $f8              # |  1,619,498 |  1,619,498 |
    fmul    $f7, $f8, $f7               # |  1,619,498 |  1,619,498 |
    fmul    $f2, $f2, $f8               # |  1,619,498 |  1,619,498 |
    load    [$i2 + 5], $f9              # |  1,619,498 |  1,619,498 |
    fmul    $f8, $f9, $f8               # |  1,619,498 |  1,619,498 |
    fadd    $f7, $f8, $f7               # |  1,619,498 |  1,619,498 |
    fmul    $f3, $f3, $f8               # |  1,619,498 |  1,619,498 |
    load    [$i2 + 6], $f9              # |  1,619,498 |  1,619,498 |
    fmul    $f8, $f9, $f8               # |  1,619,498 |  1,619,498 |
    fadd    $f7, $f8, $f7               # |  1,619,498 |  1,619,498 |
    load    [$i2 + 3], $i6              # |  1,619,498 |  1,619,498 |
    bne     $i6, 0, bne.22329           # |  1,619,498 |  1,619,498 |
be.22329:
    mov     $f7, $f1                    # |  1,619,498 |  1,619,498 |
    be      $i5, 3, be.22330            # |  1,619,498 |  1,619,498 |
.count dual_jmp
    b       bne.22330
bne.22329:
    fmul    $f2, $f3, $f8
    load    [$i2 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i2 + 18], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
    bne     $i5, 3, bne.22330
be.22330:
    fsub    $f1, $fc0, $f1              # |  1,619,498 |  1,619,498 |
    fmul    $f4, $f1, $f1               # |  1,619,498 |  1,619,498 |
    fsub    $f6, $f1, $f1               # |  1,619,498 |  1,619,498 |
    ble     $f1, $f0, ble.22334         # |  1,619,498 |  1,619,498 |
.count dual_jmp
    b       bg.22331                    # |    348,984 |    348,984 |
bne.22330:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    ble     $f1, $f0, ble.22334
bg.22331:
    load    [$i2 + 10], $i2             # |    348,984 |    348,984 |
    load    [$i4 + 4], $f2              # |    348,984 |    348,984 |
    fsqrt   $f1, $f1                    # |    348,984 |    348,984 |
    bne     $i2, 0, bne.22332           # |    348,984 |    348,984 |
be.22332:
    fsub    $f5, $f1, $f1               # |    278,797 |    278,797 |
    fmul    $f1, $f2, $fg0              # |    278,797 |    278,797 |
.count load_float
    load    [f.21980], $f1              # |    278,797 |    278,797 |
    ble     $f1, $fg0, ble.22334        # |    278,797 |    278,797 |
.count dual_jmp
    b       bg.22334                    # |    218,864 |    218,864 |
bne.22332:
    fadd    $f5, $f1, $f1               # |     70,187 |     70,187 |
    fmul    $f1, $f2, $fg0              # |     70,187 |     70,187 |
.count load_float
    load    [f.21980], $f1              # |     70,187 |     70,187 |
    bg      $f1, $fg0, bg.22334         # |     70,187 |     70,187 |
ble.22334:
    load    [ext_objects + $i1], $i1    # |  3,032,162 |  3,032,162 |
    load    [$i1 + 10], $i1             # |  3,032,162 |  3,032,162 |
    bne     $i1, 0, bne.22353           # |  3,032,162 |  3,032,162 |
be.22336:
    li      0, $i1                      # |  3,034,214 |  3,034,214 |
    jr      $ra1                        # |  3,034,214 |  3,034,214 |
bg.22334:
    load    [$i3 + 0], $i1              # |    563,692 |    563,692 |
    be      $i1, -1, bne.22355          # |    563,692 |    563,692 |
bne.22337:
    load    [ext_objects + $i1], $i1    # |    563,692 |    563,692 |
    load    [$i1 + 1], $i2              # |    563,692 |    563,692 |
    load    [$i1 + 7], $f1              # |    563,692 |    563,692 |
    fadd    $fg0, $fc15, $f2            # |    563,692 |    563,692 |
    fmul    $fg14, $f2, $f3             # |    563,692 |    563,692 |
    load    [ext_intersection_point + 0], $f4# |    563,692 |    563,692 |
    fadd    $f3, $f4, $f5               # |    563,692 |    563,692 |
    fsub    $f5, $f1, $f1               # |    563,692 |    563,692 |
    load    [$i1 + 8], $f3              # |    563,692 |    563,692 |
    fmul    $fg12, $f2, $f4             # |    563,692 |    563,692 |
    load    [ext_intersection_point + 1], $f6# |    563,692 |    563,692 |
    fadd    $f4, $f6, $f6               # |    563,692 |    563,692 |
    fsub    $f6, $f3, $f3               # |    563,692 |    563,692 |
    load    [$i1 + 9], $f4              # |    563,692 |    563,692 |
    fmul    $fg13, $f2, $f2             # |    563,692 |    563,692 |
    load    [ext_intersection_point + 2], $f7# |    563,692 |    563,692 |
    fadd    $f2, $f7, $f7               # |    563,692 |    563,692 |
    fsub    $f7, $f4, $f2               # |    563,692 |    563,692 |
    bne     $i2, 1, bne.22338           # |    563,692 |    563,692 |
be.22338:
    load    [$i1 + 4], $f4              # |    541,977 |    541,977 |
    fabs    $f1, $f1                    # |    541,977 |    541,977 |
    ble     $f4, $f1, ble.22341         # |    541,977 |    541,977 |
bg.22339:
    load    [$i1 + 5], $f1              # |    485,570 |    485,570 |
    fabs    $f3, $f3                    # |    485,570 |    485,570 |
    bg      $f1, $f3, bg.22341          # |    485,570 |    485,570 |
ble.22341:
    load    [$i1 + 10], $i1             # |     62,016 |     62,016 |
    be      $i1, 0, bne.22353           # |     62,016 |     62,016 |
.count dual_jmp
    b       be.22353
bg.22341:
    load    [$i1 + 6], $f1              # |    479,961 |    479,961 |
    fabs    $f2, $f2                    # |    479,961 |    479,961 |
    load    [$i1 + 10], $i1             # |    479,961 |    479,961 |
    bg      $f1, $f2, bg.22343          # |    479,961 |    479,961 |
ble.22343:
    be      $i1, 0, bne.22353           # |      2,213 |      2,213 |
.count dual_jmp
    b       be.22353
bg.22343:
    be      $i1, 0, be.22353            # |    477,748 |    477,748 |
.count dual_jmp
    b       bne.22353
bne.22338:
    bne     $i2, 2, bne.22345           # |     21,715 |     21,715 |
be.22345:
    load    [$i1 + 10], $i2
    load    [$i1 + 4], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 5], $f4
    fmul    $f4, $f3, $f3
    fadd    $f1, $f3, $f1
    load    [$i1 + 6], $f3
    fmul    $f3, $f2, $f2
    fadd    $f1, $f2, $f1
    bg      $f0, $f1, bg.22346
ble.22346:
    be      $i2, 0, bne.22353
.count dual_jmp
    b       be.22353
bg.22346:
    be      $i2, 0, be.22353
.count dual_jmp
    b       bne.22353
bne.22345:
    load    [$i1 + 10], $i4             # |     21,715 |     21,715 |
    fmul    $f1, $f1, $f4               # |     21,715 |     21,715 |
    load    [$i1 + 4], $f8              # |     21,715 |     21,715 |
    fmul    $f4, $f8, $f4               # |     21,715 |     21,715 |
    fmul    $f3, $f3, $f8               # |     21,715 |     21,715 |
    load    [$i1 + 5], $f9              # |     21,715 |     21,715 |
    fmul    $f8, $f9, $f8               # |     21,715 |     21,715 |
    fadd    $f4, $f8, $f4               # |     21,715 |     21,715 |
    fmul    $f2, $f2, $f8               # |     21,715 |     21,715 |
    load    [$i1 + 6], $f9              # |     21,715 |     21,715 |
    fmul    $f8, $f9, $f8               # |     21,715 |     21,715 |
    load    [$i1 + 3], $i5              # |     21,715 |     21,715 |
    fadd    $f4, $f8, $f4               # |     21,715 |     21,715 |
    bne     $i5, 0, bne.22349           # |     21,715 |     21,715 |
be.22349:
    mov     $f4, $f1                    # |     21,715 |     21,715 |
    be      $i2, 3, be.22350            # |     21,715 |     21,715 |
.count dual_jmp
    b       bne.22350
bne.22349:
    fmul    $f3, $f2, $f8
    load    [$i1 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f4, $f8, $f4
    fmul    $f2, $f1, $f2
    load    [$i1 + 17], $f8
    fmul    $f2, $f8, $f2
    fadd    $f4, $f2, $f2
    fmul    $f1, $f3, $f1
    load    [$i1 + 18], $f3
    fmul    $f1, $f3, $f1
    fadd    $f2, $f1, $f1
    bne     $i2, 3, bne.22350
be.22350:
    fsub    $f1, $fc0, $f1              # |     21,715 |     21,715 |
    ble     $f0, $f1, ble.22351         # |     21,715 |     21,715 |
.count dual_jmp
    b       bg.22351                    # |     21,715 |     21,715 |
bne.22350:
    bg      $f0, $f1, bg.22351
ble.22351:
    be      $i4, 0, bne.22353
.count dual_jmp
    b       be.22353
bg.22351:
    bne     $i4, 0, bne.22353           # |     21,715 |     21,715 |
be.22353:
    li      1, $i1                      # |    499,463 |    499,463 |
.count move_args
    mov     $f5, $f2                    # |    499,463 |    499,463 |
.count move_args
    mov     $f6, $f3                    # |    499,463 |    499,463 |
.count move_args
    mov     $f7, $f4                    # |    499,463 |    499,463 |
    call    check_all_inside.2856       # |    499,463 |    499,463 |
    bne     $i1, 0, bne.22355           # |    499,463 |    499,463 |
bne.22353:
    add     $i8, 1, $i8                 # |    953,293 |    953,293 |
    b       shadow_check_and_group.2862 # |    953,293 |    953,293 |
bne.22355:
    li      1, $i1                      # |    236,297 |    236,297 |
    jr      $ra1                        # |    236,297 |    236,297 |
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i9, $i10)
# $ra = $ra2
# [$i1 - $i9]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra - $ra1]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
    load    [$i10 + $i9], $i1           # |    223,695 |    223,695 |
    be      $i1, -1, be.22370           # |    223,695 |    223,695 |
bne.22356:
    li      0, $i8                      # |    223,695 |    223,695 |
    load    [ext_and_net + $i1], $i3    # |    223,695 |    223,695 |
    jal     shadow_check_and_group.2862, $ra1# |    223,695 |    223,695 |
    bne     $i1, 0, bne.22357           # |    223,695 |    223,695 |
be.22357:
    add     $i9, 1, $i1                 # |    113,433 |    113,433 |
    load    [$i10 + $i1], $i1           # |    113,433 |    113,433 |
    be      $i1, -1, be.22370           # |    113,433 |    113,433 |
bne.22358:
    li      0, $i8                      # |    113,433 |    113,433 |
    load    [ext_and_net + $i1], $i3    # |    113,433 |    113,433 |
    jal     shadow_check_and_group.2862, $ra1# |    113,433 |    113,433 |
    bne     $i1, 0, bne.22357           # |    113,433 |    113,433 |
be.22359:
    add     $i9, 2, $i1                 # |    106,783 |    106,783 |
    load    [$i10 + $i1], $i1           # |    106,783 |    106,783 |
    be      $i1, -1, be.22370           # |    106,783 |    106,783 |
bne.22360:
    li      0, $i8                      # |     96,452 |     96,452 |
    load    [ext_and_net + $i1], $i3    # |     96,452 |     96,452 |
    jal     shadow_check_and_group.2862, $ra1# |     96,452 |     96,452 |
    bne     $i1, 0, bne.22357           # |     96,452 |     96,452 |
be.22361:
    add     $i9, 3, $i1                 # |     94,280 |     94,280 |
    load    [$i10 + $i1], $i1           # |     94,280 |     94,280 |
    be      $i1, -1, be.22370           # |     94,280 |     94,280 |
bne.22362:
    li      0, $i8                      # |     94,280 |     94,280 |
    load    [ext_and_net + $i1], $i3    # |     94,280 |     94,280 |
    jal     shadow_check_and_group.2862, $ra1# |     94,280 |     94,280 |
    bne     $i1, 0, bne.22357           # |     94,280 |     94,280 |
be.22363:
    add     $i9, 4, $i1                 # |     82,752 |     82,752 |
    load    [$i10 + $i1], $i1           # |     82,752 |     82,752 |
    be      $i1, -1, be.22370           # |     82,752 |     82,752 |
bne.22364:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22357
be.22365:
    add     $i9, 5, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.22370
bne.22366:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22357
be.22367:
    add     $i9, 6, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.22370
bne.22368:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22357
be.22369:
    add     $i9, 7, $i1
    load    [$i10 + $i1], $i1
    bne     $i1, -1, bne.22370
be.22370:
    li      0, $i1                      # |     93,083 |     93,083 |
    jr      $ra2                        # |     93,083 |     93,083 |
bne.22370:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22357
be.22371:
    add     $i9, 8, $i9
    b       shadow_check_one_or_group.2865
bne.22357:
    li      1, $i1                      # |    130,612 |    130,612 |
    jr      $ra2                        # |    130,612 |    130,612 |
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i11, $i12)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra - $ra2]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
    load    [$i12 + $i11], $i10         # |    565,218 |    565,218 |
    load    [$i10 + 0], $i1             # |    565,218 |    565,218 |
    be      $i1, -1, be.22429           # |    565,218 |    565,218 |
bne.22372:
    be      $i1, 99, bne.22396          # |    554,887 |    554,887 |
bne.22373:
    load    [ext_objects + $i1], $i2    # |     10,331 |     10,331 |
    load    [ext_intersection_point + 0], $f1# |     10,331 |     10,331 |
    load    [$i2 + 7], $f2              # |     10,331 |     10,331 |
    fsub    $f1, $f2, $f1               # |     10,331 |     10,331 |
    load    [ext_intersection_point + 1], $f2# |     10,331 |     10,331 |
    load    [$i2 + 8], $f3              # |     10,331 |     10,331 |
    fsub    $f2, $f3, $f2               # |     10,331 |     10,331 |
    load    [ext_intersection_point + 2], $f3# |     10,331 |     10,331 |
    load    [$i2 + 9], $f4              # |     10,331 |     10,331 |
    fsub    $f3, $f4, $f3               # |     10,331 |     10,331 |
    load    [ext_light_dirvec + 3], $i3 # |     10,331 |     10,331 |
    load    [$i3 + $i1], $i1            # |     10,331 |     10,331 |
    load    [$i2 + 1], $i3              # |     10,331 |     10,331 |
    bne     $i3, 1, bne.22374           # |     10,331 |     10,331 |
be.22374:
    load    [$i2 + 5], $f4              # |     10,331 |     10,331 |
    load    [%{ext_light_dirvec + 0} + 1], $f5# |     10,331 |     10,331 |
    load    [$i1 + 0], $f6              # |     10,331 |     10,331 |
    fsub    $f6, $f1, $f6               # |     10,331 |     10,331 |
    load    [$i1 + 1], $f7              # |     10,331 |     10,331 |
    fmul    $f6, $f7, $f6               # |     10,331 |     10,331 |
    fmul    $f6, $f5, $f5               # |     10,331 |     10,331 |
    fadd_a  $f5, $f2, $f5               # |     10,331 |     10,331 |
    ble     $f4, $f5, be.22377          # |     10,331 |     10,331 |
bg.22375:
    load    [$i2 + 6], $f4              # |      3,872 |      3,872 |
    load    [%{ext_light_dirvec + 0} + 2], $f5# |      3,872 |      3,872 |
    fmul    $f6, $f5, $f5               # |      3,872 |      3,872 |
    fadd_a  $f5, $f3, $f5               # |      3,872 |      3,872 |
    ble     $f4, $f5, be.22377          # |      3,872 |      3,872 |
bg.22376:
    load    [$i1 + 1], $f4
    bne     $f4, $f0, bne.22377
be.22377:
    load    [$i2 + 4], $f4              # |     10,331 |     10,331 |
    load    [%{ext_light_dirvec + 0} + 0], $f5# |     10,331 |     10,331 |
    load    [$i1 + 2], $f6              # |     10,331 |     10,331 |
    fsub    $f6, $f2, $f6               # |     10,331 |     10,331 |
    load    [$i1 + 3], $f7              # |     10,331 |     10,331 |
    fmul    $f6, $f7, $f6               # |     10,331 |     10,331 |
    fmul    $f6, $f5, $f5               # |     10,331 |     10,331 |
    fadd_a  $f5, $f1, $f5               # |     10,331 |     10,331 |
    ble     $f4, $f5, be.22381          # |     10,331 |     10,331 |
bg.22379:
    load    [$i2 + 6], $f4              # |      1,255 |      1,255 |
    load    [%{ext_light_dirvec + 0} + 2], $f5# |      1,255 |      1,255 |
    fmul    $f6, $f5, $f5               # |      1,255 |      1,255 |
    fadd_a  $f5, $f3, $f5               # |      1,255 |      1,255 |
    ble     $f4, $f5, be.22381          # |      1,255 |      1,255 |
bg.22380:
    load    [$i1 + 3], $f4
    bne     $f4, $f0, bne.22377
be.22381:
    load    [$i2 + 4], $f4              # |     10,331 |     10,331 |
    load    [%{ext_light_dirvec + 0} + 0], $f5# |     10,331 |     10,331 |
    load    [$i1 + 4], $f6              # |     10,331 |     10,331 |
    fsub    $f6, $f3, $f3               # |     10,331 |     10,331 |
    load    [$i1 + 5], $f6              # |     10,331 |     10,331 |
    fmul    $f3, $f6, $f3               # |     10,331 |     10,331 |
    fmul    $f3, $f5, $f5               # |     10,331 |     10,331 |
    fadd_a  $f5, $f1, $f1               # |     10,331 |     10,331 |
    ble     $f4, $f1, be.22428          # |     10,331 |     10,331 |
bg.22383:
    load    [$i2 + 5], $f1
    load    [%{ext_light_dirvec + 0} + 1], $f4
    fmul    $f3, $f4, $f4
    fadd_a  $f4, $f2, $f2
    ble     $f1, $f2, be.22428
bg.22384:
    load    [$i1 + 5], $f1
    be      $f1, $f0, be.22428
bne.22385:
    mov     $f3, $fg0
    ble     $fc7, $fg0, be.22428
.count dual_jmp
    b       bg.22394
bne.22377:
    mov     $f6, $fg0
    ble     $fc7, $fg0, be.22428
.count dual_jmp
    b       bg.22394
bne.22374:
    load    [$i1 + 0], $f4
    bne     $i3, 2, bne.22386
be.22386:
    ble     $f0, $f4, be.22428
bg.22387:
    load    [$i1 + 1], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 2], $f4
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 3], $f2
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $fg0
    ble     $fc7, $fg0, be.22428
.count dual_jmp
    b       bg.22394
bne.22386:
    be      $f4, $f0, be.22428
bne.22388:
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
    load    [$i2 + 4], $f8
    fmul    $f7, $f8, $f7
    fmul    $f2, $f2, $f8
    load    [$i2 + 5], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f3, $f8
    load    [$i2 + 6], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    load    [$i2 + 3], $i4
    bne     $i4, 0, bne.22389
be.22389:
    mov     $f7, $f1
    be      $i3, 3, be.22390
.count dual_jmp
    b       bne.22390
bne.22389:
    fmul    $f2, $f3, $f8
    load    [$i2 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i2 + 18], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
    bne     $i3, 3, bne.22390
be.22390:
    fsub    $f1, $fc0, $f1
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    ble     $f1, $f0, be.22428
.count dual_jmp
    b       bg.22391
bne.22390:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    ble     $f1, $f0, be.22428
bg.22391:
    load    [$i2 + 10], $i2
    load    [$i1 + 4], $f2
    fsqrt   $f1, $f1
    bne     $i2, 0, bne.22392
be.22392:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ble     $fc7, $fg0, be.22428
.count dual_jmp
    b       bg.22394
bne.22392:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ble     $fc7, $fg0, be.22428
bg.22394:
    load    [$i10 + 1], $i1
    be      $i1, -1, be.22428
bne.22395:
    load    [ext_and_net + $i1], $i3
    li      0, $i8
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22396
be.22396:
    li      2, $i9
    jal     shadow_check_one_or_group.2865, $ra2
    be      $i1, 0, be.22428
bne.22396:
    load    [$i10 + 1], $i1             # |    544,556 |    544,556 |
    be      $i1, -1, be.22428           # |    544,556 |    544,556 |
bne.22414:
    load    [ext_and_net + $i1], $i3    # |    544,556 |    544,556 |
    li      0, $i8                      # |    544,556 |    544,556 |
    jal     shadow_check_and_group.2862, $ra1# |    544,556 |    544,556 |
    bne     $i1, 0, bne.22410           # |    544,556 |    544,556 |
be.22415:
    load    [$i10 + 2], $i1             # |    544,556 |    544,556 |
    be      $i1, -1, be.22428           # |    544,556 |    544,556 |
bne.22416:
    li      0, $i8                      # |    544,556 |    544,556 |
    load    [ext_and_net + $i1], $i3    # |    544,556 |    544,556 |
    jal     shadow_check_and_group.2862, $ra1# |    544,556 |    544,556 |
    bne     $i1, 0, bne.22410           # |    544,556 |    544,556 |
be.22417:
    load    [$i10 + 3], $i1             # |    542,972 |    542,972 |
    be      $i1, -1, be.22428           # |    542,972 |    542,972 |
bne.22418:
    li      0, $i8                      # |    542,972 |    542,972 |
    load    [ext_and_net + $i1], $i3    # |    542,972 |    542,972 |
    jal     shadow_check_and_group.2862, $ra1# |    542,972 |    542,972 |
    bne     $i1, 0, bne.22410           # |    542,972 |    542,972 |
be.22419:
    load    [$i10 + 4], $i1             # |    541,019 |    541,019 |
    be      $i1, -1, be.22428           # |    541,019 |    541,019 |
bne.22420:
    li      0, $i8                      # |    541,019 |    541,019 |
    load    [ext_and_net + $i1], $i3    # |    541,019 |    541,019 |
    jal     shadow_check_and_group.2862, $ra1# |    541,019 |    541,019 |
    bne     $i1, 0, bne.22410           # |    541,019 |    541,019 |
be.22421:
    load    [$i10 + 5], $i1             # |    540,605 |    540,605 |
    be      $i1, -1, be.22428           # |    540,605 |    540,605 |
bne.22422:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22410
be.22423:
    load    [$i10 + 6], $i1
    be      $i1, -1, be.22428
bne.22424:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22410
be.22425:
    load    [$i10 + 7], $i1
    be      $i1, -1, be.22428
bne.22426:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22410
be.22427:
    li      8, $i9
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, bne.22410
be.22428:
    add     $i11, 1, $i1                # |    550,936 |    550,936 |
    load    [$i12 + $i1], $i10          # |    550,936 |    550,936 |
    load    [$i10 + 0], $i1             # |    550,936 |    550,936 |
    bne     $i1, -1, bne.22429          # |    550,936 |    550,936 |
be.22429:
    li      0, $i1                      # |    550,936 |    550,936 |
    jr      $ra3                        # |    550,936 |    550,936 |
bne.22429:
    be      $i1, 99, bne.22434          # |     10,331 |     10,331 |
bne.22430:
    call    solver_fast.2796
    be      $i1, 0, be.22413
bne.22431:
    ble     $fc7, $fg0, be.22413
bg.22432:
    load    [$i10 + 1], $i1
    be      $i1, -1, be.22413
bne.22433:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22434
be.22434:
    load    [$i10 + 2], $i1
    be      $i1, -1, be.22413
bne.22435:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22434
be.22436:
    li      3, $i9
    jal     shadow_check_one_or_group.2865, $ra2
    be      $i1, 0, be.22413
bne.22434:
    load    [$i10 + 1], $i1             # |     10,331 |     10,331 |
    be      $i1, -1, be.22413           # |     10,331 |     10,331 |
bne.22439:
    li      0, $i8                      # |     10,331 |     10,331 |
    load    [ext_and_net + $i1], $i3    # |     10,331 |     10,331 |
    jal     shadow_check_and_group.2862, $ra1# |     10,331 |     10,331 |
    bne     $i1, 0, bne.22410           # |     10,331 |     10,331 |
be.22440:
    load    [$i10 + 2], $i1             # |     10,331 |     10,331 |
    be      $i1, -1, be.22413           # |     10,331 |     10,331 |
bne.22441:
    li      0, $i8                      # |     10,331 |     10,331 |
    load    [ext_and_net + $i1], $i3    # |     10,331 |     10,331 |
    jal     shadow_check_and_group.2862, $ra1# |     10,331 |     10,331 |
    bne     $i1, 0, bne.22410           # |     10,331 |     10,331 |
be.22442:
    li      3, $i9                      # |     10,331 |     10,331 |
    jal     shadow_check_one_or_group.2865, $ra2# |     10,331 |     10,331 |
    bne     $i1, 0, bne.22410           # |     10,331 |     10,331 |
be.22413:
    add     $i11, 2, $i11               # |     10,331 |     10,331 |
    b       shadow_check_one_or_matrix.2868# |     10,331 |     10,331 |
bne.22410:
    li      1, $i1                      # |      3,951 |      3,951 |
    jr      $ra3                        # |      3,951 |      3,951 |
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i8, $i3, $i9)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i8, $i10 - $i11]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element
solve_each_element.2871:
    load    [$i3 + $i8], $i10           # |    193,311 |    193,311 |
    be      $i10, -1, be.22479          # |    193,311 |    193,311 |
bne.22444:
    load    [ext_objects + $i10], $i1   # |    149,820 |    149,820 |
    load    [$i1 + 1], $i2              # |    149,820 |    149,820 |
    load    [$i1 + 7], $f1              # |    149,820 |    149,820 |
    fsub    $fg17, $f1, $f1             # |    149,820 |    149,820 |
    load    [$i1 + 8], $f2              # |    149,820 |    149,820 |
    fsub    $fg18, $f2, $f2             # |    149,820 |    149,820 |
    load    [$i1 + 9], $f3              # |    149,820 |    149,820 |
    fsub    $fg19, $f3, $f3             # |    149,820 |    149,820 |
    load    [$i9 + 0], $f4              # |    149,820 |    149,820 |
    bne     $i2, 1, bne.22445           # |    149,820 |    149,820 |
be.22445:
    be      $f4, $f0, ble.22452         # |     50,858 |     50,858 |
bne.22446:
    load    [$i1 + 10], $i2             # |     50,858 |     50,858 |
    bg      $f0, $f4, bg.22447          # |     50,858 |     50,858 |
ble.22447:
    li      0, $i4                      # |     50,160 |     50,160 |
    be      $i2, 0, be.22448            # |     50,160 |     50,160 |
.count dual_jmp
    b       bne.22448
bg.22447:
    li      1, $i4                      # |        698 |        698 |
    bne     $i2, 0, bne.22448           # |        698 |        698 |
be.22448:
    mov     $i4, $i2                    # |     50,858 |     50,858 |
    load    [$i1 + 4], $f5              # |     50,858 |     50,858 |
    load    [$i9 + 1], $f6              # |     50,858 |     50,858 |
    finv    $f4, $f4                    # |     50,858 |     50,858 |
    be      $i2, 0, bne.22449           # |     50,858 |     50,858 |
.count dual_jmp
    b       be.22449                    # |        698 |        698 |
bne.22448:
    load    [$i1 + 4], $f5
    load    [$i9 + 1], $f6
    finv    $f4, $f4
    bne     $i4, 0, bne.22449
be.22449:
    fsub    $f5, $f1, $f5               # |        698 |        698 |
    fmul    $f5, $f4, $f4               # |        698 |        698 |
    load    [$i1 + 5], $f5              # |        698 |        698 |
    fmul    $f4, $f6, $f6               # |        698 |        698 |
    fadd_a  $f6, $f2, $f6               # |        698 |        698 |
    ble     $f5, $f6, ble.22452         # |        698 |        698 |
.count dual_jmp
    b       bg.22451                    # |        171 |        171 |
bne.22449:
    fneg    $f5, $f5                    # |     50,160 |     50,160 |
    fsub    $f5, $f1, $f5               # |     50,160 |     50,160 |
    fmul    $f5, $f4, $f4               # |     50,160 |     50,160 |
    load    [$i1 + 5], $f5              # |     50,160 |     50,160 |
    fmul    $f4, $f6, $f6               # |     50,160 |     50,160 |
    fadd_a  $f6, $f2, $f6               # |     50,160 |     50,160 |
    ble     $f5, $f6, ble.22452         # |     50,160 |     50,160 |
bg.22451:
    load    [$i1 + 6], $f5              # |      9,810 |      9,810 |
    load    [$i9 + 2], $f6              # |      9,810 |      9,810 |
    fmul    $f4, $f6, $f6               # |      9,810 |      9,810 |
    fadd_a  $f6, $f3, $f6               # |      9,810 |      9,810 |
    bg      $f5, $f6, bg.22452          # |      9,810 |      9,810 |
ble.22452:
    load    [$i9 + 1], $f4              # |     46,747 |     46,747 |
    be      $f4, $f0, ble.22460         # |     46,747 |     46,747 |
bne.22454:
    load    [$i1 + 10], $i2             # |     46,747 |     46,747 |
    bg      $f0, $f4, bg.22455          # |     46,747 |     46,747 |
ble.22455:
    li      0, $i4                      # |        217 |        217 |
    be      $i2, 0, be.22456            # |        217 |        217 |
.count dual_jmp
    b       bne.22456
bg.22455:
    li      1, $i4                      # |     46,530 |     46,530 |
    bne     $i2, 0, bne.22456           # |     46,530 |     46,530 |
be.22456:
    mov     $i4, $i2                    # |     46,747 |     46,747 |
    load    [$i1 + 5], $f5              # |     46,747 |     46,747 |
    load    [$i9 + 2], $f6              # |     46,747 |     46,747 |
    finv    $f4, $f4                    # |     46,747 |     46,747 |
    be      $i2, 0, bne.22457           # |     46,747 |     46,747 |
.count dual_jmp
    b       be.22457                    # |     46,530 |     46,530 |
bne.22456:
    load    [$i1 + 5], $f5
    load    [$i9 + 2], $f6
    finv    $f4, $f4
    bne     $i4, 0, bne.22457
be.22457:
    fsub    $f5, $f2, $f5               # |     46,530 |     46,530 |
    fmul    $f5, $f4, $f4               # |     46,530 |     46,530 |
    load    [$i1 + 6], $f5              # |     46,530 |     46,530 |
    fmul    $f4, $f6, $f6               # |     46,530 |     46,530 |
    fadd_a  $f6, $f3, $f6               # |     46,530 |     46,530 |
    ble     $f5, $f6, ble.22460         # |     46,530 |     46,530 |
.count dual_jmp
    b       bg.22459                    # |     18,436 |     18,436 |
bne.22457:
    fneg    $f5, $f5                    # |        217 |        217 |
    fsub    $f5, $f2, $f5               # |        217 |        217 |
    fmul    $f5, $f4, $f4               # |        217 |        217 |
    load    [$i1 + 6], $f5              # |        217 |        217 |
    fmul    $f4, $f6, $f6               # |        217 |        217 |
    fadd_a  $f6, $f3, $f6               # |        217 |        217 |
    ble     $f5, $f6, ble.22460         # |        217 |        217 |
bg.22459:
    load    [$i1 + 4], $f5              # |     18,536 |     18,536 |
    load    [$i9 + 0], $f6              # |     18,536 |     18,536 |
    fmul    $f4, $f6, $f6               # |     18,536 |     18,536 |
    fadd_a  $f6, $f1, $f6               # |     18,536 |     18,536 |
    bg      $f5, $f6, bg.22460          # |     18,536 |     18,536 |
ble.22460:
    load    [$i9 + 2], $f4              # |     34,667 |     34,667 |
    be      $f4, $f0, ble.22476         # |     34,667 |     34,667 |
bne.22462:
    load    [$i1 + 4], $f5              # |     34,667 |     34,667 |
    load    [$i9 + 0], $f6              # |     34,667 |     34,667 |
    load    [$i1 + 10], $i2             # |     34,667 |     34,667 |
    bg      $f0, $f4, bg.22463          # |     34,667 |     34,667 |
ble.22463:
    li      0, $i4                      # |     24,683 |     24,683 |
    be      $i2, 0, be.22464            # |     24,683 |     24,683 |
.count dual_jmp
    b       bne.22464
bg.22463:
    li      1, $i4                      # |      9,984 |      9,984 |
    bne     $i2, 0, bne.22464           # |      9,984 |      9,984 |
be.22464:
    mov     $i4, $i2                    # |     34,667 |     34,667 |
    load    [$i1 + 6], $f7              # |     34,667 |     34,667 |
    finv    $f4, $f4                    # |     34,667 |     34,667 |
    be      $i2, 0, bne.22465           # |     34,667 |     34,667 |
.count dual_jmp
    b       be.22465                    # |      9,984 |      9,984 |
bne.22464:
    load    [$i1 + 6], $f7
    finv    $f4, $f4
    bne     $i4, 0, bne.22465
be.22465:
    fsub    $f7, $f3, $f3               # |      9,984 |      9,984 |
    fmul    $f3, $f4, $f3               # |      9,984 |      9,984 |
    fmul    $f3, $f6, $f4               # |      9,984 |      9,984 |
    fadd_a  $f4, $f1, $f1               # |      9,984 |      9,984 |
    ble     $f5, $f1, ble.22476         # |      9,984 |      9,984 |
.count dual_jmp
    b       bg.22467                    # |      6,406 |      6,406 |
bne.22465:
    fneg    $f7, $f7                    # |     24,683 |     24,683 |
    fsub    $f7, $f3, $f3               # |     24,683 |     24,683 |
    fmul    $f3, $f4, $f3               # |     24,683 |     24,683 |
    fmul    $f3, $f6, $f4               # |     24,683 |     24,683 |
    fadd_a  $f4, $f1, $f1               # |     24,683 |     24,683 |
    ble     $f5, $f1, ble.22476         # |     24,683 |     24,683 |
bg.22467:
    load    [$i1 + 5], $f1              # |     15,869 |     15,869 |
    load    [$i9 + 1], $f4              # |     15,869 |     15,869 |
    fmul    $f3, $f4, $f4               # |     15,869 |     15,869 |
    fadd_a  $f4, $f2, $f2               # |     15,869 |     15,869 |
    ble     $f1, $f2, ble.22476         # |     15,869 |     15,869 |
bg.22468:
    mov     $f3, $fg0                   # |      3,025 |      3,025 |
    li      3, $i11                     # |      3,025 |      3,025 |
    ble     $fg0, $f0, bne.22479        # |      3,025 |      3,025 |
.count dual_jmp
    b       bg.22480                    # |      2,987 |      2,987 |
bg.22460:
    mov     $f4, $fg0                   # |     12,080 |     12,080 |
    li      2, $i11                     # |     12,080 |     12,080 |
    ble     $fg0, $f0, bne.22479        # |     12,080 |     12,080 |
.count dual_jmp
    b       bg.22480                    # |     11,912 |     11,912 |
bg.22452:
    mov     $f4, $fg0                   # |      4,111 |      4,111 |
    li      1, $i11                     # |      4,111 |      4,111 |
    ble     $fg0, $f0, bne.22479        # |      4,111 |      4,111 |
.count dual_jmp
    b       bg.22480                    # |      4,020 |      4,020 |
bne.22445:
    bne     $i2, 2, bne.22469           # |     98,962 |     98,962 |
be.22469:
    load    [$i1 + 4], $f5              # |     24,693 |     24,693 |
    fmul    $f4, $f5, $f4               # |     24,693 |     24,693 |
    load    [$i9 + 1], $f6              # |     24,693 |     24,693 |
    load    [$i1 + 5], $f7              # |     24,693 |     24,693 |
    fmul    $f6, $f7, $f6               # |     24,693 |     24,693 |
    fadd    $f4, $f6, $f4               # |     24,693 |     24,693 |
    load    [$i9 + 2], $f6              # |     24,693 |     24,693 |
    load    [$i1 + 6], $f8              # |     24,693 |     24,693 |
    fmul    $f6, $f8, $f6               # |     24,693 |     24,693 |
    fadd    $f4, $f6, $f4               # |     24,693 |     24,693 |
    ble     $f4, $f0, ble.22476         # |     24,693 |     24,693 |
bg.22470:
    fmul    $f5, $f1, $f1               # |     17,158 |     17,158 |
    fmul    $f7, $f2, $f2               # |     17,158 |     17,158 |
    fadd    $f1, $f2, $f1               # |     17,158 |     17,158 |
    fmul    $f8, $f3, $f2               # |     17,158 |     17,158 |
    fadd_n  $f1, $f2, $f1               # |     17,158 |     17,158 |
    finv    $f4, $f2                    # |     17,158 |     17,158 |
    fmul    $f1, $f2, $fg0              # |     17,158 |     17,158 |
    li      1, $i11                     # |     17,158 |     17,158 |
    ble     $fg0, $f0, bne.22479        # |     17,158 |     17,158 |
.count dual_jmp
    b       bg.22480                    # |     17,133 |     17,133 |
bne.22469:
    load    [$i1 + 3], $i4              # |     74,269 |     74,269 |
    load    [$i9 + 1], $f5              # |     74,269 |     74,269 |
    load    [$i9 + 2], $f6              # |     74,269 |     74,269 |
    fmul    $f4, $f4, $f7               # |     74,269 |     74,269 |
    load    [$i1 + 4], $f8              # |     74,269 |     74,269 |
    fmul    $f7, $f8, $f7               # |     74,269 |     74,269 |
    fmul    $f5, $f5, $f9               # |     74,269 |     74,269 |
    load    [$i1 + 5], $f10             # |     74,269 |     74,269 |
    fmul    $f9, $f10, $f9              # |     74,269 |     74,269 |
    fadd    $f7, $f9, $f7               # |     74,269 |     74,269 |
    fmul    $f6, $f6, $f9               # |     74,269 |     74,269 |
    load    [$i1 + 6], $f11             # |     74,269 |     74,269 |
    fmul    $f9, $f11, $f9              # |     74,269 |     74,269 |
    fadd    $f7, $f9, $f7               # |     74,269 |     74,269 |
    bne     $i4, 0, bne.22471           # |     74,269 |     74,269 |
be.22471:
    be      $f7, $f0, ble.22476         # |     74,269 |     74,269 |
.count dual_jmp
    b       bne.22472                   # |     74,269 |     74,269 |
bne.22471:
    fmul    $f5, $f6, $f9
    load    [$i1 + 16], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f4, $f9
    load    [$i1 + 17], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f4, $f5, $f9
    load    [$i1 + 18], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    be      $f7, $f0, ble.22476
bne.22472:
    fmul    $f4, $f1, $f9               # |     74,269 |     74,269 |
    fmul    $f9, $f8, $f9               # |     74,269 |     74,269 |
    fmul    $f5, $f2, $f12              # |     74,269 |     74,269 |
    fmul    $f12, $f10, $f12            # |     74,269 |     74,269 |
    fadd    $f9, $f12, $f9              # |     74,269 |     74,269 |
    fmul    $f6, $f3, $f12              # |     74,269 |     74,269 |
    fmul    $f12, $f11, $f12            # |     74,269 |     74,269 |
    fadd    $f9, $f12, $f9              # |     74,269 |     74,269 |
    bne     $i4, 0, bne.22473           # |     74,269 |     74,269 |
be.22473:
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
    be      $i4, 0, be.22474            # |     74,269 |     74,269 |
.count dual_jmp
    b       bne.22474
bne.22473:
    fmul    $f6, $f2, $f12
    fmul    $f5, $f3, $f13
    fadd    $f12, $f13, $f12
    load    [$i1 + 16], $f13
    fmul    $f12, $f13, $f12
    fmul    $f4, $f3, $f13
    fmul    $f6, $f1, $f6
    fadd    $f13, $f6, $f6
    load    [$i1 + 17], $f13
    fmul    $f6, $f13, $f6
    fadd    $f12, $f6, $f6
    fmul    $f4, $f2, $f4
    fmul    $f5, $f1, $f5
    fadd    $f4, $f5, $f4
    load    [$i1 + 18], $f5
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
    bne     $i4, 0, bne.22474
be.22474:
    mov     $f6, $f1                    # |     74,269 |     74,269 |
    be      $i2, 3, be.22475            # |     74,269 |     74,269 |
.count dual_jmp
    b       bne.22475
bne.22474:
    fmul    $f2, $f3, $f8
    load    [$i1 + 16], $f9
    fmul    $f8, $f9, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f1, $f3
    load    [$i1 + 17], $f8
    fmul    $f3, $f8, $f3
    fadd    $f6, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i1 + 18], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
    bne     $i2, 3, bne.22475
be.22475:
    fsub    $f1, $fc0, $f1              # |     74,269 |     74,269 |
    fmul    $f7, $f1, $f1               # |     74,269 |     74,269 |
    fsub    $f5, $f1, $f1               # |     74,269 |     74,269 |
    ble     $f1, $f0, ble.22476         # |     74,269 |     74,269 |
.count dual_jmp
    b       bg.22476                    # |     11,893 |     11,893 |
bne.22475:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    bg      $f1, $f0, bg.22476
ble.22476:
    load    [ext_objects + $i10], $i1   # |    101,553 |    101,553 |
    load    [$i1 + 10], $i1             # |    101,553 |    101,553 |
    bne     $i1, 0, bne.22479           # |    101,553 |    101,553 |
be.22479:
    jr      $ra1                        # |    135,672 |    135,672 |
bg.22476:
    load    [$i1 + 10], $i1             # |     11,893 |     11,893 |
    fsqrt   $f1, $f1                    # |     11,893 |     11,893 |
    li      1, $i11                     # |     11,893 |     11,893 |
    finv    $f7, $f2                    # |     11,893 |     11,893 |
    bne     $i1, 0, bne.22477           # |     11,893 |     11,893 |
be.22477:
    fneg    $f1, $f1                    # |      9,138 |      9,138 |
    fsub    $f1, $f4, $f1               # |      9,138 |      9,138 |
    fmul    $f1, $f2, $fg0              # |      9,138 |      9,138 |
    ble     $fg0, $f0, bne.22479        # |      9,138 |      9,138 |
.count dual_jmp
    b       bg.22480                    # |      8,645 |      8,645 |
bne.22477:
    fsub    $f1, $f4, $f1               # |      2,755 |      2,755 |
    fmul    $f1, $f2, $fg0              # |      2,755 |      2,755 |
    ble     $fg0, $f0, bne.22479        # |      2,755 |      2,755 |
bg.22480:
    bg      $fg7, $fg0, bg.22481        # |     47,420 |     47,420 |
bne.22479:
    add     $i8, 1, $i8                 # |     21,900 |     21,900 |
    b       solve_each_element.2871     # |     21,900 |     21,900 |
bg.22481:
    li      0, $i1                      # |     35,739 |     35,739 |
    load    [$i9 + 0], $f1              # |     35,739 |     35,739 |
    fadd    $fg0, $fc15, $f10           # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg17, $f2             # |     35,739 |     35,739 |
    load    [$i9 + 1], $f1              # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg18, $f3             # |     35,739 |     35,739 |
    load    [$i9 + 2], $f1              # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg19, $f4             # |     35,739 |     35,739 |
    call    check_all_inside.2856       # |     35,739 |     35,739 |
    add     $i8, 1, $i8                 # |     35,739 |     35,739 |
    be      $i1, 0, solve_each_element.2871# |     35,739 |     35,739 |
bne.22482:
    mov     $f10, $fg7                  # |     25,163 |     25,163 |
    store   $f2, [ext_intersection_point + 0]# |     25,163 |     25,163 |
    store   $f3, [ext_intersection_point + 1]# |     25,163 |     25,163 |
    store   $f4, [ext_intersection_point + 2]# |     25,163 |     25,163 |
    mov     $i10, $ig3                  # |     25,163 |     25,163 |
    mov     $i11, $ig2                  # |     25,163 |     25,163 |
    b       solve_each_element.2871     # |     25,163 |     25,163 |
.end solve_each_element

######################################################################
# solve_one_or_network($i12, $i13, $i9)
# $ra = $ra2
# [$i1 - $i8, $i10 - $i12]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
    load    [$i13 + $i12], $i1          # |      6,776 |      6,776 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |
bne.22483:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i12, 1, $i1                # |      6,776 |      6,776 |
    load    [$i13 + $i1], $i1           # |      6,776 |      6,776 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |
bne.22484:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i12, 2, $i1                # |      6,776 |      6,776 |
    load    [$i13 + $i1], $i1           # |      6,776 |      6,776 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |
bne.22485:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i12, 3, $i1                # |      6,776 |      6,776 |
    load    [$i13 + $i1], $i1           # |      6,776 |      6,776 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |
bne.22486:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i12, 4, $i1                # |      6,776 |      6,776 |
    load    [$i13 + $i1], $i1           # |      6,776 |      6,776 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |
bne.22487:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i12, 5, $i1                # |      6,776 |      6,776 |
    load    [$i13 + $i1], $i1           # |      6,776 |      6,776 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |
bne.22488:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i12, 6, $i1                # |      6,776 |      6,776 |
    load    [$i13 + $i1], $i1           # |      6,776 |      6,776 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |
bne.22489:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i12, 7, $i1
    load    [$i13 + $i1], $i1
    bne     $i1, -1, bne.22490
be.22490:
    jr      $ra2                        # |      6,776 |      6,776 |
bne.22490:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i12, 8, $i12
    b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix($i14, $i15, $i9)
# $ra = $ra3
# [$i1 - $i8, $i10 - $i14]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
    load    [$i15 + $i14], $i13         # |     23,754 |     23,754 |
    load    [$i13 + 0], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.22499           # |     23,754 |     23,754 |
bne.22491:
    bne     $i1, 99, bne.22492          # |     23,754 |     23,754 |
be.22492:
    load    [$i13 + 1], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |
bne.22493:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i3    # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i13 + 2], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |
bne.22494:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i3    # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i13 + 3], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |
bne.22495:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i3    # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i13 + 4], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |
bne.22496:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i3    # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i13 + 5], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |
bne.22497:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i13 + 6], $i1
    bne     $i1, -1, bne.22498
be.22498:
    add     $i14, 1, $i1                # |     23,754 |     23,754 |
    load    [$i15 + $i1], $i13          # |     23,754 |     23,754 |
    load    [$i13 + 0], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.22499           # |     23,754 |     23,754 |
.count dual_jmp
    b       bne.22499
bne.22498:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    li      7, $i12
    jal     solve_one_or_network.2875, $ra2
    add     $i14, 1, $i1
    load    [$i15 + $i1], $i13
    load    [$i13 + 0], $i1
    bne     $i1, -1, bne.22499
be.22499:
    jr      $ra3                        # |     23,754 |     23,754 |
bne.22499:
    bne     $i1, 99, bne.22500
be.22500:
    load    [$i13 + 1], $i1
    be      $i1, -1, ble.22506
bne.22501:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i13 + 2], $i1
    be      $i1, -1, ble.22506
bne.22502:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i13 + 3], $i1
    be      $i1, -1, ble.22506
bne.22503:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i13 + 4], $i1
    be      $i1, -1, ble.22506
bne.22504:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    li      5, $i12
    jal     solve_one_or_network.2875, $ra2
    add     $i14, 2, $i14
    b       trace_or_matrix.2879
bne.22500:
.count move_args
    mov     $i9, $i2
    call    solver.2773
    be      $i1, 0, ble.22506
bne.22505:
    bg      $fg7, $fg0, bg.22506
ble.22506:
    add     $i14, 2, $i14
    b       trace_or_matrix.2879
bg.22506:
    li      1, $i12
    jal     solve_one_or_network.2875, $ra2
    add     $i14, 2, $i14
    b       trace_or_matrix.2879
bne.22492:
.count move_args
    mov     $i9, $i2
    call    solver.2773
    be      $i1, 0, ble.22508
bne.22507:
    bg      $fg7, $fg0, bg.22508
ble.22508:
    add     $i14, 1, $i14
    b       trace_or_matrix.2879
bg.22508:
    li      1, $i12
    jal     solve_one_or_network.2875, $ra2
    add     $i14, 1, $i14
    b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i8, $i3, $i9)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i8, $i10 - $i11]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
    load    [$i3 + $i8], $i10           # | 13,852,171 | 13,852,171 |
    be      $i10, -1, be.22528          # | 13,852,171 | 13,852,171 |
bne.22509:
    load    [ext_objects + $i10], $i1   # | 10,544,094 | 10,544,094 |
    load    [$i9 + 3], $i2              # | 10,544,094 | 10,544,094 |
    load    [$i1 + 1], $i4              # | 10,544,094 | 10,544,094 |
    load    [$i1 + 19], $f1             # | 10,544,094 | 10,544,094 |
    load    [$i1 + 20], $f2             # | 10,544,094 | 10,544,094 |
    load    [$i1 + 21], $f3             # | 10,544,094 | 10,544,094 |
    load    [$i2 + $i10], $i2           # | 10,544,094 | 10,544,094 |
    bne     $i4, 1, bne.22510           # | 10,544,094 | 10,544,094 |
be.22510:
    load    [$i1 + 5], $f4              # |  3,873,912 |  3,873,912 |
    load    [$i9 + 1], $f5              # |  3,873,912 |  3,873,912 |
    load    [$i2 + 0], $f6              # |  3,873,912 |  3,873,912 |
    fsub    $f6, $f1, $f6               # |  3,873,912 |  3,873,912 |
    load    [$i2 + 1], $f7              # |  3,873,912 |  3,873,912 |
    fmul    $f6, $f7, $f6               # |  3,873,912 |  3,873,912 |
    fmul    $f6, $f5, $f5               # |  3,873,912 |  3,873,912 |
    fadd_a  $f5, $f2, $f5               # |  3,873,912 |  3,873,912 |
    ble     $f4, $f5, be.22513          # |  3,873,912 |  3,873,912 |
bg.22511:
    load    [$i1 + 6], $f4              # |    828,138 |    828,138 |
    load    [$i9 + 2], $f5              # |    828,138 |    828,138 |
    fmul    $f6, $f5, $f5               # |    828,138 |    828,138 |
    fadd_a  $f5, $f3, $f5               # |    828,138 |    828,138 |
    ble     $f4, $f5, be.22513          # |    828,138 |    828,138 |
bg.22512:
    load    [$i2 + 1], $f4              # |    503,446 |    503,446 |
    bne     $f4, $f0, bne.22513         # |    503,446 |    503,446 |
be.22513:
    load    [$i1 + 4], $f4              # |  3,370,466 |  3,370,466 |
    load    [$i9 + 0], $f5              # |  3,370,466 |  3,370,466 |
    load    [$i2 + 2], $f6              # |  3,370,466 |  3,370,466 |
    fsub    $f6, $f2, $f6               # |  3,370,466 |  3,370,466 |
    load    [$i2 + 3], $f7              # |  3,370,466 |  3,370,466 |
    fmul    $f6, $f7, $f6               # |  3,370,466 |  3,370,466 |
    fmul    $f6, $f5, $f5               # |  3,370,466 |  3,370,466 |
    fadd_a  $f5, $f1, $f5               # |  3,370,466 |  3,370,466 |
    ble     $f4, $f5, be.22517          # |  3,370,466 |  3,370,466 |
bg.22515:
    load    [$i1 + 6], $f4              # |  1,793,231 |  1,793,231 |
    load    [$i9 + 2], $f5              # |  1,793,231 |  1,793,231 |
    fmul    $f6, $f5, $f5               # |  1,793,231 |  1,793,231 |
    fadd_a  $f5, $f3, $f5               # |  1,793,231 |  1,793,231 |
    ble     $f4, $f5, be.22517          # |  1,793,231 |  1,793,231 |
bg.22516:
    load    [$i2 + 3], $f4              # |  1,222,656 |  1,222,656 |
    bne     $f4, $f0, bne.22517         # |  1,222,656 |  1,222,656 |
be.22517:
    load    [$i1 + 4], $f4              # |  2,147,810 |  2,147,810 |
    load    [$i9 + 0], $f5              # |  2,147,810 |  2,147,810 |
    load    [$i2 + 4], $f6              # |  2,147,810 |  2,147,810 |
    fsub    $f6, $f3, $f3               # |  2,147,810 |  2,147,810 |
    load    [$i2 + 5], $f6              # |  2,147,810 |  2,147,810 |
    fmul    $f3, $f6, $f3               # |  2,147,810 |  2,147,810 |
    fmul    $f3, $f5, $f5               # |  2,147,810 |  2,147,810 |
    fadd_a  $f5, $f1, $f1               # |  2,147,810 |  2,147,810 |
    ble     $f4, $f1, ble.22525         # |  2,147,810 |  2,147,810 |
bg.22519:
    load    [$i1 + 5], $f1              # |    606,567 |    606,567 |
    load    [$i9 + 1], $f4              # |    606,567 |    606,567 |
    fmul    $f3, $f4, $f4               # |    606,567 |    606,567 |
    fadd_a  $f4, $f2, $f2               # |    606,567 |    606,567 |
    ble     $f1, $f2, ble.22525         # |    606,567 |    606,567 |
bg.22520:
    load    [$i2 + 5], $f1              # |    274,576 |    274,576 |
    be      $f1, $f0, ble.22525         # |    274,576 |    274,576 |
bne.22521:
    mov     $f3, $fg0                   # |    274,576 |    274,576 |
    li      3, $i11                     # |    274,576 |    274,576 |
    ble     $fg0, $f0, bne.22528        # |    274,576 |    274,576 |
.count dual_jmp
    b       bg.22529                    # |     45,684 |     45,684 |
bne.22517:
    mov     $f6, $fg0                   # |  1,222,656 |  1,222,656 |
    li      2, $i11                     # |  1,222,656 |  1,222,656 |
    ble     $fg0, $f0, bne.22528        # |  1,222,656 |  1,222,656 |
.count dual_jmp
    b       bg.22529                    # |    207,391 |    207,391 |
bne.22513:
    mov     $f6, $fg0                   # |    503,446 |    503,446 |
    li      1, $i11                     # |    503,446 |    503,446 |
    ble     $fg0, $f0, bne.22528        # |    503,446 |    503,446 |
.count dual_jmp
    b       bg.22529                    # |     77,882 |     77,882 |
bne.22510:
    bne     $i4, 2, bne.22522           # |  6,670,182 |  6,670,182 |
be.22522:
    load    [$i2 + 0], $f1              # |  1,242,326 |  1,242,326 |
    ble     $f0, $f1, ble.22525         # |  1,242,326 |  1,242,326 |
bg.22523:
    load    [$i1 + 22], $f2             # |    595,309 |    595,309 |
    fmul    $f1, $f2, $fg0              # |    595,309 |    595,309 |
    li      1, $i11                     # |    595,309 |    595,309 |
    ble     $fg0, $f0, bne.22528        # |    595,309 |    595,309 |
.count dual_jmp
    b       bg.22529                    # |    551,827 |    551,827 |
bne.22522:
    load    [$i2 + 0], $f4              # |  5,427,856 |  5,427,856 |
    be      $f4, $f0, ble.22525         # |  5,427,856 |  5,427,856 |
bne.22524:
    load    [$i2 + 1], $f5              # |  5,427,856 |  5,427,856 |
    fmul    $f5, $f1, $f1               # |  5,427,856 |  5,427,856 |
    load    [$i2 + 2], $f5              # |  5,427,856 |  5,427,856 |
    fmul    $f5, $f2, $f2               # |  5,427,856 |  5,427,856 |
    fadd    $f1, $f2, $f1               # |  5,427,856 |  5,427,856 |
    load    [$i2 + 3], $f2              # |  5,427,856 |  5,427,856 |
    fmul    $f2, $f3, $f2               # |  5,427,856 |  5,427,856 |
    fadd    $f1, $f2, $f1               # |  5,427,856 |  5,427,856 |
    fmul    $f1, $f1, $f2               # |  5,427,856 |  5,427,856 |
    load    [$i1 + 22], $f3             # |  5,427,856 |  5,427,856 |
    fmul    $f4, $f3, $f3               # |  5,427,856 |  5,427,856 |
    fsub    $f2, $f3, $f2               # |  5,427,856 |  5,427,856 |
    bg      $f2, $f0, bg.22525          # |  5,427,856 |  5,427,856 |
ble.22525:
    load    [ext_objects + $i10], $i1   # |  6,267,239 |  6,267,239 |
    load    [$i1 + 10], $i1             # |  6,267,239 |  6,267,239 |
    bne     $i1, 0, bne.22528           # |  6,267,239 |  6,267,239 |
be.22528:
    jr      $ra1                        # |  8,647,408 |  8,647,408 |
bg.22525:
    load    [$i1 + 10], $i1             # |  1,680,868 |  1,680,868 |
    li      1, $i11                     # |  1,680,868 |  1,680,868 |
    fsqrt   $f2, $f2                    # |  1,680,868 |  1,680,868 |
    bne     $i1, 0, bne.22526           # |  1,680,868 |  1,680,868 |
be.22526:
    fsub    $f1, $f2, $f1               # |  1,260,056 |  1,260,056 |
    load    [$i2 + 4], $f2              # |  1,260,056 |  1,260,056 |
    fmul    $f1, $f2, $fg0              # |  1,260,056 |  1,260,056 |
    ble     $fg0, $f0, bne.22528        # |  1,260,056 |  1,260,056 |
.count dual_jmp
    b       bg.22529                    # |    246,044 |    246,044 |
bne.22526:
    fadd    $f1, $f2, $f1               # |    420,812 |    420,812 |
    load    [$i2 + 4], $f2              # |    420,812 |    420,812 |
    fmul    $f1, $f2, $fg0              # |    420,812 |    420,812 |
    ble     $fg0, $f0, bne.22528        # |    420,812 |    420,812 |
bg.22529:
    bg      $fg7, $fg0, bg.22530        # |  1,396,931 |  1,396,931 |
bne.22528:
    add     $i8, 1, $i8                 # |  4,023,266 |  4,023,266 |
    b       solve_each_element_fast.2885# |  4,023,266 |  4,023,266 |
bg.22530:
    li      0, $i1                      # |  1,181,497 |  1,181,497 |
    load    [$i9 + 0], $f1              # |  1,181,497 |  1,181,497 |
    fadd    $fg0, $fc15, $f10           # |  1,181,497 |  1,181,497 |
    fmul    $f1, $f10, $f1              # |  1,181,497 |  1,181,497 |
    fadd    $f1, $fg8, $f2              # |  1,181,497 |  1,181,497 |
    load    [$i9 + 1], $f1              # |  1,181,497 |  1,181,497 |
    fmul    $f1, $f10, $f1              # |  1,181,497 |  1,181,497 |
    fadd    $f1, $fg9, $f3              # |  1,181,497 |  1,181,497 |
    load    [$i9 + 2], $f1              # |  1,181,497 |  1,181,497 |
    fmul    $f1, $f10, $f1              # |  1,181,497 |  1,181,497 |
    fadd    $f1, $fg10, $f4             # |  1,181,497 |  1,181,497 |
    call    check_all_inside.2856       # |  1,181,497 |  1,181,497 |
    add     $i8, 1, $i8                 # |  1,181,497 |  1,181,497 |
    be      $i1, 0, solve_each_element_fast.2885# |  1,181,497 |  1,181,497 |
bne.22531:
    mov     $f10, $fg7                  # |    756,549 |    756,549 |
    store   $f2, [ext_intersection_point + 0]# |    756,549 |    756,549 |
    store   $f3, [ext_intersection_point + 1]# |    756,549 |    756,549 |
    store   $f4, [ext_intersection_point + 2]# |    756,549 |    756,549 |
    mov     $i10, $ig3                  # |    756,549 |    756,549 |
    mov     $i11, $ig2                  # |    756,549 |    756,549 |
    b       solve_each_element_fast.2885# |    756,549 |    756,549 |
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i12, $i13, $i9)
# $ra = $ra2
# [$i1 - $i8, $i10 - $i12]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
    load    [$i13 + $i12], $i1          # |    684,824 |    684,824 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |
bne.22532:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i12, 1, $i1                # |    684,824 |    684,824 |
    load    [$i13 + $i1], $i1           # |    684,824 |    684,824 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |
bne.22533:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i12, 2, $i1                # |    684,824 |    684,824 |
    load    [$i13 + $i1], $i1           # |    684,824 |    684,824 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |
bne.22534:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i12, 3, $i1                # |    684,824 |    684,824 |
    load    [$i13 + $i1], $i1           # |    684,824 |    684,824 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |
bne.22535:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i12, 4, $i1                # |    684,824 |    684,824 |
    load    [$i13 + $i1], $i1           # |    684,824 |    684,824 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |
bne.22536:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i12, 5, $i1                # |    684,824 |    684,824 |
    load    [$i13 + $i1], $i1           # |    684,824 |    684,824 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |
bne.22537:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i12, 6, $i1                # |    684,824 |    684,824 |
    load    [$i13 + $i1], $i1           # |    684,824 |    684,824 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |
bne.22538:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i12, 7, $i1
    load    [$i13 + $i1], $i1
    bne     $i1, -1, bne.22539
be.22539:
    jr      $ra2                        # |    684,824 |    684,824 |
bne.22539:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i12, 8, $i12
    b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i14, $i15, $i9)
# $ra = $ra3
# [$i1 - $i8, $i10 - $i14]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
    load    [$i15 + $i14], $i13         # |  1,134,616 |  1,134,616 |
    load    [$i13 + 0], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22548           # |  1,134,616 |  1,134,616 |
bne.22540:
    bne     $i1, 99, bne.22541          # |  1,134,616 |  1,134,616 |
be.22541:
    load    [$i13 + 1], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |
bne.22542:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i3    # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i13 + 2], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |
bne.22543:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i3    # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i13 + 3], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |
bne.22544:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i3    # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i13 + 4], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |
bne.22545:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i3    # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i13 + 5], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |
bne.22546:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 6], $i1
    bne     $i1, -1, bne.22547
be.22547:
    add     $i14, 1, $i1                # |  1,134,616 |  1,134,616 |
    load    [$i15 + $i1], $i13          # |  1,134,616 |  1,134,616 |
    load    [$i13 + 0], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22548           # |  1,134,616 |  1,134,616 |
.count dual_jmp
    b       bne.22548
bne.22547:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      7, $i12
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i14, 1, $i1
    load    [$i15 + $i1], $i13
    load    [$i13 + 0], $i1
    bne     $i1, -1, bne.22548
be.22548:
    jr      $ra3                        # |  1,134,616 |  1,134,616 |
bne.22548:
    bne     $i1, 99, bne.22549
be.22549:
    load    [$i13 + 1], $i1
    be      $i1, -1, ble.22555
bne.22550:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 2], $i1
    be      $i1, -1, ble.22555
bne.22551:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 3], $i1
    be      $i1, -1, ble.22555
bne.22552:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 4], $i1
    be      $i1, -1, ble.22555
bne.22553:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i12
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i14, 2, $i14
    b       trace_or_matrix_fast.2893
bne.22549:
.count move_args
    mov     $i9, $i2
    call    solver_fast2.2814
    be      $i1, 0, ble.22555
bne.22554:
    bg      $fg7, $fg0, bg.22555
ble.22555:
    add     $i14, 2, $i14
    b       trace_or_matrix_fast.2893
bg.22555:
    li      1, $i12
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i14, 2, $i14
    b       trace_or_matrix_fast.2893
bne.22541:
.count move_args
    mov     $i9, $i2
    call    solver_fast2.2814
    be      $i1, 0, ble.22557
bne.22556:
    bg      $fg7, $fg0, bg.22557
ble.22557:
    add     $i14, 1, $i14
    b       trace_or_matrix_fast.2893
bg.22557:
    li      1, $i12
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i14, 1, $i14
    b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra1
# [$i1 - $i2]
# [$f1 - $f9]
# []
# [$fg11, $fg15 - $fg16]
# [$ra]
######################################################################
.begin utexture
utexture.2908:
    load    [$i1 + 13], $fg16           # |    660,729 |    660,729 |
    load    [$i1 + 14], $fg11           # |    660,729 |    660,729 |
    load    [$i1 + 15], $fg15           # |    660,729 |    660,729 |
    load    [$i1 + 0], $i2              # |    660,729 |    660,729 |
    bne     $i2, 1, bne.22558           # |    660,729 |    660,729 |
be.22558:
    load    [ext_intersection_point + 0], $f1# |     94,509 |     94,509 |
    load    [$i1 + 7], $f2              # |     94,509 |     94,509 |
.count load_float
    load    [f.21994], $f4              # |     94,509 |     94,509 |
    fsub    $f1, $f2, $f5               # |     94,509 |     94,509 |
    fmul    $f5, $f4, $f2               # |     94,509 |     94,509 |
    call    ext_floor                   # |     94,509 |     94,509 |
.count load_float
    load    [f.21995], $f6              # |     94,509 |     94,509 |
.count load_float
    load    [f.21996], $f7              # |     94,509 |     94,509 |
    fmul    $f1, $f6, $f1               # |     94,509 |     94,509 |
    fsub    $f5, $f1, $f5               # |     94,509 |     94,509 |
    load    [ext_intersection_point + 2], $f1# |     94,509 |     94,509 |
    load    [$i1 + 9], $f2              # |     94,509 |     94,509 |
    fsub    $f1, $f2, $f8               # |     94,509 |     94,509 |
    fmul    $f8, $f4, $f2               # |     94,509 |     94,509 |
    call    ext_floor                   # |     94,509 |     94,509 |
    fmul    $f1, $f6, $f1               # |     94,509 |     94,509 |
    fsub    $f8, $f1, $f1               # |     94,509 |     94,509 |
    bg      $f7, $f5, bg.22559          # |     94,509 |     94,509 |
ble.22559:
    li      0, $i1                      # |     50,304 |     50,304 |
    ble     $f7, $f1, ble.22560         # |     50,304 |     50,304 |
.count dual_jmp
    b       bg.22560                    # |     26,193 |     26,193 |
bg.22559:
    li      1, $i1                      # |     44,205 |     44,205 |
    bg      $f7, $f1, bg.22560          # |     44,205 |     44,205 |
ble.22560:
    be      $i1, 0, bne.22562           # |     45,686 |     45,686 |
.count dual_jmp
    b       be.22562                    # |     21,575 |     21,575 |
bg.22560:
    bne     $i1, 0, bne.22562           # |     48,823 |     48,823 |
be.22562:
    mov     $f0, $fg11                  # |     47,768 |     47,768 |
    jr      $ra1                        # |     47,768 |     47,768 |
bne.22562:
    mov     $fc8, $fg11                 # |     46,741 |     46,741 |
    jr      $ra1                        # |     46,741 |     46,741 |
bne.22558:
    bne     $i2, 2, bne.22563           # |    566,220 |    566,220 |
be.22563:
    load    [ext_intersection_point + 1], $f1# |      2,886 |      2,886 |
.count load_float
    load    [f.21993], $f2              # |      2,886 |      2,886 |
    fmul    $f1, $f2, $f2               # |      2,886 |      2,886 |
    call    ext_sin                     # |      2,886 |      2,886 |
    fmul    $f1, $f1, $f1               # |      2,886 |      2,886 |
    fmul    $fc8, $f1, $fg16            # |      2,886 |      2,886 |
    fsub    $fc0, $f1, $f1              # |      2,886 |      2,886 |
    fmul    $fc8, $f1, $fg11            # |      2,886 |      2,886 |
    jr      $ra1                        # |      2,886 |      2,886 |
bne.22563:
    bne     $i2, 3, bne.22564           # |    563,334 |    563,334 |
be.22564:
    load    [ext_intersection_point + 0], $f1
    load    [$i1 + 7], $f2
    fsub    $f1, $f2, $f1
    fmul    $f1, $f1, $f1
    load    [ext_intersection_point + 2], $f2
    load    [$i1 + 9], $f3
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
bne.22564:
    bne     $i2, 4, bne.22565           # |    563,334 |    563,334 |
be.22565:
.count load_float
    load    [f.21983], $f6
    load    [ext_intersection_point + 0], $f1
    load    [$i1 + 7], $f2
    fsub    $f1, $f2, $f1
    load    [$i1 + 4], $f2
    fsqrt   $f2, $f2
    fmul    $f1, $f2, $f7
    fabs    $f7, $f1
    load    [ext_intersection_point + 2], $f2
    load    [$i1 + 9], $f3
    fsub    $f2, $f3, $f2
    load    [$i1 + 6], $f3
    fsqrt   $f3, $f3
    fmul    $f2, $f3, $f8
    bg      $f6, $f1, bg.22566
ble.22566:
    finv    $f7, $f1
    fmul_a  $f8, $f1, $f2
    call    ext_atan
    fmul    $fc17, $f1, $f9
    fmul    $f7, $f7, $f1
    fmul    $f8, $f8, $f2
    fadd    $f1, $f2, $f1
    fabs    $f1, $f2
    load    [ext_intersection_point + 1], $f3
    load    [$i1 + 8], $f4
    fsub    $f3, $f4, $f3
    load    [$i1 + 5], $f4
    fsqrt   $f4, $f4
    fmul    $f3, $f4, $f3
    ble     $f6, $f2, ble.22567
.count dual_jmp
    b       bg.22567
bg.22566:
.count load_float
    load    [f.21984], $f9
    fmul    $f7, $f7, $f1
    fmul    $f8, $f8, $f2
    fadd    $f1, $f2, $f1
    fabs    $f1, $f2
    load    [ext_intersection_point + 1], $f3
    load    [$i1 + 8], $f4
    fsub    $f3, $f4, $f3
    load    [$i1 + 5], $f4
    fsqrt   $f4, $f4
    fmul    $f3, $f4, $f3
    bg      $f6, $f2, bg.22567
ble.22567:
    finv    $f1, $f1
    fmul_a  $f3, $f1, $f2
    call    ext_atan
    fmul    $fc17, $f1, $f4
.count load_float
    load    [f.21989], $f5
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
    ble     $f0, $f1, ble.22568
.count dual_jmp
    b       bg.22568
bg.22567:
.count load_float
    load    [f.21984], $f4
.count load_float
    load    [f.21989], $f5
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
    bg      $f0, $f1, bg.22568
ble.22568:
.count load_float
    load    [f.21990], $f2
    fmul    $f2, $f1, $fg15
    jr      $ra1
bg.22568:
    mov     $f0, $fg15
    jr      $ra1
bne.22565:
    jr      $ra1                        # |    563,334 |    563,334 |
.end utexture

######################################################################
# trace_reflections($i16, $f11, $f12, $i17)
# $ra = $ra4
# [$i1 - $i16, $i18]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
# [$ra - $ra3]
######################################################################
.begin trace_reflections
trace_reflections.2915:
    bl      $i16, 0, bl.22569           # |     36,992 |     36,992 |
bge.22569:
    load    [ext_reflections + $i16], $i18# |     18,496 |     18,496 |
    mov     $fc13, $fg7                 # |     18,496 |     18,496 |
    load    [$ig1 + 0], $i13            # |     18,496 |     18,496 |
    load    [$i13 + 0], $i1             # |     18,496 |     18,496 |
    bne     $i1, -1, bne.22570          # |     18,496 |     18,496 |
be.22570:
    ble     $fg7, $fc7, bne.22581
.count dual_jmp
    b       bg.22578
bne.22570:
    add     $i18, 1, $i9                # |     18,496 |     18,496 |
    bne     $i1, 99, bne.22571          # |     18,496 |     18,496 |
be.22571:
    load    [$i13 + 1], $i1
    be      $i1, -1, ble.22577
bne.22572:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 2], $i1
    be      $i1, -1, ble.22577
bne.22573:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 3], $i1
    be      $i1, -1, ble.22577
bne.22574:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 4], $i1
    be      $i1, -1, ble.22577
bne.22575:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i12
    jal     solve_one_or_network_fast.2889, $ra2
    li      1, $i14
.count move_args
    mov     $ig1, $i15
    jal     trace_or_matrix_fast.2893, $ra3
    ble     $fg7, $fc7, bne.22581
.count dual_jmp
    b       bg.22578
bne.22571:
.count move_args
    mov     $i9, $i2                    # |     18,496 |     18,496 |
    call    solver_fast2.2814           # |     18,496 |     18,496 |
    be      $i1, 0, ble.22577           # |     18,496 |     18,496 |
bne.22576:
    bg      $fg7, $fg0, bg.22577        # |      5,026 |      5,026 |
ble.22577:
    li      1, $i14                     # |     13,470 |     13,470 |
.count move_args
    mov     $ig1, $i15                  # |     13,470 |     13,470 |
    jal     trace_or_matrix_fast.2893, $ra3# |     13,470 |     13,470 |
    ble     $fg7, $fc7, bne.22581       # |     13,470 |     13,470 |
.count dual_jmp
    b       bg.22578                    # |     13,470 |     13,470 |
bg.22577:
    li      1, $i12                     # |      5,026 |      5,026 |
    jal     solve_one_or_network_fast.2889, $ra2# |      5,026 |      5,026 |
    li      1, $i14                     # |      5,026 |      5,026 |
.count move_args
    mov     $ig1, $i15                  # |      5,026 |      5,026 |
    jal     trace_or_matrix_fast.2893, $ra3# |      5,026 |      5,026 |
    ble     $fg7, $fc7, bne.22581       # |      5,026 |      5,026 |
bg.22578:
    ble     $fc12, $fg7, bne.22581      # |     18,496 |     18,496 |
bg.22579:
    load    [$i18 + 0], $i1             # |     11,284 |     11,284 |
    add     $ig3, $ig3, $i2             # |     11,284 |     11,284 |
    add     $i2, $i2, $i2               # |     11,284 |     11,284 |
    add     $i2, $ig2, $i2              # |     11,284 |     11,284 |
    bne     $i2, $i1, bne.22581         # |     11,284 |     11,284 |
be.22581:
    li      0, $i11                     # |     10,331 |     10,331 |
.count move_args
    mov     $ig1, $i12                  # |     10,331 |     10,331 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     10,331 |     10,331 |
    bne     $i1, 0, bne.22581           # |     10,331 |     10,331 |
be.22582:
    load    [$i18 + 5], $f1             # |     10,331 |     10,331 |
    fmul    $f1, $f11, $f2              # |     10,331 |     10,331 |
    load    [ext_nvector + 0], $f3      # |     10,331 |     10,331 |
    load    [$i18 + 1], $f4             # |     10,331 |     10,331 |
    fmul    $f3, $f4, $f3               # |     10,331 |     10,331 |
    load    [ext_nvector + 1], $f5      # |     10,331 |     10,331 |
    load    [$i18 + 2], $f6             # |     10,331 |     10,331 |
    fmul    $f5, $f6, $f5               # |     10,331 |     10,331 |
    fadd    $f3, $f5, $f3               # |     10,331 |     10,331 |
    load    [ext_nvector + 2], $f5      # |     10,331 |     10,331 |
    load    [$i18 + 3], $f7             # |     10,331 |     10,331 |
    fmul    $f5, $f7, $f5               # |     10,331 |     10,331 |
    fadd    $f3, $f5, $f3               # |     10,331 |     10,331 |
    fmul    $f2, $f3, $f2               # |     10,331 |     10,331 |
    bg      $f2, $f0, bg.22583          # |     10,331 |     10,331 |
ble.22583:
    load    [$i17 + 0], $f2             # |        958 |        958 |
    fmul    $f2, $f4, $f2               # |        958 |        958 |
    load    [$i17 + 1], $f3             # |        958 |        958 |
    fmul    $f3, $f6, $f3               # |        958 |        958 |
    fadd    $f2, $f3, $f2               # |        958 |        958 |
    load    [$i17 + 2], $f3             # |        958 |        958 |
    fmul    $f3, $f7, $f3               # |        958 |        958 |
    fadd    $f2, $f3, $f2               # |        958 |        958 |
    fmul    $f1, $f2, $f1               # |        958 |        958 |
    ble     $f1, $f0, bne.22581         # |        958 |        958 |
.count dual_jmp
    b       bg.22584
bg.22583:
    fmul    $f2, $fg16, $f3             # |      9,373 |      9,373 |
    fadd    $fg4, $f3, $fg4             # |      9,373 |      9,373 |
    fmul    $f2, $fg11, $f3             # |      9,373 |      9,373 |
    fadd    $fg5, $f3, $fg5             # |      9,373 |      9,373 |
    fmul    $f2, $fg15, $f2             # |      9,373 |      9,373 |
    fadd    $fg6, $f2, $fg6             # |      9,373 |      9,373 |
    load    [$i17 + 0], $f2             # |      9,373 |      9,373 |
    fmul    $f2, $f4, $f2               # |      9,373 |      9,373 |
    load    [$i17 + 1], $f3             # |      9,373 |      9,373 |
    fmul    $f3, $f6, $f3               # |      9,373 |      9,373 |
    fadd    $f2, $f3, $f2               # |      9,373 |      9,373 |
    load    [$i17 + 2], $f3             # |      9,373 |      9,373 |
    fmul    $f3, $f7, $f3               # |      9,373 |      9,373 |
    fadd    $f2, $f3, $f2               # |      9,373 |      9,373 |
    fmul    $f1, $f2, $f1               # |      9,373 |      9,373 |
    bg      $f1, $f0, bg.22584          # |      9,373 |      9,373 |
bne.22581:
    add     $i16, -1, $i16              # |     10,775 |     10,775 |
    b       trace_reflections.2915      # |     10,775 |     10,775 |
bg.22584:
    fmul    $f1, $f1, $f1               # |      7,721 |      7,721 |
    fmul    $f1, $f1, $f1               # |      7,721 |      7,721 |
    fmul    $f1, $f12, $f1              # |      7,721 |      7,721 |
    fadd    $fg4, $f1, $fg4             # |      7,721 |      7,721 |
    fadd    $fg5, $f1, $fg5             # |      7,721 |      7,721 |
    fadd    $fg6, $f1, $fg6             # |      7,721 |      7,721 |
    add     $i16, -1, $i16              # |      7,721 |      7,721 |
    b       trace_reflections.2915      # |      7,721 |      7,721 |
bl.22569:
    jr      $ra4                        # |     18,496 |     18,496 |
.end trace_reflections

######################################################################
# trace_ray($i19, $f14, $i17, $i20, $f15)
# $ra = $ra5
# [$i1 - $i16, $i18 - $i19, $i21 - $i22]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg19]
# [$ra - $ra4]
######################################################################
.begin trace_ray
trace_ray.2920:
    bg      $i19, 4, bg.22585           # |     23,754 |     23,754 |
ble.22585:
    mov     $fc13, $fg7                 # |     23,754 |     23,754 |
    load    [$ig1 + 0], $i13            # |     23,754 |     23,754 |
    load    [$i13 + 0], $i1             # |     23,754 |     23,754 |
    bne     $i1, -1, bne.22586          # |     23,754 |     23,754 |
be.22586:
    add     $i20, 8, $i21
    ble     $fg7, $fc7, ble.22595
.count dual_jmp
    b       bg.22594
bne.22586:
    bne     $i1, 99, bne.22587          # |     23,754 |     23,754 |
be.22587:
    load    [$i13 + 1], $i1
.count move_args
    mov     $i17, $i9
    be      $i1, -1, ble.22593
bne.22588:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i13 + 2], $i1
.count move_args
    mov     $i17, $i9
    be      $i1, -1, ble.22593
bne.22589:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i13 + 3], $i1
.count move_args
    mov     $i17, $i9
    be      $i1, -1, ble.22593
bne.22590:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i13 + 4], $i1
.count move_args
    mov     $i17, $i9
    be      $i1, -1, ble.22593
bne.22591:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    li      5, $i12
.count move_args
    mov     $i17, $i9
    jal     solve_one_or_network.2875, $ra2
    li      1, $i14
.count move_args
    mov     $ig1, $i15
.count move_args
    mov     $i17, $i9
    jal     trace_or_matrix.2879, $ra3
    add     $i20, 8, $i21
    ble     $fg7, $fc7, ble.22595
.count dual_jmp
    b       bg.22594
bne.22587:
.count move_args
    mov     $i17, $i2                   # |     23,754 |     23,754 |
    call    solver.2773                 # |     23,754 |     23,754 |
.count move_args
    mov     $i17, $i9                   # |     23,754 |     23,754 |
    be      $i1, 0, ble.22593           # |     23,754 |     23,754 |
bne.22592:
    bg      $fg7, $fg0, bg.22593        # |      6,776 |      6,776 |
ble.22593:
    li      1, $i14                     # |     16,978 |     16,978 |
.count move_args
    mov     $ig1, $i15                  # |     16,978 |     16,978 |
    jal     trace_or_matrix.2879, $ra3  # |     16,978 |     16,978 |
    add     $i20, 8, $i21               # |     16,978 |     16,978 |
    ble     $fg7, $fc7, ble.22595       # |     16,978 |     16,978 |
.count dual_jmp
    b       bg.22594                    # |     16,978 |     16,978 |
bg.22593:
    li      1, $i12                     # |      6,776 |      6,776 |
    jal     solve_one_or_network.2875, $ra2# |      6,776 |      6,776 |
    li      1, $i14                     # |      6,776 |      6,776 |
.count move_args
    mov     $ig1, $i15                  # |      6,776 |      6,776 |
.count move_args
    mov     $i17, $i9                   # |      6,776 |      6,776 |
    jal     trace_or_matrix.2879, $ra3  # |      6,776 |      6,776 |
    add     $i20, 8, $i21               # |      6,776 |      6,776 |
    ble     $fg7, $fc7, ble.22595       # |      6,776 |      6,776 |
bg.22594:
    bg      $fc12, $fg7, bg.22595       # |     23,754 |     23,754 |
ble.22595:
    add     $i0, -1, $i1                # |      5,258 |      5,258 |
.count storer
    add     $i21, $i19, $tmp            # |      5,258 |      5,258 |
    store   $i1, [$tmp + 0]             # |      5,258 |      5,258 |
    be      $i19, 0, bg.22585           # |      5,258 |      5,258 |
bne.22597:
    load    [$i17 + 0], $f1             # |      5,258 |      5,258 |
    fmul    $f1, $fg14, $f1             # |      5,258 |      5,258 |
    load    [$i17 + 1], $f2             # |      5,258 |      5,258 |
    fmul    $f2, $fg12, $f2             # |      5,258 |      5,258 |
    fadd    $f1, $f2, $f1               # |      5,258 |      5,258 |
    load    [$i17 + 2], $f2             # |      5,258 |      5,258 |
    fmul    $f2, $fg13, $f2             # |      5,258 |      5,258 |
    fadd_n  $f1, $f2, $f1               # |      5,258 |      5,258 |
    ble     $f1, $f0, bg.22585          # |      5,258 |      5,258 |
bg.22598:
    fmul    $f1, $f1, $f2               # |      1,984 |      1,984 |
    fmul    $f2, $f1, $f1               # |      1,984 |      1,984 |
    fmul    $f1, $f14, $f1              # |      1,984 |      1,984 |
    load    [ext_beam + 0], $f2         # |      1,984 |      1,984 |
    fmul    $f1, $f2, $f1               # |      1,984 |      1,984 |
    fadd    $fg4, $f1, $fg4             # |      1,984 |      1,984 |
    fadd    $fg5, $f1, $fg5             # |      1,984 |      1,984 |
    fadd    $fg6, $f1, $fg6             # |      1,984 |      1,984 |
    jr      $ra5                        # |      1,984 |      1,984 |
bg.22595:
    load    [ext_objects + $ig3], $i22  # |     18,496 |     18,496 |
    load    [$i22 + 1], $i1             # |     18,496 |     18,496 |
    bne     $i1, 1, bne.22599           # |     18,496 |     18,496 |
be.22599:
    store   $f0, [ext_nvector + 0]      # |      7,910 |      7,910 |
    store   $f0, [ext_nvector + 1]      # |      7,910 |      7,910 |
    store   $f0, [ext_nvector + 2]      # |      7,910 |      7,910 |
    add     $ig2, -1, $i1               # |      7,910 |      7,910 |
    load    [$i17 + $i1], $f1           # |      7,910 |      7,910 |
    bne     $f1, $f0, bne.22600         # |      7,910 |      7,910 |
be.22600:
    store   $f0, [ext_nvector + $i1]
    load    [ext_intersection_point + 0], $fg17
    load    [ext_intersection_point + 1], $fg18
    load    [ext_intersection_point + 2], $fg19
.count move_args
    mov     $i22, $i1
    jal     utexture.2908, $ra1
    add     $ig3, $ig3, $i1
    add     $i1, $i1, $i1
    add     $i1, $ig2, $i1
.count storer
    add     $i21, $i19, $tmp
    store   $i1, [$tmp + 0]
    add     $i20, 3, $i1
    load    [$i1 + $i19], $i1
    load    [ext_intersection_point + 0], $f1
    store   $f1, [$i1 + 0]
    load    [ext_intersection_point + 1], $f1
    store   $f1, [$i1 + 1]
    load    [ext_intersection_point + 2], $f1
    store   $f1, [$i1 + 2]
    add     $i20, 13, $i1
    load    [$i22 + 11], $f1
    fmul    $f1, $f14, $f11
    ble     $fc4, $f1, ble.22606
.count dual_jmp
    b       bg.22606
bne.22600:
    bg      $f1, $f0, bg.22601          # |      7,910 |      7,910 |
ble.22601:
    store   $fc0, [ext_nvector + $i1]   # |      6,667 |      6,667 |
    load    [ext_intersection_point + 0], $fg17# |      6,667 |      6,667 |
    load    [ext_intersection_point + 1], $fg18# |      6,667 |      6,667 |
    load    [ext_intersection_point + 2], $fg19# |      6,667 |      6,667 |
.count move_args
    mov     $i22, $i1                   # |      6,667 |      6,667 |
    jal     utexture.2908, $ra1         # |      6,667 |      6,667 |
    add     $ig3, $ig3, $i1             # |      6,667 |      6,667 |
    add     $i1, $i1, $i1               # |      6,667 |      6,667 |
    add     $i1, $ig2, $i1              # |      6,667 |      6,667 |
.count storer
    add     $i21, $i19, $tmp            # |      6,667 |      6,667 |
    store   $i1, [$tmp + 0]             # |      6,667 |      6,667 |
    add     $i20, 3, $i1                # |      6,667 |      6,667 |
    load    [$i1 + $i19], $i1           # |      6,667 |      6,667 |
    load    [ext_intersection_point + 0], $f1# |      6,667 |      6,667 |
    store   $f1, [$i1 + 0]              # |      6,667 |      6,667 |
    load    [ext_intersection_point + 1], $f1# |      6,667 |      6,667 |
    store   $f1, [$i1 + 1]              # |      6,667 |      6,667 |
    load    [ext_intersection_point + 2], $f1# |      6,667 |      6,667 |
    store   $f1, [$i1 + 2]              # |      6,667 |      6,667 |
    add     $i20, 13, $i1               # |      6,667 |      6,667 |
    load    [$i22 + 11], $f1            # |      6,667 |      6,667 |
    fmul    $f1, $f14, $f11             # |      6,667 |      6,667 |
    ble     $fc4, $f1, ble.22606        # |      6,667 |      6,667 |
.count dual_jmp
    b       bg.22606
bg.22601:
    store   $fc3, [ext_nvector + $i1]   # |      1,243 |      1,243 |
    load    [ext_intersection_point + 0], $fg17# |      1,243 |      1,243 |
    load    [ext_intersection_point + 1], $fg18# |      1,243 |      1,243 |
    load    [ext_intersection_point + 2], $fg19# |      1,243 |      1,243 |
.count move_args
    mov     $i22, $i1                   # |      1,243 |      1,243 |
    jal     utexture.2908, $ra1         # |      1,243 |      1,243 |
    add     $ig3, $ig3, $i1             # |      1,243 |      1,243 |
    add     $i1, $i1, $i1               # |      1,243 |      1,243 |
    add     $i1, $ig2, $i1              # |      1,243 |      1,243 |
.count storer
    add     $i21, $i19, $tmp            # |      1,243 |      1,243 |
    store   $i1, [$tmp + 0]             # |      1,243 |      1,243 |
    add     $i20, 3, $i1                # |      1,243 |      1,243 |
    load    [$i1 + $i19], $i1           # |      1,243 |      1,243 |
    load    [ext_intersection_point + 0], $f1# |      1,243 |      1,243 |
    store   $f1, [$i1 + 0]              # |      1,243 |      1,243 |
    load    [ext_intersection_point + 1], $f1# |      1,243 |      1,243 |
    store   $f1, [$i1 + 1]              # |      1,243 |      1,243 |
    load    [ext_intersection_point + 2], $f1# |      1,243 |      1,243 |
    store   $f1, [$i1 + 2]              # |      1,243 |      1,243 |
    add     $i20, 13, $i1               # |      1,243 |      1,243 |
    load    [$i22 + 11], $f1            # |      1,243 |      1,243 |
    fmul    $f1, $f14, $f11             # |      1,243 |      1,243 |
    ble     $fc4, $f1, ble.22606        # |      1,243 |      1,243 |
.count dual_jmp
    b       bg.22606
bne.22599:
    load    [$i22 + 4], $f1             # |     10,586 |     10,586 |
    bne     $i1, 2, bne.22602           # |     10,586 |     10,586 |
be.22602:
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 0]      # |      7,226 |      7,226 |
    load    [$i22 + 5], $f1             # |      7,226 |      7,226 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 1]      # |      7,226 |      7,226 |
    load    [$i22 + 6], $f1             # |      7,226 |      7,226 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 2]      # |      7,226 |      7,226 |
    load    [ext_intersection_point + 0], $fg17# |      7,226 |      7,226 |
    load    [ext_intersection_point + 1], $fg18# |      7,226 |      7,226 |
    load    [ext_intersection_point + 2], $fg19# |      7,226 |      7,226 |
.count move_args
    mov     $i22, $i1                   # |      7,226 |      7,226 |
    jal     utexture.2908, $ra1         # |      7,226 |      7,226 |
    add     $ig3, $ig3, $i1             # |      7,226 |      7,226 |
    add     $i1, $i1, $i1               # |      7,226 |      7,226 |
    add     $i1, $ig2, $i1              # |      7,226 |      7,226 |
.count storer
    add     $i21, $i19, $tmp            # |      7,226 |      7,226 |
    store   $i1, [$tmp + 0]             # |      7,226 |      7,226 |
    add     $i20, 3, $i1                # |      7,226 |      7,226 |
    load    [$i1 + $i19], $i1           # |      7,226 |      7,226 |
    load    [ext_intersection_point + 0], $f1# |      7,226 |      7,226 |
    store   $f1, [$i1 + 0]              # |      7,226 |      7,226 |
    load    [ext_intersection_point + 1], $f1# |      7,226 |      7,226 |
    store   $f1, [$i1 + 1]              # |      7,226 |      7,226 |
    load    [ext_intersection_point + 2], $f1# |      7,226 |      7,226 |
    store   $f1, [$i1 + 2]              # |      7,226 |      7,226 |
    add     $i20, 13, $i1               # |      7,226 |      7,226 |
    load    [$i22 + 11], $f1            # |      7,226 |      7,226 |
    fmul    $f1, $f14, $f11             # |      7,226 |      7,226 |
    ble     $fc4, $f1, ble.22606        # |      7,226 |      7,226 |
.count dual_jmp
    b       bg.22606                    # |      7,222 |      7,222 |
bne.22602:
    load    [$i22 + 3], $i1             # |      3,360 |      3,360 |
    load    [ext_intersection_point + 0], $f2# |      3,360 |      3,360 |
    load    [$i22 + 7], $f3             # |      3,360 |      3,360 |
    fsub    $f2, $f3, $f2               # |      3,360 |      3,360 |
    fmul    $f2, $f1, $f1               # |      3,360 |      3,360 |
    load    [$i22 + 5], $f3             # |      3,360 |      3,360 |
    load    [ext_intersection_point + 1], $f4# |      3,360 |      3,360 |
    load    [$i22 + 8], $f5             # |      3,360 |      3,360 |
    fsub    $f4, $f5, $f4               # |      3,360 |      3,360 |
    fmul    $f4, $f3, $f3               # |      3,360 |      3,360 |
    load    [$i22 + 6], $f5             # |      3,360 |      3,360 |
    load    [ext_intersection_point + 2], $f6# |      3,360 |      3,360 |
    load    [$i22 + 9], $f7             # |      3,360 |      3,360 |
    fsub    $f6, $f7, $f6               # |      3,360 |      3,360 |
    fmul    $f6, $f5, $f5               # |      3,360 |      3,360 |
    bne     $i1, 0, bne.22603           # |      3,360 |      3,360 |
be.22603:
    store   $f1, [ext_nvector + 0]      # |      3,360 |      3,360 |
    store   $f3, [ext_nvector + 1]      # |      3,360 |      3,360 |
    store   $f5, [ext_nvector + 2]      # |      3,360 |      3,360 |
    load    [ext_nvector + 0], $f1      # |      3,360 |      3,360 |
    load    [$i22 + 10], $i1            # |      3,360 |      3,360 |
    fmul    $f1, $f1, $f2               # |      3,360 |      3,360 |
    load    [ext_nvector + 1], $f3      # |      3,360 |      3,360 |
    fmul    $f3, $f3, $f3               # |      3,360 |      3,360 |
    fadd    $f2, $f3, $f2               # |      3,360 |      3,360 |
    load    [ext_nvector + 2], $f3      # |      3,360 |      3,360 |
    fmul    $f3, $f3, $f3               # |      3,360 |      3,360 |
    fadd    $f2, $f3, $f2               # |      3,360 |      3,360 |
    fsqrt   $f2, $f2                    # |      3,360 |      3,360 |
    be      $f2, $f0, be.22604          # |      3,360 |      3,360 |
.count dual_jmp
    b       bne.22604                   # |      3,360 |      3,360 |
bne.22603:
    load    [$i22 + 18], $f7
    fmul    $f4, $f7, $f7
    load    [$i22 + 17], $f8
    fmul    $f6, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc4, $f7
    fadd    $f1, $f7, $f1
    store   $f1, [ext_nvector + 0]
    load    [$i22 + 18], $f1
    fmul    $f2, $f1, $f1
    load    [$i22 + 16], $f7
    fmul    $f6, $f7, $f6
    fadd    $f1, $f6, $f1
    fmul    $f1, $fc4, $f1
    fadd    $f3, $f1, $f1
    store   $f1, [ext_nvector + 1]
    load    [$i22 + 17], $f1
    fmul    $f2, $f1, $f1
    load    [$i22 + 16], $f2
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc4, $f1
    fadd    $f5, $f1, $f1
    store   $f1, [ext_nvector + 2]
    load    [ext_nvector + 0], $f1
    load    [$i22 + 10], $i1
    fmul    $f1, $f1, $f2
    load    [ext_nvector + 1], $f3
    fmul    $f3, $f3, $f3
    fadd    $f2, $f3, $f2
    load    [ext_nvector + 2], $f3
    fmul    $f3, $f3, $f3
    fadd    $f2, $f3, $f2
    fsqrt   $f2, $f2
    bne     $f2, $f0, bne.22604
be.22604:
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
    mov     $i22, $i1
    jal     utexture.2908, $ra1
    add     $ig3, $ig3, $i1
    add     $i1, $i1, $i1
    add     $i1, $ig2, $i1
.count storer
    add     $i21, $i19, $tmp
    store   $i1, [$tmp + 0]
    add     $i20, 3, $i1
    load    [$i1 + $i19], $i1
    load    [ext_intersection_point + 0], $f1
    store   $f1, [$i1 + 0]
    load    [ext_intersection_point + 1], $f1
    store   $f1, [$i1 + 1]
    load    [ext_intersection_point + 2], $f1
    store   $f1, [$i1 + 2]
    add     $i20, 13, $i1
    load    [$i22 + 11], $f1
    fmul    $f1, $f14, $f11
    ble     $fc4, $f1, ble.22606
.count dual_jmp
    b       bg.22606
bne.22604:
    bne     $i1, 0, bne.22605           # |      3,360 |      3,360 |
be.22605:
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
    mov     $i22, $i1                   # |      3,127 |      3,127 |
    jal     utexture.2908, $ra1         # |      3,127 |      3,127 |
    add     $ig3, $ig3, $i1             # |      3,127 |      3,127 |
    add     $i1, $i1, $i1               # |      3,127 |      3,127 |
    add     $i1, $ig2, $i1              # |      3,127 |      3,127 |
.count storer
    add     $i21, $i19, $tmp            # |      3,127 |      3,127 |
    store   $i1, [$tmp + 0]             # |      3,127 |      3,127 |
    add     $i20, 3, $i1                # |      3,127 |      3,127 |
    load    [$i1 + $i19], $i1           # |      3,127 |      3,127 |
    load    [ext_intersection_point + 0], $f1# |      3,127 |      3,127 |
    store   $f1, [$i1 + 0]              # |      3,127 |      3,127 |
    load    [ext_intersection_point + 1], $f1# |      3,127 |      3,127 |
    store   $f1, [$i1 + 1]              # |      3,127 |      3,127 |
    load    [ext_intersection_point + 2], $f1# |      3,127 |      3,127 |
    store   $f1, [$i1 + 2]              # |      3,127 |      3,127 |
    add     $i20, 13, $i1               # |      3,127 |      3,127 |
    load    [$i22 + 11], $f1            # |      3,127 |      3,127 |
    fmul    $f1, $f14, $f11             # |      3,127 |      3,127 |
    ble     $fc4, $f1, ble.22606        # |      3,127 |      3,127 |
.count dual_jmp
    b       bg.22606                    # |        148 |        148 |
bne.22605:
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
    mov     $i22, $i1                   # |        233 |        233 |
    jal     utexture.2908, $ra1         # |        233 |        233 |
    add     $ig3, $ig3, $i1             # |        233 |        233 |
    add     $i1, $i1, $i1               # |        233 |        233 |
    add     $i1, $ig2, $i1              # |        233 |        233 |
.count storer
    add     $i21, $i19, $tmp            # |        233 |        233 |
    store   $i1, [$tmp + 0]             # |        233 |        233 |
    add     $i20, 3, $i1                # |        233 |        233 |
    load    [$i1 + $i19], $i1           # |        233 |        233 |
    load    [ext_intersection_point + 0], $f1# |        233 |        233 |
    store   $f1, [$i1 + 0]              # |        233 |        233 |
    load    [ext_intersection_point + 1], $f1# |        233 |        233 |
    store   $f1, [$i1 + 1]              # |        233 |        233 |
    load    [ext_intersection_point + 2], $f1# |        233 |        233 |
    store   $f1, [$i1 + 2]              # |        233 |        233 |
    add     $i20, 13, $i1               # |        233 |        233 |
    load    [$i22 + 11], $f1            # |        233 |        233 |
    fmul    $f1, $f14, $f11             # |        233 |        233 |
    bg      $fc4, $f1, bg.22606         # |        233 |        233 |
ble.22606:
    li      1, $i2                      # |     11,126 |     11,126 |
.count storer
    add     $i1, $i19, $tmp             # |     11,126 |     11,126 |
    store   $i2, [$tmp + 0]             # |     11,126 |     11,126 |
    add     $i20, 18, $i1               # |     11,126 |     11,126 |
    load    [$i1 + $i19], $i2           # |     11,126 |     11,126 |
    store   $fg16, [$i2 + 0]            # |     11,126 |     11,126 |
    store   $fg11, [$i2 + 1]            # |     11,126 |     11,126 |
    store   $fg15, [$i2 + 2]            # |     11,126 |     11,126 |
    load    [$i1 + $i19], $i1           # |     11,126 |     11,126 |
.count load_float
    load    [f.22000], $f1              # |     11,126 |     11,126 |
    fmul    $f1, $f11, $f1              # |     11,126 |     11,126 |
    load    [$i1 + 0], $f2              # |     11,126 |     11,126 |
    fmul    $f2, $f1, $f2               # |     11,126 |     11,126 |
    store   $f2, [$i1 + 0]              # |     11,126 |     11,126 |
    load    [$i1 + 1], $f2              # |     11,126 |     11,126 |
    fmul    $f2, $f1, $f2               # |     11,126 |     11,126 |
    store   $f2, [$i1 + 1]              # |     11,126 |     11,126 |
    load    [$i1 + 2], $f2              # |     11,126 |     11,126 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |
    add     $i20, 29, $i1               # |     11,126 |     11,126 |
    load    [$i1 + $i19], $i1           # |     11,126 |     11,126 |
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 0]              # |     11,126 |     11,126 |
    load    [ext_nvector + 1], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 1]              # |     11,126 |     11,126 |
    load    [ext_nvector + 2], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |
.count load_float
    load    [f.22001], $f2              # |     11,126 |     11,126 |
    load    [$i17 + 0], $f3             # |     11,126 |     11,126 |
    fmul    $f3, $f1, $f4               # |     11,126 |     11,126 |
    load    [$i17 + 1], $f5             # |     11,126 |     11,126 |
    load    [ext_nvector + 1], $f6      # |     11,126 |     11,126 |
    fmul    $f5, $f6, $f5               # |     11,126 |     11,126 |
    fadd    $f4, $f5, $f4               # |     11,126 |     11,126 |
    load    [$i17 + 2], $f5             # |     11,126 |     11,126 |
    load    [ext_nvector + 2], $f6      # |     11,126 |     11,126 |
    fmul    $f5, $f6, $f5               # |     11,126 |     11,126 |
    fadd    $f4, $f5, $f4               # |     11,126 |     11,126 |
    fmul    $f2, $f4, $f2               # |     11,126 |     11,126 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |
    fadd    $f3, $f1, $f1               # |     11,126 |     11,126 |
    store   $f1, [$i17 + 0]             # |     11,126 |     11,126 |
    load    [$i17 + 1], $f1             # |     11,126 |     11,126 |
    load    [ext_nvector + 1], $f3      # |     11,126 |     11,126 |
    fmul    $f2, $f3, $f3               # |     11,126 |     11,126 |
    fadd    $f1, $f3, $f1               # |     11,126 |     11,126 |
    store   $f1, [$i17 + 1]             # |     11,126 |     11,126 |
    load    [$i17 + 2], $f1             # |     11,126 |     11,126 |
    load    [ext_nvector + 2], $f3      # |     11,126 |     11,126 |
    fmul    $f2, $f3, $f2               # |     11,126 |     11,126 |
    fadd    $f1, $f2, $f1               # |     11,126 |     11,126 |
    store   $f1, [$i17 + 2]             # |     11,126 |     11,126 |
    load    [$ig1 + 0], $i10            # |     11,126 |     11,126 |
    load    [$i10 + 0], $i1             # |     11,126 |     11,126 |
    be      $i1, -1, be.22607           # |     11,126 |     11,126 |
.count dual_jmp
    b       bne.22607                   # |     11,126 |     11,126 |
bg.22606:
    li      0, $i2                      # |      7,370 |      7,370 |
.count storer
    add     $i1, $i19, $tmp             # |      7,370 |      7,370 |
    store   $i2, [$tmp + 0]             # |      7,370 |      7,370 |
    load    [ext_nvector + 0], $f1      # |      7,370 |      7,370 |
.count load_float
    load    [f.22001], $f2              # |      7,370 |      7,370 |
    load    [$i17 + 0], $f3             # |      7,370 |      7,370 |
    fmul    $f3, $f1, $f4               # |      7,370 |      7,370 |
    load    [$i17 + 1], $f5             # |      7,370 |      7,370 |
    load    [ext_nvector + 1], $f6      # |      7,370 |      7,370 |
    fmul    $f5, $f6, $f5               # |      7,370 |      7,370 |
    fadd    $f4, $f5, $f4               # |      7,370 |      7,370 |
    load    [$i17 + 2], $f5             # |      7,370 |      7,370 |
    load    [ext_nvector + 2], $f6      # |      7,370 |      7,370 |
    fmul    $f5, $f6, $f5               # |      7,370 |      7,370 |
    fadd    $f4, $f5, $f4               # |      7,370 |      7,370 |
    fmul    $f2, $f4, $f2               # |      7,370 |      7,370 |
    fmul    $f2, $f1, $f1               # |      7,370 |      7,370 |
    fadd    $f3, $f1, $f1               # |      7,370 |      7,370 |
    store   $f1, [$i17 + 0]             # |      7,370 |      7,370 |
    load    [$i17 + 1], $f1             # |      7,370 |      7,370 |
    load    [ext_nvector + 1], $f3      # |      7,370 |      7,370 |
    fmul    $f2, $f3, $f3               # |      7,370 |      7,370 |
    fadd    $f1, $f3, $f1               # |      7,370 |      7,370 |
    store   $f1, [$i17 + 1]             # |      7,370 |      7,370 |
    load    [$i17 + 2], $f1             # |      7,370 |      7,370 |
    load    [ext_nvector + 2], $f3      # |      7,370 |      7,370 |
    fmul    $f2, $f3, $f2               # |      7,370 |      7,370 |
    fadd    $f1, $f2, $f1               # |      7,370 |      7,370 |
    store   $f1, [$i17 + 2]             # |      7,370 |      7,370 |
    load    [$ig1 + 0], $i10            # |      7,370 |      7,370 |
    load    [$i10 + 0], $i1             # |      7,370 |      7,370 |
    bne     $i1, -1, bne.22607          # |      7,370 |      7,370 |
be.22607:
    load    [$i22 + 12], $f1
    fmul    $f14, $f1, $f12
    load    [ext_nvector + 0], $f1
    fmul    $f1, $fg14, $f1
    load    [ext_nvector + 1], $f2
    fmul    $f2, $fg12, $f2
    fadd    $f1, $f2, $f1
    load    [ext_nvector + 2], $f2
    fmul    $f2, $fg13, $f2
    fadd_n  $f1, $f2, $f1
    fmul    $f1, $f11, $f1
    load    [$i17 + 0], $f2
    fmul    $f2, $fg14, $f2
    load    [$i17 + 1], $f3
    fmul    $f3, $fg12, $f3
    fadd    $f2, $f3, $f2
    load    [$i17 + 2], $f3
    fmul    $f3, $fg13, $f3
    fadd_n  $f2, $f3, $f2
    ble     $f1, $f0, ble.22623
.count dual_jmp
    b       bg.22623
bne.22607:
    be      $i1, 99, bne.22612          # |     18,496 |     18,496 |
bne.22608:
    call    solver_fast.2796            # |     18,496 |     18,496 |
    be      $i1, 0, be.22621            # |     18,496 |     18,496 |
bne.22609:
    ble     $fc7, $fg0, be.22621        # |      5,091 |      5,091 |
bg.22610:
    load    [$i10 + 1], $i1             # |      4,884 |      4,884 |
    be      $i1, -1, be.22621           # |      4,884 |      4,884 |
bne.22611:
    li      0, $i8                      # |      4,884 |      4,884 |
    load    [ext_and_net + $i1], $i3    # |      4,884 |      4,884 |
    jal     shadow_check_and_group.2862, $ra1# |      4,884 |      4,884 |
    bne     $i1, 0, bne.22612           # |      4,884 |      4,884 |
be.22612:
    load    [$i10 + 2], $i1             # |      4,517 |      4,517 |
    be      $i1, -1, be.22621           # |      4,517 |      4,517 |
bne.22613:
    li      0, $i8                      # |      4,517 |      4,517 |
    load    [ext_and_net + $i1], $i3    # |      4,517 |      4,517 |
    jal     shadow_check_and_group.2862, $ra1# |      4,517 |      4,517 |
    bne     $i1, 0, bne.22612           # |      4,517 |      4,517 |
be.22614:
    li      3, $i9                      # |      4,439 |      4,439 |
    jal     shadow_check_one_or_group.2865, $ra2# |      4,439 |      4,439 |
    be      $i1, 0, be.22621            # |      4,439 |      4,439 |
bne.22612:
    load    [$i10 + 1], $i1             # |        785 |        785 |
    be      $i1, -1, be.22621           # |        785 |        785 |
bne.22617:
    li      0, $i8                      # |        785 |        785 |
    load    [ext_and_net + $i1], $i3    # |        785 |        785 |
    jal     shadow_check_and_group.2862, $ra1# |        785 |        785 |
    bne     $i1, 0, bne.22618           # |        785 |        785 |
be.22618:
    load    [$i10 + 2], $i1             # |        418 |        418 |
    be      $i1, -1, be.22621           # |        418 |        418 |
bne.22619:
    li      0, $i8                      # |        418 |        418 |
    load    [ext_and_net + $i1], $i3    # |        418 |        418 |
    jal     shadow_check_and_group.2862, $ra1# |        418 |        418 |
    bne     $i1, 0, bne.22618           # |        418 |        418 |
be.22620:
    li      3, $i9                      # |        340 |        340 |
    jal     shadow_check_one_or_group.2865, $ra2# |        340 |        340 |
    bne     $i1, 0, bne.22618           # |        340 |        340 |
be.22621:
    li      1, $i11                     # |     17,711 |     17,711 |
.count move_args
    mov     $ig1, $i12                  # |     17,711 |     17,711 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     17,711 |     17,711 |
    load    [$i22 + 12], $f1            # |     17,711 |     17,711 |
    fmul    $f14, $f1, $f12             # |     17,711 |     17,711 |
    bne     $i1, 0, bne.22622           # |     17,711 |     17,711 |
be.22622:
    load    [ext_nvector + 0], $f1      # |     17,538 |     17,538 |
    fmul    $f1, $fg14, $f1             # |     17,538 |     17,538 |
    load    [ext_nvector + 1], $f2      # |     17,538 |     17,538 |
    fmul    $f2, $fg12, $f2             # |     17,538 |     17,538 |
    fadd    $f1, $f2, $f1               # |     17,538 |     17,538 |
    load    [ext_nvector + 2], $f2      # |     17,538 |     17,538 |
    fmul    $f2, $fg13, $f2             # |     17,538 |     17,538 |
    fadd_n  $f1, $f2, $f1               # |     17,538 |     17,538 |
    fmul    $f1, $f11, $f1              # |     17,538 |     17,538 |
    load    [$i17 + 0], $f2             # |     17,538 |     17,538 |
    fmul    $f2, $fg14, $f2             # |     17,538 |     17,538 |
    load    [$i17 + 1], $f3             # |     17,538 |     17,538 |
    fmul    $f3, $fg12, $f3             # |     17,538 |     17,538 |
    fadd    $f2, $f3, $f2               # |     17,538 |     17,538 |
    load    [$i17 + 2], $f3             # |     17,538 |     17,538 |
    fmul    $f3, $fg13, $f3             # |     17,538 |     17,538 |
    fadd_n  $f2, $f3, $f2               # |     17,538 |     17,538 |
    bg      $f1, $f0, bg.22623          # |     17,538 |     17,538 |
ble.22623:
    ble     $f2, $f0, bne.22622         # |          2 |          2 |
.count dual_jmp
    b       bg.22624
bg.22623:
    fmul    $f1, $fg16, $f3             # |     17,536 |     17,536 |
    fadd    $fg4, $f3, $fg4             # |     17,536 |     17,536 |
    fmul    $f1, $fg11, $f3             # |     17,536 |     17,536 |
    fadd    $fg5, $f3, $fg5             # |     17,536 |     17,536 |
    fmul    $f1, $fg15, $f1             # |     17,536 |     17,536 |
    fadd    $fg6, $f1, $fg6             # |     17,536 |     17,536 |
    bg      $f2, $f0, bg.22624          # |     17,536 |     17,536 |
bne.22622:
    li      ext_intersection_point, $i2 # |     11,260 |     11,260 |
    load    [ext_intersection_point + 0], $fg8# |     11,260 |     11,260 |
    load    [ext_intersection_point + 1], $fg9# |     11,260 |     11,260 |
    load    [ext_intersection_point + 2], $fg10# |     11,260 |     11,260 |
    add     $ig0, -1, $i1               # |     11,260 |     11,260 |
    call    setup_startp_constants.2831 # |     11,260 |     11,260 |
    add     $ig4, -1, $i16              # |     11,260 |     11,260 |
    jal     trace_reflections.2915, $ra4# |     11,260 |     11,260 |
    ble     $f14, $fc9, bg.22585        # |     11,260 |     11,260 |
.count dual_jmp
    b       bg.22625                    # |     11,260 |     11,260 |
bg.22624:
    fmul    $f2, $f2, $f1               # |      6,451 |      6,451 |
    fmul    $f1, $f1, $f1               # |      6,451 |      6,451 |
    fmul    $f1, $f12, $f1              # |      6,451 |      6,451 |
    fadd    $fg4, $f1, $fg4             # |      6,451 |      6,451 |
    fadd    $fg5, $f1, $fg5             # |      6,451 |      6,451 |
    fadd    $fg6, $f1, $fg6             # |      6,451 |      6,451 |
    li      ext_intersection_point, $i2 # |      6,451 |      6,451 |
    load    [ext_intersection_point + 0], $fg8# |      6,451 |      6,451 |
    load    [ext_intersection_point + 1], $fg9# |      6,451 |      6,451 |
    load    [ext_intersection_point + 2], $fg10# |      6,451 |      6,451 |
    add     $ig0, -1, $i1               # |      6,451 |      6,451 |
    call    setup_startp_constants.2831 # |      6,451 |      6,451 |
    add     $ig4, -1, $i16              # |      6,451 |      6,451 |
    jal     trace_reflections.2915, $ra4# |      6,451 |      6,451 |
    ble     $f14, $fc9, bg.22585        # |      6,451 |      6,451 |
.count dual_jmp
    b       bg.22625                    # |      6,451 |      6,451 |
bne.22618:
    load    [$i22 + 12], $f1            # |        785 |        785 |
    fmul    $f14, $f1, $f12             # |        785 |        785 |
    li      ext_intersection_point, $i2 # |        785 |        785 |
    load    [ext_intersection_point + 0], $fg8# |        785 |        785 |
    load    [ext_intersection_point + 1], $fg9# |        785 |        785 |
    load    [ext_intersection_point + 2], $fg10# |        785 |        785 |
    add     $ig0, -1, $i1               # |        785 |        785 |
    call    setup_startp_constants.2831 # |        785 |        785 |
    add     $ig4, -1, $i16              # |        785 |        785 |
    jal     trace_reflections.2915, $ra4# |        785 |        785 |
    ble     $f14, $fc9, bg.22585        # |        785 |        785 |
bg.22625:
    bl      $i19, 4, bl.22626           # |     18,496 |     18,496 |
bge.22626:
    load    [$i22 + 2], $i1
    be      $i1, 2, be.22627
.count dual_jmp
    b       bg.22585
bl.22626:
    add     $i19, 1, $i1                # |     18,496 |     18,496 |
    add     $i0, -1, $i2                # |     18,496 |     18,496 |
.count storer
    add     $i21, $i1, $tmp             # |     18,496 |     18,496 |
    store   $i2, [$tmp + 0]             # |     18,496 |     18,496 |
    load    [$i22 + 2], $i1             # |     18,496 |     18,496 |
    bne     $i1, 2, bg.22585            # |     18,496 |     18,496 |
be.22627:
    fadd    $f15, $fg7, $f15            # |      7,370 |      7,370 |
    add     $i19, 1, $i19               # |      7,370 |      7,370 |
    load    [$i22 + 11], $f1            # |      7,370 |      7,370 |
    fsub    $fc0, $f1, $f1              # |      7,370 |      7,370 |
    fmul    $f14, $f1, $f14             # |      7,370 |      7,370 |
    b       trace_ray.2920              # |      7,370 |      7,370 |
bg.22585:
    jr      $ra5                        # |     14,400 |     14,400 |
.end trace_ray

######################################################################
# trace_diffuse_ray($i9, $f11)
# $ra = $ra4
# [$i1 - $i15]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra3]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
    mov     $fc13, $fg7                 # |  1,116,120 |  1,116,120 |
    load    [$ig1 + 0], $i13            # |  1,116,120 |  1,116,120 |
    load    [$i13 + 0], $i1             # |  1,116,120 |  1,116,120 |
    bne     $i1, -1, bne.22628          # |  1,116,120 |  1,116,120 |
be.22628:
    ble     $fg7, $fc7, bne.22657
.count dual_jmp
    b       bg.22636
bne.22628:
    bne     $i1, 99, bne.22629          # |  1,116,120 |  1,116,120 |
be.22629:
    load    [$i13 + 1], $i1
    be      $i1, -1, ble.22635
bne.22630:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 2], $i1
    be      $i1, -1, ble.22635
bne.22631:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 3], $i1
    be      $i1, -1, ble.22635
bne.22632:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i13 + 4], $i1
    be      $i1, -1, ble.22635
bne.22633:
    li      0, $i8
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i12
    jal     solve_one_or_network_fast.2889, $ra2
    li      1, $i14
.count move_args
    mov     $ig1, $i15
    jal     trace_or_matrix_fast.2893, $ra3
    ble     $fg7, $fc7, bne.22657
.count dual_jmp
    b       bg.22636
bne.22629:
.count move_args
    mov     $i9, $i2                    # |  1,116,120 |  1,116,120 |
    call    solver_fast2.2814           # |  1,116,120 |  1,116,120 |
    be      $i1, 0, ble.22635           # |  1,116,120 |  1,116,120 |
bne.22634:
    bg      $fg7, $fg0, bg.22635        # |    679,798 |    679,798 |
ble.22635:
    li      1, $i14                     # |    436,322 |    436,322 |
.count move_args
    mov     $ig1, $i15                  # |    436,322 |    436,322 |
    jal     trace_or_matrix_fast.2893, $ra3# |    436,322 |    436,322 |
    ble     $fg7, $fc7, bne.22657       # |    436,322 |    436,322 |
.count dual_jmp
    b       bg.22636                    # |    436,322 |    436,322 |
bg.22635:
    li      1, $i12                     # |    679,798 |    679,798 |
    jal     solve_one_or_network_fast.2889, $ra2# |    679,798 |    679,798 |
    li      1, $i14                     # |    679,798 |    679,798 |
.count move_args
    mov     $ig1, $i15                  # |    679,798 |    679,798 |
    jal     trace_or_matrix_fast.2893, $ra3# |    679,798 |    679,798 |
    ble     $fg7, $fc7, bne.22657       # |    679,798 |    679,798 |
bg.22636:
    ble     $fc12, $fg7, bne.22657      # |  1,116,120 |  1,116,120 |
bg.22637:
    load    [ext_objects + $ig3], $i13  # |    642,233 |    642,233 |
    load    [$i13 + 1], $i1             # |    642,233 |    642,233 |
    bne     $i1, 1, bne.22639           # |    642,233 |    642,233 |
be.22639:
    store   $f0, [ext_nvector + 0]      # |    114,909 |    114,909 |
    store   $f0, [ext_nvector + 1]      # |    114,909 |    114,909 |
    store   $f0, [ext_nvector + 2]      # |    114,909 |    114,909 |
    add     $ig2, -1, $i1               # |    114,909 |    114,909 |
    load    [$i9 + $i1], $f1            # |    114,909 |    114,909 |
    bne     $f1, $f0, bne.22640         # |    114,909 |    114,909 |
be.22640:
    store   $f0, [ext_nvector + $i1]
.count move_args
    mov     $i13, $i1
    jal     utexture.2908, $ra1
    load    [$ig1 + 0], $i10
    load    [$i10 + 0], $i1
    be      $i1, -1, be.22661
.count dual_jmp
    b       bne.22646
bne.22640:
    bg      $f1, $f0, bg.22641          # |    114,909 |    114,909 |
ble.22641:
    store   $fc0, [ext_nvector + $i1]   # |     90,131 |     90,131 |
.count move_args
    mov     $i13, $i1                   # |     90,131 |     90,131 |
    jal     utexture.2908, $ra1         # |     90,131 |     90,131 |
    load    [$ig1 + 0], $i10            # |     90,131 |     90,131 |
    load    [$i10 + 0], $i1             # |     90,131 |     90,131 |
    be      $i1, -1, be.22661           # |     90,131 |     90,131 |
.count dual_jmp
    b       bne.22646                   # |     90,131 |     90,131 |
bg.22641:
    store   $fc3, [ext_nvector + $i1]   # |     24,778 |     24,778 |
.count move_args
    mov     $i13, $i1                   # |     24,778 |     24,778 |
    jal     utexture.2908, $ra1         # |     24,778 |     24,778 |
    load    [$ig1 + 0], $i10            # |     24,778 |     24,778 |
    load    [$i10 + 0], $i1             # |     24,778 |     24,778 |
    be      $i1, -1, be.22661           # |     24,778 |     24,778 |
.count dual_jmp
    b       bne.22646                   # |     24,778 |     24,778 |
bne.22639:
    load    [$i13 + 4], $f1             # |    527,324 |    527,324 |
    bne     $i1, 2, bne.22642           # |    527,324 |    527,324 |
be.22642:
    fneg    $f1, $f1                    # |    391,531 |    391,531 |
    store   $f1, [ext_nvector + 0]      # |    391,531 |    391,531 |
    load    [$i13 + 5], $f1             # |    391,531 |    391,531 |
    fneg    $f1, $f1                    # |    391,531 |    391,531 |
    store   $f1, [ext_nvector + 1]      # |    391,531 |    391,531 |
    load    [$i13 + 6], $f1             # |    391,531 |    391,531 |
    fneg    $f1, $f1                    # |    391,531 |    391,531 |
    store   $f1, [ext_nvector + 2]      # |    391,531 |    391,531 |
.count move_args
    mov     $i13, $i1                   # |    391,531 |    391,531 |
    jal     utexture.2908, $ra1         # |    391,531 |    391,531 |
    load    [$ig1 + 0], $i10            # |    391,531 |    391,531 |
    load    [$i10 + 0], $i1             # |    391,531 |    391,531 |
    be      $i1, -1, be.22661           # |    391,531 |    391,531 |
.count dual_jmp
    b       bne.22646                   # |    391,531 |    391,531 |
bne.22642:
    load    [$i13 + 3], $i1             # |    135,793 |    135,793 |
    load    [ext_intersection_point + 0], $f2# |    135,793 |    135,793 |
    load    [$i13 + 7], $f3             # |    135,793 |    135,793 |
    fsub    $f2, $f3, $f2               # |    135,793 |    135,793 |
    fmul    $f2, $f1, $f1               # |    135,793 |    135,793 |
    load    [$i13 + 5], $f3             # |    135,793 |    135,793 |
    load    [ext_intersection_point + 1], $f4# |    135,793 |    135,793 |
    load    [$i13 + 8], $f5             # |    135,793 |    135,793 |
    fsub    $f4, $f5, $f4               # |    135,793 |    135,793 |
    fmul    $f4, $f3, $f3               # |    135,793 |    135,793 |
    load    [$i13 + 6], $f5             # |    135,793 |    135,793 |
    load    [ext_intersection_point + 2], $f6# |    135,793 |    135,793 |
    load    [$i13 + 9], $f7             # |    135,793 |    135,793 |
    fsub    $f6, $f7, $f6               # |    135,793 |    135,793 |
    fmul    $f6, $f5, $f5               # |    135,793 |    135,793 |
    bne     $i1, 0, bne.22643           # |    135,793 |    135,793 |
be.22643:
    store   $f1, [ext_nvector + 0]      # |    135,793 |    135,793 |
    store   $f3, [ext_nvector + 1]      # |    135,793 |    135,793 |
    store   $f5, [ext_nvector + 2]      # |    135,793 |    135,793 |
    load    [ext_nvector + 0], $f1      # |    135,793 |    135,793 |
    load    [$i13 + 10], $i1            # |    135,793 |    135,793 |
    fmul    $f1, $f1, $f2               # |    135,793 |    135,793 |
    load    [ext_nvector + 1], $f3      # |    135,793 |    135,793 |
    fmul    $f3, $f3, $f3               # |    135,793 |    135,793 |
    fadd    $f2, $f3, $f2               # |    135,793 |    135,793 |
    load    [ext_nvector + 2], $f3      # |    135,793 |    135,793 |
    fmul    $f3, $f3, $f3               # |    135,793 |    135,793 |
    fadd    $f2, $f3, $f2               # |    135,793 |    135,793 |
    fsqrt   $f2, $f2                    # |    135,793 |    135,793 |
    be      $f2, $f0, be.22644          # |    135,793 |    135,793 |
.count dual_jmp
    b       bne.22644                   # |    135,793 |    135,793 |
bne.22643:
    load    [$i13 + 18], $f7
    fmul    $f4, $f7, $f7
    load    [$i13 + 17], $f8
    fmul    $f6, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc4, $f7
    fadd    $f1, $f7, $f1
    store   $f1, [ext_nvector + 0]
    load    [$i13 + 18], $f1
    fmul    $f2, $f1, $f1
    load    [$i13 + 16], $f7
    fmul    $f6, $f7, $f6
    fadd    $f1, $f6, $f1
    fmul    $f1, $fc4, $f1
    fadd    $f3, $f1, $f1
    store   $f1, [ext_nvector + 1]
    load    [$i13 + 17], $f1
    fmul    $f2, $f1, $f1
    load    [$i13 + 16], $f2
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc4, $f1
    fadd    $f5, $f1, $f1
    store   $f1, [ext_nvector + 2]
    load    [ext_nvector + 0], $f1
    load    [$i13 + 10], $i1
    fmul    $f1, $f1, $f2
    load    [ext_nvector + 1], $f3
    fmul    $f3, $f3, $f3
    fadd    $f2, $f3, $f2
    load    [ext_nvector + 2], $f3
    fmul    $f3, $f3, $f3
    fadd    $f2, $f3, $f2
    fsqrt   $f2, $f2
    bne     $f2, $f0, bne.22644
be.22644:
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
    mov     $i13, $i1
    jal     utexture.2908, $ra1
    load    [$ig1 + 0], $i10
    load    [$i10 + 0], $i1
    be      $i1, -1, be.22661
.count dual_jmp
    b       bne.22646
bne.22644:
    bne     $i1, 0, bne.22645           # |    135,793 |    135,793 |
be.22645:
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
    mov     $i13, $i1                   # |    103,847 |    103,847 |
    jal     utexture.2908, $ra1         # |    103,847 |    103,847 |
    load    [$ig1 + 0], $i10            # |    103,847 |    103,847 |
    load    [$i10 + 0], $i1             # |    103,847 |    103,847 |
    be      $i1, -1, be.22661           # |    103,847 |    103,847 |
.count dual_jmp
    b       bne.22646                   # |    103,847 |    103,847 |
bne.22645:
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
    mov     $i13, $i1                   # |     31,946 |     31,946 |
    jal     utexture.2908, $ra1         # |     31,946 |     31,946 |
    load    [$ig1 + 0], $i10            # |     31,946 |     31,946 |
    load    [$i10 + 0], $i1             # |     31,946 |     31,946 |
    be      $i1, -1, be.22661           # |     31,946 |     31,946 |
bne.22646:
    be      $i1, 99, bne.22651          # |    642,233 |    642,233 |
bne.22647:
    call    solver_fast.2796            # |    642,233 |    642,233 |
    be      $i1, 0, be.22660            # |    642,233 |    642,233 |
bne.22648:
    ble     $fc7, $fg0, be.22660        # |    200,976 |    200,976 |
bg.22649:
    load    [$i10 + 1], $i1             # |    194,041 |    194,041 |
    be      $i1, -1, be.22660           # |    194,041 |    194,041 |
bne.22650:
    li      0, $i8                      # |    194,041 |    194,041 |
    load    [ext_and_net + $i1], $i3    # |    194,041 |    194,041 |
    jal     shadow_check_and_group.2862, $ra1# |    194,041 |    194,041 |
    bne     $i1, 0, bne.22651           # |    194,041 |    194,041 |
be.22651:
    load    [$i10 + 2], $i1             # |    153,753 |    153,753 |
    be      $i1, -1, be.22660           # |    153,753 |    153,753 |
bne.22652:
    li      0, $i8                      # |    153,753 |    153,753 |
    load    [ext_and_net + $i1], $i3    # |    153,753 |    153,753 |
    jal     shadow_check_and_group.2862, $ra1# |    153,753 |    153,753 |
    bne     $i1, 0, bne.22651           # |    153,753 |    153,753 |
be.22653:
    li      3, $i9                      # |    143,619 |    143,619 |
    jal     shadow_check_one_or_group.2865, $ra2# |    143,619 |    143,619 |
    be      $i1, 0, be.22660            # |    143,619 |    143,619 |
bne.22651:
    load    [$i10 + 1], $i1             # |    115,388 |    115,388 |
    be      $i1, -1, be.22660           # |    115,388 |    115,388 |
bne.22656:
    li      0, $i8                      # |    115,388 |    115,388 |
    load    [ext_and_net + $i1], $i3    # |    115,388 |    115,388 |
    jal     shadow_check_and_group.2862, $ra1# |    115,388 |    115,388 |
    bne     $i1, 0, bne.22657           # |    115,388 |    115,388 |
be.22657:
    load    [$i10 + 2], $i1             # |     75,100 |     75,100 |
    be      $i1, -1, be.22660           # |     75,100 |     75,100 |
bne.22658:
    li      0, $i8                      # |     75,100 |     75,100 |
    load    [ext_and_net + $i1], $i3    # |     75,100 |     75,100 |
    jal     shadow_check_and_group.2862, $ra1# |     75,100 |     75,100 |
    bne     $i1, 0, bne.22657           # |     75,100 |     75,100 |
be.22659:
    li      3, $i9                      # |     64,966 |     64,966 |
    jal     shadow_check_one_or_group.2865, $ra2# |     64,966 |     64,966 |
    bne     $i1, 0, bne.22657           # |     64,966 |     64,966 |
be.22660:
    li      1, $i11                     # |    526,845 |    526,845 |
.count move_args
    mov     $ig1, $i12                  # |    526,845 |    526,845 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |    526,845 |    526,845 |
    bne     $i1, 0, bne.22657           # |    526,845 |    526,845 |
be.22661:
    load    [ext_nvector + 0], $f1      # |    523,067 |    523,067 |
    fmul    $f1, $fg14, $f1             # |    523,067 |    523,067 |
    load    [ext_nvector + 1], $f2      # |    523,067 |    523,067 |
    fmul    $f2, $fg12, $f2             # |    523,067 |    523,067 |
    fadd    $f1, $f2, $f1               # |    523,067 |    523,067 |
    load    [ext_nvector + 2], $f2      # |    523,067 |    523,067 |
    fmul    $f2, $fg13, $f2             # |    523,067 |    523,067 |
    fadd_n  $f1, $f2, $f1               # |    523,067 |    523,067 |
    load    [$i13 + 11], $f2            # |    523,067 |    523,067 |
    bg      $f1, $f0, bg.22662          # |    523,067 |    523,067 |
ble.22662:
    mov     $f0, $f1                    # |        709 |        709 |
    fmul    $f11, $f1, $f1              # |        709 |        709 |
    fmul    $f1, $f2, $f1               # |        709 |        709 |
    fmul    $f1, $fg16, $f2             # |        709 |        709 |
    fadd    $fg1, $f2, $fg1             # |        709 |        709 |
    fmul    $f1, $fg11, $f2             # |        709 |        709 |
    fadd    $fg2, $f2, $fg2             # |        709 |        709 |
    fmul    $f1, $fg15, $f1             # |        709 |        709 |
    fadd    $fg3, $f1, $fg3             # |        709 |        709 |
    jr      $ra4                        # |        709 |        709 |
bg.22662:
    fmul    $f11, $f1, $f1              # |    522,358 |    522,358 |
    fmul    $f1, $f2, $f1               # |    522,358 |    522,358 |
    fmul    $f1, $fg16, $f2             # |    522,358 |    522,358 |
    fadd    $fg1, $f2, $fg1             # |    522,358 |    522,358 |
    fmul    $f1, $fg11, $f2             # |    522,358 |    522,358 |
    fadd    $fg2, $f2, $fg2             # |    522,358 |    522,358 |
    fmul    $f1, $fg15, $f1             # |    522,358 |    522,358 |
    fadd    $fg3, $f1, $fg3             # |    522,358 |    522,358 |
    jr      $ra4                        # |    522,358 |    522,358 |
bne.22657:
    jr      $ra4                        # |    593,053 |    593,053 |
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i16, $i17, $i18)
# $ra = $ra5
# [$i1 - $i15, $i18]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra4]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
    bl      $i18, 0, bl.22663           # |    558,060 |    558,060 |
bge.22663:
    load    [$i16 + $i18], $i1          # |    558,060 |    558,060 |
    load    [$i1 + 0], $f1              # |    558,060 |    558,060 |
    load    [$i17 + 0], $f2             # |    558,060 |    558,060 |
    fmul    $f1, $f2, $f1               # |    558,060 |    558,060 |
    load    [$i1 + 1], $f2              # |    558,060 |    558,060 |
    load    [$i17 + 1], $f3             # |    558,060 |    558,060 |
    fmul    $f2, $f3, $f2               # |    558,060 |    558,060 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |
    load    [$i1 + 2], $f2              # |    558,060 |    558,060 |
    load    [$i17 + 2], $f3             # |    558,060 |    558,060 |
    fmul    $f2, $f3, $f2               # |    558,060 |    558,060 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |
    bg      $f0, $f1, bg.22664          # |    558,060 |    558,060 |
ble.22664:
    fmul    $f1, $fc1, $f11             # |    381,373 |    381,373 |
    load    [$i16 + $i18], $i9          # |    381,373 |    381,373 |
    jal     trace_diffuse_ray.2926, $ra4# |    381,373 |    381,373 |
    add     $i18, -2, $i18              # |    381,373 |    381,373 |
    bge     $i18, 0, bge.22667          # |    381,373 |    381,373 |
.count dual_jmp
    b       bl.22663                    # |     15,574 |     15,574 |
bg.22664:
    fmul    $f1, $fc2, $f11             # |    176,687 |    176,687 |
    add     $i18, 1, $i1                # |    176,687 |    176,687 |
    load    [$i16 + $i1], $i9           # |    176,687 |    176,687 |
    jal     trace_diffuse_ray.2926, $ra4# |    176,687 |    176,687 |
    add     $i18, -2, $i18              # |    176,687 |    176,687 |
    bl      $i18, 0, bl.22663           # |    176,687 |    176,687 |
bge.22667:
    load    [$i16 + $i18], $i1          # |    539,458 |    539,458 |
    load    [$i1 + 0], $f1              # |    539,458 |    539,458 |
    load    [$i17 + 0], $f2             # |    539,458 |    539,458 |
    fmul    $f1, $f2, $f1               # |    539,458 |    539,458 |
    load    [$i1 + 1], $f2              # |    539,458 |    539,458 |
    load    [$i17 + 1], $f3             # |    539,458 |    539,458 |
    fmul    $f2, $f3, $f2               # |    539,458 |    539,458 |
    fadd    $f1, $f2, $f1               # |    539,458 |    539,458 |
    load    [$i1 + 2], $f2              # |    539,458 |    539,458 |
    load    [$i17 + 2], $f3             # |    539,458 |    539,458 |
    fmul    $f2, $f3, $f2               # |    539,458 |    539,458 |
    fadd    $f1, $f2, $f1               # |    539,458 |    539,458 |
    bg      $f0, $f1, bg.22668          # |    539,458 |    539,458 |
ble.22668:
    fmul    $f1, $fc1, $f11             # |    211,266 |    211,266 |
    load    [$i16 + $i18], $i9          # |    211,266 |    211,266 |
    jal     trace_diffuse_ray.2926, $ra4# |    211,266 |    211,266 |
    add     $i18, -2, $i18              # |    211,266 |    211,266 |
    b       iter_trace_diffuse_rays.2929# |    211,266 |    211,266 |
bg.22668:
    fmul    $f1, $fc2, $f11             # |    328,192 |    328,192 |
    add     $i18, 1, $i1                # |    328,192 |    328,192 |
    load    [$i16 + $i1], $i9           # |    328,192 |    328,192 |
    jal     trace_diffuse_ray.2926, $ra4# |    328,192 |    328,192 |
    add     $i18, -2, $i18              # |    328,192 |    328,192 |
    b       iter_trace_diffuse_rays.2929# |    328,192 |    328,192 |
bl.22663:
    jr      $ra5                        # |     18,602 |     18,602 |
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i19, $i20)
# $ra = $ra6
# [$i1 - $i18, $i21 - $i22]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
    add     $i19, 23, $i1               # |      1,737 |      1,737 |
    load    [$i1 + $i20], $i1           # |      1,737 |      1,737 |
    load    [$i1 + 0], $fg1             # |      1,737 |      1,737 |
    load    [$i1 + 1], $fg2             # |      1,737 |      1,737 |
    load    [$i1 + 2], $fg3             # |      1,737 |      1,737 |
    add     $i19, 29, $i1               # |      1,737 |      1,737 |
    add     $i19, 3, $i2                # |      1,737 |      1,737 |
    load    [$i1 + $i20], $i17          # |      1,737 |      1,737 |
    load    [$i2 + $i20], $i21          # |      1,737 |      1,737 |
    load    [$i19 + 28], $i22           # |      1,737 |      1,737 |
    bne     $i22, 0, bne.22669          # |      1,737 |      1,737 |
be.22669:
    be      $i22, 1, be.22671           # |        348 |        348 |
.count dual_jmp
    b       bne.22671                   # |        348 |        348 |
bne.22669:
    load    [ext_dirvecs + 0], $i16     # |      1,389 |      1,389 |
    load    [$i21 + 0], $fg8            # |      1,389 |      1,389 |
    load    [$i21 + 1], $fg9            # |      1,389 |      1,389 |
    load    [$i21 + 2], $fg10           # |      1,389 |      1,389 |
    add     $ig0, -1, $i1               # |      1,389 |      1,389 |
.count move_args
    mov     $i21, $i2                   # |      1,389 |      1,389 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |
    load    [$i16 + 118], $i1           # |      1,389 |      1,389 |
    load    [$i1 + 0], $f1              # |      1,389 |      1,389 |
    load    [$i17 + 0], $f2             # |      1,389 |      1,389 |
    fmul    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 1], $f2              # |      1,389 |      1,389 |
    load    [$i17 + 1], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 2], $f2              # |      1,389 |      1,389 |
    load    [$i17 + 2], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    bg      $f0, $f1, bg.22670          # |      1,389 |      1,389 |
ble.22670:
    load    [$i16 + 118], $i9           # |         90 |         90 |
    fmul    $f1, $fc1, $f11             # |         90 |         90 |
    jal     trace_diffuse_ray.2926, $ra4# |         90 |         90 |
    li      116, $i18                   # |         90 |         90 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         90 |         90 |
    be      $i22, 1, be.22671           # |         90 |         90 |
.count dual_jmp
    b       bne.22671                   # |         64 |         64 |
bg.22670:
    load    [$i16 + 119], $i9           # |      1,299 |      1,299 |
    fmul    $f1, $fc2, $f11             # |      1,299 |      1,299 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,299 |      1,299 |
    li      116, $i18                   # |      1,299 |      1,299 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,299 |      1,299 |
    bne     $i22, 1, bne.22671          # |      1,299 |      1,299 |
be.22671:
    be      $i22, 2, be.22673           # |        348 |        348 |
.count dual_jmp
    b       bne.22673                   # |        348 |        348 |
bne.22671:
    load    [ext_dirvecs + 1], $i16     # |      1,389 |      1,389 |
    load    [$i21 + 0], $fg8            # |      1,389 |      1,389 |
    load    [$i21 + 1], $fg9            # |      1,389 |      1,389 |
    load    [$i21 + 2], $fg10           # |      1,389 |      1,389 |
    add     $ig0, -1, $i1               # |      1,389 |      1,389 |
.count move_args
    mov     $i21, $i2                   # |      1,389 |      1,389 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |
    load    [$i16 + 118], $i1           # |      1,389 |      1,389 |
    load    [$i1 + 0], $f1              # |      1,389 |      1,389 |
    load    [$i17 + 0], $f2             # |      1,389 |      1,389 |
    fmul    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 1], $f2              # |      1,389 |      1,389 |
    load    [$i17 + 1], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 2], $f2              # |      1,389 |      1,389 |
    load    [$i17 + 2], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    bg      $f0, $f1, bg.22672          # |      1,389 |      1,389 |
ble.22672:
    load    [$i16 + 118], $i9           # |         96 |         96 |
    fmul    $f1, $fc1, $f11             # |         96 |         96 |
    jal     trace_diffuse_ray.2926, $ra4# |         96 |         96 |
    li      116, $i18                   # |         96 |         96 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         96 |         96 |
    be      $i22, 2, be.22673           # |         96 |         96 |
.count dual_jmp
    b       bne.22673                   # |         75 |         75 |
bg.22672:
    load    [$i16 + 119], $i9           # |      1,293 |      1,293 |
    fmul    $f1, $fc2, $f11             # |      1,293 |      1,293 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,293 |      1,293 |
    li      116, $i18                   # |      1,293 |      1,293 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,293 |      1,293 |
    bne     $i22, 2, bne.22673          # |      1,293 |      1,293 |
be.22673:
    be      $i22, 3, be.22675           # |        337 |        337 |
.count dual_jmp
    b       bne.22675                   # |        337 |        337 |
bne.22673:
    load    [ext_dirvecs + 2], $i16     # |      1,400 |      1,400 |
    load    [$i21 + 0], $fg8            # |      1,400 |      1,400 |
    load    [$i21 + 1], $fg9            # |      1,400 |      1,400 |
    load    [$i21 + 2], $fg10           # |      1,400 |      1,400 |
    add     $ig0, -1, $i1               # |      1,400 |      1,400 |
.count move_args
    mov     $i21, $i2                   # |      1,400 |      1,400 |
    call    setup_startp_constants.2831 # |      1,400 |      1,400 |
    load    [$i16 + 118], $i1           # |      1,400 |      1,400 |
    load    [$i1 + 0], $f1              # |      1,400 |      1,400 |
    load    [$i17 + 0], $f2             # |      1,400 |      1,400 |
    fmul    $f1, $f2, $f1               # |      1,400 |      1,400 |
    load    [$i1 + 1], $f2              # |      1,400 |      1,400 |
    load    [$i17 + 1], $f3             # |      1,400 |      1,400 |
    fmul    $f2, $f3, $f2               # |      1,400 |      1,400 |
    fadd    $f1, $f2, $f1               # |      1,400 |      1,400 |
    load    [$i1 + 2], $f2              # |      1,400 |      1,400 |
    load    [$i17 + 2], $f3             # |      1,400 |      1,400 |
    fmul    $f2, $f3, $f2               # |      1,400 |      1,400 |
    fadd    $f1, $f2, $f1               # |      1,400 |      1,400 |
    bg      $f0, $f1, bg.22674          # |      1,400 |      1,400 |
ble.22674:
    load    [$i16 + 118], $i9           # |        126 |        126 |
    fmul    $f1, $fc1, $f11             # |        126 |        126 |
    jal     trace_diffuse_ray.2926, $ra4# |        126 |        126 |
    li      116, $i18                   # |        126 |        126 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        126 |        126 |
    be      $i22, 3, be.22675           # |        126 |        126 |
.count dual_jmp
    b       bne.22675                   # |        100 |        100 |
bg.22674:
    load    [$i16 + 119], $i9           # |      1,274 |      1,274 |
    fmul    $f1, $fc2, $f11             # |      1,274 |      1,274 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,274 |      1,274 |
    li      116, $i18                   # |      1,274 |      1,274 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,274 |      1,274 |
    bne     $i22, 3, bne.22675          # |      1,274 |      1,274 |
be.22675:
    be      $i22, 4, be.22677           # |        352 |        352 |
.count dual_jmp
    b       bne.22677                   # |        352 |        352 |
bne.22675:
    load    [ext_dirvecs + 3], $i16     # |      1,385 |      1,385 |
    load    [$i21 + 0], $fg8            # |      1,385 |      1,385 |
    load    [$i21 + 1], $fg9            # |      1,385 |      1,385 |
    load    [$i21 + 2], $fg10           # |      1,385 |      1,385 |
    add     $ig0, -1, $i1               # |      1,385 |      1,385 |
.count move_args
    mov     $i21, $i2                   # |      1,385 |      1,385 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |
    load    [$i16 + 118], $i1           # |      1,385 |      1,385 |
    load    [$i1 + 0], $f1              # |      1,385 |      1,385 |
    load    [$i17 + 0], $f2             # |      1,385 |      1,385 |
    fmul    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 1], $f2              # |      1,385 |      1,385 |
    load    [$i17 + 1], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 2], $f2              # |      1,385 |      1,385 |
    load    [$i17 + 2], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    bg      $f0, $f1, bg.22676          # |      1,385 |      1,385 |
ble.22676:
    load    [$i16 + 118], $i9           # |        115 |        115 |
    fmul    $f1, $fc1, $f11             # |        115 |        115 |
    jal     trace_diffuse_ray.2926, $ra4# |        115 |        115 |
    li      116, $i18                   # |        115 |        115 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        115 |        115 |
    be      $i22, 4, be.22677           # |        115 |        115 |
.count dual_jmp
    b       bne.22677                   # |         90 |         90 |
bg.22676:
    load    [$i16 + 119], $i9           # |      1,270 |      1,270 |
    fmul    $f1, $fc2, $f11             # |      1,270 |      1,270 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,270 |      1,270 |
    li      116, $i18                   # |      1,270 |      1,270 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,270 |      1,270 |
    bne     $i22, 4, bne.22677          # |      1,270 |      1,270 |
be.22677:
    add     $i19, 18, $i1               # |        352 |        352 |
    load    [$i1 + $i20], $i1           # |        352 |        352 |
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
bne.22677:
    load    [ext_dirvecs + 4], $i16     # |      1,385 |      1,385 |
    load    [$i21 + 0], $fg8            # |      1,385 |      1,385 |
    load    [$i21 + 1], $fg9            # |      1,385 |      1,385 |
    load    [$i21 + 2], $fg10           # |      1,385 |      1,385 |
    add     $ig0, -1, $i1               # |      1,385 |      1,385 |
.count move_args
    mov     $i21, $i2                   # |      1,385 |      1,385 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |
    load    [$i16 + 118], $i1           # |      1,385 |      1,385 |
    load    [$i1 + 0], $f1              # |      1,385 |      1,385 |
    load    [$i17 + 0], $f2             # |      1,385 |      1,385 |
    fmul    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 1], $f2              # |      1,385 |      1,385 |
    load    [$i17 + 1], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 2], $f2              # |      1,385 |      1,385 |
    load    [$i17 + 2], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    bg      $f0, $f1, bg.22678          # |      1,385 |      1,385 |
ble.22678:
    load    [$i16 + 118], $i9           # |         98 |         98 |
    fmul    $f1, $fc1, $f11             # |         98 |         98 |
    jal     trace_diffuse_ray.2926, $ra4# |         98 |         98 |
    li      116, $i18                   # |         98 |         98 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         98 |         98 |
    add     $i19, 18, $i1               # |         98 |         98 |
    load    [$i1 + $i20], $i1           # |         98 |         98 |
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
bg.22678:
    load    [$i16 + 119], $i9           # |      1,287 |      1,287 |
    fmul    $f1, $fc2, $f11             # |      1,287 |      1,287 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,287 |      1,287 |
    li      116, $i18                   # |      1,287 |      1,287 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,287 |      1,287 |
    add     $i19, 18, $i1               # |      1,287 |      1,287 |
    load    [$i1 + $i20], $i1           # |      1,287 |      1,287 |
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
# do_without_neighbors($i19, $i23)
# $ra = $ra7
# [$i1 - $i18, $i20 - $i24]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
    bg      $i23, 4, bg.22679           # |      2,430 |      2,430 |
ble.22679:
    add     $i19, 8, $i20               # |      2,430 |      2,430 |
    load    [$i20 + $i23], $i1          # |      2,430 |      2,430 |
    bl      $i1, 0, bg.22679            # |      2,430 |      2,430 |
bge.22680:
    add     $i19, 13, $i21              # |        143 |        143 |
    load    [$i21 + $i23], $i1          # |        143 |        143 |
    bne     $i1, 0, bne.22681           # |        143 |        143 |
be.22681:
    add     $i23, 1, $i1                # |         11 |         11 |
    ble     $i1, 4, ble.22695           # |         11 |         11 |
.count dual_jmp
    b       bg.22679
bne.22681:
    add     $i19, 23, $i1               # |        132 |        132 |
    load    [$i1 + $i23], $i1           # |        132 |        132 |
    load    [$i1 + 0], $fg1             # |        132 |        132 |
    load    [$i1 + 1], $fg2             # |        132 |        132 |
    load    [$i1 + 2], $fg3             # |        132 |        132 |
    add     $i19, 29, $i1               # |        132 |        132 |
    add     $i19, 3, $i2                # |        132 |        132 |
    load    [$i1 + $i23], $i17          # |        132 |        132 |
    load    [$i2 + $i23], $i22          # |        132 |        132 |
    load    [$i19 + 28], $i24           # |        132 |        132 |
    bne     $i24, 0, bne.22685          # |        132 |        132 |
be.22685:
    be      $i24, 1, be.22687           # |         25 |         25 |
.count dual_jmp
    b       bne.22687                   # |         25 |         25 |
bne.22685:
    load    [ext_dirvecs + 0], $i16     # |        107 |        107 |
    load    [$i22 + 0], $fg8            # |        107 |        107 |
    load    [$i22 + 1], $fg9            # |        107 |        107 |
    load    [$i22 + 2], $fg10           # |        107 |        107 |
    add     $ig0, -1, $i1               # |        107 |        107 |
.count move_args
    mov     $i22, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i16 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i17 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i17 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i17 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, bg.22686          # |        107 |        107 |
ble.22686:
    fmul    $f1, $fc1, $f11
    load    [$i16 + 118], $i9
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i18
    jal     iter_trace_diffuse_rays.2929, $ra5
    be      $i24, 1, be.22687
.count dual_jmp
    b       bne.22687
bg.22686:
    fmul    $f1, $fc2, $f11             # |        107 |        107 |
    load    [$i16 + 119], $i9           # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i18                   # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
    bne     $i24, 1, bne.22687          # |        107 |        107 |
be.22687:
    be      $i24, 2, be.22689           # |         28 |         28 |
.count dual_jmp
    b       bne.22689                   # |         28 |         28 |
bne.22687:
    load    [ext_dirvecs + 1], $i16     # |        104 |        104 |
    load    [$i22 + 0], $fg8            # |        104 |        104 |
    load    [$i22 + 1], $fg9            # |        104 |        104 |
    load    [$i22 + 2], $fg10           # |        104 |        104 |
    add     $ig0, -1, $i1               # |        104 |        104 |
.count move_args
    mov     $i22, $i2                   # |        104 |        104 |
    call    setup_startp_constants.2831 # |        104 |        104 |
    load    [$i16 + 118], $i1           # |        104 |        104 |
    load    [$i1 + 0], $f1              # |        104 |        104 |
    load    [$i17 + 0], $f2             # |        104 |        104 |
    fmul    $f1, $f2, $f1               # |        104 |        104 |
    load    [$i1 + 1], $f2              # |        104 |        104 |
    load    [$i17 + 1], $f3             # |        104 |        104 |
    fmul    $f2, $f3, $f2               # |        104 |        104 |
    fadd    $f1, $f2, $f1               # |        104 |        104 |
    load    [$i1 + 2], $f2              # |        104 |        104 |
    load    [$i17 + 2], $f3             # |        104 |        104 |
    fmul    $f2, $f3, $f2               # |        104 |        104 |
    fadd    $f1, $f2, $f1               # |        104 |        104 |
    bg      $f0, $f1, bg.22688          # |        104 |        104 |
ble.22688:
    fmul    $f1, $fc1, $f11
    load    [$i16 + 118], $i9
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i18
    jal     iter_trace_diffuse_rays.2929, $ra5
    be      $i24, 2, be.22689
.count dual_jmp
    b       bne.22689
bg.22688:
    fmul    $f1, $fc2, $f11             # |        104 |        104 |
    load    [$i16 + 119], $i9           # |        104 |        104 |
    jal     trace_diffuse_ray.2926, $ra4# |        104 |        104 |
    li      116, $i18                   # |        104 |        104 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        104 |        104 |
    bne     $i24, 2, bne.22689          # |        104 |        104 |
be.22689:
    be      $i24, 3, be.22691           # |         25 |         25 |
.count dual_jmp
    b       bne.22691                   # |         25 |         25 |
bne.22689:
    load    [ext_dirvecs + 2], $i16     # |        107 |        107 |
    load    [$i22 + 0], $fg8            # |        107 |        107 |
    load    [$i22 + 1], $fg9            # |        107 |        107 |
    load    [$i22 + 2], $fg10           # |        107 |        107 |
    add     $ig0, -1, $i1               # |        107 |        107 |
.count move_args
    mov     $i22, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i16 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i17 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i17 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i17 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, bg.22690          # |        107 |        107 |
ble.22690:
    fmul    $f1, $fc1, $f11
    load    [$i16 + 118], $i9
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i18
    jal     iter_trace_diffuse_rays.2929, $ra5
    be      $i24, 3, be.22691
.count dual_jmp
    b       bne.22691
bg.22690:
    fmul    $f1, $fc2, $f11             # |        107 |        107 |
    load    [$i16 + 119], $i9           # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i18                   # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
    bne     $i24, 3, bne.22691          # |        107 |        107 |
be.22691:
    be      $i24, 4, be.22693           # |         29 |         29 |
.count dual_jmp
    b       bne.22693                   # |         29 |         29 |
bne.22691:
    load    [ext_dirvecs + 3], $i16     # |        103 |        103 |
    load    [$i22 + 0], $fg8            # |        103 |        103 |
    load    [$i22 + 1], $fg9            # |        103 |        103 |
    load    [$i22 + 2], $fg10           # |        103 |        103 |
    add     $ig0, -1, $i1               # |        103 |        103 |
.count move_args
    mov     $i22, $i2                   # |        103 |        103 |
    call    setup_startp_constants.2831 # |        103 |        103 |
    load    [$i16 + 118], $i1           # |        103 |        103 |
    load    [$i1 + 0], $f1              # |        103 |        103 |
    load    [$i17 + 0], $f2             # |        103 |        103 |
    fmul    $f1, $f2, $f1               # |        103 |        103 |
    load    [$i1 + 1], $f2              # |        103 |        103 |
    load    [$i17 + 1], $f3             # |        103 |        103 |
    fmul    $f2, $f3, $f2               # |        103 |        103 |
    fadd    $f1, $f2, $f1               # |        103 |        103 |
    load    [$i1 + 2], $f2              # |        103 |        103 |
    load    [$i17 + 2], $f3             # |        103 |        103 |
    fmul    $f2, $f3, $f2               # |        103 |        103 |
    fadd    $f1, $f2, $f1               # |        103 |        103 |
    bg      $f0, $f1, bg.22692          # |        103 |        103 |
ble.22692:
    fmul    $f1, $fc1, $f11
    load    [$i16 + 118], $i9
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i18
    jal     iter_trace_diffuse_rays.2929, $ra5
    be      $i24, 4, be.22693
.count dual_jmp
    b       bne.22693
bg.22692:
    fmul    $f1, $fc2, $f11             # |        103 |        103 |
    load    [$i16 + 119], $i9           # |        103 |        103 |
    jal     trace_diffuse_ray.2926, $ra4# |        103 |        103 |
    li      116, $i18                   # |        103 |        103 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        103 |        103 |
    bne     $i24, 4, bne.22693          # |        103 |        103 |
be.22693:
    add     $i19, 18, $i1               # |         25 |         25 |
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
    add     $i23, 1, $i1                # |         25 |         25 |
    ble     $i1, 4, ble.22695           # |         25 |         25 |
.count dual_jmp
    b       bg.22679
bne.22693:
    load    [ext_dirvecs + 4], $i16     # |        107 |        107 |
    load    [$i22 + 0], $fg8            # |        107 |        107 |
    load    [$i22 + 1], $fg9            # |        107 |        107 |
    load    [$i22 + 2], $fg10           # |        107 |        107 |
    add     $ig0, -1, $i1               # |        107 |        107 |
.count move_args
    mov     $i22, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i16 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i17 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i17 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i17 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, bg.22694          # |        107 |        107 |
ble.22694:
    fmul    $f1, $fc1, $f11
    load    [$i16 + 118], $i9
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i18
    jal     iter_trace_diffuse_rays.2929, $ra5
    add     $i19, 18, $i1
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
    add     $i23, 1, $i1
    ble     $i1, 4, ble.22695
.count dual_jmp
    b       bg.22679
bg.22694:
    fmul    $f1, $fc2, $f11             # |        107 |        107 |
    load    [$i16 + 119], $i9           # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i18                   # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
    add     $i19, 18, $i1               # |        107 |        107 |
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
    add     $i23, 1, $i1                # |        107 |        107 |
    bg      $i1, 4, bg.22679            # |        107 |        107 |
ble.22695:
    load    [$i20 + $i1], $i2           # |        143 |        143 |
    bl      $i2, 0, bg.22679            # |        143 |        143 |
bge.22696:
    load    [$i21 + $i1], $i2           # |          1 |          1 |
    bne     $i2, 0, bne.22697           # |          1 |          1 |
be.22697:
    add     $i23, 2, $i23
    b       do_without_neighbors.2951
bne.22697:
.count move_args
    mov     $i1, $i20                   # |          1 |          1 |
    jal     calc_diffuse_using_1point.2942, $ra6# |          1 |          1 |
    add     $i23, 2, $i23               # |          1 |          1 |
    b       do_without_neighbors.2951   # |          1 |          1 |
bg.22679:
    jr      $ra7                        # |      2,429 |      2,429 |
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i20)
# $ra = $ra7
# [$i1 - $i24]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
    bg      $i20, 4, bg.22698           # |     15,923 |     15,923 |
ble.22698:
    load    [$i4 + $i2], $i1            # |     15,923 |     15,923 |
    add     $i1, 8, $i6                 # |     15,923 |     15,923 |
    load    [$i6 + $i20], $i6           # |     15,923 |     15,923 |
    bl      $i6, 0, bg.22698            # |     15,923 |     15,923 |
bge.22699:
    load    [$i3 + $i2], $i7            # |      1,968 |      1,968 |
    add     $i7, 8, $i8                 # |      1,968 |      1,968 |
    load    [$i8 + $i20], $i8           # |      1,968 |      1,968 |
    bne     $i8, $i6, bne.22700         # |      1,968 |      1,968 |
be.22700:
    load    [$i5 + $i2], $i8            # |      1,796 |      1,796 |
    add     $i8, 8, $i8                 # |      1,796 |      1,796 |
    load    [$i8 + $i20], $i8           # |      1,796 |      1,796 |
    bne     $i8, $i6, bne.22700         # |      1,796 |      1,796 |
be.22701:
    add     $i2, -1, $i8                # |      1,700 |      1,700 |
    load    [$i4 + $i8], $i8            # |      1,700 |      1,700 |
    add     $i8, 8, $i8                 # |      1,700 |      1,700 |
    load    [$i8 + $i20], $i8           # |      1,700 |      1,700 |
    bne     $i8, $i6, bne.22700         # |      1,700 |      1,700 |
be.22702:
    add     $i2, 1, $i8                 # |      1,634 |      1,634 |
    load    [$i4 + $i8], $i8            # |      1,634 |      1,634 |
    add     $i8, 8, $i8                 # |      1,634 |      1,634 |
    load    [$i8 + $i20], $i8           # |      1,634 |      1,634 |
    bne     $i8, $i6, bne.22700         # |      1,634 |      1,634 |
be.22703:
    add     $i1, 13, $i1                # |      1,590 |      1,590 |
    load    [$i1 + $i20], $i1           # |      1,590 |      1,590 |
    bne     $i1, 0, bne.22708           # |      1,590 |      1,590 |
be.22708:
    add     $i20, 1, $i20               # |         26 |         26 |
    b       try_exploit_neighbors.2967  # |         26 |         26 |
bne.22708:
    add     $i7, 23, $i1                # |      1,564 |      1,564 |
    load    [$i1 + $i20], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $fg3             # |      1,564 |      1,564 |
    add     $i2, -1, $i1                # |      1,564 |      1,564 |
    load    [$i4 + $i1], $i1            # |      1,564 |      1,564 |
    add     $i1, 23, $i1                # |      1,564 |      1,564 |
    load    [$i1 + $i20], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fadd    $fg2, $f1, $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fadd    $fg3, $f1, $fg3             # |      1,564 |      1,564 |
    load    [$i4 + $i2], $i1            # |      1,564 |      1,564 |
    add     $i1, 23, $i1                # |      1,564 |      1,564 |
    load    [$i1 + $i20], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fadd    $fg2, $f1, $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fadd    $fg3, $f1, $fg3             # |      1,564 |      1,564 |
    add     $i2, 1, $i1                 # |      1,564 |      1,564 |
    load    [$i4 + $i1], $i1            # |      1,564 |      1,564 |
    add     $i1, 23, $i1                # |      1,564 |      1,564 |
    load    [$i1 + $i20], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fadd    $fg2, $f1, $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fadd    $fg3, $f1, $fg3             # |      1,564 |      1,564 |
    load    [$i5 + $i2], $i1            # |      1,564 |      1,564 |
    add     $i1, 23, $i1                # |      1,564 |      1,564 |
    load    [$i1 + $i20], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fadd    $fg2, $f1, $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fadd    $fg3, $f1, $fg3             # |      1,564 |      1,564 |
    load    [$i4 + $i2], $i1            # |      1,564 |      1,564 |
    add     $i1, 18, $i1                # |      1,564 |      1,564 |
    load    [$i1 + $i20], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fmul    $f1, $fg1, $f1              # |      1,564 |      1,564 |
    fadd    $fg4, $f1, $fg4             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fmul    $f1, $fg2, $f1              # |      1,564 |      1,564 |
    fadd    $fg5, $f1, $fg5             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fmul    $f1, $fg3, $f1              # |      1,564 |      1,564 |
    fadd    $fg6, $f1, $fg6             # |      1,564 |      1,564 |
    add     $i20, 1, $i20               # |      1,564 |      1,564 |
    b       try_exploit_neighbors.2967  # |      1,564 |      1,564 |
bne.22700:
    bg      $i20, 4, bg.22698           # |        378 |        378 |
ble.22705:
    load    [$i4 + $i2], $i19           # |        378 |        378 |
    add     $i19, 8, $i1                # |        378 |        378 |
    load    [$i1 + $i20], $i1           # |        378 |        378 |
    bl      $i1, 0, bg.22698            # |        378 |        378 |
bge.22706:
    add     $i19, 13, $i1               # |        378 |        378 |
    load    [$i1 + $i20], $i1           # |        378 |        378 |
    bne     $i1, 0, bne.22707           # |        378 |        378 |
be.22707:
    add     $i20, 1, $i23               # |         32 |         32 |
    b       do_without_neighbors.2951   # |         32 |         32 |
bne.22707:
    jal     calc_diffuse_using_1point.2942, $ra6# |        346 |        346 |
    add     $i20, 1, $i23               # |        346 |        346 |
    b       do_without_neighbors.2951   # |        346 |        346 |
bg.22698:
    jr      $ra7                        # |     13,955 |     13,955 |
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
    bg      $i1, $i4, bg.22711          # |     49,152 |     49,152 |
ble.22711:
    bl      $i1, 0, bl.22712            # |     33,363 |     33,363 |
bge.22712:
.count move_args
    mov     $i1, $i2                    # |     33,363 |     33,363 |
    b       ext_write                   # |     33,363 |     33,363 |
bl.22712:
    li      0, $i2
    b       ext_write
bg.22711:
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
# pretrace_diffuse_rays($i19, $i20)
# $ra = $ra6
# [$i1 - $i18, $i20 - $i26]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
    bg      $i20, 4, bg.22715           # |     16,395 |     16,395 |
ble.22715:
    add     $i19, 8, $i21               # |     16,395 |     16,395 |
    load    [$i21 + $i20], $i1          # |     16,395 |     16,395 |
    bl      $i1, 0, bg.22715            # |     16,395 |     16,395 |
bge.22716:
    add     $i19, 13, $i22              # |      2,101 |      2,101 |
    load    [$i22 + $i20], $i1          # |      2,101 |      2,101 |
    bne     $i1, 0, bne.22717           # |      2,101 |      2,101 |
be.22717:
    add     $i20, 1, $i23               # |         67 |         67 |
    bg      $i23, 4, bg.22715           # |         67 |         67 |
ble.22718:
    load    [$i21 + $i23], $i1          # |         67 |         67 |
    bl      $i1, 0, bg.22715            # |         67 |         67 |
bge.22719:
    load    [$i22 + $i23], $i1          # |         11 |         11 |
    be      $i1, 0, be.22725            # |         11 |         11 |
bne.22720:
    mov     $f0, $fg1                   # |          9 |          9 |
    mov     $f0, $fg2                   # |          9 |          9 |
    mov     $f0, $fg3                   # |          9 |          9 |
    add     $i19, 29, $i6               # |          9 |          9 |
    add     $i19, 3, $i1                # |          9 |          9 |
    load    [$i1 + $i23], $i2           # |          9 |          9 |
    load    [$i2 + 0], $fg8             # |          9 |          9 |
    load    [$i2 + 1], $fg9             # |          9 |          9 |
    load    [$i2 + 2], $fg10            # |          9 |          9 |
    add     $ig0, -1, $i1               # |          9 |          9 |
    call    setup_startp_constants.2831 # |          9 |          9 |
    load    [$i19 + 28], $i1            # |          9 |          9 |
    load    [ext_dirvecs + $i1], $i16   # |          9 |          9 |
    load    [$i16 + 118], $i1           # |          9 |          9 |
    load    [$i6 + $i23], $i17          # |          9 |          9 |
    load    [$i1 + 0], $f1              # |          9 |          9 |
    load    [$i17 + 0], $f2             # |          9 |          9 |
    fmul    $f1, $f2, $f1               # |          9 |          9 |
    load    [$i1 + 1], $f2              # |          9 |          9 |
    load    [$i17 + 1], $f3             # |          9 |          9 |
    fmul    $f2, $f3, $f2               # |          9 |          9 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |
    load    [$i1 + 2], $f2              # |          9 |          9 |
    load    [$i17 + 2], $f3             # |          9 |          9 |
    fmul    $f2, $f3, $f2               # |          9 |          9 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |
    bg      $f0, $f1, bg.22721          # |          9 |          9 |
ble.22721:
    fmul    $f1, $fc1, $f11
    load    [$i16 + 118], $i9
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i18
    jal     iter_trace_diffuse_rays.2929, $ra5
    add     $i19, 23, $i1
    load    [$i1 + $i23], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    add     $i20, 2, $i20
    b       pretrace_diffuse_rays.2980
bg.22721:
    fmul    $f1, $fc2, $f11             # |          9 |          9 |
    load    [$i16 + 119], $i9           # |          9 |          9 |
    jal     trace_diffuse_ray.2926, $ra4# |          9 |          9 |
    li      116, $i18                   # |          9 |          9 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |          9 |          9 |
    add     $i19, 23, $i1               # |          9 |          9 |
    load    [$i1 + $i23], $i1           # |          9 |          9 |
    store   $fg1, [$i1 + 0]             # |          9 |          9 |
    store   $fg2, [$i1 + 1]             # |          9 |          9 |
    store   $fg3, [$i1 + 2]             # |          9 |          9 |
    add     $i20, 2, $i20               # |          9 |          9 |
    b       pretrace_diffuse_rays.2980  # |          9 |          9 |
bne.22717:
    mov     $f0, $fg1                   # |      2,034 |      2,034 |
    mov     $f0, $fg2                   # |      2,034 |      2,034 |
    mov     $f0, $fg3                   # |      2,034 |      2,034 |
    add     $i19, 29, $i23              # |      2,034 |      2,034 |
    add     $i19, 3, $i24               # |      2,034 |      2,034 |
    load    [$i24 + $i20], $i2          # |      2,034 |      2,034 |
    load    [$i2 + 0], $fg8             # |      2,034 |      2,034 |
    load    [$i2 + 1], $fg9             # |      2,034 |      2,034 |
    load    [$i2 + 2], $fg10            # |      2,034 |      2,034 |
    add     $ig0, -1, $i1               # |      2,034 |      2,034 |
    call    setup_startp_constants.2831 # |      2,034 |      2,034 |
    load    [$i19 + 28], $i1            # |      2,034 |      2,034 |
    load    [ext_dirvecs + $i1], $i16   # |      2,034 |      2,034 |
    load    [$i16 + 118], $i1           # |      2,034 |      2,034 |
    load    [$i1 + 0], $f1              # |      2,034 |      2,034 |
    load    [$i23 + $i20], $i17         # |      2,034 |      2,034 |
    load    [$i17 + 0], $f2             # |      2,034 |      2,034 |
    fmul    $f1, $f2, $f1               # |      2,034 |      2,034 |
    load    [$i1 + 1], $f2              # |      2,034 |      2,034 |
    load    [$i17 + 1], $f3             # |      2,034 |      2,034 |
    fmul    $f2, $f3, $f2               # |      2,034 |      2,034 |
    fadd    $f1, $f2, $f1               # |      2,034 |      2,034 |
    load    [$i1 + 2], $f2              # |      2,034 |      2,034 |
    load    [$i17 + 2], $f3             # |      2,034 |      2,034 |
    fmul    $f2, $f3, $f2               # |      2,034 |      2,034 |
    fadd    $f1, $f2, $f1               # |      2,034 |      2,034 |
    bg      $f0, $f1, bg.22722          # |      2,034 |      2,034 |
ble.22722:
    load    [$i16 + 118], $i9           # |        293 |        293 |
    fmul    $f1, $fc1, $f11             # |        293 |        293 |
    jal     trace_diffuse_ray.2926, $ra4# |        293 |        293 |
    li      116, $i18                   # |        293 |        293 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        293 |        293 |
    add     $i19, 23, $i25              # |        293 |        293 |
    load    [$i25 + $i20], $i1          # |        293 |        293 |
    store   $fg1, [$i1 + 0]             # |        293 |        293 |
    store   $fg2, [$i1 + 1]             # |        293 |        293 |
    store   $fg3, [$i1 + 2]             # |        293 |        293 |
    add     $i20, 1, $i26               # |        293 |        293 |
    ble     $i26, 4, ble.22723          # |        293 |        293 |
.count dual_jmp
    b       bg.22715
bg.22722:
    load    [$i16 + 119], $i9           # |      1,741 |      1,741 |
    fmul    $f1, $fc2, $f11             # |      1,741 |      1,741 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,741 |      1,741 |
    li      116, $i18                   # |      1,741 |      1,741 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,741 |      1,741 |
    add     $i19, 23, $i25              # |      1,741 |      1,741 |
    load    [$i25 + $i20], $i1          # |      1,741 |      1,741 |
    store   $fg1, [$i1 + 0]             # |      1,741 |      1,741 |
    store   $fg2, [$i1 + 1]             # |      1,741 |      1,741 |
    store   $fg3, [$i1 + 2]             # |      1,741 |      1,741 |
    add     $i20, 1, $i26               # |      1,741 |      1,741 |
    bg      $i26, 4, bg.22715           # |      1,741 |      1,741 |
ble.22723:
    load    [$i21 + $i26], $i1          # |      2,034 |      2,034 |
    bl      $i1, 0, bg.22715            # |      2,034 |      2,034 |
bge.22724:
    load    [$i22 + $i26], $i1
    bne     $i1, 0, bne.22725
be.22725:
    add     $i20, 2, $i20               # |          2 |          2 |
    b       pretrace_diffuse_rays.2980  # |          2 |          2 |
bne.22725:
    mov     $f0, $fg1
    mov     $f0, $fg2
    mov     $f0, $fg3
    load    [$i24 + $i26], $i2
    load    [$i2 + 0], $fg8
    load    [$i2 + 1], $fg9
    load    [$i2 + 2], $fg10
    add     $ig0, -1, $i1
    call    setup_startp_constants.2831
    load    [$i19 + 28], $i1
    load    [ext_dirvecs + $i1], $i16
    load    [$i16 + 118], $i1
    load    [$i23 + $i26], $i17
    load    [$i1 + 0], $f1
    load    [$i17 + 0], $f2
    fmul    $f1, $f2, $f1
    load    [$i1 + 1], $f2
    load    [$i17 + 1], $f3
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 2], $f2
    load    [$i17 + 2], $f3
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    bg      $f0, $f1, bg.22726
ble.22726:
    fmul    $f1, $fc1, $f11
    load    [$i16 + 118], $i9
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i18
    jal     iter_trace_diffuse_rays.2929, $ra5
    load    [$i25 + $i26], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    add     $i20, 2, $i20
    b       pretrace_diffuse_rays.2980
bg.22726:
    fmul    $f1, $fc2, $f11
    load    [$i16 + 119], $i9
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i18
    jal     iter_trace_diffuse_rays.2929, $ra5
    load    [$i25 + $i26], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    add     $i20, 2, $i20
    b       pretrace_diffuse_rays.2980
bg.22715:
    jr      $ra6                        # |     16,384 |     16,384 |
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i27, $i28, $i29, $f16, $f17, $f18)
# $ra = $ra7
# [$i1 - $i26, $i28 - $i29]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra6]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
    bl      $i28, 0, bl.22727           # |     16,512 |     16,512 |
bge.22727:
    add     $i28, -64, $i2              # |     16,384 |     16,384 |
    call    ext_float_of_int            # |     16,384 |     16,384 |
    load    [ext_screenx_dir + 0], $f2  # |     16,384 |     16,384 |
    fmul    $f1, $f2, $f2               # |     16,384 |     16,384 |
    fadd    $f2, $f16, $f2              # |     16,384 |     16,384 |
    store   $f2, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |
    store   $f17, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |
    load    [ext_screenx_dir + 2], $f2  # |     16,384 |     16,384 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |
    fadd    $f1, $f18, $f1              # |     16,384 |     16,384 |
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
    mov     $f0, $f15                   # |     16,384 |     16,384 |
.count move_args
    mov     $fc0, $f14                  # |     16,384 |     16,384 |
    li      0, $i19                     # |     16,384 |     16,384 |
    li      ext_ptrace_dirvec, $i17     # |     16,384 |     16,384 |
    mov     $f0, $fg6                   # |     16,384 |     16,384 |
    mov     $f0, $fg5                   # |     16,384 |     16,384 |
    mov     $f0, $fg4                   # |     16,384 |     16,384 |
    bne     $f2, $f0, bne.22728         # |     16,384 |     16,384 |
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
    load    [$i27 + $i28], $i20
    jal     trace_ray.2920, $ra5
    load    [$i27 + $i28], $i1
    store   $fg4, [$i1 + 0]
    store   $fg5, [$i1 + 1]
    store   $fg6, [$i1 + 2]
    load    [$i27 + $i28], $i1
    store   $i29, [$i1 + 28]
    load    [$i27 + $i28], $i19
    load    [$i19 + 8], $i1
    bge     $i1, 0, bge.22729
.count dual_jmp
    b       bl.22729
bne.22728:
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
    load    [$i27 + $i28], $i20         # |     16,384 |     16,384 |
    jal     trace_ray.2920, $ra5        # |     16,384 |     16,384 |
    load    [$i27 + $i28], $i1          # |     16,384 |     16,384 |
    store   $fg4, [$i1 + 0]             # |     16,384 |     16,384 |
    store   $fg5, [$i1 + 1]             # |     16,384 |     16,384 |
    store   $fg6, [$i1 + 2]             # |     16,384 |     16,384 |
    load    [$i27 + $i28], $i1          # |     16,384 |     16,384 |
    store   $i29, [$i1 + 28]            # |     16,384 |     16,384 |
    load    [$i27 + $i28], $i19         # |     16,384 |     16,384 |
    load    [$i19 + 8], $i1             # |     16,384 |     16,384 |
    bl      $i1, 0, bl.22729            # |     16,384 |     16,384 |
bge.22729:
    load    [$i19 + 13], $i1            # |     16,384 |     16,384 |
    bne     $i1, 0, bne.22730           # |     16,384 |     16,384 |
be.22730:
    li      1, $i20                     # |      7,301 |      7,301 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      7,301 |      7,301 |
    add     $i28, -1, $i28              # |      7,301 |      7,301 |
    add     $i29, 1, $i1                # |      7,301 |      7,301 |
    bge     $i1, 5, bge.22732           # |      7,301 |      7,301 |
.count dual_jmp
    b       bl.22732                    # |      5,841 |      5,841 |
bne.22730:
    load    [$i19 + 28], $i1            # |      9,083 |      9,083 |
    mov     $f0, $fg1                   # |      9,083 |      9,083 |
    mov     $f0, $fg2                   # |      9,083 |      9,083 |
    mov     $f0, $fg3                   # |      9,083 |      9,083 |
    load    [ext_dirvecs + $i1], $i16   # |      9,083 |      9,083 |
    load    [$i19 + 29], $i17           # |      9,083 |      9,083 |
    load    [$i19 + 3], $i2             # |      9,083 |      9,083 |
    load    [$i2 + 0], $fg8             # |      9,083 |      9,083 |
    load    [$i2 + 1], $fg9             # |      9,083 |      9,083 |
    load    [$i2 + 2], $fg10            # |      9,083 |      9,083 |
    add     $ig0, -1, $i1               # |      9,083 |      9,083 |
    call    setup_startp_constants.2831 # |      9,083 |      9,083 |
    load    [$i16 + 118], $i1           # |      9,083 |      9,083 |
    load    [$i1 + 0], $f1              # |      9,083 |      9,083 |
    load    [$i17 + 0], $f2             # |      9,083 |      9,083 |
    fmul    $f1, $f2, $f1               # |      9,083 |      9,083 |
    load    [$i1 + 1], $f2              # |      9,083 |      9,083 |
    load    [$i17 + 1], $f3             # |      9,083 |      9,083 |
    fmul    $f2, $f3, $f2               # |      9,083 |      9,083 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |
    load    [$i1 + 2], $f2              # |      9,083 |      9,083 |
    load    [$i17 + 2], $f3             # |      9,083 |      9,083 |
    fmul    $f2, $f3, $f2               # |      9,083 |      9,083 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |
    bg      $f0, $f1, bg.22731          # |      9,083 |      9,083 |
ble.22731:
    fmul    $f1, $fc1, $f11             # |         14 |         14 |
    load    [$i16 + 118], $i9           # |         14 |         14 |
    jal     trace_diffuse_ray.2926, $ra4# |         14 |         14 |
    li      116, $i18                   # |         14 |         14 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         14 |         14 |
    load    [$i19 + 23], $i1            # |         14 |         14 |
    store   $fg1, [$i1 + 0]             # |         14 |         14 |
    store   $fg2, [$i1 + 1]             # |         14 |         14 |
    store   $fg3, [$i1 + 2]             # |         14 |         14 |
    li      1, $i20                     # |         14 |         14 |
    jal     pretrace_diffuse_rays.2980, $ra6# |         14 |         14 |
    add     $i28, -1, $i28              # |         14 |         14 |
    add     $i29, 1, $i1                # |         14 |         14 |
    bge     $i1, 5, bge.22732           # |         14 |         14 |
.count dual_jmp
    b       bl.22732                    # |         13 |         13 |
bg.22731:
    fmul    $f1, $fc2, $f11             # |      9,069 |      9,069 |
    load    [$i16 + 119], $i9           # |      9,069 |      9,069 |
    jal     trace_diffuse_ray.2926, $ra4# |      9,069 |      9,069 |
    li      116, $i18                   # |      9,069 |      9,069 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      9,069 |      9,069 |
    load    [$i19 + 23], $i1            # |      9,069 |      9,069 |
    store   $fg1, [$i1 + 0]             # |      9,069 |      9,069 |
    store   $fg2, [$i1 + 1]             # |      9,069 |      9,069 |
    store   $fg3, [$i1 + 2]             # |      9,069 |      9,069 |
    li      1, $i20                     # |      9,069 |      9,069 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      9,069 |      9,069 |
    add     $i28, -1, $i28              # |      9,069 |      9,069 |
    add     $i29, 1, $i1                # |      9,069 |      9,069 |
    bge     $i1, 5, bge.22732           # |      9,069 |      9,069 |
.count dual_jmp
    b       bl.22732                    # |      7,253 |      7,253 |
bl.22729:
    add     $i28, -1, $i28
    add     $i29, 1, $i1
    bl      $i1, 5, bl.22732
bge.22732:
    add     $i29, -4, $i29              # |      3,277 |      3,277 |
    b       pretrace_pixels.2983        # |      3,277 |      3,277 |
bl.22732:
.count move_args
    mov     $i1, $i29                   # |     13,107 |     13,107 |
    b       pretrace_pixels.2983        # |     13,107 |     13,107 |
bl.22727:
    jr      $ra7                        # |        128 |        128 |
.end pretrace_pixels

######################################################################
# scan_pixel($i25, $i26, $i27, $i28, $i29)
# $ra = $ra8
# [$i1 - $i25]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra7]
######################################################################
.begin scan_pixel
scan_pixel.2994:
    li      128, $i1                    # |     16,512 |     16,512 |
    bg      $i1, $i25, bg.22733         # |     16,512 |     16,512 |
ble.22733:
    jr      $ra8                        # |        128 |        128 |
bg.22733:
    load    [$i28 + $i25], $i1          # |     16,384 |     16,384 |
    load    [$i1 + 0], $fg4             # |     16,384 |     16,384 |
    load    [$i1 + 1], $fg5             # |     16,384 |     16,384 |
    load    [$i1 + 2], $fg6             # |     16,384 |     16,384 |
    li      128, $i1                    # |     16,384 |     16,384 |
    add     $i26, 1, $i2                # |     16,384 |     16,384 |
    ble     $i1, $i2, ble.22737         # |     16,384 |     16,384 |
bg.22734:
    ble     $i26, 0, ble.22737          # |     16,256 |     16,256 |
bg.22735:
    li      128, $i1                    # |     16,128 |     16,128 |
    add     $i25, 1, $i2                # |     16,128 |     16,128 |
    ble     $i1, $i2, ble.22737         # |     16,128 |     16,128 |
bg.22736:
    bg      $i25, 0, bg.22737           # |     16,002 |     16,002 |
ble.22737:
    load    [$i28 + $i25], $i19         # |        508 |        508 |
    load    [$i19 + 8], $i1             # |        508 |        508 |
    bl      $i1, 0, bl.22741            # |        508 |        508 |
bge.22739:
    load    [$i19 + 13], $i1            # |        508 |        508 |
    be      $i1, 0, be.22748            # |        508 |        508 |
bne.22740:
    li      0, $i20                     # |        148 |        148 |
    jal     calc_diffuse_using_1point.2942, $ra6# |        148 |        148 |
    li      1, $i23                     # |        148 |        148 |
    jal     do_without_neighbors.2951, $ra7# |        148 |        148 |
    call    write_rgb.2978              # |        148 |        148 |
    add     $i25, 1, $i25               # |        148 |        148 |
    b       scan_pixel.2994             # |        148 |        148 |
bg.22737:
    load    [$i28 + $i25], $i1          # |     15,876 |     15,876 |
    load    [$i1 + 8], $i2              # |     15,876 |     15,876 |
    bl      $i2, 0, bl.22741            # |     15,876 |     15,876 |
bge.22741:
    li      0, $i20                     # |     15,876 |     15,876 |
    load    [$i27 + $i25], $i3          # |     15,876 |     15,876 |
    load    [$i3 + 8], $i4              # |     15,876 |     15,876 |
    bne     $i4, $i2, bne.22742         # |     15,876 |     15,876 |
be.22742:
    load    [$i29 + $i25], $i4          # |     15,253 |     15,253 |
    load    [$i4 + 8], $i4              # |     15,253 |     15,253 |
    bne     $i4, $i2, bne.22742         # |     15,253 |     15,253 |
be.22743:
    add     $i25, -1, $i4               # |     14,657 |     14,657 |
    load    [$i28 + $i4], $i4           # |     14,657 |     14,657 |
    load    [$i4 + 8], $i4              # |     14,657 |     14,657 |
    bne     $i4, $i2, bne.22742         # |     14,657 |     14,657 |
be.22744:
    add     $i25, 1, $i4                # |     14,497 |     14,497 |
    load    [$i28 + $i4], $i4           # |     14,497 |     14,497 |
    load    [$i4 + 8], $i4              # |     14,497 |     14,497 |
    bne     $i4, $i2, bne.22742         # |     14,497 |     14,497 |
be.22745:
    load    [$i1 + 13], $i1             # |     14,333 |     14,333 |
.count move_args
    mov     $i29, $i5                   # |     14,333 |     14,333 |
.count move_args
    mov     $i28, $i4                   # |     14,333 |     14,333 |
.count move_args
    mov     $i25, $i2                   # |     14,333 |     14,333 |
    li      1, $i20                     # |     14,333 |     14,333 |
    bne     $i1, 0, bne.22749           # |     14,333 |     14,333 |
be.22749:
.count move_args
    mov     $i27, $i3                   # |      6,640 |      6,640 |
    jal     try_exploit_neighbors.2967, $ra7# |      6,640 |      6,640 |
    call    write_rgb.2978              # |      6,640 |      6,640 |
    add     $i25, 1, $i25               # |      6,640 |      6,640 |
    b       scan_pixel.2994             # |      6,640 |      6,640 |
bne.22749:
    load    [$i3 + 23], $i1             # |      7,693 |      7,693 |
    load    [$i1 + 0], $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $fg3             # |      7,693 |      7,693 |
    add     $i25, -1, $i1               # |      7,693 |      7,693 |
    load    [$i28 + $i1], $i1           # |      7,693 |      7,693 |
    load    [$i1 + 23], $i1             # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fadd    $fg2, $f1, $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fadd    $fg3, $f1, $fg3             # |      7,693 |      7,693 |
    load    [$i28 + $i25], $i1          # |      7,693 |      7,693 |
    load    [$i1 + 23], $i1             # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fadd    $fg2, $f1, $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fadd    $fg3, $f1, $fg3             # |      7,693 |      7,693 |
    add     $i25, 1, $i1                # |      7,693 |      7,693 |
    load    [$i28 + $i1], $i1           # |      7,693 |      7,693 |
    load    [$i1 + 23], $i1             # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fadd    $fg2, $f1, $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fadd    $fg3, $f1, $fg3             # |      7,693 |      7,693 |
    load    [$i29 + $i25], $i1          # |      7,693 |      7,693 |
    load    [$i1 + 23], $i1             # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fadd    $fg2, $f1, $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fadd    $fg3, $f1, $fg3             # |      7,693 |      7,693 |
    load    [$i28 + $i25], $i1          # |      7,693 |      7,693 |
    load    [$i1 + 18], $i1             # |      7,693 |      7,693 |
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
    mov     $i27, $i3                   # |      7,693 |      7,693 |
    jal     try_exploit_neighbors.2967, $ra7# |      7,693 |      7,693 |
    call    write_rgb.2978              # |      7,693 |      7,693 |
    add     $i25, 1, $i25               # |      7,693 |      7,693 |
    b       scan_pixel.2994             # |      7,693 |      7,693 |
bne.22742:
    load    [$i28 + $i25], $i19         # |      1,543 |      1,543 |
    load    [$i19 + 8], $i1             # |      1,543 |      1,543 |
    bl      $i1, 0, bl.22741            # |      1,543 |      1,543 |
bge.22747:
    load    [$i19 + 13], $i1            # |      1,543 |      1,543 |
    bne     $i1, 0, bne.22748           # |      1,543 |      1,543 |
be.22748:
    li      1, $i23                     # |        661 |        661 |
    jal     do_without_neighbors.2951, $ra7# |        661 |        661 |
    call    write_rgb.2978              # |        661 |        661 |
    add     $i25, 1, $i25               # |        661 |        661 |
    b       scan_pixel.2994             # |        661 |        661 |
bne.22748:
    jal     calc_diffuse_using_1point.2942, $ra6# |      1,242 |      1,242 |
    li      1, $i23                     # |      1,242 |      1,242 |
    jal     do_without_neighbors.2951, $ra7# |      1,242 |      1,242 |
    call    write_rgb.2978              # |      1,242 |      1,242 |
    add     $i25, 1, $i25               # |      1,242 |      1,242 |
    b       scan_pixel.2994             # |      1,242 |      1,242 |
bl.22741:
    call    write_rgb.2978
    add     $i25, 1, $i25
    b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line($i30, $i31, $i32, $i33, $i34)
# $ra = $ra9
# [$i1 - $i34]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra8]
######################################################################
.begin scan_line
scan_line.3000:
    li      128, $i1                    # |        129 |        129 |
    bg      $i1, $i30, bg.22750         # |        129 |        129 |
ble.22750:
    jr      $ra9                        # |          1 |          1 |
bg.22750:
    bl      $i30, 127, bl.22751         # |        128 |        128 |
bge.22751:
    li      0, $i25                     # |          1 |          1 |
.count move_args
    mov     $i30, $i26                  # |          1 |          1 |
.count move_args
    mov     $i31, $i27                  # |          1 |          1 |
.count move_args
    mov     $i32, $i28                  # |          1 |          1 |
.count move_args
    mov     $i33, $i29                  # |          1 |          1 |
    jal     scan_pixel.2994, $ra8       # |          1 |          1 |
    add     $i30, 1, $i30               # |          1 |          1 |
    add     $i34, 2, $i1                # |          1 |          1 |
    bge     $i1, 5, bge.22752           # |          1 |          1 |
.count dual_jmp
    b       bl.22752                    # |          1 |          1 |
bl.22751:
    add     $i30, -63, $i2              # |        127 |        127 |
    call    ext_float_of_int            # |        127 |        127 |
    fmul    $f1, $fg23, $f2             # |        127 |        127 |
    fadd    $f2, $fg20, $f16            # |        127 |        127 |
    fmul    $f1, $fg24, $f2             # |        127 |        127 |
    fadd    $f2, $fg21, $f17            # |        127 |        127 |
    load    [ext_screeny_dir + 2], $f2  # |        127 |        127 |
    fmul    $f1, $f2, $f1               # |        127 |        127 |
    fadd    $f1, $fg22, $f18            # |        127 |        127 |
    li      127, $i28                   # |        127 |        127 |
.count move_args
    mov     $i33, $i27                  # |        127 |        127 |
.count move_args
    mov     $i34, $i29                  # |        127 |        127 |
    jal     pretrace_pixels.2983, $ra7  # |        127 |        127 |
    li      0, $i25                     # |        127 |        127 |
.count move_args
    mov     $i30, $i26                  # |        127 |        127 |
.count move_args
    mov     $i31, $i27                  # |        127 |        127 |
.count move_args
    mov     $i32, $i28                  # |        127 |        127 |
.count move_args
    mov     $i33, $i29                  # |        127 |        127 |
    jal     scan_pixel.2994, $ra8       # |        127 |        127 |
    add     $i30, 1, $i30               # |        127 |        127 |
    add     $i34, 2, $i1                # |        127 |        127 |
    bl      $i1, 5, bl.22752            # |        127 |        127 |
bge.22752:
    add     $i34, -3, $i34              # |         51 |         51 |
.count move_args
    mov     $i31, $tmp                  # |         51 |         51 |
.count move_args
    mov     $i32, $i31                  # |         51 |         51 |
.count move_args
    mov     $i33, $i32                  # |         51 |         51 |
.count move_args
    mov     $tmp, $i33                  # |         51 |         51 |
    b       scan_line.3000              # |         51 |         51 |
bl.22752:
.count move_args
    mov     $i1, $i34                   # |         77 |         77 |
.count move_args
    mov     $i31, $tmp                  # |         77 |         77 |
.count move_args
    mov     $i32, $i31                  # |         77 |         77 |
.count move_args
    mov     $i33, $i32                  # |         77 |         77 |
.count move_args
    mov     $tmp, $i33                  # |         77 |         77 |
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
    add     $hp, 34, $hp                # |        384 |        384 |
    load    [$i5 + 0], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 0]              # |        384 |        384 |
    load    [$i5 + 1], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 1]              # |        384 |        384 |
    load    [$i5 + 2], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 2]              # |        384 |        384 |
    load    [$i6 + 0], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 3]              # |        384 |        384 |
    load    [$i6 + 1], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 4]              # |        384 |        384 |
    load    [$i6 + 2], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 5]              # |        384 |        384 |
    load    [$i6 + 3], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 6]              # |        384 |        384 |
    load    [$i6 + 4], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 7]              # |        384 |        384 |
    load    [$i7 + 0], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 8]              # |        384 |        384 |
    load    [$i7 + 1], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 9]              # |        384 |        384 |
    load    [$i7 + 2], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 10]             # |        384 |        384 |
    load    [$i7 + 3], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 11]             # |        384 |        384 |
    load    [$i7 + 4], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 12]             # |        384 |        384 |
    load    [$i8 + 0], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 13]             # |        384 |        384 |
    load    [$i8 + 1], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 14]             # |        384 |        384 |
    load    [$i8 + 2], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 15]             # |        384 |        384 |
    load    [$i8 + 3], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 16]             # |        384 |        384 |
    load    [$i8 + 4], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 17]             # |        384 |        384 |
    load    [$i9 + 0], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 18]             # |        384 |        384 |
    load    [$i9 + 1], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 19]             # |        384 |        384 |
    load    [$i9 + 2], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 20]             # |        384 |        384 |
    load    [$i9 + 3], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 21]             # |        384 |        384 |
    load    [$i9 + 4], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 22]             # |        384 |        384 |
    load    [$i10 + 0], $i3             # |        384 |        384 |
    store   $i3, [$i2 + 23]             # |        384 |        384 |
    load    [$i10 + 1], $i3             # |        384 |        384 |
    store   $i3, [$i2 + 24]             # |        384 |        384 |
    load    [$i10 + 2], $i3             # |        384 |        384 |
    store   $i3, [$i2 + 25]             # |        384 |        384 |
    load    [$i10 + 3], $i3             # |        384 |        384 |
    store   $i3, [$i2 + 26]             # |        384 |        384 |
    load    [$i10 + 4], $i3             # |        384 |        384 |
    store   $i3, [$i2 + 27]             # |        384 |        384 |
    load    [$i11 + 0], $i3             # |        384 |        384 |
    store   $i3, [$i2 + 28]             # |        384 |        384 |
    load    [$i1 + 0], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 29]             # |        384 |        384 |
    load    [$i1 + 1], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 30]             # |        384 |        384 |
    load    [$i1 + 2], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 31]             # |        384 |        384 |
    load    [$i1 + 3], $i3              # |        384 |        384 |
    store   $i3, [$i2 + 32]             # |        384 |        384 |
    load    [$i1 + 4], $i1              # |        384 |        384 |
    store   $i1, [$i2 + 33]             # |        384 |        384 |
    mov     $i2, $i1                    # |        384 |        384 |
    jr      $ra2                        # |        384 |        384 |
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
.begin init_line_elements
init_line_elements.3010:
    bl      $i13, 0, bl.22753           # |        384 |        384 |
bge.22753:
    jal     create_pixel.3008, $ra2     # |        381 |        381 |
.count storer
    add     $i12, $i13, $tmp            # |        381 |        381 |
    store   $i1, [$tmp + 0]             # |        381 |        381 |
    add     $i13, -1, $i13              # |        381 |        381 |
    b       init_line_elements.3010     # |        381 |        381 |
bl.22753:
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
# calc_dirvec($i1, $f1, $f2, $f7, $f8, $i3, $i4)
# $ra = $ra1
# [$i1 - $i2]
# [$f1 - $f6, $f9 - $f12]
# []
# []
# [$ra]
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
    bl      $i1, 5, bl.22754            # |        600 |        600 |
bge.22754:
    load    [ext_dirvecs + $i3], $i1    # |        100 |        100 |
    load    [$i1 + $i4], $i2            # |        100 |        100 |
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
    store   $f1, [$i2 + 0]              # |        100 |        100 |
    store   $f3, [$i2 + 1]              # |        100 |        100 |
    fneg    $f2, $f4                    # |        100 |        100 |
    store   $f4, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 80, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    store   $f3, [$i2 + 0]              # |        100 |        100 |
    fneg    $f1, $f5                    # |        100 |        100 |
    store   $f5, [$i2 + 1]              # |        100 |        100 |
    store   $f4, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 1, $i2                 # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    store   $f5, [$i2 + 0]              # |        100 |        100 |
    store   $f4, [$i2 + 1]              # |        100 |        100 |
    fneg    $f3, $f3                    # |        100 |        100 |
    store   $f3, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 41, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    store   $f5, [$i2 + 0]              # |        100 |        100 |
    store   $f3, [$i2 + 1]              # |        100 |        100 |
    store   $f2, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 81, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i1            # |        100 |        100 |
    store   $f3, [$i1 + 0]              # |        100 |        100 |
    store   $f1, [$i1 + 1]              # |        100 |        100 |
    store   $f2, [$i1 + 2]              # |        100 |        100 |
    jr      $ra1                        # |        100 |        100 |
bl.22754:
    fmul    $f2, $f2, $f1               # |        500 |        500 |
    fadd    $f1, $fc9, $f1              # |        500 |        500 |
    fsqrt   $f1, $f9                    # |        500 |        500 |
    finv    $f9, $f2                    # |        500 |        500 |
    call    ext_atan                    # |        500 |        500 |
    fmul    $f1, $f7, $f10              # |        500 |        500 |
.count move_args
    mov     $f10, $f2                   # |        500 |        500 |
    call    ext_sin                     # |        500 |        500 |
.count move_ret
    mov     $f1, $f11                   # |        500 |        500 |
.count move_args
    mov     $f10, $f2                   # |        500 |        500 |
    call    ext_cos                     # |        500 |        500 |
    finv    $f1, $f1                    # |        500 |        500 |
    fmul    $f11, $f1, $f1              # |        500 |        500 |
    fmul    $f1, $f9, $f9               # |        500 |        500 |
    fmul    $f9, $f9, $f1               # |        500 |        500 |
    fadd    $f1, $fc9, $f1              # |        500 |        500 |
    fsqrt   $f1, $f10                   # |        500 |        500 |
    finv    $f10, $f2                   # |        500 |        500 |
    call    ext_atan                    # |        500 |        500 |
    fmul    $f1, $f8, $f11              # |        500 |        500 |
.count move_args
    mov     $f11, $f2                   # |        500 |        500 |
    call    ext_sin                     # |        500 |        500 |
.count move_ret
    mov     $f1, $f12                   # |        500 |        500 |
.count move_args
    mov     $f11, $f2                   # |        500 |        500 |
    call    ext_cos                     # |        500 |        500 |
    finv    $f1, $f1                    # |        500 |        500 |
    fmul    $f12, $f1, $f1              # |        500 |        500 |
    fmul    $f1, $f10, $f2              # |        500 |        500 |
    add     $i1, 1, $i1                 # |        500 |        500 |
.count move_args
    mov     $f9, $f1                    # |        500 |        500 |
    b       calc_dirvec.3020            # |        500 |        500 |
.end calc_dirvec

######################################################################
# calc_dirvecs($i5, $f8, $i6, $i7)
# $ra = $ra2
# [$i1 - $i6, $i8]
# [$f1 - $f7, $f9 - $f13]
# []
# []
# [$ra - $ra1]
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
    bl      $i5, 0, bl.22755            # |         11 |         11 |
bge.22755:
    li      0, $i1                      # |         11 |         11 |
.count move_args
    mov     $i5, $i2                    # |         11 |         11 |
    call    ext_float_of_int            # |         11 |         11 |
    fmul    $f1, $fc16, $f13            # |         11 |         11 |
    fsub    $f13, $fc11, $f7            # |         11 |         11 |
.count move_args
    mov     $f0, $f1                    # |         11 |         11 |
.count move_args
    mov     $f0, $f2                    # |         11 |         11 |
.count move_args
    mov     $i6, $i3                    # |         11 |         11 |
.count move_args
    mov     $i7, $i4                    # |         11 |         11 |
    jal     calc_dirvec.3020, $ra1      # |         11 |         11 |
    li      0, $i1                      # |         11 |         11 |
    add     $i7, 2, $i8                 # |         11 |         11 |
    fadd    $f13, $fc9, $f7             # |         11 |         11 |
.count move_args
    mov     $f0, $f1                    # |         11 |         11 |
.count move_args
    mov     $f0, $f2                    # |         11 |         11 |
.count move_args
    mov     $i6, $i3                    # |         11 |         11 |
.count move_args
    mov     $i8, $i4                    # |         11 |         11 |
    jal     calc_dirvec.3020, $ra1      # |         11 |         11 |
    add     $i5, -1, $i5                # |         11 |         11 |
    bl      $i5, 0, bl.22755            # |         11 |         11 |
bge.22756:
    li      0, $i1                      # |         10 |         10 |
    add     $i6, 1, $i2                 # |         10 |         10 |
    bl      $i2, 5, bl.22757            # |         10 |         10 |
bge.22757:
    add     $i6, -4, $i6                # |          2 |          2 |
.count move_args
    mov     $i5, $i2                    # |          2 |          2 |
    call    ext_float_of_int            # |          2 |          2 |
    fmul    $f1, $fc16, $f13            # |          2 |          2 |
    fsub    $f13, $fc11, $f7            # |          2 |          2 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
.count move_args
    mov     $i6, $i3                    # |          2 |          2 |
.count move_args
    mov     $i7, $i4                    # |          2 |          2 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |
    li      0, $i1                      # |          2 |          2 |
    fadd    $f13, $fc9, $f7             # |          2 |          2 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
.count move_args
    mov     $i6, $i3                    # |          2 |          2 |
.count move_args
    mov     $i8, $i4                    # |          2 |          2 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |
    add     $i5, -1, $i5                # |          2 |          2 |
    bge     $i5, 0, bge.22758           # |          2 |          2 |
.count dual_jmp
    b       bl.22755                    # |          1 |          1 |
bl.22757:
    mov     $i2, $i6                    # |          8 |          8 |
.count move_args
    mov     $i5, $i2                    # |          8 |          8 |
    call    ext_float_of_int            # |          8 |          8 |
    fmul    $f1, $fc16, $f13            # |          8 |          8 |
    fsub    $f13, $fc11, $f7            # |          8 |          8 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |
.count move_args
    mov     $i6, $i3                    # |          8 |          8 |
.count move_args
    mov     $i7, $i4                    # |          8 |          8 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |
    li      0, $i1                      # |          8 |          8 |
    fadd    $f13, $fc9, $f7             # |          8 |          8 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |
.count move_args
    mov     $i6, $i3                    # |          8 |          8 |
.count move_args
    mov     $i8, $i4                    # |          8 |          8 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |
    add     $i5, -1, $i5                # |          8 |          8 |
    bl      $i5, 0, bl.22755            # |          8 |          8 |
bge.22758:
    li      0, $i1                      # |          5 |          5 |
    add     $i6, 1, $i2                 # |          5 |          5 |
    bl      $i2, 5, bl.22759            # |          5 |          5 |
bge.22759:
    add     $i6, -4, $i6                # |          1 |          1 |
.count move_args
    mov     $i5, $i2                    # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    fmul    $f1, $fc16, $f13            # |          1 |          1 |
    fsub    $f13, $fc11, $f7            # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i7, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    fadd    $f13, $fc9, $f7             # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i8, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    add     $i5, -1, $i5                # |          1 |          1 |
    bge     $i5, 0, bge.22760           # |          1 |          1 |
.count dual_jmp
    b       bl.22755                    # |          1 |          1 |
bl.22759:
    mov     $i2, $i6                    # |          4 |          4 |
.count move_args
    mov     $i5, $i2                    # |          4 |          4 |
    call    ext_float_of_int            # |          4 |          4 |
    fmul    $f1, $fc16, $f13            # |          4 |          4 |
    fsub    $f13, $fc11, $f7            # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i7, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
    fadd    $f13, $fc9, $f7             # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i8, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    add     $i5, -1, $i5                # |          4 |          4 |
    bl      $i5, 0, bl.22755            # |          4 |          4 |
bge.22760:
    li      0, $i1                      # |          1 |          1 |
    add     $i6, 1, $i2                 # |          1 |          1 |
    bl      $i2, 5, bl.22761            # |          1 |          1 |
bge.22761:
    add     $i6, -4, $i6
.count move_args
    mov     $i5, $i2
    call    ext_float_of_int
    fmul    $f1, $fc16, $f13
    fsub    $f13, $fc11, $f7
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i6, $i3
.count move_args
    mov     $i7, $i4
    jal     calc_dirvec.3020, $ra1
    li      0, $i1
    fadd    $f13, $fc9, $f7
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i6, $i3
.count move_args
    mov     $i8, $i4
    jal     calc_dirvec.3020, $ra1
    add     $i5, -1, $i5
    add     $i6, 1, $i1
    bge     $i1, 5, bge.22762
.count dual_jmp
    b       bl.22762
bl.22761:
    mov     $i2, $i6                    # |          1 |          1 |
.count move_args
    mov     $i5, $i2                    # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    fmul    $f1, $fc16, $f13            # |          1 |          1 |
    fsub    $f13, $fc11, $f7            # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i7, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    fadd    $f13, $fc9, $f7             # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i8, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    add     $i5, -1, $i5                # |          1 |          1 |
    add     $i6, 1, $i1                 # |          1 |          1 |
    bl      $i1, 5, bl.22762            # |          1 |          1 |
bge.22762:
    add     $i6, -4, $i6
    b       calc_dirvecs.3028
bl.22762:
.count move_args
    mov     $i1, $i6                    # |          1 |          1 |
    b       calc_dirvecs.3028           # |          1 |          1 |
bl.22755:
    jr      $ra2                        # |         10 |         10 |
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i9, $i10, $i11)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f16]
# []
# []
# [$ra - $ra2]
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
    bl      $i9, 0, bl.22763            # |          5 |          5 |
bge.22763:
    li      0, $i1                      # |          5 |          5 |
.count load_float
    load    [f.22077], $f14             # |          5 |          5 |
.count move_args
    mov     $i9, $i2                    # |          5 |          5 |
    call    ext_float_of_int            # |          5 |          5 |
    fmul    $f1, $fc16, $f1             # |          5 |          5 |
    fsub    $f1, $fc11, $f8             # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f14, $f7                   # |          5 |          5 |
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
    mov     $fc11, $f7                  # |          5 |          5 |
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
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count load_float
    load    [f.22078], $f15             # |          5 |          5 |
.count move_args
    mov     $f15, $f7                   # |          5 |          5 |
    bl      $i2, 5, bl.22764            # |          5 |          5 |
bge.22764:
    add     $i10, -4, $i3               # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
.count load_float
    load    [f.22079], $f16             # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f16, $f7                   # |          1 |          1 |
.count move_args
    mov     $i5, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    add     $i3, 1, $i2                 # |          1 |          1 |
    bge     $i2, 5, bge.22765           # |          1 |          1 |
.count dual_jmp
    b       bl.22765                    # |          1 |          1 |
bl.22764:
    mov     $i2, $i3                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
.count load_float
    load    [f.22079], $f16             # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f16, $f7                   # |          4 |          4 |
.count move_args
    mov     $i5, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
    add     $i3, 1, $i2                 # |          4 |          4 |
    bl      $i2, 5, bl.22765            # |          4 |          4 |
bge.22765:
    add     $i3, -4, $i3                # |          1 |          1 |
.count load_float
    load    [f.22080], $f7              # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $i11, $i4                   # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc4, $f7                   # |          1 |          1 |
.count move_args
    mov     $i5, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      1, $i5                      # |          1 |          1 |
    add     $i3, 1, $i1                 # |          1 |          1 |
    bge     $i1, 5, bge.22766           # |          1 |          1 |
.count dual_jmp
    b       bl.22766                    # |          1 |          1 |
bl.22765:
    mov     $i2, $i3                    # |          4 |          4 |
.count load_float
    load    [f.22080], $f7              # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $i11, $i4                   # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $fc4, $f7                   # |          4 |          4 |
.count move_args
    mov     $i5, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      1, $i5                      # |          4 |          4 |
    add     $i3, 1, $i1                 # |          4 |          4 |
    bl      $i1, 5, bl.22766            # |          4 |          4 |
bge.22766:
    add     $i3, -4, $i6                # |          1 |          1 |
.count move_args
    mov     $i11, $i7                   # |          1 |          1 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |
    add     $i9, -1, $i9                # |          1 |          1 |
    bge     $i9, 0, bge.22767           # |          1 |          1 |
.count dual_jmp
    b       bl.22763
bl.22766:
    mov     $i1, $i6                    # |          4 |          4 |
.count move_args
    mov     $i11, $i7                   # |          4 |          4 |
    jal     calc_dirvecs.3028, $ra2     # |          4 |          4 |
    add     $i9, -1, $i9                # |          4 |          4 |
    bl      $i9, 0, bl.22763            # |          4 |          4 |
bge.22767:
    add     $i10, 2, $i1                # |          4 |          4 |
.count move_args
    mov     $i9, $i2                    # |          4 |          4 |
    add     $i11, 4, $i7                # |          4 |          4 |
    bl      $i1, 5, bl.22768            # |          4 |          4 |
bge.22768:
    add     $i10, -3, $i10              # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    fmul    $f1, $fc16, $f1             # |          1 |          1 |
    fsub    $f1, $fc11, $f8             # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f14, $f7                   # |          1 |          1 |
.count move_args
    mov     $i10, $i3                   # |          1 |          1 |
.count move_args
    mov     $i7, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    add     $i11, 6, $i5                # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc11, $f7                  # |          1 |          1 |
.count move_args
    mov     $i10, $i3                   # |          1 |          1 |
.count move_args
    mov     $i5, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    add     $i10, 1, $i2                # |          1 |          1 |
    bge     $i2, 5, bge.22769           # |          1 |          1 |
.count dual_jmp
    b       bl.22769                    # |          1 |          1 |
bl.22768:
    mov     $i1, $i10                   # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
    call    ext_float_of_int            # |          3 |          3 |
    fmul    $f1, $fc16, $f1             # |          3 |          3 |
    fsub    $f1, $fc11, $f8             # |          3 |          3 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |
.count move_args
    mov     $f14, $f7                   # |          3 |          3 |
.count move_args
    mov     $i10, $i3                   # |          3 |          3 |
.count move_args
    mov     $i7, $i4                    # |          3 |          3 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
    add     $i11, 6, $i5                # |          3 |          3 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |
.count move_args
    mov     $fc11, $f7                  # |          3 |          3 |
.count move_args
    mov     $i10, $i3                   # |          3 |          3 |
.count move_args
    mov     $i5, $i4                    # |          3 |          3 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
    add     $i10, 1, $i2                # |          3 |          3 |
    bl      $i2, 5, bl.22769            # |          3 |          3 |
bge.22769:
    add     $i10, -4, $i3               # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f15, $f7                   # |          1 |          1 |
.count move_args
    mov     $i7, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f16, $f7                   # |          1 |          1 |
.count move_args
    mov     $i5, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      2, $i5                      # |          1 |          1 |
    add     $i3, 1, $i1                 # |          1 |          1 |
    bge     $i1, 5, bge.22770           # |          1 |          1 |
.count dual_jmp
    b       bl.22770                    # |          1 |          1 |
bl.22769:
    mov     $i2, $i3                    # |          3 |          3 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |
.count move_args
    mov     $f15, $f7                   # |          3 |          3 |
.count move_args
    mov     $i7, $i4                    # |          3 |          3 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |
.count move_args
    mov     $f16, $f7                   # |          3 |          3 |
.count move_args
    mov     $i5, $i4                    # |          3 |          3 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |
    li      2, $i5                      # |          3 |          3 |
    add     $i3, 1, $i1                 # |          3 |          3 |
    bl      $i1, 5, bl.22770            # |          3 |          3 |
bge.22770:
    add     $i3, -4, $i6                # |          1 |          1 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |
    add     $i9, -1, $i9                # |          1 |          1 |
    add     $i10, 2, $i1                # |          1 |          1 |
    bge     $i1, 5, bge.22771           # |          1 |          1 |
.count dual_jmp
    b       bl.22771
bl.22770:
    mov     $i1, $i6                    # |          3 |          3 |
    jal     calc_dirvecs.3028, $ra2     # |          3 |          3 |
    add     $i9, -1, $i9                # |          3 |          3 |
    add     $i10, 2, $i1                # |          3 |          3 |
    bl      $i1, 5, bl.22771            # |          3 |          3 |
bge.22771:
    add     $i10, -3, $i10              # |          2 |          2 |
    add     $i11, 8, $i11               # |          2 |          2 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |
bl.22771:
    add     $i11, 8, $i11               # |          2 |          2 |
.count move_args
    mov     $i1, $i10                   # |          2 |          2 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |
bl.22763:
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
    mov     $i1, $i3                    # |        601 |        601 |
.count move_args
    mov     $ig0, $i2                   # |        601 |        601 |
    call    ext_create_array_int        # |        601 |        601 |
    mov     $hp, $i2                    # |        601 |        601 |
    add     $hp, 4, $hp                 # |        601 |        601 |
    load    [$i3 + 0], $i4              # |        601 |        601 |
    store   $i4, [$i2 + 0]              # |        601 |        601 |
    load    [$i3 + 1], $i4              # |        601 |        601 |
    store   $i4, [$i2 + 1]              # |        601 |        601 |
    load    [$i3 + 2], $i3              # |        601 |        601 |
    store   $i3, [$i2 + 2]              # |        601 |        601 |
    store   $i1, [$i2 + 3]              # |        601 |        601 |
    mov     $i2, $i1                    # |        601 |        601 |
    jr      $ra1                        # |        601 |        601 |
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
.begin create_dirvec_elements
create_dirvec_elements.3039:
    bl      $i6, 0, bl.22772            # |        600 |        600 |
bge.22772:
    jal     create_dirvec.3037, $ra1    # |        595 |        595 |
.count storer
    add     $i5, $i6, $tmp              # |        595 |        595 |
    store   $i1, [$tmp + 0]             # |        595 |        595 |
    add     $i6, -1, $i6                # |        595 |        595 |
    b       create_dirvec_elements.3039 # |        595 |        595 |
bl.22772:
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
    bl      $i7, 0, bl.22773            # |          6 |          6 |
bge.22773:
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
bl.22773:
    jr      $ra3                        # |          1 |          1 |
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
.begin init_dirvec_constants
init_dirvec_constants.3044:
    bl      $i9, 0, bl.22774            # |        605 |        605 |
bge.22774:
    load    [$i8 + $i9], $i4            # |        600 |        600 |
    jal     setup_dirvec_constants.2829, $ra2# |        600 |        600 |
    add     $i9, -1, $i9                # |        600 |        600 |
    b       init_dirvec_constants.3044  # |        600 |        600 |
bl.22774:
    jr      $ra3                        # |          5 |          5 |
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
.begin init_vecset_constants
init_vecset_constants.3047:
    bl      $i10, 0, bl.22775           # |          6 |          6 |
bge.22775:
    load    [ext_dirvecs + $i10], $i8   # |          5 |          5 |
    li      119, $i9                    # |          5 |          5 |
    jal     init_dirvec_constants.3044, $ra3# |          5 |          5 |
    add     $i10, -1, $i10              # |          5 |          5 |
    b       init_vecset_constants.3047  # |          5 |          5 |
bl.22775:
    jr      $ra4                        # |          1 |          1 |
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
.begin add_reflection
add_reflection.3051:
    jal     create_dirvec.3037, $ra1    # |          1 |          1 |
.count move_ret
    mov     $i1, $i4                    # |          1 |          1 |
    store   $f1, [$i4 + 0]              # |          1 |          1 |
    store   $f3, [$i4 + 1]              # |          1 |          1 |
    store   $f4, [$i4 + 2]              # |          1 |          1 |
    jal     setup_dirvec_constants.2829, $ra2# |          1 |          1 |
    mov     $hp, $i1                    # |          1 |          1 |
    add     $hp, 6, $hp                 # |          1 |          1 |
    store   $i9, [$i1 + 0]              # |          1 |          1 |
    load    [$i4 + 0], $i2              # |          1 |          1 |
    store   $i2, [$i1 + 1]              # |          1 |          1 |
    load    [$i4 + 1], $i2              # |          1 |          1 |
    store   $i2, [$i1 + 2]              # |          1 |          1 |
    load    [$i4 + 2], $i2              # |          1 |          1 |
    store   $i2, [$i1 + 3]              # |          1 |          1 |
    load    [$i4 + 3], $i2              # |          1 |          1 |
    store   $i2, [$i1 + 4]              # |          1 |          1 |
    store   $f9, [$i1 + 5]              # |          1 |          1 |
    store   $i1, [ext_reflections + $i8]# |          1 |          1 |
    jr      $ra3                        # |          1 |          1 |
.end add_reflection

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i34]
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
    load    [f.21978 + 0], $fc0         # |          1 |          1 |
    load    [f.22003 + 0], $fc1         # |          1 |          1 |
    load    [f.22002 + 0], $fc2         # |          1 |          1 |
    load    [f.21977 + 0], $fc3         # |          1 |          1 |
    load    [f.21979 + 0], $fc4         # |          1 |          1 |
    load    [f.22005 + 0], $fc5         # |          1 |          1 |
    load    [f.22004 + 0], $fc6         # |          1 |          1 |
    load    [f.21982 + 0], $fc7         # |          1 |          1 |
    load    [f.21992 + 0], $fc8         # |          1 |          1 |
    load    [f.21991 + 0], $fc9         # |          1 |          1 |
    load    [f.21976 + 0], $fc10        # |          1 |          1 |
    load    [f.22076 + 0], $fc11        # |          1 |          1 |
    load    [f.21998 + 0], $fc12        # |          1 |          1 |
    load    [f.21997 + 0], $fc13        # |          1 |          1 |
    load    [f.21986 + 0], $fc14        # |          1 |          1 |
    load    [f.21981 + 0], $fc15        # |          1 |          1 |
    load    [f.22075 + 0], $fc16        # |          1 |          1 |
    load    [f.21988 + 0], $fc17        # |          1 |          1 |
    load    [f.21987 + 0], $fc18        # |          1 |          1 |
    load    [f.21985 + 0], $fc19        # |          1 |          1 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |
.count move_ret
    mov     $i1, $i31                   # |          1 |          1 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |
.count move_ret
    mov     $i1, $i27                   # |          1 |          1 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |
.count move_ret
    mov     $i1, $i33                   # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 0]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 1]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 2]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
.count load_float
    load    [f.21933], $f7              # |          1 |          1 |
    fmul    $f1, $f7, $f8               # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f9                    # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f8                    # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    fmul    $f1, $f7, $f10              # |          1 |          1 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f11                   # |          1 |          1 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
    fmul    $f9, $f1, $f2               # |          1 |          1 |
.count load_float
    load    [f.22100], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $fg20             # |          1 |          1 |
.count load_float
    load    [f.22101], $f2              # |          1 |          1 |
    fmul    $f8, $f2, $fg21             # |          1 |          1 |
    fmul    $f9, $f11, $f2              # |          1 |          1 |
    fmul    $f2, $f3, $fg22             # |          1 |          1 |
    store   $f11, [ext_screenx_dir + 0] # |          1 |          1 |
    fneg    $f1, $f2                    # |          1 |          1 |
    store   $f2, [ext_screenx_dir + 2]  # |          1 |          1 |
    fneg    $f8, $f2                    # |          1 |          1 |
    fmul    $f2, $f1, $fg23             # |          1 |          1 |
    fneg    $f9, $fg24                  # |          1 |          1 |
    fmul    $f2, $f11, $f1              # |          1 |          1 |
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
    call    ext_read_int                # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    fmul    $f1, $f7, $f8               # |          1 |          1 |
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
    mov     $f1, $f8                    # |          1 |          1 |
    fmul    $f9, $f7, $f7               # |          1 |          1 |
.count move_args
    mov     $f7, $f2                    # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
    fmul    $f8, $f1, $fg14             # |          1 |          1 |
.count move_args
    mov     $f7, $f2                    # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
    fmul    $f8, $f1, $fg13             # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_beam + 0]         # |          1 |          1 |
    li      0, $i6                      # |          1 |          1 |
    jal     read_object.2721, $ra2      # |          1 |          1 |
    li      0, $i6                      # |          1 |          1 |
    jal     read_and_network.2729, $ra1 # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    call    read_or_network.2727        # |          1 |          1 |
.count move_ret
    mov     $i1, $ig1                   # |          1 |          1 |
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
    li      4, $i7                      # |          1 |          1 |
    jal     create_dirvecs.3042, $ra3   # |          1 |          1 |
    li      0, $i6                      # |          1 |          1 |
    li      0, $i7                      # |          1 |          1 |
    li      4, $i5                      # |          1 |          1 |
.count move_args
    mov     $fc11, $f8                  # |          1 |          1 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |
    li      8, $i9                      # |          1 |          1 |
    li      2, $i10                     # |          1 |          1 |
    li      4, $i11                     # |          1 |          1 |
    jal     calc_dirvec_rows.3033, $ra3 # |          1 |          1 |
    li      4, $i10                     # |          1 |          1 |
    jal     init_vecset_constants.3047, $ra4# |          1 |          1 |
    li      ext_light_dirvec, $i4       # |          1 |          1 |
    store   $fg14, [%{ext_light_dirvec + 0} + 0]# |          1 |          1 |
    store   $fg12, [%{ext_light_dirvec + 0} + 1]# |          1 |          1 |
    store   $fg13, [%{ext_light_dirvec + 0} + 2]# |          1 |          1 |
    jal     setup_dirvec_constants.2829, $ra2# |          1 |          1 |
    add     $ig0, -1, $i1               # |          1 |          1 |
    bl      $i1, 0, bl.22777            # |          1 |          1 |
bge.22777:
    load    [ext_objects + $i1], $i2    # |          1 |          1 |
    load    [$i2 + 2], $i3              # |          1 |          1 |
    bne     $i3, 2, bl.22777            # |          1 |          1 |
be.22778:
    load    [$i2 + 11], $f1             # |          1 |          1 |
    ble     $fc0, $f1, bl.22777         # |          1 |          1 |
bg.22779:
    load    [$i2 + 1], $i3              # |          1 |          1 |
    bne     $i3, 1, bne.22780           # |          1 |          1 |
be.22780:
    add     $i1, $i1, $i1
    add     $i1, $i1, $i10
    add     $i10, 1, $i9
    load    [$i2 + 11], $f1
    fsub    $fc0, $f1, $f9
    fneg    $fg12, $f10
    fneg    $fg13, $f11
.count move_args
    mov     $ig4, $i8
.count move_args
    mov     $fg14, $f1
.count move_args
    mov     $f10, $f3
.count move_args
    mov     $f11, $f4
    jal     add_reflection.3051, $ra3
    add     $ig4, 1, $i8
    add     $i10, 2, $i9
    fneg    $fg14, $f12
.count move_args
    mov     $f12, $f1
.count move_args
    mov     $fg12, $f3
.count move_args
    mov     $f11, $f4
    jal     add_reflection.3051, $ra3
    add     $ig4, 2, $i8
    add     $i10, 3, $i9
.count move_args
    mov     $f12, $f1
.count move_args
    mov     $f10, $f3
.count move_args
    mov     $fg13, $f4
    jal     add_reflection.3051, $ra3
    add     $ig4, 3, $ig4
    li      127, $i28
    li      0, $i29
.count load_float
    load    [f.22102], $f1
    fmul    $f1, $fg23, $f2
    fadd    $f2, $fg20, $f16
    fmul    $f1, $fg24, $f2
    fadd    $f2, $fg21, $f17
    load    [ext_screeny_dir + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f1, $fg22, $f18
    jal     pretrace_pixels.2983, $ra7
    li      0, $i30
    li      2, $i34
.count move_args
    mov     $i27, $i32
    jal     scan_line.3000, $ra9
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 1, $sp
    li      0, $i1
    ret     
bne.22780:
    bne     $i3, 2, bl.22777            # |          1 |          1 |
be.22781:
    load    [$i2 + 4], $f2              # |          1 |          1 |
    fmul    $fc10, $f2, $f3             # |          1 |          1 |
    fmul    $fg14, $f2, $f2             # |          1 |          1 |
    load    [$i2 + 5], $f4              # |          1 |          1 |
    fmul    $fg12, $f4, $f5             # |          1 |          1 |
    fadd    $f2, $f5, $f2               # |          1 |          1 |
    load    [$i2 + 6], $f5              # |          1 |          1 |
    fmul    $fg13, $f5, $f6             # |          1 |          1 |
    fadd    $f2, $f6, $f2               # |          1 |          1 |
    fmul    $f3, $f2, $f3               # |          1 |          1 |
    fsub    $f3, $fg14, $f6             # |          1 |          1 |
    fmul    $fc10, $f4, $f3             # |          1 |          1 |
    fmul    $f3, $f2, $f3               # |          1 |          1 |
    fsub    $f3, $fg12, $f3             # |          1 |          1 |
    fmul    $fc10, $f5, $f4             # |          1 |          1 |
    fmul    $f4, $f2, $f2               # |          1 |          1 |
    fsub    $f2, $fg13, $f4             # |          1 |          1 |
    fsub    $fc0, $f1, $f9              # |          1 |          1 |
    add     $i1, $i1, $i1               # |          1 |          1 |
    add     $i1, $i1, $i1               # |          1 |          1 |
    add     $i1, 1, $i9                 # |          1 |          1 |
.count move_args
    mov     $ig4, $i8                   # |          1 |          1 |
.count move_args
    mov     $f6, $f1                    # |          1 |          1 |
    jal     add_reflection.3051, $ra3   # |          1 |          1 |
    add     $ig4, 1, $ig4               # |          1 |          1 |
    li      127, $i28                   # |          1 |          1 |
    li      0, $i29                     # |          1 |          1 |
.count load_float
    load    [f.22102], $f1              # |          1 |          1 |
    fmul    $f1, $fg23, $f2             # |          1 |          1 |
    fadd    $f2, $fg20, $f16            # |          1 |          1 |
    fmul    $f1, $fg24, $f2             # |          1 |          1 |
    fadd    $f2, $fg21, $f17            # |          1 |          1 |
    load    [ext_screeny_dir + 2], $f2  # |          1 |          1 |
    fmul    $f1, $f2, $f1               # |          1 |          1 |
    fadd    $f1, $fg22, $f18            # |          1 |          1 |
    jal     pretrace_pixels.2983, $ra7  # |          1 |          1 |
    li      0, $i30                     # |          1 |          1 |
    li      2, $i34                     # |          1 |          1 |
.count move_args
    mov     $i27, $i32                  # |          1 |          1 |
    jal     scan_line.3000, $ra9        # |          1 |          1 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 1, $sp                 # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    ret                                 # |          1 |          1 |
bl.22777:
    li      127, $i28
    li      0, $i29
.count load_float
    load    [f.22102], $f1
    fmul    $f1, $fg23, $f2
    fadd    $f2, $fg20, $f16
    fmul    $f1, $fg24, $f2
    fadd    $f2, $fg21, $f17
    load    [ext_screeny_dir + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f1, $fg22, $f18
    jal     pretrace_pixels.2983, $ra7
    li      0, $i30
    li      2, $i34
.count move_args
    mov     $i27, $i32
    jal     scan_line.3000, $ra9
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 1, $sp
    li      0, $i1
    ret     
.end main
                                        # | Instructions | Clocks     |
