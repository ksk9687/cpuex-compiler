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
    call    min_caml_main               # |          1 |          1 |
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
# * floor
# それ以下の最大の数
# $f1 = floor($f2)
# [$f1, $f2, $f3]
######################################################################
.begin floor
min_caml_floor:
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
# * float_of_int
# 最も近いfloat
# $f1 = float_of_int($i2)
# [$i2, $i3, $i4, $f1, $f2, $f3]
######################################################################
.begin float_of_int
min_caml_float_of_int:
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
# * int_of_float
# 最も近いint
# $i1 = int_of_float($f2)
# [$i1, $i2, $i3, $f2, $f3]
######################################################################
.begin int_of_float
min_caml_int_of_float:
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
# * read
# 1byte同期読み込み
# $i1 = read()
# [$i1, $i2]
######################################################################
.begin read
min_caml_read:
    li 255, $i2
read_loop:
    read $i1
    bg $i1, $i2, min_caml_read
    ret

######################################################################
# * read_int
# 4byte同期読み込み
# $i1 = read_int()
# [$i1, $i2, $i3, $i4, $i5]
######################################################################
min_caml_read_int:
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
# * read_float
# 4byte同期読み込み
# $f1 = read_float()
# [$i1, $i2, $i3, $i4, $i5, $f1]
######################################################################
min_caml_read_float:
    mov $ra, $tmp                       # |        212 |        212 |
    call min_caml_read_int              # |        212 |        212 |
    mov $i1, $f1                        # |        212 |        212 |
    jr $tmp                             # |        212 |        212 |
.end read

######################################################################
# * write
# 1byte同期出力
# write($i2)
# [$i2]
######################################################################
.begin write
min_caml_write:
    write $i2, $tmp                     # |     49,167 |     49,167 |
    bg $tmp, 0, min_caml_write          # |     49,167 |     49,167 |
    ret                                 # |     49,167 |     49,167 |
.end write

######################################################################
# * create_array_int
# create_array_int(length, init)で長さlength、初期値initの配列を作成
# $i1 = create_array_int($i2, $i3)
# [$i1, $i2, $i3]
######################################################################
.begin create_array
min_caml_create_array_int:
    mov $i2, $i1                        # |     22,313 |     22,313 |
    add $i2, $hp, $i2                   # |     22,313 |     22,313 |
    mov $hp, $i1                        # |     22,313 |     22,313 |
create_array_loop:
    store $i3, [$hp]                    # |    103,030 |    103,030 |
    add $hp, 1, $hp                     # |    103,030 |    103,030 |
    bl $hp, $i2, create_array_loop      # |    103,030 |    103,030 |
    ret                                 # |     22,313 |     22,313 |

######################################################################
# * create_array_float
# create_array_float(length, init)で長さlength、初期値initの配列を作成
# $i1 = create_array_float($i2, $f2)
# [$i1, $i2, $i3, $f2]
######################################################################
min_caml_create_array_float:
    mov $f2, $i3                        # |     19,001 |     19,001 |
    jal min_caml_create_array_int $tmp  # |     19,001 |     19,001 |
.end create_array

######################################################################
# * 算術関数(atan, sin, cos)
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

f._186: .float  6.2831853072E+00
f._185: .float  3.1415926536E+00
f._184: .float  1.5707963268E+00
f._183: .float  6.0725293501E-01
f._182: .float  1.0000000000E+00
f._181: .float  5.0000000000E-01

######################################################################
# $f1 = atan($f2)
# [$i2, $f1, $f2, $f3, $f4, $f5]
######################################################################
.begin atan
min_caml_atan:
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
    load    [min_caml_atan_table + $i2], $f2# |     12,268 |     12,268 |
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
    load    [min_caml_atan_table + $i2], $f2# |     12,732 |     12,732 |
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
# [$i2, $f1, $f2, $f3, $f4, $f5, $f6, $f7]
######################################################################
.begin sin
min_caml_sin:
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
    b       min_caml_sin                # |      2,416 |      2,416 |
ble_else._195:
.count stack_move
    sub     $sp, 1, $sp                 # |      1,342 |      1,342 |
.count stack_store
    store   $ra, [$sp + 0]              # |      1,342 |      1,342 |
    fsub    $f1, $f2, $f2               # |      1,342 |      1,342 |
    call    min_caml_sin                # |      1,342 |      1,342 |
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
    call    min_caml_sin                # |        500 |        500 |
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
    load    [min_caml_atan_table + $i2], $f3# |     59,231 |     59,231 |
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
    load    [min_caml_atan_table + $i2], $f3# |     63,094 |     63,094 |
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
# [$i2, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8]
######################################################################
.begin cos
min_caml_cos:
.count load_float
    load    [f._184], $f8               # |      1,004 |      1,004 |
    fsub    $f8, $f2, $f2               # |      1,004 |      1,004 |
    b       min_caml_sin                # |      1,004 |      1,004 |
.end cos

######################################################################
#
#       ↑　ここまで lib_asm.s
#
######################################################################
min_caml_n_objects:
    .skip   1
min_caml_objects:
    .skip   60
min_caml_screen:
    .skip   3
min_caml_viewpoint:
    .skip   3
min_caml_light:
    .skip   3
min_caml_beam:
    .skip   1
min_caml_and_net:
    .skip   50
min_caml_or_net:
    .skip   1
min_caml_solver_dist:
    .skip   1
min_caml_intsec_rectside:
    .skip   1
min_caml_tmin:
    .skip   1
min_caml_intersection_point:
    .skip   3
min_caml_intersected_object_id:
    .skip   1
min_caml_nvector:
    .skip   3
min_caml_texture_color:
    .skip   3
min_caml_diffuse_ray:
    .skip   3
min_caml_rgb:
    .skip   3
min_caml_image_size:
    .skip   2
min_caml_image_center:
    .skip   2
min_caml_scan_pitch:
    .skip   1
min_caml_startp:
    .skip   3
min_caml_startp_fast:
    .skip   3
min_caml_screenx_dir:
    .skip   3
min_caml_screeny_dir:
    .skip   3
min_caml_screenz_dir:
    .skip   3
min_caml_ptrace_dirvec:
    .skip   3
min_caml_dirvecs:
    .skip   5
min_caml_light_dirvec:
    .int    light_dirvec_v3
    .int    light_dirvec_consts
light_dirvec_v3:
    .skip   3
light_dirvec_consts:
    .skip   60
min_caml_reflections:
    .skip   180
min_caml_n_reflections:
    .skip   1
.define $ig0 $i51
.define $i51 orz
.define $ig1 $i52
.define $i52 orz
.define $ig2 $i53
.define $i53 orz
.define $ig3 $i54
.define $i54 orz
.define $ig4 $i55
.define $i55 orz
.define $ig5 $i56
.define $i56 orz
.define $ig6 $i57
.define $i57 orz
.define $ig7 $i58
.define $i58 orz
.define $ig8 $i59
.define $i59 orz
.define $fc0 $f19
.define $f19 orz
.define $fc1 $f20
.define $f20 orz
.define $fc2 $f21
.define $f21 orz
.define $fc3 $f22
.define $f22 orz
.define $fc4 $f23
.define $f23 orz
.define $fc5 $f24
.define $f24 orz
.define $fc6 $f25
.define $f25 orz
.define $fc7 $f26
.define $f26 orz
.define $fc8 $f27
.define $f27 orz
.define $fc9 $f28
.define $f28 orz
.define $fc10 $f29
.define $f29 orz
.define $fc11 $f30
.define $f30 orz
.define $fc12 $f31
.define $f31 orz
.define $fc13 $f32
.define $f32 orz
.define $fc14 $f33
.define $f33 orz
.define $fc15 $f34
.define $f34 orz
.define $fc16 $f35
.define $f35 orz
.define $fc17 $f36
.define $f36 orz
.define $fc18 $f37
.define $f37 orz
.define $fc19 $f38
.define $f38 orz
.define $fg0 $f39
.define $f39 orz
.define $fg1 $f40
.define $f40 orz
.define $fg2 $f41
.define $f41 orz
.define $fg3 $f42
.define $f42 orz
.define $fg4 $f43
.define $f43 orz
.define $fg5 $f44
.define $f44 orz
.define $fg6 $f45
.define $f45 orz
.define $fg7 $f46
.define $f46 orz
.define $fg8 $f47
.define $f47 orz
.define $fg9 $f48
.define $f48 orz
.define $fg10 $f49
.define $f49 orz
.define $fg11 $f50
.define $f50 orz
.define $fg12 $f51
.define $f51 orz
.define $fg13 $f52
.define $f52 orz
.define $fg14 $f53
.define $f53 orz
.define $fg15 $f54
.define $f54 orz
.define $fg16 $f55
.define $f55 orz
.define $fg17 $f56
.define $f56 orz
.define $fg18 $f57
.define $f57 orz
.define $fg19 $f58
.define $f58 orz
.define $fg20 $f59
.define $f59 orz
.define $fg21 $f60
.define $f60 orz
.define $fg22 $f61
.define $f61 orz
.define $fg23 $f62
.define $f62 orz
.define $fg24 $f63
.define $f63 orz
f.32096:    .float  -2.0000000000E+02
f.32095:    .float  2.0000000000E+02
f.32067:    .float  1.2800000000E+02
f.32005:    .float  9.0000000000E-01
f.32004:    .float  2.0000000000E-01
f.31976:    .float  1.5000000000E+02
f.31975:    .float  -1.5000000000E+02
f.31974:    .float  6.6666666667E-03
f.31973:    .float  -6.6666666667E-03
f.31972:    .float  -2.0000000000E+00
f.31971:    .float  3.9062500000E-03
f.31970:    .float  2.5600000000E+02
f.31969:    .float  1.0000000000E+08
f.31968:    .float  1.0000000000E+09
f.31967:    .float  1.0000000000E+01
f.31966:    .float  2.0000000000E+01
f.31965:    .float  5.0000000000E-02
f.31964:    .float  2.5000000000E-01
f.31963:    .float  1.0000000000E-01
f.31962:    .float  3.3333333333E+00
f.31961:    .float  2.5500000000E+02
f.31960:    .float  1.5000000000E-01
f.31959:    .float  3.1830988148E-01
f.31958:    .float  3.1415927000E+00
f.31957:    .float  3.0000000000E+01
f.31956:    .float  1.5000000000E+01
f.31955:    .float  1.0000000000E-04
f.31954:    .float  -1.0000000000E-01
f.31953:    .float  1.0000000000E-02
f.31952:    .float  -2.0000000000E-01
f.31951:    .float  5.0000000000E-01
f.31950:    .float  1.0000000000E+00
f.31949:    .float  -1.0000000000E+00
f.31948:    .float  2.0000000000E+00
f.31935:    .float  1.7453293000E-02

######################################################################
# read_nth_object
######################################################################
.begin read_nth_object
read_nth_object.2719:
.count stack_move
    sub     $sp, 3, $sp                 # |         18 |         18 |
.count stack_store
    store   $ra, [$sp + 0]              # |         18 |         18 |
.count stack_store
    store   $i2, [$sp + 1]              # |         18 |         18 |
    call    min_caml_read_int           # |         18 |         18 |
.count move_ret
    mov     $i1, $i10                   # |         18 |         18 |
    bne     $i10, -1, be_else.35554     # |         18 |         18 |
be_then.35554:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 3, $sp                 # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    ret                                 # |          1 |          1 |
be_else.35554:
    call    min_caml_read_int           # |         17 |         17 |
.count move_ret
    mov     $i1, $i11                   # |         17 |         17 |
    call    min_caml_read_int           # |         17 |         17 |
.count move_ret
    mov     $i1, $i12                   # |         17 |         17 |
    call    min_caml_read_int           # |         17 |         17 |
.count move_ret
    mov     $i1, $i13                   # |         17 |         17 |
    li      3, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    min_caml_create_array_float # |         17 |         17 |
.count move_ret
    mov     $i1, $i14                   # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count move_ret
    mov     $f1, $f10                   # |         17 |         17 |
    store   $f10, [$i14 + 0]            # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count move_ret
    mov     $f1, $f10                   # |         17 |         17 |
    store   $f10, [$i14 + 1]            # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
    store   $f1, [$i14 + 2]             # |         17 |         17 |
    li      3, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    min_caml_create_array_float # |         17 |         17 |
.count move_ret
    mov     $i1, $i15                   # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count move_ret
    mov     $f1, $f10                   # |         17 |         17 |
    store   $f10, [$i15 + 0]            # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count move_ret
    mov     $f1, $f10                   # |         17 |         17 |
    store   $f10, [$i15 + 1]            # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count move_ret
    mov     $f1, $f10                   # |         17 |         17 |
    store   $f10, [$i15 + 2]            # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count stack_store
    store   $f1, [$sp + 2]              # |         17 |         17 |
    li      2, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    min_caml_create_array_float # |         17 |         17 |
.count move_ret
    mov     $i1, $i16                   # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count move_ret
    mov     $f1, $f10                   # |         17 |         17 |
    store   $f10, [$i16 + 0]            # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
    store   $f1, [$i16 + 1]             # |         17 |         17 |
    li      3, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    min_caml_create_array_float # |         17 |         17 |
.count move_ret
    mov     $i1, $i17                   # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count move_ret
    mov     $f1, $f10                   # |         17 |         17 |
    store   $f10, [$i17 + 0]            # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
.count move_ret
    mov     $f1, $f10                   # |         17 |         17 |
    store   $f10, [$i17 + 1]            # |         17 |         17 |
    call    min_caml_read_float         # |         17 |         17 |
    store   $f1, [$i17 + 2]             # |         17 |         17 |
    li      3, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    min_caml_create_array_float # |         17 |         17 |
.count move_ret
    mov     $i1, $i18                   # |         17 |         17 |
    be      $i13, 0, bne_cont.35555     # |         17 |         17 |
bne_then.35555:
    call    min_caml_read_float
.count move_ret
    mov     $f1, $f10
.count load_float
    load    [f.31935], $f11
    fmul    $f10, $f11, $f10
    store   $f10, [$i18 + 0]
    call    min_caml_read_float
.count move_ret
    mov     $f1, $f10
    fmul    $f10, $f11, $f10
    store   $f10, [$i18 + 1]
    call    min_caml_read_float
    fmul    $f1, $f11, $f1
    store   $f1, [$i18 + 2]
bne_cont.35555:
    li      4, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    min_caml_create_array_float # |         17 |         17 |
.count stack_load
    load    [$sp + 2], $f10             # |         17 |         17 |
    bg      $f0, $f10, ble_else.35556   # |         17 |         17 |
ble_then.35556:
    li      0, $i19                     # |         15 |         15 |
.count b_cont
    b       ble_cont.35556              # |         15 |         15 |
ble_else.35556:
    li      1, $i19                     # |          2 |          2 |
ble_cont.35556:
    bne     $i11, 2, be_else.35557      # |         17 |         17 |
be_then.35557:
    li      1, $i20                     # |          2 |          2 |
.count b_cont
    b       be_cont.35557               # |          2 |          2 |
be_else.35557:
    mov     $i19, $i20                  # |         15 |         15 |
be_cont.35557:
    mov     $hp, $i21                   # |         17 |         17 |
    add     $hp, 11, $hp                # |         17 |         17 |
    store   $i1, [$i21 + 10]            # |         17 |         17 |
    store   $i18, [$i21 + 9]            # |         17 |         17 |
    store   $i17, [$i21 + 8]            # |         17 |         17 |
    store   $i16, [$i21 + 7]            # |         17 |         17 |
    store   $i20, [$i21 + 6]            # |         17 |         17 |
    store   $i15, [$i21 + 5]            # |         17 |         17 |
    store   $i14, [$i21 + 4]            # |         17 |         17 |
    store   $i13, [$i21 + 3]            # |         17 |         17 |
    store   $i12, [$i21 + 2]            # |         17 |         17 |
    store   $i11, [$i21 + 1]            # |         17 |         17 |
    store   $i10, [$i21 + 0]            # |         17 |         17 |
.count stack_load
    load    [$sp + 1], $i1              # |         17 |         17 |
    store   $i21, [min_caml_objects + $i1]# |         17 |         17 |
    bne     $i11, 3, be_else.35558      # |         17 |         17 |
be_then.35558:
    load    [$i14 + 0], $f10            # |          9 |          9 |
    bne     $f10, $f0, be_else.35559    # |          9 |          9 |
be_then.35559:
    mov     $f0, $f10                   # |          2 |          2 |
.count b_cont
    b       be_cont.35559               # |          2 |          2 |
be_else.35559:
    bne     $f10, $f0, be_else.35560    # |          7 |          7 |
be_then.35560:
    fmul    $f10, $f10, $f10
    finv    $f10, $f10
    mov     $f0, $f10
.count b_cont
    b       be_cont.35560
be_else.35560:
    bg      $f10, $f0, ble_else.35561   # |          7 |          7 |
ble_then.35561:
    fmul    $f10, $f10, $f10
    finv_n  $f10, $f10
.count b_cont
    b       ble_cont.35561
ble_else.35561:
    fmul    $f10, $f10, $f10            # |          7 |          7 |
    finv    $f10, $f10                  # |          7 |          7 |
ble_cont.35561:
be_cont.35560:
be_cont.35559:
    store   $f10, [$i14 + 0]            # |          9 |          9 |
    load    [$i14 + 1], $f10            # |          9 |          9 |
    bne     $f10, $f0, be_else.35562    # |          9 |          9 |
be_then.35562:
    mov     $f0, $f10
.count b_cont
    b       be_cont.35562
be_else.35562:
    bne     $f10, $f0, be_else.35563    # |          9 |          9 |
be_then.35563:
    fmul    $f10, $f10, $f10
    finv    $f10, $f10
    mov     $f0, $f10
.count b_cont
    b       be_cont.35563
be_else.35563:
    bg      $f10, $f0, ble_else.35564   # |          9 |          9 |
ble_then.35564:
    fmul    $f10, $f10, $f10
    finv_n  $f10, $f10
.count b_cont
    b       ble_cont.35564
ble_else.35564:
    fmul    $f10, $f10, $f10            # |          9 |          9 |
    finv    $f10, $f10                  # |          9 |          9 |
ble_cont.35564:
be_cont.35563:
be_cont.35562:
    store   $f10, [$i14 + 1]            # |          9 |          9 |
    load    [$i14 + 2], $f10            # |          9 |          9 |
    bne     $f10, $f0, be_else.35565    # |          9 |          9 |
be_then.35565:
    mov     $f0, $f10
.count b_cont
    b       be_cont.35565
be_else.35565:
    bne     $f10, $f0, be_else.35566    # |          9 |          9 |
be_then.35566:
    fmul    $f10, $f10, $f10
    finv    $f10, $f10
    mov     $f0, $f10
.count b_cont
    b       be_cont.35566
be_else.35566:
    bg      $f10, $f0, ble_else.35567   # |          9 |          9 |
ble_then.35567:
    fmul    $f10, $f10, $f10
    finv_n  $f10, $f10
.count b_cont
    b       ble_cont.35567
ble_else.35567:
    fmul    $f10, $f10, $f10            # |          9 |          9 |
    finv    $f10, $f10                  # |          9 |          9 |
ble_cont.35567:
be_cont.35566:
be_cont.35565:
    store   $f10, [$i14 + 2]            # |          9 |          9 |
    bne     $i13, 0, be_else.35568      # |          9 |          9 |
be_then.35568:
.count stack_load
    load    [$sp + 0], $ra              # |          9 |          9 |
.count stack_move
    add     $sp, 3, $sp                 # |          9 |          9 |
    li      1, $i1                      # |          9 |          9 |
    ret                                 # |          9 |          9 |
be_else.35568:
    load    [$i18 + 0], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f10
    load    [$i18 + 0], $f2
    call    min_caml_sin
.count move_ret
    mov     $f1, $f11
    load    [$i18 + 1], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f12
    load    [$i18 + 1], $f2
    call    min_caml_sin
.count move_ret
    mov     $f1, $f13
    load    [$i18 + 2], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f14
    load    [$i18 + 2], $f2
    call    min_caml_sin
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    fmul    $f12, $f14, $f2
    fmul    $f2, $f2, $f3
    load    [$i14 + 0], $f4
    fmul    $f4, $f3, $f3
    fmul    $f12, $f1, $f5
    fmul    $f5, $f5, $f6
    load    [$i14 + 1], $f7
    fmul    $f7, $f6, $f6
    fadd    $f3, $f6, $f3
    fneg    $f13, $f6
    fmul    $f6, $f6, $f8
    load    [$i14 + 2], $f9
    fmul    $f9, $f8, $f8
    fadd    $f3, $f8, $f3
    store   $f3, [$i14 + 0]
    fmul    $f11, $f13, $f3
    fmul    $f3, $f14, $f8
    fmul    $f10, $f1, $f15
    fsub    $f8, $f15, $f8
    fmul    $f8, $f8, $f15
    fmul    $f4, $f15, $f15
    fmul    $f3, $f1, $f3
    fmul    $f10, $f14, $f16
    fadd    $f3, $f16, $f3
    fmul    $f3, $f3, $f16
    fmul    $f7, $f16, $f16
    fadd    $f15, $f16, $f15
    fmul    $f11, $f12, $f16
    fmul    $f16, $f16, $f17
    fmul    $f9, $f17, $f17
    fadd    $f15, $f17, $f15
    store   $f15, [$i14 + 1]
    fmul    $f10, $f13, $f13
    fmul    $f13, $f14, $f15
    fmul    $f11, $f1, $f17
    fadd    $f15, $f17, $f15
    fmul    $f15, $f15, $f17
    fmul    $f4, $f17, $f17
    fmul    $f13, $f1, $f1
    fmul    $f11, $f14, $f11
    fsub    $f1, $f11, $f1
    fmul    $f1, $f1, $f11
    fmul    $f7, $f11, $f11
    fadd    $f17, $f11, $f11
    fmul    $f10, $f12, $f10
    fmul    $f10, $f10, $f12
    fmul    $f9, $f12, $f12
    fadd    $f11, $f12, $f11
    store   $f11, [$i14 + 2]
    fmul    $f4, $f8, $f11
    fmul    $f11, $f15, $f11
    fmul    $f7, $f3, $f12
    fmul    $f12, $f1, $f12
    fadd    $f11, $f12, $f11
    fmul    $f9, $f16, $f12
    fmul    $f12, $f10, $f12
    fadd    $f11, $f12, $f11
    fmul    $fc10, $f11, $f11
    store   $f11, [$i18 + 0]
    fmul    $f4, $f2, $f2
    fmul    $f2, $f15, $f4
    fmul    $f7, $f5, $f5
    fmul    $f5, $f1, $f1
    fadd    $f4, $f1, $f1
    fmul    $f9, $f6, $f4
    fmul    $f4, $f10, $f6
    fadd    $f1, $f6, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i18 + 1]
    fmul    $f2, $f8, $f1
    fmul    $f5, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f4, $f16, $f2
    fadd    $f1, $f2, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i18 + 2]
    li      1, $i1
    ret
be_else.35558:
    bne     $i11, 2, be_else.35569      # |          8 |          8 |
be_then.35569:
    load    [$i14 + 0], $f10            # |          2 |          2 |
    bne     $i19, 0, be_else.35570      # |          2 |          2 |
be_then.35570:
    li      1, $i1                      # |          2 |          2 |
.count b_cont
    b       be_cont.35570               # |          2 |          2 |
be_else.35570:
    li      0, $i1
be_cont.35570:
    fmul    $f10, $f10, $f11            # |          2 |          2 |
    load    [$i14 + 1], $f12            # |          2 |          2 |
    fmul    $f12, $f12, $f12            # |          2 |          2 |
    fadd    $f11, $f12, $f11            # |          2 |          2 |
    load    [$i14 + 2], $f12            # |          2 |          2 |
    fmul    $f12, $f12, $f12            # |          2 |          2 |
    fadd    $f11, $f12, $f11            # |          2 |          2 |
    fsqrt   $f11, $f11                  # |          2 |          2 |
    bne     $f11, $f0, be_else.35571    # |          2 |          2 |
be_then.35571:
    mov     $fc0, $f11
.count b_cont
    b       be_cont.35571
be_else.35571:
    bne     $i1, 0, be_else.35572       # |          2 |          2 |
be_then.35572:
    finv    $f11, $f11
.count b_cont
    b       be_cont.35572
be_else.35572:
    finv_n  $f11, $f11                  # |          2 |          2 |
be_cont.35572:
be_cont.35571:
    fmul    $f10, $f11, $f10            # |          2 |          2 |
    store   $f10, [$i14 + 0]            # |          2 |          2 |
    load    [$i14 + 1], $f10            # |          2 |          2 |
    fmul    $f10, $f11, $f10            # |          2 |          2 |
    store   $f10, [$i14 + 1]            # |          2 |          2 |
    load    [$i14 + 2], $f10            # |          2 |          2 |
    fmul    $f10, $f11, $f10            # |          2 |          2 |
    store   $f10, [$i14 + 2]            # |          2 |          2 |
    bne     $i13, 0, be_else.35573      # |          2 |          2 |
be_then.35573:
.count stack_load
    load    [$sp + 0], $ra              # |          2 |          2 |
.count stack_move
    add     $sp, 3, $sp                 # |          2 |          2 |
    li      1, $i1                      # |          2 |          2 |
    ret                                 # |          2 |          2 |
be_else.35573:
    load    [$i18 + 0], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f10
    load    [$i18 + 0], $f2
    call    min_caml_sin
.count move_ret
    mov     $f1, $f11
    load    [$i18 + 1], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f12
    load    [$i18 + 1], $f2
    call    min_caml_sin
.count move_ret
    mov     $f1, $f13
    load    [$i18 + 2], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f14
    load    [$i18 + 2], $f2
    call    min_caml_sin
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    fmul    $f12, $f14, $f2
    fmul    $f2, $f2, $f3
    load    [$i14 + 0], $f4
    fmul    $f4, $f3, $f3
    fmul    $f12, $f1, $f5
    fmul    $f5, $f5, $f6
    load    [$i14 + 1], $f7
    fmul    $f7, $f6, $f6
    fadd    $f3, $f6, $f3
    fneg    $f13, $f6
    fmul    $f6, $f6, $f8
    load    [$i14 + 2], $f9
    fmul    $f9, $f8, $f8
    fadd    $f3, $f8, $f3
    store   $f3, [$i14 + 0]
    fmul    $f11, $f13, $f3
    fmul    $f3, $f14, $f8
    fmul    $f10, $f1, $f15
    fsub    $f8, $f15, $f8
    fmul    $f8, $f8, $f15
    fmul    $f4, $f15, $f15
    fmul    $f3, $f1, $f3
    fmul    $f10, $f14, $f16
    fadd    $f3, $f16, $f3
    fmul    $f3, $f3, $f16
    fmul    $f7, $f16, $f16
    fadd    $f15, $f16, $f15
    fmul    $f11, $f12, $f16
    fmul    $f16, $f16, $f17
    fmul    $f9, $f17, $f17
    fadd    $f15, $f17, $f15
    store   $f15, [$i14 + 1]
    fmul    $f10, $f13, $f13
    fmul    $f13, $f14, $f15
    fmul    $f11, $f1, $f17
    fadd    $f15, $f17, $f15
    fmul    $f15, $f15, $f17
    fmul    $f4, $f17, $f17
    fmul    $f13, $f1, $f1
    fmul    $f11, $f14, $f11
    fsub    $f1, $f11, $f1
    fmul    $f1, $f1, $f11
    fmul    $f7, $f11, $f11
    fadd    $f17, $f11, $f11
    fmul    $f10, $f12, $f10
    fmul    $f10, $f10, $f12
    fmul    $f9, $f12, $f12
    fadd    $f11, $f12, $f11
    store   $f11, [$i14 + 2]
    fmul    $f4, $f8, $f11
    fmul    $f11, $f15, $f11
    fmul    $f7, $f3, $f12
    fmul    $f12, $f1, $f12
    fadd    $f11, $f12, $f11
    fmul    $f9, $f16, $f12
    fmul    $f12, $f10, $f12
    fadd    $f11, $f12, $f11
    fmul    $fc10, $f11, $f11
    store   $f11, [$i18 + 0]
    fmul    $f4, $f2, $f2
    fmul    $f2, $f15, $f4
    fmul    $f7, $f5, $f5
    fmul    $f5, $f1, $f1
    fadd    $f4, $f1, $f1
    fmul    $f9, $f6, $f4
    fmul    $f4, $f10, $f6
    fadd    $f1, $f6, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i18 + 1]
    fmul    $f2, $f8, $f1
    fmul    $f5, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f4, $f16, $f2
    fadd    $f1, $f2, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i18 + 2]
    li      1, $i1
    ret
be_else.35569:
    bne     $i13, 0, be_else.35574      # |          6 |          6 |
be_then.35574:
.count stack_load
    load    [$sp + 0], $ra              # |          6 |          6 |
.count stack_move
    add     $sp, 3, $sp                 # |          6 |          6 |
    li      1, $i1                      # |          6 |          6 |
    ret                                 # |          6 |          6 |
be_else.35574:
    load    [$i18 + 0], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f10
    load    [$i18 + 0], $f2
    call    min_caml_sin
.count move_ret
    mov     $f1, $f11
    load    [$i18 + 1], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f12
    load    [$i18 + 1], $f2
    call    min_caml_sin
.count move_ret
    mov     $f1, $f13
    load    [$i18 + 2], $f2
    call    min_caml_cos
.count move_ret
    mov     $f1, $f14
    load    [$i18 + 2], $f2
    call    min_caml_sin
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    fmul    $f12, $f14, $f2
    fmul    $f2, $f2, $f3
    load    [$i14 + 0], $f4
    fmul    $f4, $f3, $f3
    fmul    $f12, $f1, $f5
    fmul    $f5, $f5, $f6
    load    [$i14 + 1], $f7
    fmul    $f7, $f6, $f6
    fadd    $f3, $f6, $f3
    fneg    $f13, $f6
    fmul    $f6, $f6, $f8
    load    [$i14 + 2], $f9
    fmul    $f9, $f8, $f8
    fadd    $f3, $f8, $f3
    store   $f3, [$i14 + 0]
    fmul    $f11, $f13, $f3
    fmul    $f3, $f14, $f8
    fmul    $f10, $f1, $f15
    fsub    $f8, $f15, $f8
    fmul    $f8, $f8, $f15
    fmul    $f4, $f15, $f15
    fmul    $f3, $f1, $f3
    fmul    $f10, $f14, $f16
    fadd    $f3, $f16, $f3
    fmul    $f3, $f3, $f16
    fmul    $f7, $f16, $f16
    fadd    $f15, $f16, $f15
    fmul    $f11, $f12, $f16
    fmul    $f16, $f16, $f17
    fmul    $f9, $f17, $f17
    fadd    $f15, $f17, $f15
    store   $f15, [$i14 + 1]
    fmul    $f10, $f13, $f13
    fmul    $f13, $f14, $f15
    fmul    $f11, $f1, $f17
    fadd    $f15, $f17, $f15
    fmul    $f15, $f15, $f17
    fmul    $f4, $f17, $f17
    fmul    $f13, $f1, $f1
    fmul    $f11, $f14, $f11
    fsub    $f1, $f11, $f1
    fmul    $f1, $f1, $f11
    fmul    $f7, $f11, $f11
    fadd    $f17, $f11, $f11
    fmul    $f10, $f12, $f10
    fmul    $f10, $f10, $f12
    fmul    $f9, $f12, $f12
    fadd    $f11, $f12, $f11
    store   $f11, [$i14 + 2]
    fmul    $f4, $f8, $f11
    fmul    $f11, $f15, $f11
    fmul    $f7, $f3, $f12
    fmul    $f12, $f1, $f12
    fadd    $f11, $f12, $f11
    fmul    $f9, $f16, $f12
    fmul    $f12, $f10, $f12
    fadd    $f11, $f12, $f11
    fmul    $fc10, $f11, $f11
    store   $f11, [$i18 + 0]
    fmul    $f4, $f2, $f2
    fmul    $f2, $f15, $f4
    fmul    $f7, $f5, $f5
    fmul    $f5, $f1, $f1
    fadd    $f4, $f1, $f1
    fmul    $f9, $f6, $f4
    fmul    $f4, $f10, $f6
    fadd    $f1, $f6, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i18 + 1]
    fmul    $f2, $f8, $f1
    fmul    $f5, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f4, $f16, $f2
    fadd    $f1, $f2, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i18 + 2]
    li      1, $i1
    ret
.end read_nth_object

######################################################################
# read_object
######################################################################
.begin read_object
read_object.2721:
    bl      $i2, 60, bge_else.35575     # |          2 |          2 |
bge_then.35575:
    ret
bge_else.35575:
.count stack_move
    sub     $sp, 9, $sp                 # |          2 |          2 |
.count stack_store
    store   $ra, [$sp + 0]              # |          2 |          2 |
.count stack_store
    store   $i2, [$sp + 1]              # |          2 |          2 |
    call    read_nth_object.2719        # |          2 |          2 |
.count move_ret
    mov     $i1, $i22                   # |          2 |          2 |
    bne     $i22, 0, be_else.35576      # |          2 |          2 |
be_then.35576:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
.count stack_load
    load    [$sp - 8], $i1
    mov     $i1, $ig0
    ret
be_else.35576:
.count stack_load
    load    [$sp + 1], $i22             # |          2 |          2 |
    add     $i22, 1, $i2                # |          2 |          2 |
    bl      $i2, 60, bge_else.35577     # |          2 |          2 |
bge_then.35577:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
    ret
bge_else.35577:
.count stack_store
    store   $i2, [$sp + 2]              # |          2 |          2 |
    call    read_nth_object.2719        # |          2 |          2 |
.count move_ret
    mov     $i1, $i22                   # |          2 |          2 |
    bne     $i22, 0, be_else.35578      # |          2 |          2 |
be_then.35578:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
.count stack_load
    load    [$sp - 7], $i1
    mov     $i1, $ig0
    ret
be_else.35578:
.count stack_load
    load    [$sp + 2], $i22             # |          2 |          2 |
    add     $i22, 1, $i2                # |          2 |          2 |
    bl      $i2, 60, bge_else.35579     # |          2 |          2 |
bge_then.35579:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
    ret
bge_else.35579:
.count stack_store
    store   $i2, [$sp + 3]              # |          2 |          2 |
    call    read_nth_object.2719        # |          2 |          2 |
.count move_ret
    mov     $i1, $i22                   # |          2 |          2 |
    bne     $i22, 0, be_else.35580      # |          2 |          2 |
be_then.35580:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
.count stack_load
    load    [$sp - 6], $i1
    mov     $i1, $ig0
    ret
be_else.35580:
.count stack_load
    load    [$sp + 3], $i22             # |          2 |          2 |
    add     $i22, 1, $i2                # |          2 |          2 |
    bl      $i2, 60, bge_else.35581     # |          2 |          2 |
bge_then.35581:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
    ret
bge_else.35581:
.count stack_store
    store   $i2, [$sp + 4]              # |          2 |          2 |
    call    read_nth_object.2719        # |          2 |          2 |
.count move_ret
    mov     $i1, $i22                   # |          2 |          2 |
    bne     $i22, 0, be_else.35582      # |          2 |          2 |
be_then.35582:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
.count stack_load
    load    [$sp - 5], $i1
    mov     $i1, $ig0
    ret
be_else.35582:
.count stack_load
    load    [$sp + 4], $i22             # |          2 |          2 |
    add     $i22, 1, $i2                # |          2 |          2 |
    bl      $i2, 60, bge_else.35583     # |          2 |          2 |
bge_then.35583:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
    ret
bge_else.35583:
.count stack_store
    store   $i2, [$sp + 5]              # |          2 |          2 |
    call    read_nth_object.2719        # |          2 |          2 |
.count move_ret
    mov     $i1, $i22                   # |          2 |          2 |
    bne     $i22, 0, be_else.35584      # |          2 |          2 |
be_then.35584:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
.count stack_load
    load    [$sp - 4], $i1
    mov     $i1, $ig0
    ret
be_else.35584:
.count stack_load
    load    [$sp + 5], $i22             # |          2 |          2 |
    add     $i22, 1, $i2                # |          2 |          2 |
    bl      $i2, 60, bge_else.35585     # |          2 |          2 |
bge_then.35585:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
    ret
bge_else.35585:
.count stack_store
    store   $i2, [$sp + 6]              # |          2 |          2 |
    call    read_nth_object.2719        # |          2 |          2 |
.count move_ret
    mov     $i1, $i22                   # |          2 |          2 |
    bne     $i22, 0, be_else.35586      # |          2 |          2 |
be_then.35586:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 9, $sp                 # |          1 |          1 |
.count stack_load
    load    [$sp - 3], $i1              # |          1 |          1 |
    mov     $i1, $ig0                   # |          1 |          1 |
    ret                                 # |          1 |          1 |
be_else.35586:
.count stack_load
    load    [$sp + 6], $i22             # |          1 |          1 |
    add     $i22, 1, $i2                # |          1 |          1 |
    bl      $i2, 60, bge_else.35587     # |          1 |          1 |
bge_then.35587:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
    ret
bge_else.35587:
.count stack_store
    store   $i2, [$sp + 7]              # |          1 |          1 |
    call    read_nth_object.2719        # |          1 |          1 |
.count move_ret
    mov     $i1, $i22                   # |          1 |          1 |
    bne     $i22, 0, be_else.35588      # |          1 |          1 |
be_then.35588:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
.count stack_load
    load    [$sp - 2], $i1
    mov     $i1, $ig0
    ret
be_else.35588:
.count stack_load
    load    [$sp + 7], $i22             # |          1 |          1 |
    add     $i22, 1, $i2                # |          1 |          1 |
    bl      $i2, 60, bge_else.35589     # |          1 |          1 |
bge_then.35589:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
    ret
bge_else.35589:
.count stack_store
    store   $i2, [$sp + 8]              # |          1 |          1 |
    call    read_nth_object.2719        # |          1 |          1 |
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 9, $sp                 # |          1 |          1 |
    bne     $i1, 0, be_else.35590       # |          1 |          1 |
be_then.35590:
.count stack_load
    load    [$sp - 1], $i1
    mov     $i1, $ig0
    ret
be_else.35590:
.count stack_load
    load    [$sp - 1], $i1              # |          1 |          1 |
    add     $i1, 1, $i2                 # |          1 |          1 |
    b       read_object.2721            # |          1 |          1 |
.end read_object

######################################################################
# read_net_item
######################################################################
.begin read_net_item
read_net_item.2725:
.count stack_move
    sub     $sp, 9, $sp                 # |          7 |          7 |
.count stack_store
    store   $ra, [$sp + 0]              # |          7 |          7 |
.count stack_store
    store   $i2, [$sp + 1]              # |          7 |          7 |
    call    min_caml_read_int           # |          7 |          7 |
.count move_ret
    mov     $i1, $i10                   # |          7 |          7 |
    bne     $i10, -1, be_else.35591     # |          7 |          7 |
be_then.35591:
.count stack_load
    load    [$sp + 0], $ra              # |          2 |          2 |
.count stack_move
    add     $sp, 9, $sp                 # |          2 |          2 |
.count stack_load
    load    [$sp - 8], $i10             # |          2 |          2 |
    add     $i10, 1, $i2                # |          2 |          2 |
    add     $i0, -1, $i3                # |          2 |          2 |
    b       min_caml_create_array_int   # |          2 |          2 |
be_else.35591:
    call    min_caml_read_int           # |          5 |          5 |
.count move_ret
    mov     $i1, $i11                   # |          5 |          5 |
.count stack_load
    load    [$sp + 1], $i12             # |          5 |          5 |
    add     $i12, 1, $i13               # |          5 |          5 |
    bne     $i11, -1, be_else.35592     # |          5 |          5 |
be_then.35592:
    add     $i13, 1, $i2                # |          3 |          3 |
    add     $i0, -1, $i3                # |          3 |          3 |
    call    min_caml_create_array_int   # |          3 |          3 |
.count stack_load
    load    [$sp + 0], $ra              # |          3 |          3 |
.count stack_move
    add     $sp, 9, $sp                 # |          3 |          3 |
.count storer
    add     $i1, $i12, $tmp             # |          3 |          3 |
    store   $i10, [$tmp + 0]            # |          3 |          3 |
    ret                                 # |          3 |          3 |
be_else.35592:
    call    min_caml_read_int           # |          2 |          2 |
.count move_ret
    mov     $i1, $i14                   # |          2 |          2 |
    add     $i13, 1, $i15               # |          2 |          2 |
    bne     $i14, -1, be_else.35593     # |          2 |          2 |
be_then.35593:
    add     $i15, 1, $i2                # |          1 |          1 |
    add     $i0, -1, $i3                # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 9, $sp                 # |          1 |          1 |
.count storer
    add     $i1, $i13, $tmp             # |          1 |          1 |
    store   $i11, [$tmp + 0]            # |          1 |          1 |
.count storer
    add     $i1, $i12, $tmp             # |          1 |          1 |
    store   $i10, [$tmp + 0]            # |          1 |          1 |
    ret                                 # |          1 |          1 |
be_else.35593:
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    add     $i15, 1, $i17               # |          1 |          1 |
    add     $i17, 1, $i2                # |          1 |          1 |
    bne     $i16, -1, be_else.35594     # |          1 |          1 |
be_then.35594:
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
.count storer
    add     $i1, $i15, $tmp
    store   $i14, [$tmp + 0]
.count storer
    add     $i1, $i13, $tmp
    store   $i11, [$tmp + 0]
.count storer
    add     $i1, $i12, $tmp
    store   $i10, [$tmp + 0]
    ret
be_else.35594:
.count stack_store
    store   $i10, [$sp + 2]             # |          1 |          1 |
.count stack_store
    store   $i13, [$sp + 3]             # |          1 |          1 |
.count stack_store
    store   $i11, [$sp + 4]             # |          1 |          1 |
.count stack_store
    store   $i15, [$sp + 5]             # |          1 |          1 |
.count stack_store
    store   $i14, [$sp + 6]             # |          1 |          1 |
.count stack_store
    store   $i17, [$sp + 7]             # |          1 |          1 |
.count stack_store
    store   $i16, [$sp + 8]             # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
.count stack_load
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
    load    [$sp - 4], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 3], $i3              # |          1 |          1 |
.count storer
    add     $i1, $i2, $tmp              # |          1 |          1 |
    store   $i3, [$tmp + 0]             # |          1 |          1 |
.count stack_load
    load    [$sp - 6], $i2              # |          1 |          1 |
.count stack_load
    load    [$sp - 5], $i3              # |          1 |          1 |
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
# read_or_network
######################################################################
.begin read_or_network
read_or_network.2727:
.count stack_move
    sub     $sp, 10, $sp                # |          1 |          1 |
.count stack_store
    store   $ra, [$sp + 0]              # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 1]              # |          1 |          1 |
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    bne     $i10, -1, be_else.35595     # |          1 |          1 |
be_then.35595:
    li      1, $i2
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i10
.count b_cont
    b       be_cont.35595
be_else.35595:
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    bne     $i11, -1, be_else.35596     # |          1 |          1 |
be_then.35596:
    li      2, $i2
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i11
    store   $i10, [$i11 + 0]
    mov     $i11, $i10
.count b_cont
    b       be_cont.35596
be_else.35596:
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
    bne     $i12, -1, be_else.35597     # |          1 |          1 |
be_then.35597:
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i12
    store   $i11, [$i12 + 1]
    store   $i10, [$i12 + 0]
    mov     $i12, $i10
.count b_cont
    b       be_cont.35597
be_else.35597:
.count stack_store
    store   $i10, [$sp + 2]             # |          1 |          1 |
.count stack_store
    store   $i11, [$sp + 3]             # |          1 |          1 |
.count stack_store
    store   $i12, [$sp + 4]             # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count stack_load
    load    [$sp + 4], $i11             # |          1 |          1 |
    store   $i11, [$i10 + 2]            # |          1 |          1 |
.count stack_load
    load    [$sp + 3], $i11             # |          1 |          1 |
    store   $i11, [$i10 + 1]            # |          1 |          1 |
.count stack_load
    load    [$sp + 2], $i11             # |          1 |          1 |
    store   $i11, [$i10 + 0]            # |          1 |          1 |
be_cont.35597:
be_cont.35596:
be_cont.35595:
    mov     $i10, $i3                   # |          1 |          1 |
    load    [$i3 + 0], $i10             # |          1 |          1 |
    bne     $i10, -1, be_else.35598     # |          1 |          1 |
be_then.35598:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 10, $sp
.count stack_load
    load    [$sp - 9], $i10
    add     $i10, 1, $i2
    b       min_caml_create_array_int
be_else.35598:
.count stack_store
    store   $i3, [$sp + 5]              # |          1 |          1 |
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    bne     $i10, -1, be_else.35599     # |          1 |          1 |
be_then.35599:
    li      1, $i2                      # |          1 |          1 |
    add     $i0, -1, $i3                # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count b_cont
    b       be_cont.35599               # |          1 |          1 |
be_else.35599:
    call    min_caml_read_int
.count move_ret
    mov     $i1, $i11
    li      2, $i2
    bne     $i11, -1, be_else.35600
be_then.35600:
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i11
    store   $i10, [$i11 + 0]
    mov     $i11, $i10
.count b_cont
    b       be_cont.35600
be_else.35600:
.count stack_store
    store   $i10, [$sp + 6]
.count stack_store
    store   $i11, [$sp + 7]
    call    read_net_item.2725
.count move_ret
    mov     $i1, $i10
.count stack_load
    load    [$sp + 7], $i11
    store   $i11, [$i10 + 1]
.count stack_load
    load    [$sp + 6], $i11
    store   $i11, [$i10 + 0]
be_cont.35600:
be_cont.35599:
    mov     $i10, $i3                   # |          1 |          1 |
    load    [$i3 + 0], $i10             # |          1 |          1 |
.count stack_load
    load    [$sp + 1], $i11             # |          1 |          1 |
    add     $i11, 1, $i12               # |          1 |          1 |
    add     $i12, 1, $i2                # |          1 |          1 |
    bne     $i10, -1, be_else.35601     # |          1 |          1 |
be_then.35601:
    call    min_caml_create_array_int   # |          1 |          1 |
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 10, $sp                # |          1 |          1 |
.count stack_load
    load    [$sp - 5], $i2              # |          1 |          1 |
.count storer
    add     $i1, $i11, $tmp             # |          1 |          1 |
    store   $i2, [$tmp + 0]             # |          1 |          1 |
    ret                                 # |          1 |          1 |
be_else.35601:
.count stack_store
    store   $i12, [$sp + 8]
.count stack_store
    store   $i3, [$sp + 9]
    call    read_or_network.2727
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 10, $sp
.count stack_load
    load    [$sp - 2], $i2
.count stack_load
    load    [$sp - 1], $i3
.count storer
    add     $i1, $i2, $tmp
    store   $i3, [$tmp + 0]
.count stack_load
    load    [$sp - 9], $i2
.count stack_load
    load    [$sp - 5], $i3
.count storer
    add     $i1, $i2, $tmp
    store   $i3, [$tmp + 0]
    ret
.end read_or_network

######################################################################
# read_and_network
######################################################################
.begin read_and_network
read_and_network.2729:
.count stack_move
    sub     $sp, 14, $sp                # |          3 |          3 |
.count stack_store
    store   $ra, [$sp + 0]              # |          3 |          3 |
.count stack_store
    store   $i2, [$sp + 1]              # |          3 |          3 |
    call    min_caml_read_int           # |          3 |          3 |
.count move_ret
    mov     $i1, $i10                   # |          3 |          3 |
    bne     $i10, -1, be_else.35602     # |          3 |          3 |
be_then.35602:
    li      1, $i2
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i10
.count b_cont
    b       be_cont.35602
be_else.35602:
    call    min_caml_read_int           # |          3 |          3 |
.count move_ret
    mov     $i1, $i11                   # |          3 |          3 |
    bne     $i11, -1, be_else.35603     # |          3 |          3 |
be_then.35603:
    li      2, $i2                      # |          2 |          2 |
    add     $i0, -1, $i3                # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i11                   # |          2 |          2 |
    store   $i10, [$i11 + 0]            # |          2 |          2 |
    mov     $i11, $i10                  # |          2 |          2 |
.count b_cont
    b       be_cont.35603               # |          2 |          2 |
be_else.35603:
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
    bne     $i12, -1, be_else.35604     # |          1 |          1 |
be_then.35604:
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i12
    store   $i11, [$i12 + 1]
    store   $i10, [$i12 + 0]
    mov     $i12, $i10
.count b_cont
    b       be_cont.35604
be_else.35604:
.count stack_store
    store   $i10, [$sp + 2]             # |          1 |          1 |
.count stack_store
    store   $i11, [$sp + 3]             # |          1 |          1 |
.count stack_store
    store   $i12, [$sp + 4]             # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count stack_load
    load    [$sp + 4], $i11             # |          1 |          1 |
    store   $i11, [$i10 + 2]            # |          1 |          1 |
.count stack_load
    load    [$sp + 3], $i11             # |          1 |          1 |
    store   $i11, [$i10 + 1]            # |          1 |          1 |
.count stack_load
    load    [$sp + 2], $i11             # |          1 |          1 |
    store   $i11, [$i10 + 0]            # |          1 |          1 |
be_cont.35604:
be_cont.35603:
be_cont.35602:
    load    [$i10 + 0], $i11            # |          3 |          3 |
    bne     $i11, -1, be_else.35605     # |          3 |          3 |
be_then.35605:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 14, $sp
    ret
be_else.35605:
.count stack_load
    load    [$sp + 1], $i11             # |          3 |          3 |
    store   $i10, [min_caml_and_net + $i11]# |          3 |          3 |
    call    min_caml_read_int           # |          3 |          3 |
.count move_ret
    mov     $i1, $i10                   # |          3 |          3 |
    bne     $i10, -1, be_else.35606     # |          3 |          3 |
be_then.35606:
    li      1, $i2                      # |          1 |          1 |
    add     $i0, -1, $i3                # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count b_cont
    b       be_cont.35606               # |          1 |          1 |
be_else.35606:
    call    min_caml_read_int           # |          2 |          2 |
.count move_ret
    mov     $i1, $i11                   # |          2 |          2 |
    li      2, $i2                      # |          2 |          2 |
    bne     $i11, -1, be_else.35607     # |          2 |          2 |
be_then.35607:
    add     $i0, -1, $i3                # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    store   $i10, [$i11 + 0]            # |          1 |          1 |
    mov     $i11, $i10                  # |          1 |          1 |
.count b_cont
    b       be_cont.35607               # |          1 |          1 |
be_else.35607:
.count stack_store
    store   $i10, [$sp + 5]             # |          1 |          1 |
.count stack_store
    store   $i11, [$sp + 6]             # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count stack_load
    load    [$sp + 6], $i11             # |          1 |          1 |
    store   $i11, [$i10 + 1]            # |          1 |          1 |
.count stack_load
    load    [$sp + 5], $i11             # |          1 |          1 |
    store   $i11, [$i10 + 0]            # |          1 |          1 |
be_cont.35607:
be_cont.35606:
    load    [$i10 + 0], $i11            # |          3 |          3 |
    bne     $i11, -1, be_else.35608     # |          3 |          3 |
be_then.35608:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 14, $sp                # |          1 |          1 |
    ret                                 # |          1 |          1 |
be_else.35608:
.count stack_load
    load    [$sp + 1], $i11             # |          2 |          2 |
    add     $i11, 1, $i11               # |          2 |          2 |
.count stack_store
    store   $i11, [$sp + 7]             # |          2 |          2 |
    store   $i10, [min_caml_and_net + $i11]# |          2 |          2 |
    call    min_caml_read_int           # |          2 |          2 |
.count move_ret
    mov     $i1, $i10                   # |          2 |          2 |
    bne     $i10, -1, be_else.35609     # |          2 |          2 |
be_then.35609:
    li      1, $i2
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i10
.count b_cont
    b       be_cont.35609
be_else.35609:
    call    min_caml_read_int           # |          2 |          2 |
.count move_ret
    mov     $i1, $i11                   # |          2 |          2 |
    bne     $i11, -1, be_else.35610     # |          2 |          2 |
be_then.35610:
    li      2, $i2                      # |          2 |          2 |
    add     $i0, -1, $i3                # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i11                   # |          2 |          2 |
    store   $i10, [$i11 + 0]            # |          2 |          2 |
    mov     $i11, $i10                  # |          2 |          2 |
.count b_cont
    b       be_cont.35610               # |          2 |          2 |
be_else.35610:
    call    min_caml_read_int
.count move_ret
    mov     $i1, $i12
    li      3, $i2
    bne     $i12, -1, be_else.35611
be_then.35611:
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i12
    store   $i11, [$i12 + 1]
    store   $i10, [$i12 + 0]
    mov     $i12, $i10
.count b_cont
    b       be_cont.35611
be_else.35611:
.count stack_store
    store   $i10, [$sp + 8]
.count stack_store
    store   $i11, [$sp + 9]
.count stack_store
    store   $i12, [$sp + 10]
    call    read_net_item.2725
.count move_ret
    mov     $i1, $i10
.count stack_load
    load    [$sp + 10], $i11
    store   $i11, [$i10 + 2]
.count stack_load
    load    [$sp + 9], $i11
    store   $i11, [$i10 + 1]
.count stack_load
    load    [$sp + 8], $i11
    store   $i11, [$i10 + 0]
be_cont.35611:
be_cont.35610:
be_cont.35609:
    load    [$i10 + 0], $i11            # |          2 |          2 |
    bne     $i11, -1, be_else.35612     # |          2 |          2 |
be_then.35612:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 14, $sp
    ret
be_else.35612:
.count stack_load
    load    [$sp + 7], $i11             # |          2 |          2 |
    add     $i11, 1, $i11               # |          2 |          2 |
.count stack_store
    store   $i11, [$sp + 11]            # |          2 |          2 |
    store   $i10, [min_caml_and_net + $i11]# |          2 |          2 |
    call    min_caml_read_int           # |          2 |          2 |
.count move_ret
    mov     $i1, $i10                   # |          2 |          2 |
    bne     $i10, -1, be_else.35613     # |          2 |          2 |
be_then.35613:
    li      1, $i2
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count b_cont
    b       be_cont.35613
be_else.35613:
    call    min_caml_read_int           # |          2 |          2 |
.count move_ret
    mov     $i1, $i11                   # |          2 |          2 |
    li      2, $i2                      # |          2 |          2 |
    bne     $i11, -1, be_else.35614     # |          2 |          2 |
be_then.35614:
    add     $i0, -1, $i3                # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
    store   $i10, [$i1 + 0]             # |          1 |          1 |
.count b_cont
    b       be_cont.35614               # |          1 |          1 |
be_else.35614:
.count stack_store
    store   $i10, [$sp + 12]            # |          1 |          1 |
.count stack_store
    store   $i11, [$sp + 13]            # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
.count stack_load
    load    [$sp + 13], $i2             # |          1 |          1 |
    store   $i2, [$i1 + 1]              # |          1 |          1 |
.count stack_load
    load    [$sp + 12], $i2             # |          1 |          1 |
    store   $i2, [$i1 + 0]              # |          1 |          1 |
be_cont.35614:
be_cont.35613:
.count stack_load
    load    [$sp + 0], $ra              # |          2 |          2 |
.count stack_move
    add     $sp, 14, $sp                # |          2 |          2 |
    load    [$i1 + 0], $i2              # |          2 |          2 |
    bne     $i2, -1, be_else.35615      # |          2 |          2 |
be_then.35615:
    ret
be_else.35615:
.count stack_load
    load    [$sp - 3], $i2              # |          2 |          2 |
    add     $i2, 1, $i2                 # |          2 |          2 |
    store   $i1, [min_caml_and_net + $i2]# |          2 |          2 |
    add     $i2, 1, $i2                 # |          2 |          2 |
    b       read_and_network.2729       # |          2 |          2 |
.end read_and_network

######################################################################
# solver
######################################################################
.begin solver
solver.2773:
    load    [min_caml_objects + $i2], $i1# |     23,754 |     23,754 |
    load    [$i1 + 5], $i2              # |     23,754 |     23,754 |
    load    [$i1 + 5], $i4              # |     23,754 |     23,754 |
    load    [$i1 + 5], $i5              # |     23,754 |     23,754 |
    load    [$i1 + 1], $i6              # |     23,754 |     23,754 |
    load    [$i2 + 0], $f1              # |     23,754 |     23,754 |
    load    [$i4 + 1], $f2              # |     23,754 |     23,754 |
    load    [$i5 + 2], $f3              # |     23,754 |     23,754 |
    fsub    $fg21, $f1, $f1             # |     23,754 |     23,754 |
    fsub    $fg22, $f2, $f2             # |     23,754 |     23,754 |
    fsub    $fg23, $f3, $f3             # |     23,754 |     23,754 |
    load    [$i3 + 0], $f4              # |     23,754 |     23,754 |
    bne     $i6, 1, be_else.35616       # |     23,754 |     23,754 |
be_then.35616:
    bne     $f4, $f0, be_else.35617     # |     23,754 |     23,754 |
be_then.35617:
    li      0, $i2
.count b_cont
    b       be_cont.35617
be_else.35617:
    load    [$i1 + 4], $i2              # |     23,754 |     23,754 |
    load    [$i2 + 1], $f5              # |     23,754 |     23,754 |
    load    [$i3 + 1], $f6              # |     23,754 |     23,754 |
    load    [$i1 + 6], $i4              # |     23,754 |     23,754 |
    bg      $f0, $f4, ble_else.35618    # |     23,754 |     23,754 |
ble_then.35618:
    li      0, $i5                      # |     23,580 |     23,580 |
.count b_cont
    b       ble_cont.35618              # |     23,580 |     23,580 |
ble_else.35618:
    li      1, $i5                      # |        174 |        174 |
ble_cont.35618:
    bne     $i4, 0, be_else.35619       # |     23,754 |     23,754 |
be_then.35619:
    mov     $i5, $i4                    # |     23,754 |     23,754 |
.count b_cont
    b       be_cont.35619               # |     23,754 |     23,754 |
be_else.35619:
    bne     $i5, 0, be_else.35620
be_then.35620:
    li      1, $i4
.count b_cont
    b       be_cont.35620
be_else.35620:
    li      0, $i4
be_cont.35620:
be_cont.35619:
    load    [$i2 + 0], $f7              # |     23,754 |     23,754 |
    bne     $i4, 0, be_cont.35621       # |     23,754 |     23,754 |
be_then.35621:
    fneg    $f7, $f7                    # |     23,580 |     23,580 |
be_cont.35621:
    fsub    $f7, $f1, $f7               # |     23,754 |     23,754 |
    finv    $f4, $f4                    # |     23,754 |     23,754 |
    fmul    $f7, $f4, $f4               # |     23,754 |     23,754 |
    fmul    $f4, $f6, $f6               # |     23,754 |     23,754 |
    fadd_a  $f6, $f2, $f6               # |     23,754 |     23,754 |
    bg      $f5, $f6, ble_else.35622    # |     23,754 |     23,754 |
ble_then.35622:
    li      0, $i2                      # |     14,964 |     14,964 |
.count b_cont
    b       ble_cont.35622              # |     14,964 |     14,964 |
ble_else.35622:
    load    [$i2 + 2], $f5              # |      8,790 |      8,790 |
    load    [$i3 + 2], $f6              # |      8,790 |      8,790 |
    fmul    $f4, $f6, $f6               # |      8,790 |      8,790 |
    fadd_a  $f6, $f3, $f6               # |      8,790 |      8,790 |
    bg      $f5, $f6, ble_else.35623    # |      8,790 |      8,790 |
ble_then.35623:
    li      0, $i2                      # |      5,123 |      5,123 |
.count b_cont
    b       ble_cont.35623              # |      5,123 |      5,123 |
ble_else.35623:
    mov     $f4, $fg0                   # |      3,667 |      3,667 |
    li      1, $i2                      # |      3,667 |      3,667 |
ble_cont.35623:
ble_cont.35622:
be_cont.35617:
    bne     $i2, 0, be_else.35624       # |     23,754 |     23,754 |
be_then.35624:
    load    [$i3 + 1], $f4              # |     20,087 |     20,087 |
    bne     $f4, $f0, be_else.35625     # |     20,087 |     20,087 |
be_then.35625:
    li      0, $i2
.count b_cont
    b       be_cont.35625
be_else.35625:
    load    [$i1 + 4], $i2              # |     20,087 |     20,087 |
    load    [$i2 + 2], $f5              # |     20,087 |     20,087 |
    load    [$i3 + 2], $f6              # |     20,087 |     20,087 |
    load    [$i1 + 6], $i4              # |     20,087 |     20,087 |
    bg      $f0, $f4, ble_else.35626    # |     20,087 |     20,087 |
ble_then.35626:
    li      0, $i5                      # |         38 |         38 |
.count b_cont
    b       ble_cont.35626              # |         38 |         38 |
ble_else.35626:
    li      1, $i5                      # |     20,049 |     20,049 |
ble_cont.35626:
    bne     $i4, 0, be_else.35627       # |     20,087 |     20,087 |
be_then.35627:
    mov     $i5, $i4                    # |     20,087 |     20,087 |
.count b_cont
    b       be_cont.35627               # |     20,087 |     20,087 |
be_else.35627:
    bne     $i5, 0, be_else.35628
be_then.35628:
    li      1, $i4
.count b_cont
    b       be_cont.35628
be_else.35628:
    li      0, $i4
be_cont.35628:
be_cont.35627:
    load    [$i2 + 1], $f7              # |     20,087 |     20,087 |
    bne     $i4, 0, be_cont.35629       # |     20,087 |     20,087 |
be_then.35629:
    fneg    $f7, $f7                    # |         38 |         38 |
be_cont.35629:
    fsub    $f7, $f2, $f7               # |     20,087 |     20,087 |
    finv    $f4, $f4                    # |     20,087 |     20,087 |
    fmul    $f7, $f4, $f4               # |     20,087 |     20,087 |
    fmul    $f4, $f6, $f6               # |     20,087 |     20,087 |
    fadd_a  $f6, $f3, $f6               # |     20,087 |     20,087 |
    bg      $f5, $f6, ble_else.35630    # |     20,087 |     20,087 |
ble_then.35630:
    li      0, $i2                      # |     16,512 |     16,512 |
.count b_cont
    b       ble_cont.35630              # |     16,512 |     16,512 |
ble_else.35630:
    load    [$i2 + 0], $f5              # |      3,575 |      3,575 |
    load    [$i3 + 0], $f6              # |      3,575 |      3,575 |
    fmul    $f4, $f6, $f6               # |      3,575 |      3,575 |
    fadd_a  $f6, $f1, $f6               # |      3,575 |      3,575 |
    bg      $f5, $f6, ble_else.35631    # |      3,575 |      3,575 |
ble_then.35631:
    li      0, $i2                      # |      2,631 |      2,631 |
.count b_cont
    b       ble_cont.35631              # |      2,631 |      2,631 |
ble_else.35631:
    mov     $f4, $fg0                   # |        944 |        944 |
    li      1, $i2                      # |        944 |        944 |
ble_cont.35631:
ble_cont.35630:
be_cont.35625:
    bne     $i2, 0, be_else.35632       # |     20,087 |     20,087 |
be_then.35632:
    load    [$i3 + 2], $f4              # |     19,143 |     19,143 |
    bne     $f4, $f0, be_else.35633     # |     19,143 |     19,143 |
be_then.35633:
    li      0, $i1
    ret
be_else.35633:
    load    [$i1 + 4], $i2              # |     19,143 |     19,143 |
    load    [$i1 + 6], $i1              # |     19,143 |     19,143 |
    load    [$i2 + 0], $f5              # |     19,143 |     19,143 |
    load    [$i3 + 0], $f6              # |     19,143 |     19,143 |
    bg      $f0, $f4, ble_else.35634    # |     19,143 |     19,143 |
ble_then.35634:
    li      0, $i4                      # |     12,429 |     12,429 |
.count b_cont
    b       ble_cont.35634              # |     12,429 |     12,429 |
ble_else.35634:
    li      1, $i4                      # |      6,714 |      6,714 |
ble_cont.35634:
    bne     $i1, 0, be_else.35635       # |     19,143 |     19,143 |
be_then.35635:
    mov     $i4, $i1                    # |     19,143 |     19,143 |
.count b_cont
    b       be_cont.35635               # |     19,143 |     19,143 |
be_else.35635:
    bne     $i4, 0, be_else.35636
be_then.35636:
    li      1, $i1
.count b_cont
    b       be_cont.35636
be_else.35636:
    li      0, $i1
be_cont.35636:
be_cont.35635:
    load    [$i2 + 2], $f7              # |     19,143 |     19,143 |
    bne     $i1, 0, be_cont.35637       # |     19,143 |     19,143 |
be_then.35637:
    fneg    $f7, $f7                    # |     12,429 |     12,429 |
be_cont.35637:
    fsub    $f7, $f3, $f3               # |     19,143 |     19,143 |
    finv    $f4, $f4                    # |     19,143 |     19,143 |
    fmul    $f3, $f4, $f3               # |     19,143 |     19,143 |
    fmul    $f3, $f6, $f4               # |     19,143 |     19,143 |
    fadd_a  $f4, $f1, $f1               # |     19,143 |     19,143 |
    bg      $f5, $f1, ble_else.35638    # |     19,143 |     19,143 |
ble_then.35638:
    li      0, $i1                      # |     15,261 |     15,261 |
    ret                                 # |     15,261 |     15,261 |
ble_else.35638:
    load    [$i2 + 1], $f1              # |      3,882 |      3,882 |
    load    [$i3 + 1], $f4              # |      3,882 |      3,882 |
    fmul    $f3, $f4, $f4               # |      3,882 |      3,882 |
    fadd_a  $f4, $f2, $f2               # |      3,882 |      3,882 |
    bg      $f1, $f2, ble_else.35639    # |      3,882 |      3,882 |
ble_then.35639:
    li      0, $i1                      # |      1,717 |      1,717 |
    ret                                 # |      1,717 |      1,717 |
ble_else.35639:
    mov     $f3, $fg0                   # |      2,165 |      2,165 |
    li      3, $i1                      # |      2,165 |      2,165 |
    ret                                 # |      2,165 |      2,165 |
be_else.35632:
    li      2, $i1                      # |        944 |        944 |
    ret                                 # |        944 |        944 |
be_else.35624:
    li      1, $i1                      # |      3,667 |      3,667 |
    ret                                 # |      3,667 |      3,667 |
be_else.35616:
    bne     $i6, 2, be_else.35640
be_then.35640:
    load    [$i1 + 4], $i1
    load    [$i1 + 0], $f5
    fmul    $f4, $f5, $f4
    load    [$i3 + 1], $f6
    load    [$i1 + 1], $f7
    fmul    $f6, $f7, $f6
    fadd    $f4, $f6, $f4
    load    [$i3 + 2], $f6
    load    [$i1 + 2], $f8
    fmul    $f6, $f8, $f6
    fadd    $f4, $f6, $f4
    bg      $f4, $f0, ble_else.35641
ble_then.35641:
    li      0, $i1
    ret
ble_else.35641:
    fmul    $f5, $f1, $f1
    fmul    $f7, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f8, $f3, $f2
    fadd_n  $f1, $f2, $f1
    finv    $f4, $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.35640:
    load    [$i1 + 4], $i2
    load    [$i1 + 4], $i4
    load    [$i1 + 4], $i5
    load    [$i1 + 3], $i7
    load    [$i3 + 1], $f5
    load    [$i3 + 2], $f6
    fmul    $f4, $f4, $f7
    load    [$i2 + 0], $f8
    fmul    $f7, $f8, $f7
    fmul    $f5, $f5, $f9
    load    [$i4 + 1], $f10
    fmul    $f9, $f10, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f6, $f9
    load    [$i5 + 2], $f11
    fmul    $f9, $f11, $f9
    fadd    $f7, $f9, $f7
    be      $i7, 0, bne_cont.35642
bne_then.35642:
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
bne_cont.35642:
    bne     $f7, $f0, be_else.35643
be_then.35643:
    li      0, $i1
    ret
be_else.35643:
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
    bne     $i2, 0, be_else.35644
be_then.35644:
    mov     $f9, $f4
.count b_cont
    b       be_cont.35644
be_else.35644:
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
be_cont.35644:
    fmul    $f4, $f4, $f5
    fmul    $f1, $f1, $f6
    fmul    $f6, $f8, $f6
    fmul    $f2, $f2, $f8
    fmul    $f8, $f10, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f3, $f8
    fmul    $f8, $f11, $f8
    fadd    $f6, $f8, $f6
    bne     $i3, 0, be_else.35645
be_then.35645:
    mov     $f6, $f1
.count b_cont
    b       be_cont.35645
be_else.35645:
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
be_cont.35645:
    bne     $i6, 3, be_cont.35646
be_then.35646:
    fsub    $f1, $fc0, $f1
be_cont.35646:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    bg      $f1, $f0, ble_else.35647
ble_then.35647:
    li      0, $i1
    ret
ble_else.35647:
    load    [$i1 + 6], $i1
    fsqrt   $f1, $f1
    finv    $f7, $f2
    bne     $i1, 0, be_else.35648
be_then.35648:
    fneg    $f1, $f1
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.35648:
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
.end solver

######################################################################
# solver_fast
######################################################################
.begin solver_fast
solver_fast.2796:
    load    [min_caml_objects + $i2], $i1# |    660,661 |    660,661 |
    load    [$i1 + 5], $i3              # |    660,661 |    660,661 |
    load    [$i1 + 5], $i4              # |    660,661 |    660,661 |
    load    [$i1 + 5], $i5              # |    660,661 |    660,661 |
    load    [min_caml_light_dirvec + 1], $i6# |    660,661 |    660,661 |
    load    [$i1 + 1], $i7              # |    660,661 |    660,661 |
    load    [min_caml_intersection_point + 0], $f1# |    660,661 |    660,661 |
    load    [$i3 + 0], $f2              # |    660,661 |    660,661 |
    load    [min_caml_intersection_point + 1], $f3# |    660,661 |    660,661 |
    load    [$i4 + 1], $f4              # |    660,661 |    660,661 |
    load    [min_caml_intersection_point + 2], $f5# |    660,661 |    660,661 |
    load    [$i5 + 2], $f6              # |    660,661 |    660,661 |
    fsub    $f1, $f2, $f1               # |    660,661 |    660,661 |
    fsub    $f3, $f4, $f2               # |    660,661 |    660,661 |
    fsub    $f5, $f6, $f3               # |    660,661 |    660,661 |
    load    [$i6 + $i2], $i2            # |    660,661 |    660,661 |
    bne     $i7, 1, be_else.35649       # |    660,661 |    660,661 |
be_then.35649:
    load    [min_caml_light_dirvec + 0], $i3# |    660,661 |    660,661 |
    load    [$i1 + 4], $i4              # |    660,661 |    660,661 |
    load    [$i4 + 1], $f4              # |    660,661 |    660,661 |
    load    [$i3 + 1], $f5              # |    660,661 |    660,661 |
    load    [$i2 + 0], $f6              # |    660,661 |    660,661 |
    fsub    $f6, $f1, $f6               # |    660,661 |    660,661 |
    load    [$i2 + 1], $f7              # |    660,661 |    660,661 |
    fmul    $f6, $f7, $f6               # |    660,661 |    660,661 |
    fmul    $f6, $f5, $f5               # |    660,661 |    660,661 |
    fadd_a  $f5, $f2, $f5               # |    660,661 |    660,661 |
    bg      $f4, $f5, ble_else.35650    # |    660,661 |    660,661 |
ble_then.35650:
    li      0, $i4                      # |    437,614 |    437,614 |
.count b_cont
    b       ble_cont.35650              # |    437,614 |    437,614 |
ble_else.35650:
    load    [$i1 + 4], $i4              # |    223,047 |    223,047 |
    load    [$i4 + 2], $f5              # |    223,047 |    223,047 |
    load    [$i3 + 2], $f7              # |    223,047 |    223,047 |
    fmul    $f6, $f7, $f7               # |    223,047 |    223,047 |
    fadd_a  $f7, $f3, $f7               # |    223,047 |    223,047 |
    bg      $f5, $f7, ble_else.35651    # |    223,047 |    223,047 |
ble_then.35651:
    li      0, $i4                      # |     76,254 |     76,254 |
.count b_cont
    b       ble_cont.35651              # |     76,254 |     76,254 |
ble_else.35651:
    load    [$i2 + 1], $f5              # |    146,793 |    146,793 |
    bne     $f5, $f0, be_else.35652     # |    146,793 |    146,793 |
be_then.35652:
    li      0, $i4
.count b_cont
    b       be_cont.35652
be_else.35652:
    li      1, $i4                      # |    146,793 |    146,793 |
be_cont.35652:
ble_cont.35651:
ble_cont.35650:
    bne     $i4, 0, be_else.35653       # |    660,661 |    660,661 |
be_then.35653:
    load    [$i1 + 4], $i4              # |    513,868 |    513,868 |
    load    [$i4 + 0], $f5              # |    513,868 |    513,868 |
    load    [$i3 + 0], $f6              # |    513,868 |    513,868 |
    load    [$i2 + 2], $f7              # |    513,868 |    513,868 |
    fsub    $f7, $f2, $f7               # |    513,868 |    513,868 |
    load    [$i2 + 3], $f8              # |    513,868 |    513,868 |
    fmul    $f7, $f8, $f7               # |    513,868 |    513,868 |
    fmul    $f7, $f6, $f6               # |    513,868 |    513,868 |
    fadd_a  $f6, $f1, $f6               # |    513,868 |    513,868 |
    bg      $f5, $f6, ble_else.35654    # |    513,868 |    513,868 |
ble_then.35654:
    li      0, $i1                      # |    438,844 |    438,844 |
.count b_cont
    b       ble_cont.35654              # |    438,844 |    438,844 |
ble_else.35654:
    load    [$i1 + 4], $i1              # |     75,024 |     75,024 |
    load    [$i1 + 2], $f6              # |     75,024 |     75,024 |
    load    [$i3 + 2], $f8              # |     75,024 |     75,024 |
    fmul    $f7, $f8, $f8               # |     75,024 |     75,024 |
    fadd_a  $f8, $f3, $f8               # |     75,024 |     75,024 |
    bg      $f6, $f8, ble_else.35655    # |     75,024 |     75,024 |
ble_then.35655:
    li      0, $i1                      # |     40,191 |     40,191 |
.count b_cont
    b       ble_cont.35655              # |     40,191 |     40,191 |
ble_else.35655:
    load    [$i2 + 3], $f6              # |     34,833 |     34,833 |
    bne     $f6, $f0, be_else.35656     # |     34,833 |     34,833 |
be_then.35656:
    li      0, $i1
.count b_cont
    b       be_cont.35656
be_else.35656:
    li      1, $i1                      # |     34,833 |     34,833 |
be_cont.35656:
ble_cont.35655:
ble_cont.35654:
    bne     $i1, 0, be_else.35657       # |    513,868 |    513,868 |
be_then.35657:
    load    [$i3 + 0], $f6              # |    479,035 |    479,035 |
    load    [$i2 + 4], $f7              # |    479,035 |    479,035 |
    fsub    $f7, $f3, $f3               # |    479,035 |    479,035 |
    load    [$i2 + 5], $f7              # |    479,035 |    479,035 |
    fmul    $f3, $f7, $f3               # |    479,035 |    479,035 |
    fmul    $f3, $f6, $f6               # |    479,035 |    479,035 |
    fadd_a  $f6, $f1, $f1               # |    479,035 |    479,035 |
    bg      $f5, $f1, ble_else.35658    # |    479,035 |    479,035 |
ble_then.35658:
    li      0, $i1                      # |    447,036 |    447,036 |
    ret                                 # |    447,036 |    447,036 |
ble_else.35658:
    load    [$i3 + 1], $f1              # |     31,999 |     31,999 |
    fmul    $f3, $f1, $f1               # |     31,999 |     31,999 |
    fadd_a  $f1, $f2, $f1               # |     31,999 |     31,999 |
    bg      $f4, $f1, ble_else.35659    # |     31,999 |     31,999 |
ble_then.35659:
    li      0, $i1                      # |      7,652 |      7,652 |
    ret                                 # |      7,652 |      7,652 |
ble_else.35659:
    load    [$i2 + 5], $f1              # |     24,347 |     24,347 |
    bne     $f1, $f0, be_else.35660     # |     24,347 |     24,347 |
be_then.35660:
    li      0, $i1
    ret
be_else.35660:
    mov     $f3, $fg0                   # |     24,347 |     24,347 |
    li      3, $i1                      # |     24,347 |     24,347 |
    ret                                 # |     24,347 |     24,347 |
be_else.35657:
    mov     $f7, $fg0                   # |     34,833 |     34,833 |
    li      2, $i1                      # |     34,833 |     34,833 |
    ret                                 # |     34,833 |     34,833 |
be_else.35653:
    mov     $f6, $fg0                   # |    146,793 |    146,793 |
    li      1, $i1                      # |    146,793 |    146,793 |
    ret                                 # |    146,793 |    146,793 |
be_else.35649:
    load    [$i2 + 0], $f4
    bne     $i7, 2, be_else.35661
be_then.35661:
    bg      $f0, $f4, ble_else.35662
ble_then.35662:
    li      0, $i1
    ret
ble_else.35662:
    load    [$i2 + 1], $f4
    fmul    $f4, $f1, $f1
    load    [$i2 + 2], $f4
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    load    [$i2 + 3], $f2
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.35661:
    bne     $f4, $f0, be_else.35663
be_then.35663:
    li      0, $i1
    ret
be_else.35663:
    load    [$i1 + 4], $i3
    load    [$i1 + 4], $i4
    load    [$i1 + 4], $i5
    load    [$i1 + 3], $i6
    load    [$i2 + 1], $f5
    fmul    $f5, $f1, $f5
    load    [$i2 + 2], $f6
    fmul    $f6, $f2, $f6
    fadd    $f5, $f6, $f5
    load    [$i2 + 3], $f6
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
    bne     $i6, 0, be_else.35664
be_then.35664:
    mov     $f7, $f1
.count b_cont
    b       be_cont.35664
be_else.35664:
    fmul    $f2, $f3, $f8
    load    [$i1 + 9], $i3
    load    [$i3 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i1 + 9], $i3
    load    [$i3 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i1 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.35664:
    bne     $i7, 3, be_cont.35665
be_then.35665:
    fsub    $f1, $fc0, $f1
be_cont.35665:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    bg      $f1, $f0, ble_else.35666
ble_then.35666:
    li      0, $i1
    ret
ble_else.35666:
    load    [$i1 + 6], $i1
    load    [$i2 + 4], $f2
    fsqrt   $f1, $f1
    bne     $i1, 0, be_else.35667
be_then.35667:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.35667:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
.end solver_fast

######################################################################
# solver_fast2
######################################################################
.begin solver_fast2
solver_fast2.2814:
    load    [min_caml_objects + $i2], $i1# |  1,134,616 |  1,134,616 |
    load    [$i1 + 10], $i4             # |  1,134,616 |  1,134,616 |
    load    [$i3 + 1], $i5              # |  1,134,616 |  1,134,616 |
    load    [$i1 + 1], $i6              # |  1,134,616 |  1,134,616 |
    load    [$i4 + 0], $f1              # |  1,134,616 |  1,134,616 |
    load    [$i4 + 1], $f2              # |  1,134,616 |  1,134,616 |
    load    [$i4 + 2], $f3              # |  1,134,616 |  1,134,616 |
    load    [$i5 + $i2], $i2            # |  1,134,616 |  1,134,616 |
    bne     $i6, 1, be_else.35668       # |  1,134,616 |  1,134,616 |
be_then.35668:
    load    [$i3 + 0], $i3              # |  1,134,616 |  1,134,616 |
    load    [$i1 + 4], $i4              # |  1,134,616 |  1,134,616 |
    load    [$i4 + 1], $f4              # |  1,134,616 |  1,134,616 |
    load    [$i3 + 1], $f5              # |  1,134,616 |  1,134,616 |
    load    [$i2 + 0], $f6              # |  1,134,616 |  1,134,616 |
    fsub    $f6, $f1, $f6               # |  1,134,616 |  1,134,616 |
    load    [$i2 + 1], $f7              # |  1,134,616 |  1,134,616 |
    fmul    $f6, $f7, $f6               # |  1,134,616 |  1,134,616 |
    fmul    $f6, $f5, $f5               # |  1,134,616 |  1,134,616 |
    fadd_a  $f5, $f2, $f5               # |  1,134,616 |  1,134,616 |
    bg      $f4, $f5, ble_else.35669    # |  1,134,616 |  1,134,616 |
ble_then.35669:
    li      0, $i4                      # |    640,191 |    640,191 |
.count b_cont
    b       ble_cont.35669              # |    640,191 |    640,191 |
ble_else.35669:
    load    [$i1 + 4], $i4              # |    494,425 |    494,425 |
    load    [$i4 + 2], $f5              # |    494,425 |    494,425 |
    load    [$i3 + 2], $f7              # |    494,425 |    494,425 |
    fmul    $f6, $f7, $f7               # |    494,425 |    494,425 |
    fadd_a  $f7, $f3, $f7               # |    494,425 |    494,425 |
    bg      $f5, $f7, ble_else.35670    # |    494,425 |    494,425 |
ble_then.35670:
    li      0, $i4                      # |    164,419 |    164,419 |
.count b_cont
    b       ble_cont.35670              # |    164,419 |    164,419 |
ble_else.35670:
    load    [$i2 + 1], $f5              # |    330,006 |    330,006 |
    bne     $f5, $f0, be_else.35671     # |    330,006 |    330,006 |
be_then.35671:
    li      0, $i4
.count b_cont
    b       be_cont.35671
be_else.35671:
    li      1, $i4                      # |    330,006 |    330,006 |
be_cont.35671:
ble_cont.35670:
ble_cont.35669:
    bne     $i4, 0, be_else.35672       # |  1,134,616 |  1,134,616 |
be_then.35672:
    load    [$i1 + 4], $i4              # |    804,610 |    804,610 |
    load    [$i4 + 0], $f5              # |    804,610 |    804,610 |
    load    [$i3 + 0], $f6              # |    804,610 |    804,610 |
    load    [$i2 + 2], $f7              # |    804,610 |    804,610 |
    fsub    $f7, $f2, $f7               # |    804,610 |    804,610 |
    load    [$i2 + 3], $f8              # |    804,610 |    804,610 |
    fmul    $f7, $f8, $f7               # |    804,610 |    804,610 |
    fmul    $f7, $f6, $f6               # |    804,610 |    804,610 |
    fadd_a  $f6, $f1, $f6               # |    804,610 |    804,610 |
    bg      $f5, $f6, ble_else.35673    # |    804,610 |    804,610 |
ble_then.35673:
    li      0, $i1                      # |    453,618 |    453,618 |
.count b_cont
    b       ble_cont.35673              # |    453,618 |    453,618 |
ble_else.35673:
    load    [$i1 + 4], $i1              # |    350,992 |    350,992 |
    load    [$i1 + 2], $f6              # |    350,992 |    350,992 |
    load    [$i3 + 2], $f8              # |    350,992 |    350,992 |
    fmul    $f7, $f8, $f8               # |    350,992 |    350,992 |
    fadd_a  $f8, $f3, $f8               # |    350,992 |    350,992 |
    bg      $f6, $f8, ble_else.35674    # |    350,992 |    350,992 |
ble_then.35674:
    li      0, $i1                      # |    123,643 |    123,643 |
.count b_cont
    b       ble_cont.35674              # |    123,643 |    123,643 |
ble_else.35674:
    load    [$i2 + 3], $f6              # |    227,349 |    227,349 |
    bne     $f6, $f0, be_else.35675     # |    227,349 |    227,349 |
be_then.35675:
    li      0, $i1
.count b_cont
    b       be_cont.35675
be_else.35675:
    li      1, $i1                      # |    227,349 |    227,349 |
be_cont.35675:
ble_cont.35674:
ble_cont.35673:
    bne     $i1, 0, be_else.35676       # |    804,610 |    804,610 |
be_then.35676:
    load    [$i3 + 0], $f6              # |    577,261 |    577,261 |
    load    [$i2 + 4], $f7              # |    577,261 |    577,261 |
    fsub    $f7, $f3, $f3               # |    577,261 |    577,261 |
    load    [$i2 + 5], $f7              # |    577,261 |    577,261 |
    fmul    $f3, $f7, $f3               # |    577,261 |    577,261 |
    fmul    $f3, $f6, $f6               # |    577,261 |    577,261 |
    fadd_a  $f6, $f1, $f1               # |    577,261 |    577,261 |
    bg      $f5, $f1, ble_else.35677    # |    577,261 |    577,261 |
ble_then.35677:
    li      0, $i1                      # |    412,314 |    412,314 |
    ret                                 # |    412,314 |    412,314 |
ble_else.35677:
    load    [$i3 + 1], $f1              # |    164,947 |    164,947 |
    fmul    $f3, $f1, $f1               # |    164,947 |    164,947 |
    fadd_a  $f1, $f2, $f1               # |    164,947 |    164,947 |
    bg      $f4, $f1, ble_else.35678    # |    164,947 |    164,947 |
ble_then.35678:
    li      0, $i1                      # |     37,478 |     37,478 |
    ret                                 # |     37,478 |     37,478 |
ble_else.35678:
    load    [$i2 + 5], $f1              # |    127,469 |    127,469 |
    bne     $f1, $f0, be_else.35679     # |    127,469 |    127,469 |
be_then.35679:
    li      0, $i1
    ret
be_else.35679:
    mov     $f3, $fg0                   # |    127,469 |    127,469 |
    li      3, $i1                      # |    127,469 |    127,469 |
    ret                                 # |    127,469 |    127,469 |
be_else.35676:
    mov     $f7, $fg0                   # |    227,349 |    227,349 |
    li      2, $i1                      # |    227,349 |    227,349 |
    ret                                 # |    227,349 |    227,349 |
be_else.35672:
    mov     $f6, $fg0                   # |    330,006 |    330,006 |
    li      1, $i1                      # |    330,006 |    330,006 |
    ret                                 # |    330,006 |    330,006 |
be_else.35668:
    bne     $i6, 2, be_else.35680
be_then.35680:
    load    [$i2 + 0], $f1
    bg      $f0, $f1, ble_else.35681
ble_then.35681:
    li      0, $i1
    ret
ble_else.35681:
    load    [$i4 + 3], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.35680:
    load    [$i2 + 0], $f4
    bne     $f4, $f0, be_else.35682
be_then.35682:
    li      0, $i1
    ret
be_else.35682:
    load    [$i2 + 1], $f5
    fmul    $f5, $f1, $f1
    load    [$i2 + 2], $f5
    fmul    $f5, $f2, $f2
    fadd    $f1, $f2, $f1
    load    [$i2 + 3], $f2
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $f1, $f2
    load    [$i4 + 3], $f3
    fmul    $f4, $f3, $f3
    fsub    $f2, $f3, $f2
    bg      $f2, $f0, ble_else.35683
ble_then.35683:
    li      0, $i1
    ret
ble_else.35683:
    load    [$i1 + 6], $i1
    fsqrt   $f2, $f2
    bne     $i1, 0, be_else.35684
be_then.35684:
    fsub    $f1, $f2, $f1
    load    [$i2 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.35684:
    fadd    $f1, $f2, $f1
    load    [$i2 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
.end solver_fast2

######################################################################
# iter_setup_dirvec_constants
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
    bl      $i3, 0, bge_else.35685      # |      7,375 |      7,375 |
bge_then.35685:
.count stack_move
    sub     $sp, 3, $sp                 # |      7,375 |      7,375 |
.count stack_store
    store   $ra, [$sp + 0]              # |      7,375 |      7,375 |
    load    [$i2 + 1], $i10             # |      7,375 |      7,375 |
    load    [min_caml_objects + $i3], $i11# |      7,375 |      7,375 |
    load    [$i11 + 1], $i12            # |      7,375 |      7,375 |
    load    [$i2 + 0], $i13             # |      7,375 |      7,375 |
.count move_args
    mov     $f0, $f2                    # |      7,375 |      7,375 |
.count stack_store
    store   $i2, [$sp + 1]              # |      7,375 |      7,375 |
.count stack_store
    store   $i3, [$sp + 2]              # |      7,375 |      7,375 |
    bne     $i12, 1, be_else.35686      # |      7,375 |      7,375 |
be_then.35686:
    li      6, $i2                      # |      3,010 |      3,010 |
    call    min_caml_create_array_float # |      3,010 |      3,010 |
.count move_ret
    mov     $i1, $i12                   # |      3,010 |      3,010 |
    load    [$i13 + 0], $f1             # |      3,010 |      3,010 |
    bne     $f1, $f0, be_else.35687     # |      3,010 |      3,010 |
be_then.35687:
    store   $f0, [$i12 + 1]
.count b_cont
    b       be_cont.35687
be_else.35687:
    load    [$i11 + 6], $i14            # |      3,010 |      3,010 |
    bg      $f0, $f1, ble_else.35688    # |      3,010 |      3,010 |
ble_then.35688:
    li      0, $i15                     # |      1,505 |      1,505 |
.count b_cont
    b       ble_cont.35688              # |      1,505 |      1,505 |
ble_else.35688:
    li      1, $i15                     # |      1,505 |      1,505 |
ble_cont.35688:
    bne     $i14, 0, be_else.35689      # |      3,010 |      3,010 |
be_then.35689:
    mov     $i15, $i14                  # |      3,010 |      3,010 |
.count b_cont
    b       be_cont.35689               # |      3,010 |      3,010 |
be_else.35689:
    bne     $i15, 0, be_else.35690
be_then.35690:
    li      1, $i14
.count b_cont
    b       be_cont.35690
be_else.35690:
    li      0, $i14
be_cont.35690:
be_cont.35689:
    load    [$i11 + 4], $i15            # |      3,010 |      3,010 |
    load    [$i15 + 0], $f1             # |      3,010 |      3,010 |
    bne     $i14, 0, be_else.35691      # |      3,010 |      3,010 |
be_then.35691:
    fneg    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i12 + 0]             # |      1,505 |      1,505 |
    load    [$i13 + 0], $f1             # |      1,505 |      1,505 |
    finv    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i12 + 1]             # |      1,505 |      1,505 |
.count b_cont
    b       be_cont.35691               # |      1,505 |      1,505 |
be_else.35691:
    store   $f1, [$i12 + 0]             # |      1,505 |      1,505 |
    load    [$i13 + 0], $f1             # |      1,505 |      1,505 |
    finv    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i12 + 1]             # |      1,505 |      1,505 |
be_cont.35691:
be_cont.35687:
    load    [$i13 + 1], $f1             # |      3,010 |      3,010 |
    bne     $f1, $f0, be_else.35692     # |      3,010 |      3,010 |
be_then.35692:
    store   $f0, [$i12 + 3]
.count b_cont
    b       be_cont.35692
be_else.35692:
    load    [$i11 + 6], $i14            # |      3,010 |      3,010 |
    bg      $f0, $f1, ble_else.35693    # |      3,010 |      3,010 |
ble_then.35693:
    li      0, $i15                     # |      1,505 |      1,505 |
.count b_cont
    b       ble_cont.35693              # |      1,505 |      1,505 |
ble_else.35693:
    li      1, $i15                     # |      1,505 |      1,505 |
ble_cont.35693:
    bne     $i14, 0, be_else.35694      # |      3,010 |      3,010 |
be_then.35694:
    mov     $i15, $i14                  # |      3,010 |      3,010 |
.count b_cont
    b       be_cont.35694               # |      3,010 |      3,010 |
be_else.35694:
    bne     $i15, 0, be_else.35695
be_then.35695:
    li      1, $i14
.count b_cont
    b       be_cont.35695
be_else.35695:
    li      0, $i14
be_cont.35695:
be_cont.35694:
    load    [$i11 + 4], $i15            # |      3,010 |      3,010 |
    load    [$i15 + 1], $f1             # |      3,010 |      3,010 |
    bne     $i14, 0, be_else.35696      # |      3,010 |      3,010 |
be_then.35696:
    fneg    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i12 + 2]             # |      1,505 |      1,505 |
    load    [$i13 + 1], $f1             # |      1,505 |      1,505 |
    finv    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i12 + 3]             # |      1,505 |      1,505 |
.count b_cont
    b       be_cont.35696               # |      1,505 |      1,505 |
be_else.35696:
    store   $f1, [$i12 + 2]             # |      1,505 |      1,505 |
    load    [$i13 + 1], $f1             # |      1,505 |      1,505 |
    finv    $f1, $f1                    # |      1,505 |      1,505 |
    store   $f1, [$i12 + 3]             # |      1,505 |      1,505 |
be_cont.35696:
be_cont.35692:
    load    [$i13 + 2], $f1             # |      3,010 |      3,010 |
    bne     $f1, $f0, be_else.35697     # |      3,010 |      3,010 |
be_then.35697:
    store   $f0, [$i12 + 5]
    mov     $i12, $i11
.count b_cont
    b       be_cont.35697
be_else.35697:
    load    [$i11 + 6], $i14            # |      3,010 |      3,010 |
    bg      $f0, $f1, ble_else.35698    # |      3,010 |      3,010 |
ble_then.35698:
    li      0, $i15                     # |      1,510 |      1,510 |
.count b_cont
    b       ble_cont.35698              # |      1,510 |      1,510 |
ble_else.35698:
    li      1, $i15                     # |      1,500 |      1,500 |
ble_cont.35698:
    bne     $i14, 0, be_else.35699      # |      3,010 |      3,010 |
be_then.35699:
    mov     $i15, $i14                  # |      3,010 |      3,010 |
.count b_cont
    b       be_cont.35699               # |      3,010 |      3,010 |
be_else.35699:
    bne     $i15, 0, be_else.35700
be_then.35700:
    li      1, $i14
.count b_cont
    b       be_cont.35700
be_else.35700:
    li      0, $i14
be_cont.35700:
be_cont.35699:
    load    [$i11 + 4], $i11            # |      3,010 |      3,010 |
    load    [$i11 + 2], $f1             # |      3,010 |      3,010 |
    mov     $i12, $i11                  # |      3,010 |      3,010 |
    bne     $i14, 0, be_else.35701      # |      3,010 |      3,010 |
be_then.35701:
    fneg    $f1, $f1                    # |      1,510 |      1,510 |
    store   $f1, [$i12 + 4]             # |      1,510 |      1,510 |
    load    [$i13 + 2], $f1             # |      1,510 |      1,510 |
    finv    $f1, $f1                    # |      1,510 |      1,510 |
    store   $f1, [$i12 + 5]             # |      1,510 |      1,510 |
.count b_cont
    b       be_cont.35701               # |      1,510 |      1,510 |
be_else.35701:
    store   $f1, [$i12 + 4]             # |      1,500 |      1,500 |
    load    [$i13 + 2], $f1             # |      1,500 |      1,500 |
    finv    $f1, $f1                    # |      1,500 |      1,500 |
    store   $f1, [$i12 + 5]             # |      1,500 |      1,500 |
be_cont.35701:
be_cont.35697:
.count stack_load
    load    [$sp + 2], $i12             # |      3,010 |      3,010 |
.count storer
    add     $i10, $i12, $tmp            # |      3,010 |      3,010 |
    store   $i11, [$tmp + 0]            # |      3,010 |      3,010 |
    sub     $i12, 1, $i11               # |      3,010 |      3,010 |
    bl      $i11, 0, bge_else.35702     # |      3,010 |      3,010 |
bge_then.35702:
    load    [min_caml_objects + $i11], $i12# |      2,408 |      2,408 |
    load    [$i12 + 1], $i14            # |      2,408 |      2,408 |
.count move_args
    mov     $f0, $f2                    # |      2,408 |      2,408 |
    bne     $i14, 1, be_else.35703      # |      2,408 |      2,408 |
be_then.35703:
    li      6, $i2                      # |        602 |        602 |
    call    min_caml_create_array_float # |        602 |        602 |
.count stack_load
    load    [$sp + 0], $ra              # |        602 |        602 |
.count stack_move
    add     $sp, 3, $sp                 # |        602 |        602 |
    load    [$i13 + 0], $f1             # |        602 |        602 |
    bne     $f1, $f0, be_else.35704     # |        602 |        602 |
be_then.35704:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.35704
be_else.35704:
    load    [$i12 + 6], $i2             # |        602 |        602 |
    bg      $f0, $f1, ble_else.35705    # |        602 |        602 |
ble_then.35705:
    li      0, $i3                      # |        301 |        301 |
.count b_cont
    b       ble_cont.35705              # |        301 |        301 |
ble_else.35705:
    li      1, $i3                      # |        301 |        301 |
ble_cont.35705:
    bne     $i2, 0, be_else.35706       # |        602 |        602 |
be_then.35706:
    mov     $i3, $i2                    # |        602 |        602 |
.count b_cont
    b       be_cont.35706               # |        602 |        602 |
be_else.35706:
    bne     $i3, 0, be_else.35707
be_then.35707:
    li      1, $i2
.count b_cont
    b       be_cont.35707
be_else.35707:
    li      0, $i2
be_cont.35707:
be_cont.35706:
    load    [$i12 + 4], $i3             # |        602 |        602 |
    load    [$i3 + 0], $f1              # |        602 |        602 |
    bne     $i2, 0, be_else.35708       # |        602 |        602 |
be_then.35708:
    fneg    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 0]              # |        301 |        301 |
    load    [$i13 + 0], $f1             # |        301 |        301 |
    finv    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 1]              # |        301 |        301 |
.count b_cont
    b       be_cont.35708               # |        301 |        301 |
be_else.35708:
    store   $f1, [$i1 + 0]              # |        301 |        301 |
    load    [$i13 + 0], $f1             # |        301 |        301 |
    finv    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 1]              # |        301 |        301 |
be_cont.35708:
be_cont.35704:
    load    [$i13 + 1], $f1             # |        602 |        602 |
    bne     $f1, $f0, be_else.35709     # |        602 |        602 |
be_then.35709:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.35709
be_else.35709:
    load    [$i12 + 6], $i2             # |        602 |        602 |
    bg      $f0, $f1, ble_else.35710    # |        602 |        602 |
ble_then.35710:
    li      0, $i3                      # |        301 |        301 |
.count b_cont
    b       ble_cont.35710              # |        301 |        301 |
ble_else.35710:
    li      1, $i3                      # |        301 |        301 |
ble_cont.35710:
    bne     $i2, 0, be_else.35711       # |        602 |        602 |
be_then.35711:
    mov     $i3, $i2                    # |        602 |        602 |
.count b_cont
    b       be_cont.35711               # |        602 |        602 |
be_else.35711:
    bne     $i3, 0, be_else.35712
be_then.35712:
    li      1, $i2
.count b_cont
    b       be_cont.35712
be_else.35712:
    li      0, $i2
be_cont.35712:
be_cont.35711:
    load    [$i12 + 4], $i3             # |        602 |        602 |
    load    [$i3 + 1], $f1              # |        602 |        602 |
    bne     $i2, 0, be_else.35713       # |        602 |        602 |
be_then.35713:
    fneg    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 2]              # |        301 |        301 |
    load    [$i13 + 1], $f1             # |        301 |        301 |
    finv    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 3]              # |        301 |        301 |
.count b_cont
    b       be_cont.35713               # |        301 |        301 |
be_else.35713:
    store   $f1, [$i1 + 2]              # |        301 |        301 |
    load    [$i13 + 1], $f1             # |        301 |        301 |
    finv    $f1, $f1                    # |        301 |        301 |
    store   $f1, [$i1 + 3]              # |        301 |        301 |
be_cont.35713:
be_cont.35709:
    load    [$i13 + 2], $f1             # |        602 |        602 |
    bne     $f1, $f0, be_else.35714     # |        602 |        602 |
be_then.35714:
    store   $f0, [$i1 + 5]
.count storer
    add     $i10, $i11, $tmp
    store   $i1, [$tmp + 0]
    sub     $i11, 1, $i3
.count stack_load
    load    [$sp - 2], $i2
    b       iter_setup_dirvec_constants.2826
be_else.35714:
    load    [$i12 + 6], $i2             # |        602 |        602 |
    load    [$i12 + 4], $i3             # |        602 |        602 |
    bg      $f0, $f1, ble_else.35715    # |        602 |        602 |
ble_then.35715:
    li      0, $i4                      # |        302 |        302 |
.count b_cont
    b       ble_cont.35715              # |        302 |        302 |
ble_else.35715:
    li      1, $i4                      # |        300 |        300 |
ble_cont.35715:
    bne     $i2, 0, be_else.35716       # |        602 |        602 |
be_then.35716:
    mov     $i4, $i2                    # |        602 |        602 |
.count b_cont
    b       be_cont.35716               # |        602 |        602 |
be_else.35716:
    bne     $i4, 0, be_else.35717
be_then.35717:
    li      1, $i2
.count b_cont
    b       be_cont.35717
be_else.35717:
    li      0, $i2
be_cont.35717:
be_cont.35716:
    load    [$i3 + 2], $f1              # |        602 |        602 |
    bne     $i2, 0, be_cont.35718       # |        602 |        602 |
be_then.35718:
    fneg    $f1, $f1                    # |        302 |        302 |
be_cont.35718:
    store   $f1, [$i1 + 4]              # |        602 |        602 |
    load    [$i13 + 2], $f1             # |        602 |        602 |
    finv    $f1, $f1                    # |        602 |        602 |
    store   $f1, [$i1 + 5]              # |        602 |        602 |
.count storer
    add     $i10, $i11, $tmp            # |        602 |        602 |
    store   $i1, [$tmp + 0]             # |        602 |        602 |
    sub     $i11, 1, $i3                # |        602 |        602 |
.count stack_load
    load    [$sp - 2], $i2              # |        602 |        602 |
    b       iter_setup_dirvec_constants.2826# |        602 |        602 |
be_else.35703:
    bne     $i14, 2, be_else.35719      # |      1,806 |      1,806 |
be_then.35719:
    li      4, $i2                      # |        602 |        602 |
    call    min_caml_create_array_float # |        602 |        602 |
.count stack_load
    load    [$sp + 0], $ra              # |        602 |        602 |
.count stack_move
    add     $sp, 3, $sp                 # |        602 |        602 |
    load    [$i12 + 4], $i2             # |        602 |        602 |
    load    [$i12 + 4], $i3             # |        602 |        602 |
    load    [$i12 + 4], $i4             # |        602 |        602 |
    load    [$i13 + 0], $f1             # |        602 |        602 |
    load    [$i2 + 0], $f2              # |        602 |        602 |
    fmul    $f1, $f2, $f1               # |        602 |        602 |
    load    [$i13 + 1], $f2             # |        602 |        602 |
    load    [$i3 + 1], $f3              # |        602 |        602 |
    fmul    $f2, $f3, $f2               # |        602 |        602 |
    fadd    $f1, $f2, $f1               # |        602 |        602 |
    load    [$i13 + 2], $f2             # |        602 |        602 |
    load    [$i4 + 2], $f3              # |        602 |        602 |
    fmul    $f2, $f3, $f2               # |        602 |        602 |
    fadd    $f1, $f2, $f1               # |        602 |        602 |
    sub     $i11, 1, $i3                # |        602 |        602 |
.count storer
    add     $i10, $i11, $tmp            # |        602 |        602 |
    bg      $f1, $f0, ble_else.35720    # |        602 |        602 |
ble_then.35720:
    store   $f0, [$i1 + 0]              # |        301 |        301 |
    store   $i1, [$tmp + 0]             # |        301 |        301 |
.count stack_load
    load    [$sp - 2], $i2              # |        301 |        301 |
    b       iter_setup_dirvec_constants.2826# |        301 |        301 |
ble_else.35720:
    finv    $f1, $f1                    # |        301 |        301 |
    fneg    $f1, $f2                    # |        301 |        301 |
    store   $f2, [$i1 + 0]              # |        301 |        301 |
    load    [$i12 + 4], $i2             # |        301 |        301 |
    load    [$i2 + 0], $f2              # |        301 |        301 |
    fmul_n  $f2, $f1, $f2               # |        301 |        301 |
    store   $f2, [$i1 + 1]              # |        301 |        301 |
    load    [$i12 + 4], $i2             # |        301 |        301 |
    load    [$i2 + 1], $f2              # |        301 |        301 |
    fmul_n  $f2, $f1, $f2               # |        301 |        301 |
    store   $f2, [$i1 + 2]              # |        301 |        301 |
    load    [$i12 + 4], $i2             # |        301 |        301 |
    load    [$i2 + 2], $f2              # |        301 |        301 |
    fmul_n  $f2, $f1, $f1               # |        301 |        301 |
    store   $f1, [$i1 + 3]              # |        301 |        301 |
    store   $i1, [$tmp + 0]             # |        301 |        301 |
.count stack_load
    load    [$sp - 2], $i2              # |        301 |        301 |
    b       iter_setup_dirvec_constants.2826# |        301 |        301 |
be_else.35719:
    li      5, $i2                      # |      1,204 |      1,204 |
    call    min_caml_create_array_float # |      1,204 |      1,204 |
.count stack_load
    load    [$sp + 0], $ra              # |      1,204 |      1,204 |
.count stack_move
    add     $sp, 3, $sp                 # |      1,204 |      1,204 |
    load    [$i12 + 3], $i2             # |      1,204 |      1,204 |
    load    [$i12 + 4], $i3             # |      1,204 |      1,204 |
    load    [$i12 + 4], $i4             # |      1,204 |      1,204 |
    load    [$i12 + 4], $i5             # |      1,204 |      1,204 |
    load    [$i13 + 0], $f1             # |      1,204 |      1,204 |
    load    [$i13 + 1], $f2             # |      1,204 |      1,204 |
    load    [$i13 + 2], $f3             # |      1,204 |      1,204 |
    fmul    $f1, $f1, $f4               # |      1,204 |      1,204 |
    load    [$i3 + 0], $f5              # |      1,204 |      1,204 |
    fmul    $f4, $f5, $f4               # |      1,204 |      1,204 |
    fmul    $f2, $f2, $f5               # |      1,204 |      1,204 |
    load    [$i4 + 1], $f6              # |      1,204 |      1,204 |
    fmul    $f5, $f6, $f5               # |      1,204 |      1,204 |
    fadd    $f4, $f5, $f4               # |      1,204 |      1,204 |
    fmul    $f3, $f3, $f5               # |      1,204 |      1,204 |
    load    [$i5 + 2], $f6              # |      1,204 |      1,204 |
    fmul    $f5, $f6, $f5               # |      1,204 |      1,204 |
    fadd    $f4, $f5, $f4               # |      1,204 |      1,204 |
    bne     $i2, 0, be_else.35721       # |      1,204 |      1,204 |
be_then.35721:
    mov     $f4, $f1                    # |      1,204 |      1,204 |
.count b_cont
    b       be_cont.35721               # |      1,204 |      1,204 |
be_else.35721:
    fmul    $f2, $f3, $f5
    load    [$i12 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i12 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i12 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.35721:
    store   $f1, [$i1 + 0]              # |      1,204 |      1,204 |
    load    [$i12 + 4], $i3             # |      1,204 |      1,204 |
    load    [$i12 + 4], $i4             # |      1,204 |      1,204 |
    load    [$i12 + 4], $i5             # |      1,204 |      1,204 |
    load    [$i13 + 0], $f2             # |      1,204 |      1,204 |
    load    [$i3 + 0], $f3              # |      1,204 |      1,204 |
    fmul    $f2, $f3, $f2               # |      1,204 |      1,204 |
    load    [$i13 + 1], $f3             # |      1,204 |      1,204 |
    load    [$i4 + 1], $f4              # |      1,204 |      1,204 |
    fmul    $f3, $f4, $f4               # |      1,204 |      1,204 |
    load    [$i13 + 2], $f5             # |      1,204 |      1,204 |
    load    [$i5 + 2], $f6              # |      1,204 |      1,204 |
    fmul    $f5, $f6, $f6               # |      1,204 |      1,204 |
    fneg    $f2, $f2                    # |      1,204 |      1,204 |
    fneg    $f4, $f4                    # |      1,204 |      1,204 |
    fneg    $f6, $f6                    # |      1,204 |      1,204 |
.count storer
    add     $i10, $i11, $tmp            # |      1,204 |      1,204 |
    bne     $i2, 0, be_else.35722       # |      1,204 |      1,204 |
be_then.35722:
    store   $f2, [$i1 + 1]              # |      1,204 |      1,204 |
    store   $f4, [$i1 + 2]              # |      1,204 |      1,204 |
    store   $f6, [$i1 + 3]              # |      1,204 |      1,204 |
    sub     $i11, 1, $i3                # |      1,204 |      1,204 |
    bne     $f1, $f0, be_else.35723     # |      1,204 |      1,204 |
be_then.35723:
    store   $i1, [$tmp + 0]
.count stack_load
    load    [$sp - 2], $i2
    b       iter_setup_dirvec_constants.2826
be_else.35723:
    finv    $f1, $f1                    # |      1,204 |      1,204 |
    store   $f1, [$i1 + 4]              # |      1,204 |      1,204 |
    store   $i1, [$tmp + 0]             # |      1,204 |      1,204 |
.count stack_load
    load    [$sp - 2], $i2              # |      1,204 |      1,204 |
    b       iter_setup_dirvec_constants.2826# |      1,204 |      1,204 |
be_else.35722:
    load    [$i12 + 9], $i2
    load    [$i12 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i12 + 9], $i2
    load    [$i13 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i13 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i13 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i13 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    sub     $i11, 1, $i3
    bne     $f1, $f0, be_else.35724
be_then.35724:
    store   $i1, [$tmp + 0]
.count stack_load
    load    [$sp - 2], $i2
    b       iter_setup_dirvec_constants.2826
be_else.35724:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    store   $i1, [$tmp + 0]
.count stack_load
    load    [$sp - 2], $i2
    b       iter_setup_dirvec_constants.2826
bge_else.35702:
.count stack_load
    load    [$sp + 0], $ra              # |        602 |        602 |
.count stack_move
    add     $sp, 3, $sp                 # |        602 |        602 |
    ret                                 # |        602 |        602 |
be_else.35686:
    bne     $i12, 2, be_else.35725      # |      4,365 |      4,365 |
be_then.35725:
    li      4, $i2                      # |        151 |        151 |
    call    min_caml_create_array_float # |        151 |        151 |
.count stack_load
    load    [$sp + 0], $ra              # |        151 |        151 |
.count stack_move
    add     $sp, 3, $sp                 # |        151 |        151 |
    load    [$i11 + 4], $i2             # |        151 |        151 |
    load    [$i11 + 4], $i3             # |        151 |        151 |
    load    [$i11 + 4], $i4             # |        151 |        151 |
    load    [$i13 + 0], $f1             # |        151 |        151 |
    load    [$i2 + 0], $f2              # |        151 |        151 |
    fmul    $f1, $f2, $f1               # |        151 |        151 |
    load    [$i13 + 1], $f2             # |        151 |        151 |
    load    [$i3 + 1], $f3              # |        151 |        151 |
    fmul    $f2, $f3, $f2               # |        151 |        151 |
    fadd    $f1, $f2, $f1               # |        151 |        151 |
    load    [$i13 + 2], $f2             # |        151 |        151 |
    load    [$i4 + 2], $f3              # |        151 |        151 |
    fmul    $f2, $f3, $f2               # |        151 |        151 |
    fadd    $f1, $f2, $f1               # |        151 |        151 |
    bg      $f1, $f0, ble_else.35726    # |        151 |        151 |
ble_then.35726:
    store   $f0, [$i1 + 0]              # |         80 |         80 |
.count stack_load
    load    [$sp - 1], $i2              # |         80 |         80 |
.count storer
    add     $i10, $i2, $tmp             # |         80 |         80 |
    store   $i1, [$tmp + 0]             # |         80 |         80 |
    sub     $i2, 1, $i3                 # |         80 |         80 |
.count stack_load
    load    [$sp - 2], $i2              # |         80 |         80 |
    b       iter_setup_dirvec_constants.2826# |         80 |         80 |
ble_else.35726:
    finv    $f1, $f1                    # |         71 |         71 |
    fneg    $f1, $f2                    # |         71 |         71 |
    store   $f2, [$i1 + 0]              # |         71 |         71 |
    load    [$i11 + 4], $i2             # |         71 |         71 |
    load    [$i2 + 0], $f2              # |         71 |         71 |
    fmul_n  $f2, $f1, $f2               # |         71 |         71 |
    store   $f2, [$i1 + 1]              # |         71 |         71 |
    load    [$i11 + 4], $i2             # |         71 |         71 |
    load    [$i2 + 1], $f2              # |         71 |         71 |
    fmul_n  $f2, $f1, $f2               # |         71 |         71 |
    store   $f2, [$i1 + 2]              # |         71 |         71 |
    load    [$i11 + 4], $i2             # |         71 |         71 |
    load    [$i2 + 2], $f2              # |         71 |         71 |
    fmul_n  $f2, $f1, $f1               # |         71 |         71 |
    store   $f1, [$i1 + 3]              # |         71 |         71 |
.count stack_load
    load    [$sp - 1], $i2              # |         71 |         71 |
.count storer
    add     $i10, $i2, $tmp             # |         71 |         71 |
    store   $i1, [$tmp + 0]             # |         71 |         71 |
    sub     $i2, 1, $i3                 # |         71 |         71 |
.count stack_load
    load    [$sp - 2], $i2              # |         71 |         71 |
    b       iter_setup_dirvec_constants.2826# |         71 |         71 |
be_else.35725:
    li      5, $i2                      # |      4,214 |      4,214 |
    call    min_caml_create_array_float # |      4,214 |      4,214 |
.count stack_load
    load    [$sp + 0], $ra              # |      4,214 |      4,214 |
.count stack_move
    add     $sp, 3, $sp                 # |      4,214 |      4,214 |
    load    [$i11 + 3], $i2             # |      4,214 |      4,214 |
    load    [$i11 + 4], $i3             # |      4,214 |      4,214 |
    load    [$i11 + 4], $i4             # |      4,214 |      4,214 |
    load    [$i11 + 4], $i5             # |      4,214 |      4,214 |
    load    [$i13 + 0], $f1             # |      4,214 |      4,214 |
    load    [$i13 + 1], $f2             # |      4,214 |      4,214 |
    load    [$i13 + 2], $f3             # |      4,214 |      4,214 |
    fmul    $f1, $f1, $f4               # |      4,214 |      4,214 |
    load    [$i3 + 0], $f5              # |      4,214 |      4,214 |
    fmul    $f4, $f5, $f4               # |      4,214 |      4,214 |
    fmul    $f2, $f2, $f5               # |      4,214 |      4,214 |
    load    [$i4 + 1], $f6              # |      4,214 |      4,214 |
    fmul    $f5, $f6, $f5               # |      4,214 |      4,214 |
    fadd    $f4, $f5, $f4               # |      4,214 |      4,214 |
    fmul    $f3, $f3, $f5               # |      4,214 |      4,214 |
    load    [$i5 + 2], $f6              # |      4,214 |      4,214 |
    fmul    $f5, $f6, $f5               # |      4,214 |      4,214 |
    fadd    $f4, $f5, $f4               # |      4,214 |      4,214 |
    bne     $i2, 0, be_else.35727       # |      4,214 |      4,214 |
be_then.35727:
    mov     $f4, $f1                    # |      4,214 |      4,214 |
.count b_cont
    b       be_cont.35727               # |      4,214 |      4,214 |
be_else.35727:
    fmul    $f2, $f3, $f5
    load    [$i11 + 9], $i3
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i11 + 9], $i3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i11 + 9], $i3
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.35727:
    store   $f1, [$i1 + 0]              # |      4,214 |      4,214 |
    load    [$i11 + 4], $i3             # |      4,214 |      4,214 |
    load    [$i11 + 4], $i4             # |      4,214 |      4,214 |
    load    [$i11 + 4], $i5             # |      4,214 |      4,214 |
    load    [$i13 + 0], $f2             # |      4,214 |      4,214 |
    load    [$i3 + 0], $f3              # |      4,214 |      4,214 |
    fmul    $f2, $f3, $f2               # |      4,214 |      4,214 |
    load    [$i13 + 1], $f3             # |      4,214 |      4,214 |
    load    [$i4 + 1], $f4              # |      4,214 |      4,214 |
    fmul    $f3, $f4, $f4               # |      4,214 |      4,214 |
    load    [$i13 + 2], $f5             # |      4,214 |      4,214 |
    load    [$i5 + 2], $f6              # |      4,214 |      4,214 |
    fmul    $f5, $f6, $f6               # |      4,214 |      4,214 |
    fneg    $f2, $f2                    # |      4,214 |      4,214 |
    fneg    $f4, $f4                    # |      4,214 |      4,214 |
    fneg    $f6, $f6                    # |      4,214 |      4,214 |
    bne     $i2, 0, be_else.35728       # |      4,214 |      4,214 |
be_then.35728:
    store   $f2, [$i1 + 1]              # |      4,214 |      4,214 |
    store   $f4, [$i1 + 2]              # |      4,214 |      4,214 |
    store   $f6, [$i1 + 3]              # |      4,214 |      4,214 |
    bne     $f1, $f0, be_else.35729     # |      4,214 |      4,214 |
be_then.35729:
.count stack_load
    load    [$sp - 1], $i2
.count storer
    add     $i10, $i2, $tmp
    store   $i1, [$tmp + 0]
    sub     $i2, 1, $i3
.count stack_load
    load    [$sp - 2], $i2
    b       iter_setup_dirvec_constants.2826
be_else.35729:
    finv    $f1, $f1                    # |      4,214 |      4,214 |
    store   $f1, [$i1 + 4]              # |      4,214 |      4,214 |
.count stack_load
    load    [$sp - 1], $i2              # |      4,214 |      4,214 |
.count storer
    add     $i10, $i2, $tmp             # |      4,214 |      4,214 |
    store   $i1, [$tmp + 0]             # |      4,214 |      4,214 |
    sub     $i2, 1, $i3                 # |      4,214 |      4,214 |
.count stack_load
    load    [$sp - 2], $i2              # |      4,214 |      4,214 |
    b       iter_setup_dirvec_constants.2826# |      4,214 |      4,214 |
be_else.35728:
    load    [$i11 + 9], $i2
    load    [$i11 + 9], $i3
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i3 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc3, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i11 + 9], $i2
    load    [$i13 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i13 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i13 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i13 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.35730
be_then.35730:
.count stack_load
    load    [$sp - 1], $i2
.count storer
    add     $i10, $i2, $tmp
    store   $i1, [$tmp + 0]
    sub     $i2, 1, $i3
.count stack_load
    load    [$sp - 2], $i2
    b       iter_setup_dirvec_constants.2826
be_else.35730:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
.count stack_load
    load    [$sp - 1], $i2
.count storer
    add     $i10, $i2, $tmp
    store   $i1, [$tmp + 0]
    sub     $i2, 1, $i3
.count stack_load
    load    [$sp - 2], $i2
    b       iter_setup_dirvec_constants.2826
bge_else.35685:
    ret
.end iter_setup_dirvec_constants

######################################################################
# setup_startp_constants
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
    bl      $i3, 0, bge_else.35731      # |    667,764 |    667,764 |
bge_then.35731:
    load    [min_caml_objects + $i3], $i1# |    630,666 |    630,666 |
    load    [$i1 + 5], $i4              # |    630,666 |    630,666 |
    load    [$i1 + 10], $i5             # |    630,666 |    630,666 |
    load    [$i2 + 0], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 0], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 0]              # |    630,666 |    630,666 |
    load    [$i1 + 5], $i4              # |    630,666 |    630,666 |
    load    [$i2 + 1], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 1], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 1]              # |    630,666 |    630,666 |
    load    [$i1 + 5], $i4              # |    630,666 |    630,666 |
    load    [$i2 + 2], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 2], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 2]              # |    630,666 |    630,666 |
    load    [$i1 + 1], $i4              # |    630,666 |    630,666 |
    bne     $i4, 2, be_else.35732       # |    630,666 |    630,666 |
be_then.35732:
    load    [$i1 + 4], $i1              # |     74,196 |     74,196 |
    load    [$i5 + 0], $f1              # |     74,196 |     74,196 |
    load    [$i1 + 0], $f2              # |     74,196 |     74,196 |
    fmul    $f2, $f1, $f1               # |     74,196 |     74,196 |
    load    [$i5 + 1], $f2              # |     74,196 |     74,196 |
    load    [$i1 + 1], $f3              # |     74,196 |     74,196 |
    fmul    $f3, $f2, $f2               # |     74,196 |     74,196 |
    fadd    $f1, $f2, $f1               # |     74,196 |     74,196 |
    load    [$i5 + 2], $f2              # |     74,196 |     74,196 |
    load    [$i1 + 2], $f3              # |     74,196 |     74,196 |
    fmul    $f3, $f2, $f2               # |     74,196 |     74,196 |
    fadd    $f1, $f2, $f1               # |     74,196 |     74,196 |
    store   $f1, [$i5 + 3]              # |     74,196 |     74,196 |
    sub     $i3, 1, $i3                 # |     74,196 |     74,196 |
    b       setup_startp_constants.2831 # |     74,196 |     74,196 |
be_else.35732:
    bg      $i4, 2, ble_else.35733      # |    556,470 |    556,470 |
ble_then.35733:
    sub     $i3, 1, $i3                 # |    222,588 |    222,588 |
    b       setup_startp_constants.2831 # |    222,588 |    222,588 |
ble_else.35733:
    load    [$i1 + 4], $i6              # |    333,882 |    333,882 |
    load    [$i1 + 4], $i7              # |    333,882 |    333,882 |
    load    [$i1 + 4], $i8              # |    333,882 |    333,882 |
    load    [$i1 + 3], $i9              # |    333,882 |    333,882 |
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
    bne     $i9, 0, be_else.35734       # |    333,882 |    333,882 |
be_then.35734:
    mov     $f4, $f1                    # |    333,882 |    333,882 |
.count b_cont
    b       be_cont.35734               # |    333,882 |    333,882 |
be_else.35734:
    load    [$i1 + 9], $i6
    load    [$i1 + 9], $i7
    load    [$i1 + 9], $i1
    fmul    $f2, $f3, $f5
    load    [$i6 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i7 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i1 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.35734:
    sub     $i3, 1, $i3                 # |    333,882 |    333,882 |
    bne     $i4, 3, be_else.35735       # |    333,882 |    333,882 |
be_then.35735:
    fsub    $f1, $fc0, $f1              # |    333,882 |    333,882 |
    store   $f1, [$i5 + 3]              # |    333,882 |    333,882 |
    b       setup_startp_constants.2831 # |    333,882 |    333,882 |
be_else.35735:
    store   $f1, [$i5 + 3]
    b       setup_startp_constants.2831
bge_else.35731:
    ret                                 # |     37,098 |     37,098 |
.end setup_startp_constants

######################################################################
# check_all_inside
######################################################################
.begin check_all_inside
check_all_inside.2856:
    load    [$i3 + $i2], $i1            # |  1,716,028 |  1,716,028 |
    bne     $i1, -1, be_else.35736      # |  1,716,028 |  1,716,028 |
be_then.35736:
    li      1, $i1                      # |     22,090 |     22,090 |
    ret                                 # |     22,090 |     22,090 |
be_else.35736:
    load    [min_caml_objects + $i1], $i1# |  1,693,938 |  1,693,938 |
    load    [$i1 + 1], $i4              # |  1,693,938 |  1,693,938 |
    load    [$i1 + 5], $i5              # |  1,693,938 |  1,693,938 |
    load    [$i1 + 5], $i6              # |  1,693,938 |  1,693,938 |
    load    [$i1 + 5], $i7              # |  1,693,938 |  1,693,938 |
    load    [$i5 + 0], $f1              # |  1,693,938 |  1,693,938 |
    fsub    $f2, $f1, $f1               # |  1,693,938 |  1,693,938 |
    load    [$i6 + 1], $f5              # |  1,693,938 |  1,693,938 |
    fsub    $f3, $f5, $f5               # |  1,693,938 |  1,693,938 |
    load    [$i7 + 2], $f6              # |  1,693,938 |  1,693,938 |
    fsub    $f4, $f6, $f6               # |  1,693,938 |  1,693,938 |
    bne     $i4, 1, be_else.35737       # |  1,693,938 |  1,693,938 |
be_then.35737:
    load    [$i1 + 4], $i4              # |    716,909 |    716,909 |
    load    [$i4 + 0], $f7              # |    716,909 |    716,909 |
    fabs    $f1, $f1                    # |    716,909 |    716,909 |
    bg      $f7, $f1, ble_else.35738    # |    716,909 |    716,909 |
ble_then.35738:
    load    [$i1 + 6], $i1              # |    198,344 |    198,344 |
    bne     $i1, 0, be_else.35739       # |    198,344 |    198,344 |
be_then.35739:
    li      1, $i1                      # |    198,344 |    198,344 |
.count b_cont
    b       be_cont.35737               # |    198,344 |    198,344 |
be_else.35739:
    li      0, $i1
.count b_cont
    b       be_cont.35737
ble_else.35738:
    load    [$i1 + 4], $i4              # |    518,565 |    518,565 |
    load    [$i4 + 1], $f1              # |    518,565 |    518,565 |
    fabs    $f5, $f5                    # |    518,565 |    518,565 |
    bg      $f1, $f5, ble_else.35740    # |    518,565 |    518,565 |
ble_then.35740:
    load    [$i1 + 6], $i1              # |     55,268 |     55,268 |
    bne     $i1, 0, be_else.35741       # |     55,268 |     55,268 |
be_then.35741:
    li      1, $i1                      # |     55,268 |     55,268 |
.count b_cont
    b       be_cont.35737               # |     55,268 |     55,268 |
be_else.35741:
    li      0, $i1
.count b_cont
    b       be_cont.35737
ble_else.35740:
    load    [$i1 + 4], $i4              # |    463,297 |    463,297 |
    load    [$i4 + 2], $f1              # |    463,297 |    463,297 |
    fabs    $f6, $f5                    # |    463,297 |    463,297 |
    load    [$i1 + 6], $i1              # |    463,297 |    463,297 |
    bg      $f1, $f5, be_cont.35737     # |    463,297 |    463,297 |
ble_then.35742:
    bne     $i1, 0, be_else.35743       # |     17,085 |     17,085 |
be_then.35743:
    li      1, $i1                      # |     17,085 |     17,085 |
.count b_cont
    b       be_cont.35737               # |     17,085 |     17,085 |
be_else.35743:
    li      0, $i1
.count b_cont
    b       be_cont.35737
be_else.35737:
    bne     $i4, 2, be_else.35744       # |    977,029 |    977,029 |
be_then.35744:
    load    [$i1 + 6], $i4              # |    460,725 |    460,725 |
    load    [$i1 + 4], $i1              # |    460,725 |    460,725 |
    load    [$i1 + 0], $f7              # |    460,725 |    460,725 |
    fmul    $f7, $f1, $f1               # |    460,725 |    460,725 |
    load    [$i1 + 1], $f7              # |    460,725 |    460,725 |
    fmul    $f7, $f5, $f5               # |    460,725 |    460,725 |
    fadd    $f1, $f5, $f1               # |    460,725 |    460,725 |
    load    [$i1 + 2], $f5              # |    460,725 |    460,725 |
    fmul    $f5, $f6, $f5               # |    460,725 |    460,725 |
    fadd    $f1, $f5, $f1               # |    460,725 |    460,725 |
    bg      $f0, $f1, ble_else.35745    # |    460,725 |    460,725 |
ble_then.35745:
    bne     $i4, 0, be_else.35746       # |    460,725 |    460,725 |
be_then.35746:
    li      1, $i1
.count b_cont
    b       be_cont.35744
be_else.35746:
    li      0, $i1                      # |    460,725 |    460,725 |
.count b_cont
    b       be_cont.35744               # |    460,725 |    460,725 |
ble_else.35745:
    bne     $i4, 0, be_else.35747
be_then.35747:
    li      0, $i1
.count b_cont
    b       be_cont.35744
be_else.35747:
    li      1, $i1
.count b_cont
    b       be_cont.35744
be_else.35744:
    load    [$i1 + 6], $i5              # |    516,304 |    516,304 |
    fmul    $f1, $f1, $f7               # |    516,304 |    516,304 |
    load    [$i1 + 4], $i6              # |    516,304 |    516,304 |
    load    [$i6 + 0], $f8              # |    516,304 |    516,304 |
    fmul    $f7, $f8, $f7               # |    516,304 |    516,304 |
    fmul    $f5, $f5, $f8               # |    516,304 |    516,304 |
    load    [$i1 + 4], $i6              # |    516,304 |    516,304 |
    load    [$i6 + 1], $f9              # |    516,304 |    516,304 |
    fmul    $f8, $f9, $f8               # |    516,304 |    516,304 |
    fadd    $f7, $f8, $f7               # |    516,304 |    516,304 |
    fmul    $f6, $f6, $f8               # |    516,304 |    516,304 |
    load    [$i1 + 4], $i6              # |    516,304 |    516,304 |
    load    [$i6 + 2], $f9              # |    516,304 |    516,304 |
    fmul    $f8, $f9, $f8               # |    516,304 |    516,304 |
    fadd    $f7, $f8, $f7               # |    516,304 |    516,304 |
    load    [$i1 + 3], $i6              # |    516,304 |    516,304 |
    bne     $i6, 0, be_else.35748       # |    516,304 |    516,304 |
be_then.35748:
    mov     $f7, $f1                    # |    516,304 |    516,304 |
.count b_cont
    b       be_cont.35748               # |    516,304 |    516,304 |
be_else.35748:
    fmul    $f5, $f6, $f8
    load    [$i1 + 9], $i6
    load    [$i6 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i1 + 9], $i6
    load    [$i6 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i1 + 9], $i1
    load    [$i1 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.35748:
    bne     $i4, 3, be_cont.35749       # |    516,304 |    516,304 |
be_then.35749:
    fsub    $f1, $fc0, $f1              # |    516,304 |    516,304 |
be_cont.35749:
    bg      $f0, $f1, ble_else.35750    # |    516,304 |    516,304 |
ble_then.35750:
    bne     $i5, 0, be_else.35751       # |    184,512 |    184,512 |
be_then.35751:
    li      1, $i1                      # |    184,512 |    184,512 |
.count b_cont
    b       ble_cont.35750              # |    184,512 |    184,512 |
be_else.35751:
    li      0, $i1
.count b_cont
    b       ble_cont.35750
ble_else.35750:
    bne     $i5, 0, be_else.35752       # |    331,792 |    331,792 |
be_then.35752:
    li      0, $i1                      # |    331,792 |    331,792 |
.count b_cont
    b       be_cont.35752               # |    331,792 |    331,792 |
be_else.35752:
    li      1, $i1
be_cont.35752:
ble_cont.35750:
be_cont.35744:
be_cont.35737:
    bne     $i1, 0, be_else.35753       # |  1,693,938 |  1,693,938 |
be_then.35753:
    add     $i2, 1, $i1                 # |  1,238,729 |  1,238,729 |
    load    [$i3 + $i1], $i2            # |  1,238,729 |  1,238,729 |
    bne     $i2, -1, be_else.35754      # |  1,238,729 |  1,238,729 |
be_then.35754:
    li      1, $i1                      # |    596,960 |    596,960 |
    ret                                 # |    596,960 |    596,960 |
be_else.35754:
    load    [min_caml_objects + $i2], $i2# |    641,769 |    641,769 |
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
    bne     $i7, 1, be_else.35755       # |    641,769 |    641,769 |
be_then.35755:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    bg      $f7, $f1, ble_else.35756
ble_then.35756:
    load    [$i2 + 6], $i2
    bne     $i2, 0, be_else.35757
be_then.35757:
    li      1, $i2
.count b_cont
    b       be_cont.35755
be_else.35757:
    li      0, $i2
.count b_cont
    b       be_cont.35755
ble_else.35756:
    load    [$i2 + 4], $i4
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.35758
ble_then.35758:
    load    [$i2 + 6], $i2
    bne     $i2, 0, be_else.35759
be_then.35759:
    li      1, $i2
.count b_cont
    b       be_cont.35755
be_else.35759:
    li      0, $i2
.count b_cont
    b       be_cont.35755
ble_else.35758:
    load    [$i2 + 4], $i4
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    load    [$i2 + 6], $i2
    bg      $f1, $f5, be_cont.35755
ble_then.35760:
    bne     $i2, 0, be_else.35761
be_then.35761:
    li      1, $i2
.count b_cont
    b       be_cont.35755
be_else.35761:
    li      0, $i2
.count b_cont
    b       be_cont.35755
be_else.35755:
    load    [$i2 + 6], $i4              # |    641,769 |    641,769 |
    bne     $i7, 2, be_else.35762       # |    641,769 |    641,769 |
be_then.35762:
    load    [$i2 + 4], $i2              # |     31,829 |     31,829 |
    load    [$i2 + 0], $f7              # |     31,829 |     31,829 |
    fmul    $f7, $f1, $f1               # |     31,829 |     31,829 |
    load    [$i2 + 1], $f7              # |     31,829 |     31,829 |
    fmul    $f7, $f5, $f5               # |     31,829 |     31,829 |
    fadd    $f1, $f5, $f1               # |     31,829 |     31,829 |
    load    [$i2 + 2], $f5              # |     31,829 |     31,829 |
    fmul    $f5, $f6, $f5               # |     31,829 |     31,829 |
    fadd    $f1, $f5, $f1               # |     31,829 |     31,829 |
    bg      $f0, $f1, ble_else.35763    # |     31,829 |     31,829 |
ble_then.35763:
    bne     $i4, 0, be_else.35764       # |     20,422 |     20,422 |
be_then.35764:
    li      1, $i2
.count b_cont
    b       be_cont.35762
be_else.35764:
    li      0, $i2                      # |     20,422 |     20,422 |
.count b_cont
    b       be_cont.35762               # |     20,422 |     20,422 |
ble_else.35763:
    bne     $i4, 0, be_else.35765       # |     11,407 |     11,407 |
be_then.35765:
    li      0, $i2
.count b_cont
    b       be_cont.35762
be_else.35765:
    li      1, $i2                      # |     11,407 |     11,407 |
.count b_cont
    b       be_cont.35762               # |     11,407 |     11,407 |
be_else.35762:
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
    bne     $i9, 0, be_else.35766       # |    609,940 |    609,940 |
be_then.35766:
    mov     $f7, $f1                    # |    609,940 |    609,940 |
.count b_cont
    b       be_cont.35766               # |    609,940 |    609,940 |
be_else.35766:
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
be_cont.35766:
    bne     $i5, 3, be_cont.35767       # |    609,940 |    609,940 |
be_then.35767:
    fsub    $f1, $fc0, $f1              # |    609,940 |    609,940 |
be_cont.35767:
    bg      $f0, $f1, ble_else.35768    # |    609,940 |    609,940 |
ble_then.35768:
    bne     $i4, 0, be_else.35769       # |    299,723 |    299,723 |
be_then.35769:
    li      1, $i2                      # |    108,345 |    108,345 |
.count b_cont
    b       ble_cont.35768              # |    108,345 |    108,345 |
be_else.35769:
    li      0, $i2                      # |    191,378 |    191,378 |
.count b_cont
    b       ble_cont.35768              # |    191,378 |    191,378 |
ble_else.35768:
    bne     $i4, 0, be_else.35770       # |    310,217 |    310,217 |
be_then.35770:
    li      0, $i2                      # |    243,275 |    243,275 |
.count b_cont
    b       be_cont.35770               # |    243,275 |    243,275 |
be_else.35770:
    li      1, $i2                      # |     66,942 |     66,942 |
be_cont.35770:
ble_cont.35768:
be_cont.35762:
be_cont.35755:
    bne     $i2, 0, be_else.35771       # |    641,769 |    641,769 |
be_then.35771:
    add     $i1, 1, $i1                 # |    455,075 |    455,075 |
    load    [$i3 + $i1], $i2            # |    455,075 |    455,075 |
    bne     $i2, -1, be_else.35772      # |    455,075 |    455,075 |
be_then.35772:
    li      1, $i1                      # |    219,472 |    219,472 |
    ret                                 # |    219,472 |    219,472 |
be_else.35772:
    load    [min_caml_objects + $i2], $i2# |    235,603 |    235,603 |
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
    bne     $i4, 1, be_else.35773       # |    235,603 |    235,603 |
be_then.35773:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    bg      $f7, $f1, ble_else.35774
ble_then.35774:
    load    [$i2 + 6], $i2
    bne     $i2, 0, be_else.35775
be_then.35775:
    li      1, $i2
.count b_cont
    b       be_cont.35773
be_else.35775:
    li      0, $i2
.count b_cont
    b       be_cont.35773
ble_else.35774:
    load    [$i2 + 4], $i4
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.35776
ble_then.35776:
    load    [$i2 + 6], $i2
    bne     $i2, 0, be_else.35777
be_then.35777:
    li      1, $i2
.count b_cont
    b       be_cont.35773
be_else.35777:
    li      0, $i2
.count b_cont
    b       be_cont.35773
ble_else.35776:
    load    [$i2 + 4], $i4
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    load    [$i2 + 6], $i2
    bg      $f1, $f5, be_cont.35773
ble_then.35778:
    bne     $i2, 0, be_else.35779
be_then.35779:
    li      1, $i2
.count b_cont
    b       be_cont.35773
be_else.35779:
    li      0, $i2
.count b_cont
    b       be_cont.35773
be_else.35773:
    bne     $i4, 2, be_else.35780       # |    235,603 |    235,603 |
be_then.35780:
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
    bg      $f0, $f1, ble_else.35781    # |     46,306 |     46,306 |
ble_then.35781:
    bne     $i4, 0, be_else.35782       # |     26,044 |     26,044 |
be_then.35782:
    li      1, $i2
.count b_cont
    b       be_cont.35780
be_else.35782:
    li      0, $i2                      # |     26,044 |     26,044 |
.count b_cont
    b       be_cont.35780               # |     26,044 |     26,044 |
ble_else.35781:
    bne     $i4, 0, be_else.35783       # |     20,262 |     20,262 |
be_then.35783:
    li      0, $i2
.count b_cont
    b       be_cont.35780
be_else.35783:
    li      1, $i2                      # |     20,262 |     20,262 |
.count b_cont
    b       be_cont.35780               # |     20,262 |     20,262 |
be_else.35780:
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
    bne     $i6, 0, be_else.35784       # |    189,297 |    189,297 |
be_then.35784:
    mov     $f7, $f1                    # |    189,297 |    189,297 |
.count b_cont
    b       be_cont.35784               # |    189,297 |    189,297 |
be_else.35784:
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
be_cont.35784:
    bne     $i5, 3, be_cont.35785       # |    189,297 |    189,297 |
be_then.35785:
    fsub    $f1, $fc0, $f1              # |    189,297 |    189,297 |
be_cont.35785:
    bg      $f0, $f1, ble_else.35786    # |    189,297 |    189,297 |
ble_then.35786:
    bne     $i4, 0, be_else.35787       # |    153,079 |    153,079 |
be_then.35787:
    li      1, $i2
.count b_cont
    b       ble_cont.35786
be_else.35787:
    li      0, $i2                      # |    153,079 |    153,079 |
.count b_cont
    b       ble_cont.35786              # |    153,079 |    153,079 |
ble_else.35786:
    bne     $i4, 0, be_else.35788       # |     36,218 |     36,218 |
be_then.35788:
    li      0, $i2
.count b_cont
    b       be_cont.35788
be_else.35788:
    li      1, $i2                      # |     36,218 |     36,218 |
be_cont.35788:
ble_cont.35786:
be_cont.35780:
be_cont.35773:
    bne     $i2, 0, be_else.35789       # |    235,603 |    235,603 |
be_then.35789:
    add     $i1, 1, $i1                 # |    179,123 |    179,123 |
    load    [$i3 + $i1], $i2            # |    179,123 |    179,123 |
    bne     $i2, -1, be_else.35790      # |    179,123 |    179,123 |
be_then.35790:
    li      1, $i1                      # |    179,123 |    179,123 |
    ret                                 # |    179,123 |    179,123 |
be_else.35790:
    load    [min_caml_objects + $i2], $i2
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
    bne     $i7, 1, be_else.35791
be_then.35791:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    bg      $f7, $f1, ble_else.35792
ble_then.35792:
    li      0, $i4
.count b_cont
    b       ble_cont.35792
ble_else.35792:
    load    [$i2 + 4], $i4
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.35793
ble_then.35793:
    li      0, $i4
.count b_cont
    b       ble_cont.35793
ble_else.35793:
    load    [$i2 + 4], $i4
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, ble_else.35794
ble_then.35794:
    li      0, $i4
.count b_cont
    b       ble_cont.35794
ble_else.35794:
    li      1, $i4
ble_cont.35794:
ble_cont.35793:
ble_cont.35792:
    load    [$i2 + 6], $i2
    bne     $i4, 0, be_else.35795
be_then.35795:
    bne     $i2, 0, be_else.35796
be_then.35796:
    li      0, $i1
    ret
be_else.35796:
    add     $i1, 1, $i2
    b       check_all_inside.2856
be_else.35795:
    bne     $i2, 0, be_else.35797
be_then.35797:
    add     $i1, 1, $i2
    b       check_all_inside.2856
be_else.35797:
    li      0, $i1
    ret
be_else.35791:
    load    [$i2 + 6], $i4
    bne     $i7, 2, be_else.35798
be_then.35798:
    load    [$i2 + 4], $i2
    load    [$i2 + 0], $f7
    fmul    $f7, $f1, $f1
    load    [$i2 + 1], $f7
    fmul    $f7, $f5, $f5
    fadd    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f5, $f6, $f5
    fadd    $f1, $f5, $f1
    bg      $f0, $f1, ble_else.35799
ble_then.35799:
    bne     $i4, 0, be_else.35800
be_then.35800:
    li      0, $i1
    ret
be_else.35800:
    add     $i1, 1, $i2
    b       check_all_inside.2856
ble_else.35799:
    bne     $i4, 0, be_else.35801
be_then.35801:
    add     $i1, 1, $i2
    b       check_all_inside.2856
be_else.35801:
    li      0, $i1
    ret
be_else.35798:
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
    bne     $i9, 0, be_else.35802
be_then.35802:
    mov     $f7, $f1
.count b_cont
    b       be_cont.35802
be_else.35802:
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
be_cont.35802:
    bne     $i7, 3, be_cont.35803
be_then.35803:
    fsub    $f1, $fc0, $f1
be_cont.35803:
    bg      $f0, $f1, ble_else.35804
ble_then.35804:
    bne     $i4, 0, be_else.35805
be_then.35805:
    li      0, $i1
    ret
be_else.35805:
    add     $i1, 1, $i2
    b       check_all_inside.2856
ble_else.35804:
    bne     $i4, 0, be_else.35806
be_then.35806:
    add     $i1, 1, $i2
    b       check_all_inside.2856
be_else.35806:
    li      0, $i1
    ret
be_else.35789:
    li      0, $i1                      # |     56,480 |     56,480 |
    ret                                 # |     56,480 |     56,480 |
be_else.35771:
    li      0, $i1                      # |    186,694 |    186,694 |
    ret                                 # |    186,694 |    186,694 |
be_else.35753:
    li      0, $i1                      # |    455,209 |    455,209 |
    ret                                 # |    455,209 |    455,209 |
.end check_all_inside

######################################################################
# shadow_check_and_group
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
    load    [$i3 + $i2], $i10           # |  4,222,772 |  4,222,772 |
    bne     $i10, -1, be_else.35807     # |  4,222,772 |  4,222,772 |
be_then.35807:
    li      0, $i1                      # |    627,857 |    627,857 |
    ret                                 # |    627,857 |    627,857 |
be_else.35807:
    load    [min_caml_objects + $i10], $i11# |  3,594,915 |  3,594,915 |
    load    [$i11 + 5], $i12            # |  3,594,915 |  3,594,915 |
    load    [$i11 + 5], $i13            # |  3,594,915 |  3,594,915 |
    load    [$i11 + 5], $i14            # |  3,594,915 |  3,594,915 |
    load    [min_caml_light_dirvec + 1], $i15# |  3,594,915 |  3,594,915 |
    load    [$i11 + 1], $i16            # |  3,594,915 |  3,594,915 |
    load    [min_caml_intersection_point + 0], $f10# |  3,594,915 |  3,594,915 |
    load    [$i12 + 0], $f11            # |  3,594,915 |  3,594,915 |
    fsub    $f10, $f11, $f10            # |  3,594,915 |  3,594,915 |
    load    [min_caml_intersection_point + 1], $f11# |  3,594,915 |  3,594,915 |
    load    [$i13 + 1], $f12            # |  3,594,915 |  3,594,915 |
    fsub    $f11, $f12, $f11            # |  3,594,915 |  3,594,915 |
    load    [min_caml_intersection_point + 2], $f12# |  3,594,915 |  3,594,915 |
    load    [$i14 + 2], $f13            # |  3,594,915 |  3,594,915 |
    fsub    $f12, $f13, $f12            # |  3,594,915 |  3,594,915 |
    load    [$i15 + $i10], $i12         # |  3,594,915 |  3,594,915 |
    bne     $i16, 1, be_else.35808      # |  3,594,915 |  3,594,915 |
be_then.35808:
    load    [min_caml_light_dirvec + 0], $i13# |  1,409,409 |  1,409,409 |
    load    [$i11 + 4], $i14            # |  1,409,409 |  1,409,409 |
    load    [$i14 + 1], $f13            # |  1,409,409 |  1,409,409 |
    load    [$i13 + 1], $f14            # |  1,409,409 |  1,409,409 |
    load    [$i12 + 0], $f15            # |  1,409,409 |  1,409,409 |
    fsub    $f15, $f10, $f15            # |  1,409,409 |  1,409,409 |
    load    [$i12 + 1], $f16            # |  1,409,409 |  1,409,409 |
    fmul    $f15, $f16, $f15            # |  1,409,409 |  1,409,409 |
    fmul    $f15, $f14, $f14            # |  1,409,409 |  1,409,409 |
    fadd_a  $f14, $f11, $f14            # |  1,409,409 |  1,409,409 |
    bg      $f13, $f14, ble_else.35809  # |  1,409,409 |  1,409,409 |
ble_then.35809:
    li      0, $i14                     # |    998,347 |    998,347 |
.count b_cont
    b       ble_cont.35809              # |    998,347 |    998,347 |
ble_else.35809:
    load    [$i11 + 4], $i14            # |    411,062 |    411,062 |
    load    [$i14 + 2], $f13            # |    411,062 |    411,062 |
    load    [$i13 + 2], $f14            # |    411,062 |    411,062 |
    fmul    $f15, $f14, $f14            # |    411,062 |    411,062 |
    fadd_a  $f14, $f12, $f14            # |    411,062 |    411,062 |
    bg      $f13, $f14, ble_else.35810  # |    411,062 |    411,062 |
ble_then.35810:
    li      0, $i14                     # |    136,251 |    136,251 |
.count b_cont
    b       ble_cont.35810              # |    136,251 |    136,251 |
ble_else.35810:
    load    [$i12 + 1], $f13            # |    274,811 |    274,811 |
    bne     $f13, $f0, be_else.35811    # |    274,811 |    274,811 |
be_then.35811:
    li      0, $i14
.count b_cont
    b       be_cont.35811
be_else.35811:
    li      1, $i14                     # |    274,811 |    274,811 |
be_cont.35811:
ble_cont.35810:
ble_cont.35809:
    bne     $i14, 0, be_else.35812      # |  1,409,409 |  1,409,409 |
be_then.35812:
    load    [$i11 + 4], $i14            # |  1,134,598 |  1,134,598 |
    load    [$i14 + 0], $f13            # |  1,134,598 |  1,134,598 |
    load    [$i13 + 0], $f14            # |  1,134,598 |  1,134,598 |
    load    [$i12 + 2], $f15            # |  1,134,598 |  1,134,598 |
    fsub    $f15, $f11, $f15            # |  1,134,598 |  1,134,598 |
    load    [$i12 + 3], $f16            # |  1,134,598 |  1,134,598 |
    fmul    $f15, $f16, $f15            # |  1,134,598 |  1,134,598 |
    fmul    $f15, $f14, $f14            # |  1,134,598 |  1,134,598 |
    fadd_a  $f14, $f10, $f14            # |  1,134,598 |  1,134,598 |
    bg      $f13, $f14, ble_else.35813  # |  1,134,598 |  1,134,598 |
ble_then.35813:
    li      0, $i14                     # |    632,414 |    632,414 |
.count b_cont
    b       ble_cont.35813              # |    632,414 |    632,414 |
ble_else.35813:
    load    [$i11 + 4], $i14            # |    502,184 |    502,184 |
    load    [$i14 + 2], $f13            # |    502,184 |    502,184 |
    load    [$i13 + 2], $f14            # |    502,184 |    502,184 |
    fmul    $f15, $f14, $f14            # |    502,184 |    502,184 |
    fadd_a  $f14, $f12, $f14            # |    502,184 |    502,184 |
    bg      $f13, $f14, ble_else.35814  # |    502,184 |    502,184 |
ble_then.35814:
    li      0, $i14                     # |    138,902 |    138,902 |
.count b_cont
    b       ble_cont.35814              # |    138,902 |    138,902 |
ble_else.35814:
    load    [$i12 + 3], $f13            # |    363,282 |    363,282 |
    bne     $f13, $f0, be_else.35815    # |    363,282 |    363,282 |
be_then.35815:
    li      0, $i14
.count b_cont
    b       be_cont.35815
be_else.35815:
    li      1, $i14                     # |    363,282 |    363,282 |
be_cont.35815:
ble_cont.35814:
ble_cont.35813:
    bne     $i14, 0, be_else.35816      # |  1,134,598 |  1,134,598 |
be_then.35816:
    load    [$i11 + 4], $i14            # |    771,316 |    771,316 |
    load    [$i14 + 0], $f13            # |    771,316 |    771,316 |
    load    [$i13 + 0], $f14            # |    771,316 |    771,316 |
    load    [$i12 + 4], $f15            # |    771,316 |    771,316 |
    fsub    $f15, $f12, $f12            # |    771,316 |    771,316 |
    load    [$i12 + 5], $f15            # |    771,316 |    771,316 |
    fmul    $f12, $f15, $f12            # |    771,316 |    771,316 |
    fmul    $f12, $f14, $f14            # |    771,316 |    771,316 |
    fadd_a  $f14, $f10, $f10            # |    771,316 |    771,316 |
    bg      $f13, $f10, ble_else.35817  # |    771,316 |    771,316 |
ble_then.35817:
    li      0, $i11                     # |    642,019 |    642,019 |
.count b_cont
    b       be_cont.35808               # |    642,019 |    642,019 |
ble_else.35817:
    load    [$i11 + 4], $i11            # |    129,297 |    129,297 |
    load    [$i11 + 1], $f10            # |    129,297 |    129,297 |
    load    [$i13 + 1], $f13            # |    129,297 |    129,297 |
    fmul    $f12, $f13, $f13            # |    129,297 |    129,297 |
    fadd_a  $f13, $f11, $f11            # |    129,297 |    129,297 |
    bg      $f10, $f11, ble_else.35818  # |    129,297 |    129,297 |
ble_then.35818:
    li      0, $i11                     # |     78,455 |     78,455 |
.count b_cont
    b       be_cont.35808               # |     78,455 |     78,455 |
ble_else.35818:
    load    [$i12 + 5], $f10            # |     50,842 |     50,842 |
    bne     $f10, $f0, be_else.35819    # |     50,842 |     50,842 |
be_then.35819:
    li      0, $i11
.count b_cont
    b       be_cont.35808
be_else.35819:
    mov     $f12, $fg0                  # |     50,842 |     50,842 |
    li      3, $i11                     # |     50,842 |     50,842 |
.count b_cont
    b       be_cont.35808               # |     50,842 |     50,842 |
be_else.35816:
    mov     $f15, $fg0                  # |    363,282 |    363,282 |
    li      2, $i11                     # |    363,282 |    363,282 |
.count b_cont
    b       be_cont.35808               # |    363,282 |    363,282 |
be_else.35812:
    mov     $f15, $fg0                  # |    274,811 |    274,811 |
    li      1, $i11                     # |    274,811 |    274,811 |
.count b_cont
    b       be_cont.35808               # |    274,811 |    274,811 |
be_else.35808:
    load    [$i12 + 0], $f13            # |  2,185,506 |  2,185,506 |
    bne     $i16, 2, be_else.35820      # |  2,185,506 |  2,185,506 |
be_then.35820:
    bg      $f0, $f13, ble_else.35821   # |    566,355 |    566,355 |
ble_then.35821:
    li      0, $i11                     # |     11,416 |     11,416 |
.count b_cont
    b       be_cont.35820               # |     11,416 |     11,416 |
ble_else.35821:
    load    [$i12 + 1], $f13            # |    554,939 |    554,939 |
    fmul    $f13, $f10, $f10            # |    554,939 |    554,939 |
    load    [$i12 + 2], $f13            # |    554,939 |    554,939 |
    fmul    $f13, $f11, $f11            # |    554,939 |    554,939 |
    fadd    $f10, $f11, $f10            # |    554,939 |    554,939 |
    load    [$i12 + 3], $f11            # |    554,939 |    554,939 |
    fmul    $f11, $f12, $f11            # |    554,939 |    554,939 |
    fadd    $f10, $f11, $fg0            # |    554,939 |    554,939 |
    li      1, $i11                     # |    554,939 |    554,939 |
.count b_cont
    b       be_cont.35820               # |    554,939 |    554,939 |
be_else.35820:
    bne     $f13, $f0, be_else.35822    # |  1,619,151 |  1,619,151 |
be_then.35822:
    li      0, $i11
.count b_cont
    b       be_cont.35822
be_else.35822:
    load    [$i12 + 1], $f14            # |  1,619,151 |  1,619,151 |
    fmul    $f14, $f10, $f14            # |  1,619,151 |  1,619,151 |
    load    [$i12 + 2], $f15            # |  1,619,151 |  1,619,151 |
    fmul    $f15, $f11, $f15            # |  1,619,151 |  1,619,151 |
    fadd    $f14, $f15, $f14            # |  1,619,151 |  1,619,151 |
    load    [$i12 + 3], $f15            # |  1,619,151 |  1,619,151 |
    fmul    $f15, $f12, $f15            # |  1,619,151 |  1,619,151 |
    fadd    $f14, $f15, $f14            # |  1,619,151 |  1,619,151 |
    fmul    $f14, $f14, $f15            # |  1,619,151 |  1,619,151 |
    fmul    $f10, $f10, $f16            # |  1,619,151 |  1,619,151 |
    load    [$i11 + 4], $i13            # |  1,619,151 |  1,619,151 |
    load    [$i13 + 0], $f17            # |  1,619,151 |  1,619,151 |
    fmul    $f16, $f17, $f16            # |  1,619,151 |  1,619,151 |
    fmul    $f11, $f11, $f17            # |  1,619,151 |  1,619,151 |
    load    [$i11 + 4], $i13            # |  1,619,151 |  1,619,151 |
    load    [$i13 + 1], $f18            # |  1,619,151 |  1,619,151 |
    fmul    $f17, $f18, $f17            # |  1,619,151 |  1,619,151 |
    fadd    $f16, $f17, $f16            # |  1,619,151 |  1,619,151 |
    fmul    $f12, $f12, $f17            # |  1,619,151 |  1,619,151 |
    load    [$i11 + 4], $i13            # |  1,619,151 |  1,619,151 |
    load    [$i13 + 2], $f18            # |  1,619,151 |  1,619,151 |
    fmul    $f17, $f18, $f17            # |  1,619,151 |  1,619,151 |
    fadd    $f16, $f17, $f16            # |  1,619,151 |  1,619,151 |
    load    [$i11 + 3], $i13            # |  1,619,151 |  1,619,151 |
    bne     $i13, 0, be_else.35823      # |  1,619,151 |  1,619,151 |
be_then.35823:
    mov     $f16, $f10                  # |  1,619,151 |  1,619,151 |
.count b_cont
    b       be_cont.35823               # |  1,619,151 |  1,619,151 |
be_else.35823:
    fmul    $f11, $f12, $f17
    load    [$i11 + 9], $i13
    load    [$i13 + 0], $f18
    fmul    $f17, $f18, $f17
    fadd    $f16, $f17, $f16
    fmul    $f12, $f10, $f12
    load    [$i11 + 9], $i13
    load    [$i13 + 1], $f17
    fmul    $f12, $f17, $f12
    fadd    $f16, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i11 + 9], $i13
    load    [$i13 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.35823:
    bne     $i16, 3, be_cont.35824      # |  1,619,151 |  1,619,151 |
be_then.35824:
    fsub    $f10, $fc0, $f10            # |  1,619,151 |  1,619,151 |
be_cont.35824:
    fmul    $f13, $f10, $f10            # |  1,619,151 |  1,619,151 |
    fsub    $f15, $f10, $f10            # |  1,619,151 |  1,619,151 |
    bg      $f10, $f0, ble_else.35825   # |  1,619,151 |  1,619,151 |
ble_then.35825:
    li      0, $i11                     # |  1,270,619 |  1,270,619 |
.count b_cont
    b       ble_cont.35825              # |  1,270,619 |  1,270,619 |
ble_else.35825:
    load    [$i11 + 6], $i11            # |    348,532 |    348,532 |
    load    [$i12 + 4], $f11            # |    348,532 |    348,532 |
    fsqrt   $f10, $f10                  # |    348,532 |    348,532 |
    bne     $i11, 0, be_else.35826      # |    348,532 |    348,532 |
be_then.35826:
    fsub    $f14, $f10, $f10            # |    278,489 |    278,489 |
    fmul    $f10, $f11, $fg0            # |    278,489 |    278,489 |
    li      1, $i11                     # |    278,489 |    278,489 |
.count b_cont
    b       be_cont.35826               # |    278,489 |    278,489 |
be_else.35826:
    fadd    $f14, $f10, $f10            # |     70,043 |     70,043 |
    fmul    $f10, $f11, $fg0            # |     70,043 |     70,043 |
    li      1, $i11                     # |     70,043 |     70,043 |
be_cont.35826:
ble_cont.35825:
be_cont.35822:
be_cont.35820:
be_cont.35808:
    bne     $i11, 0, be_else.35827      # |  3,594,915 |  3,594,915 |
be_then.35827:
    li      0, $i11                     # |  2,002,509 |  2,002,509 |
.count b_cont
    b       be_cont.35827               # |  2,002,509 |  2,002,509 |
be_else.35827:
.count load_float
    load    [f.31952], $f10             # |  1,592,406 |  1,592,406 |
    bg      $f10, $fg0, ble_else.35828  # |  1,592,406 |  1,592,406 |
ble_then.35828:
    li      0, $i11                     # |  1,029,338 |  1,029,338 |
.count b_cont
    b       ble_cont.35828              # |  1,029,338 |  1,029,338 |
ble_else.35828:
    li      1, $i11                     # |    563,068 |    563,068 |
ble_cont.35828:
be_cont.35827:
    bne     $i11, 0, be_else.35829      # |  3,594,915 |  3,594,915 |
be_then.35829:
    load    [min_caml_objects + $i10], $i1# |  3,031,847 |  3,031,847 |
    load    [$i1 + 6], $i1              # |  3,031,847 |  3,031,847 |
    bne     $i1, 0, be_else.35830       # |  3,031,847 |  3,031,847 |
be_then.35830:
    li      0, $i1                      # |  2,406,042 |  2,406,042 |
    ret                                 # |  2,406,042 |  2,406,042 |
be_else.35830:
    add     $i2, 1, $i2                 # |    625,805 |    625,805 |
    b       shadow_check_and_group.2862 # |    625,805 |    625,805 |
be_else.35829:
    load    [$i3 + 0], $i10             # |    563,068 |    563,068 |
    bne     $i10, -1, be_else.35831     # |    563,068 |    563,068 |
be_then.35831:
    li      1, $i1
    ret
be_else.35831:
    load    [min_caml_objects + $i10], $i10# |    563,068 |    563,068 |
    load    [$i10 + 5], $i11            # |    563,068 |    563,068 |
    load    [$i10 + 5], $i12            # |    563,068 |    563,068 |
    load    [$i10 + 5], $i13            # |    563,068 |    563,068 |
    load    [$i10 + 1], $i14            # |    563,068 |    563,068 |
    load    [$i11 + 0], $f10            # |    563,068 |    563,068 |
    fadd    $fg0, $fc16, $f11           # |    563,068 |    563,068 |
    fmul    $fg12, $f11, $f12           # |    563,068 |    563,068 |
    load    [min_caml_intersection_point + 0], $f13# |    563,068 |    563,068 |
    fadd    $f12, $f13, $f2             # |    563,068 |    563,068 |
    fsub    $f2, $f10, $f10             # |    563,068 |    563,068 |
    load    [$i12 + 1], $f12            # |    563,068 |    563,068 |
    fmul    $fg13, $f11, $f13           # |    563,068 |    563,068 |
    load    [min_caml_intersection_point + 1], $f14# |    563,068 |    563,068 |
    fadd    $f13, $f14, $f3             # |    563,068 |    563,068 |
    fsub    $f3, $f12, $f12             # |    563,068 |    563,068 |
    load    [$i13 + 2], $f13            # |    563,068 |    563,068 |
    fmul    $fg14, $f11, $f11           # |    563,068 |    563,068 |
    load    [min_caml_intersection_point + 2], $f14# |    563,068 |    563,068 |
    fadd    $f11, $f14, $f4             # |    563,068 |    563,068 |
    fsub    $f4, $f13, $f11             # |    563,068 |    563,068 |
    bne     $i14, 1, be_else.35832      # |    563,068 |    563,068 |
be_then.35832:
    load    [$i10 + 4], $i11            # |    541,392 |    541,392 |
    load    [$i11 + 0], $f13            # |    541,392 |    541,392 |
    fabs    $f10, $f10                  # |    541,392 |    541,392 |
    bg      $f13, $f10, ble_else.35833  # |    541,392 |    541,392 |
ble_then.35833:
    load    [$i10 + 6], $i10            # |     56,355 |     56,355 |
    bne     $i10, 0, be_else.35834      # |     56,355 |     56,355 |
be_then.35834:
    li      1, $i10                     # |     56,355 |     56,355 |
.count b_cont
    b       be_cont.35832               # |     56,355 |     56,355 |
be_else.35834:
    li      0, $i10
.count b_cont
    b       be_cont.35832
ble_else.35833:
    load    [$i10 + 4], $i11            # |    485,037 |    485,037 |
    load    [$i11 + 1], $f10            # |    485,037 |    485,037 |
    fabs    $f12, $f12                  # |    485,037 |    485,037 |
    bg      $f10, $f12, ble_else.35835  # |    485,037 |    485,037 |
ble_then.35835:
    load    [$i10 + 6], $i10            # |      5,586 |      5,586 |
    bne     $i10, 0, be_else.35836      # |      5,586 |      5,586 |
be_then.35836:
    li      1, $i10                     # |      5,586 |      5,586 |
.count b_cont
    b       be_cont.35832               # |      5,586 |      5,586 |
be_else.35836:
    li      0, $i10
.count b_cont
    b       be_cont.35832
ble_else.35835:
    load    [$i10 + 4], $i11            # |    479,451 |    479,451 |
    load    [$i11 + 2], $f10            # |    479,451 |    479,451 |
    fabs    $f11, $f11                  # |    479,451 |    479,451 |
    load    [$i10 + 6], $i10            # |    479,451 |    479,451 |
    bg      $f10, $f11, be_cont.35832   # |    479,451 |    479,451 |
ble_then.35837:
    bne     $i10, 0, be_else.35838      # |      2,205 |      2,205 |
be_then.35838:
    li      1, $i10                     # |      2,205 |      2,205 |
.count b_cont
    b       be_cont.35832               # |      2,205 |      2,205 |
be_else.35838:
    li      0, $i10
.count b_cont
    b       be_cont.35832
be_else.35832:
    load    [$i10 + 6], $i11            # |     21,676 |     21,676 |
    bne     $i14, 2, be_else.35839      # |     21,676 |     21,676 |
be_then.35839:
    load    [$i10 + 4], $i10
    load    [$i10 + 0], $f13
    fmul    $f13, $f10, $f10
    load    [$i10 + 1], $f13
    fmul    $f13, $f12, $f12
    fadd    $f10, $f12, $f10
    load    [$i10 + 2], $f12
    fmul    $f12, $f11, $f11
    fadd    $f10, $f11, $f10
    bg      $f0, $f10, ble_else.35840
ble_then.35840:
    bne     $i11, 0, be_else.35841
be_then.35841:
    li      1, $i10
.count b_cont
    b       be_cont.35839
be_else.35841:
    li      0, $i10
.count b_cont
    b       be_cont.35839
ble_else.35840:
    bne     $i11, 0, be_else.35842
be_then.35842:
    li      0, $i10
.count b_cont
    b       be_cont.35839
be_else.35842:
    li      1, $i10
.count b_cont
    b       be_cont.35839
be_else.35839:
    fmul    $f10, $f10, $f13            # |     21,676 |     21,676 |
    load    [$i10 + 4], $i12            # |     21,676 |     21,676 |
    load    [$i12 + 0], $f14            # |     21,676 |     21,676 |
    fmul    $f13, $f14, $f13            # |     21,676 |     21,676 |
    fmul    $f12, $f12, $f14            # |     21,676 |     21,676 |
    load    [$i10 + 4], $i12            # |     21,676 |     21,676 |
    load    [$i12 + 1], $f15            # |     21,676 |     21,676 |
    fmul    $f14, $f15, $f14            # |     21,676 |     21,676 |
    fadd    $f13, $f14, $f13            # |     21,676 |     21,676 |
    fmul    $f11, $f11, $f14            # |     21,676 |     21,676 |
    load    [$i10 + 4], $i12            # |     21,676 |     21,676 |
    load    [$i12 + 2], $f15            # |     21,676 |     21,676 |
    fmul    $f14, $f15, $f14            # |     21,676 |     21,676 |
    load    [$i10 + 3], $i12            # |     21,676 |     21,676 |
    fadd    $f13, $f14, $f13            # |     21,676 |     21,676 |
    bne     $i12, 0, be_else.35843      # |     21,676 |     21,676 |
be_then.35843:
    mov     $f13, $f10                  # |     21,676 |     21,676 |
.count b_cont
    b       be_cont.35843               # |     21,676 |     21,676 |
be_else.35843:
    fmul    $f12, $f11, $f14
    load    [$i10 + 9], $i12
    load    [$i12 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f11, $f10, $f11
    load    [$i10 + 9], $i12
    load    [$i12 + 1], $f14
    fmul    $f11, $f14, $f11
    fadd    $f13, $f11, $f11
    fmul    $f10, $f12, $f10
    load    [$i10 + 9], $i10
    load    [$i10 + 2], $f12
    fmul    $f10, $f12, $f10
    fadd    $f11, $f10, $f10
be_cont.35843:
    bne     $i14, 3, be_cont.35844      # |     21,676 |     21,676 |
be_then.35844:
    fsub    $f10, $fc0, $f10            # |     21,676 |     21,676 |
be_cont.35844:
    bg      $f0, $f10, ble_else.35845   # |     21,676 |     21,676 |
ble_then.35845:
    bne     $i11, 0, be_else.35846
be_then.35846:
    li      1, $i10
.count b_cont
    b       ble_cont.35845
be_else.35846:
    li      0, $i10
.count b_cont
    b       ble_cont.35845
ble_else.35845:
    bne     $i11, 0, be_else.35847      # |     21,676 |     21,676 |
be_then.35847:
    li      0, $i10                     # |     21,676 |     21,676 |
.count b_cont
    b       be_cont.35847               # |     21,676 |     21,676 |
be_else.35847:
    li      1, $i10
be_cont.35847:
ble_cont.35845:
be_cont.35839:
be_cont.35832:
    bne     $i10, 0, be_else.35848      # |    563,068 |    563,068 |
be_then.35848:
.count stack_move
    sub     $sp, 3, $sp                 # |    498,922 |    498,922 |
.count stack_store
    store   $ra, [$sp + 0]              # |    498,922 |    498,922 |
.count stack_store
    store   $i3, [$sp + 1]              # |    498,922 |    498,922 |
.count stack_store
    store   $i2, [$sp + 2]              # |    498,922 |    498,922 |
    li      1, $i2                      # |    498,922 |    498,922 |
    call    check_all_inside.2856       # |    498,922 |    498,922 |
.count stack_load
    load    [$sp + 0], $ra              # |    498,922 |    498,922 |
.count stack_move
    add     $sp, 3, $sp                 # |    498,922 |    498,922 |
    bne     $i1, 0, be_else.35849       # |    498,922 |    498,922 |
be_then.35849:
.count stack_load
    load    [$sp - 1], $i1              # |    262,860 |    262,860 |
    add     $i1, 1, $i2                 # |    262,860 |    262,860 |
.count stack_load
    load    [$sp - 2], $i3              # |    262,860 |    262,860 |
    b       shadow_check_and_group.2862 # |    262,860 |    262,860 |
be_else.35849:
    li      1, $i1                      # |    236,062 |    236,062 |
    ret                                 # |    236,062 |    236,062 |
be_else.35848:
    add     $i2, 1, $i2                 # |     64,146 |     64,146 |
    b       shadow_check_and_group.2862 # |     64,146 |     64,146 |
.end shadow_check_and_group

######################################################################
# shadow_check_one_or_group
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
    load    [$i3 + $i2], $i17           # |    223,481 |    223,481 |
    bne     $i17, -1, be_else.35850     # |    223,481 |    223,481 |
be_then.35850:
    li      0, $i1
    ret
be_else.35850:
.count stack_move
    sub     $sp, 3, $sp                 # |    223,481 |    223,481 |
.count stack_store
    store   $ra, [$sp + 0]              # |    223,481 |    223,481 |
.count stack_store
    store   $i3, [$sp + 1]              # |    223,481 |    223,481 |
.count stack_store
    store   $i2, [$sp + 2]              # |    223,481 |    223,481 |
    li      0, $i2                      # |    223,481 |    223,481 |
    load    [min_caml_and_net + $i17], $i3# |    223,481 |    223,481 |
    call    shadow_check_and_group.2862 # |    223,481 |    223,481 |
.count move_ret
    mov     $i1, $i17                   # |    223,481 |    223,481 |
    bne     $i17, 0, be_else.35851      # |    223,481 |    223,481 |
be_then.35851:
.count stack_load
    load    [$sp + 2], $i17             # |    113,403 |    113,403 |
    add     $i17, 1, $i17               # |    113,403 |    113,403 |
.count stack_load
    load    [$sp + 1], $i18             # |    113,403 |    113,403 |
    load    [$i18 + $i17], $i19         # |    113,403 |    113,403 |
    bne     $i19, -1, be_else.35852     # |    113,403 |    113,403 |
be_then.35852:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    li      0, $i1
    ret
be_else.35852:
    li      0, $i2                      # |    113,403 |    113,403 |
    load    [min_caml_and_net + $i19], $i3# |    113,403 |    113,403 |
    call    shadow_check_and_group.2862 # |    113,403 |    113,403 |
.count move_ret
    mov     $i1, $i19                   # |    113,403 |    113,403 |
    bne     $i19, 0, be_else.35853      # |    113,403 |    113,403 |
be_then.35853:
    add     $i17, 1, $i17               # |    106,755 |    106,755 |
    load    [$i18 + $i17], $i19         # |    106,755 |    106,755 |
    bne     $i19, -1, be_else.35854     # |    106,755 |    106,755 |
be_then.35854:
.count stack_load
    load    [$sp + 0], $ra              # |     10,334 |     10,334 |
.count stack_move
    add     $sp, 3, $sp                 # |     10,334 |     10,334 |
    li      0, $i1                      # |     10,334 |     10,334 |
    ret                                 # |     10,334 |     10,334 |
be_else.35854:
    li      0, $i2                      # |     96,421 |     96,421 |
    load    [min_caml_and_net + $i19], $i3# |     96,421 |     96,421 |
    call    shadow_check_and_group.2862 # |     96,421 |     96,421 |
.count move_ret
    mov     $i1, $i19                   # |     96,421 |     96,421 |
    bne     $i19, 0, be_else.35855      # |     96,421 |     96,421 |
be_then.35855:
    add     $i17, 1, $i17               # |     94,249 |     94,249 |
    load    [$i18 + $i17], $i19         # |     94,249 |     94,249 |
    bne     $i19, -1, be_else.35856     # |     94,249 |     94,249 |
be_then.35856:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    li      0, $i1
    ret
be_else.35856:
    li      0, $i2                      # |     94,249 |     94,249 |
    load    [min_caml_and_net + $i19], $i3# |     94,249 |     94,249 |
    call    shadow_check_and_group.2862 # |     94,249 |     94,249 |
.count move_ret
    mov     $i1, $i19                   # |     94,249 |     94,249 |
    bne     $i19, 0, be_else.35857      # |     94,249 |     94,249 |
be_then.35857:
    add     $i17, 1, $i17               # |     82,757 |     82,757 |
    load    [$i18 + $i17], $i19         # |     82,757 |     82,757 |
    bne     $i19, -1, be_else.35858     # |     82,757 |     82,757 |
be_then.35858:
.count stack_load
    load    [$sp + 0], $ra              # |     82,757 |     82,757 |
.count stack_move
    add     $sp, 3, $sp                 # |     82,757 |     82,757 |
    li      0, $i1                      # |     82,757 |     82,757 |
    ret                                 # |     82,757 |     82,757 |
be_else.35858:
    li      0, $i2
    load    [min_caml_and_net + $i19], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i19
    bne     $i19, 0, be_else.35859
be_then.35859:
    add     $i17, 1, $i17
    load    [$i18 + $i17], $i19
    bne     $i19, -1, be_else.35860
be_then.35860:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    li      0, $i1
    ret
be_else.35860:
    li      0, $i2
    load    [min_caml_and_net + $i19], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i19
    bne     $i19, 0, be_else.35861
be_then.35861:
    add     $i17, 1, $i17
    load    [$i18 + $i17], $i19
    bne     $i19, -1, be_else.35862
be_then.35862:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    li      0, $i1
    ret
be_else.35862:
    li      0, $i2
    load    [min_caml_and_net + $i19], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i19
    bne     $i19, 0, be_else.35863
be_then.35863:
    add     $i17, 1, $i17
    load    [$i18 + $i17], $i19
    bne     $i19, -1, be_else.35864
be_then.35864:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    li      0, $i1
    ret
be_else.35864:
    li      0, $i2
    load    [min_caml_and_net + $i19], $i3
    call    shadow_check_and_group.2862
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    bne     $i1, 0, be_else.35865
be_then.35865:
    add     $i17, 1, $i2
.count move_args
    mov     $i18, $i3
    b       shadow_check_one_or_group.2865
be_else.35865:
    li      1, $i1
    ret
be_else.35863:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    li      1, $i1
    ret
be_else.35861:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    li      1, $i1
    ret
be_else.35859:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    li      1, $i1
    ret
be_else.35857:
.count stack_load
    load    [$sp + 0], $ra              # |     11,492 |     11,492 |
.count stack_move
    add     $sp, 3, $sp                 # |     11,492 |     11,492 |
    li      1, $i1                      # |     11,492 |     11,492 |
    ret                                 # |     11,492 |     11,492 |
be_else.35855:
.count stack_load
    load    [$sp + 0], $ra              # |      2,172 |      2,172 |
.count stack_move
    add     $sp, 3, $sp                 # |      2,172 |      2,172 |
    li      1, $i1                      # |      2,172 |      2,172 |
    ret                                 # |      2,172 |      2,172 |
be_else.35853:
.count stack_load
    load    [$sp + 0], $ra              # |      6,648 |      6,648 |
.count stack_move
    add     $sp, 3, $sp                 # |      6,648 |      6,648 |
    li      1, $i1                      # |      6,648 |      6,648 |
    ret                                 # |      6,648 |      6,648 |
be_else.35851:
.count stack_load
    load    [$sp + 0], $ra              # |    110,078 |    110,078 |
.count stack_move
    add     $sp, 3, $sp                 # |    110,078 |    110,078 |
    li      1, $i1                      # |    110,078 |    110,078 |
    ret                                 # |    110,078 |    110,078 |
.end shadow_check_one_or_group

######################################################################
# shadow_check_one_or_matrix
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
    load    [$i3 + $i2], $i17           # |    565,273 |    565,273 |
    load    [$i17 + 0], $i18            # |    565,273 |    565,273 |
    bne     $i18, -1, be_else.35866     # |    565,273 |    565,273 |
be_then.35866:
    li      0, $i1                      # |     10,334 |     10,334 |
    ret                                 # |     10,334 |     10,334 |
be_else.35866:
.count stack_move
    sub     $sp, 8, $sp                 # |    554,939 |    554,939 |
.count stack_store
    store   $ra, [$sp + 0]              # |    554,939 |    554,939 |
.count stack_store
    store   $i17, [$sp + 1]             # |    554,939 |    554,939 |
.count stack_store
    store   $i3, [$sp + 2]              # |    554,939 |    554,939 |
.count stack_store
    store   $i2, [$sp + 3]              # |    554,939 |    554,939 |
    bne     $i18, 99, be_else.35867     # |    554,939 |    554,939 |
be_then.35867:
    li      1, $i10                     # |    544,605 |    544,605 |
.count b_cont
    b       be_cont.35867               # |    544,605 |    544,605 |
be_else.35867:
    load    [min_caml_objects + $i18], $i19# |     10,334 |     10,334 |
    load    [min_caml_intersection_point + 0], $f10# |     10,334 |     10,334 |
    load    [$i19 + 5], $i20            # |     10,334 |     10,334 |
    load    [$i20 + 0], $f11            # |     10,334 |     10,334 |
    fsub    $f10, $f11, $f10            # |     10,334 |     10,334 |
    load    [min_caml_intersection_point + 1], $f11# |     10,334 |     10,334 |
    load    [$i19 + 5], $i20            # |     10,334 |     10,334 |
    load    [$i20 + 1], $f12            # |     10,334 |     10,334 |
    fsub    $f11, $f12, $f11            # |     10,334 |     10,334 |
    load    [min_caml_intersection_point + 2], $f12# |     10,334 |     10,334 |
    load    [$i19 + 5], $i20            # |     10,334 |     10,334 |
    load    [$i20 + 2], $f13            # |     10,334 |     10,334 |
    fsub    $f12, $f13, $f12            # |     10,334 |     10,334 |
    load    [min_caml_light_dirvec + 1], $i20# |     10,334 |     10,334 |
    load    [$i20 + $i18], $i18         # |     10,334 |     10,334 |
    load    [$i19 + 1], $i20            # |     10,334 |     10,334 |
    bne     $i20, 1, be_else.35868      # |     10,334 |     10,334 |
be_then.35868:
    load    [min_caml_light_dirvec + 0], $i20# |     10,334 |     10,334 |
    load    [$i19 + 4], $i21            # |     10,334 |     10,334 |
    load    [$i21 + 1], $f13            # |     10,334 |     10,334 |
    load    [$i20 + 1], $f14            # |     10,334 |     10,334 |
    load    [$i18 + 0], $f15            # |     10,334 |     10,334 |
    fsub    $f15, $f10, $f15            # |     10,334 |     10,334 |
    load    [$i18 + 1], $f16            # |     10,334 |     10,334 |
    fmul    $f15, $f16, $f15            # |     10,334 |     10,334 |
    fmul    $f15, $f14, $f14            # |     10,334 |     10,334 |
    fadd_a  $f14, $f11, $f14            # |     10,334 |     10,334 |
    bg      $f13, $f14, ble_else.35869  # |     10,334 |     10,334 |
ble_then.35869:
    li      0, $i21                     # |      6,459 |      6,459 |
.count b_cont
    b       ble_cont.35869              # |      6,459 |      6,459 |
ble_else.35869:
    load    [$i19 + 4], $i21            # |      3,875 |      3,875 |
    load    [$i21 + 2], $f13            # |      3,875 |      3,875 |
    load    [$i20 + 2], $f14            # |      3,875 |      3,875 |
    fmul    $f15, $f14, $f14            # |      3,875 |      3,875 |
    fadd_a  $f14, $f12, $f14            # |      3,875 |      3,875 |
    bg      $f13, $f14, ble_else.35870  # |      3,875 |      3,875 |
ble_then.35870:
    li      0, $i21                     # |      3,875 |      3,875 |
.count b_cont
    b       ble_cont.35870              # |      3,875 |      3,875 |
ble_else.35870:
    load    [$i18 + 1], $f13
    bne     $f13, $f0, be_else.35871
be_then.35871:
    li      0, $i21
.count b_cont
    b       be_cont.35871
be_else.35871:
    li      1, $i21
be_cont.35871:
ble_cont.35870:
ble_cont.35869:
    bne     $i21, 0, be_else.35872      # |     10,334 |     10,334 |
be_then.35872:
    load    [$i19 + 4], $i21            # |     10,334 |     10,334 |
    load    [$i21 + 0], $f13            # |     10,334 |     10,334 |
    load    [$i20 + 0], $f14            # |     10,334 |     10,334 |
    load    [$i18 + 2], $f15            # |     10,334 |     10,334 |
    fsub    $f15, $f11, $f15            # |     10,334 |     10,334 |
    load    [$i18 + 3], $f16            # |     10,334 |     10,334 |
    fmul    $f15, $f16, $f15            # |     10,334 |     10,334 |
    fmul    $f15, $f14, $f14            # |     10,334 |     10,334 |
    fadd_a  $f14, $f10, $f14            # |     10,334 |     10,334 |
    bg      $f13, $f14, ble_else.35873  # |     10,334 |     10,334 |
ble_then.35873:
    li      0, $i21                     # |      9,079 |      9,079 |
.count b_cont
    b       ble_cont.35873              # |      9,079 |      9,079 |
ble_else.35873:
    load    [$i19 + 4], $i21            # |      1,255 |      1,255 |
    load    [$i21 + 2], $f13            # |      1,255 |      1,255 |
    load    [$i20 + 2], $f14            # |      1,255 |      1,255 |
    fmul    $f15, $f14, $f14            # |      1,255 |      1,255 |
    fadd_a  $f14, $f12, $f14            # |      1,255 |      1,255 |
    bg      $f13, $f14, ble_else.35874  # |      1,255 |      1,255 |
ble_then.35874:
    li      0, $i21                     # |      1,255 |      1,255 |
.count b_cont
    b       ble_cont.35874              # |      1,255 |      1,255 |
ble_else.35874:
    load    [$i18 + 3], $f13
    bne     $f13, $f0, be_else.35875
be_then.35875:
    li      0, $i21
.count b_cont
    b       be_cont.35875
be_else.35875:
    li      1, $i21
be_cont.35875:
ble_cont.35874:
ble_cont.35873:
    bne     $i21, 0, be_else.35876      # |     10,334 |     10,334 |
be_then.35876:
    load    [$i19 + 4], $i21            # |     10,334 |     10,334 |
    load    [$i21 + 0], $f13            # |     10,334 |     10,334 |
    load    [$i20 + 0], $f14            # |     10,334 |     10,334 |
    load    [$i18 + 4], $f15            # |     10,334 |     10,334 |
    fsub    $f15, $f12, $f12            # |     10,334 |     10,334 |
    load    [$i18 + 5], $f15            # |     10,334 |     10,334 |
    fmul    $f12, $f15, $f12            # |     10,334 |     10,334 |
    fmul    $f12, $f14, $f14            # |     10,334 |     10,334 |
    fadd_a  $f14, $f10, $f10            # |     10,334 |     10,334 |
    bg      $f13, $f10, ble_else.35877  # |     10,334 |     10,334 |
ble_then.35877:
    li      0, $i18                     # |     10,334 |     10,334 |
.count b_cont
    b       be_cont.35868               # |     10,334 |     10,334 |
ble_else.35877:
    load    [$i19 + 4], $i19
    load    [$i19 + 1], $f10
    load    [$i20 + 1], $f13
    fmul    $f12, $f13, $f13
    fadd_a  $f13, $f11, $f11
    bg      $f10, $f11, ble_else.35878
ble_then.35878:
    li      0, $i18
.count b_cont
    b       be_cont.35868
ble_else.35878:
    load    [$i18 + 5], $f10
    bne     $f10, $f0, be_else.35879
be_then.35879:
    li      0, $i18
.count b_cont
    b       be_cont.35868
be_else.35879:
    mov     $f12, $fg0
    li      3, $i18
.count b_cont
    b       be_cont.35868
be_else.35876:
    mov     $f15, $fg0
    li      2, $i18
.count b_cont
    b       be_cont.35868
be_else.35872:
    mov     $f15, $fg0
    li      1, $i18
.count b_cont
    b       be_cont.35868
be_else.35868:
    load    [$i18 + 0], $f13
    bne     $i20, 2, be_else.35880
be_then.35880:
    bg      $f0, $f13, ble_else.35881
ble_then.35881:
    li      0, $i18
.count b_cont
    b       be_cont.35880
ble_else.35881:
    load    [$i18 + 1], $f13
    fmul    $f13, $f10, $f10
    load    [$i18 + 2], $f13
    fmul    $f13, $f11, $f11
    fadd    $f10, $f11, $f10
    load    [$i18 + 3], $f11
    fmul    $f11, $f12, $f11
    fadd    $f10, $f11, $fg0
    li      1, $i18
.count b_cont
    b       be_cont.35880
be_else.35880:
    bne     $f13, $f0, be_else.35882
be_then.35882:
    li      0, $i18
.count b_cont
    b       be_cont.35882
be_else.35882:
    load    [$i18 + 1], $f14
    fmul    $f14, $f10, $f14
    load    [$i18 + 2], $f15
    fmul    $f15, $f11, $f15
    fadd    $f14, $f15, $f14
    load    [$i18 + 3], $f15
    fmul    $f15, $f12, $f15
    fadd    $f14, $f15, $f14
    fmul    $f14, $f14, $f15
    fmul    $f10, $f10, $f16
    load    [$i19 + 4], $i21
    load    [$i21 + 0], $f17
    fmul    $f16, $f17, $f16
    fmul    $f11, $f11, $f17
    load    [$i19 + 4], $i21
    load    [$i21 + 1], $f18
    fmul    $f17, $f18, $f17
    fadd    $f16, $f17, $f16
    fmul    $f12, $f12, $f17
    load    [$i19 + 4], $i21
    load    [$i21 + 2], $f18
    fmul    $f17, $f18, $f17
    fadd    $f16, $f17, $f16
    load    [$i19 + 3], $i21
    bne     $i21, 0, be_else.35883
be_then.35883:
    mov     $f16, $f10
.count b_cont
    b       be_cont.35883
be_else.35883:
    fmul    $f11, $f12, $f17
    load    [$i19 + 9], $i21
    load    [$i21 + 0], $f18
    fmul    $f17, $f18, $f17
    fadd    $f16, $f17, $f16
    fmul    $f12, $f10, $f12
    load    [$i19 + 9], $i21
    load    [$i21 + 1], $f17
    fmul    $f12, $f17, $f12
    fadd    $f16, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i19 + 9], $i21
    load    [$i21 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.35883:
    bne     $i20, 3, be_cont.35884
be_then.35884:
    fsub    $f10, $fc0, $f10
be_cont.35884:
    fmul    $f13, $f10, $f10
    fsub    $f15, $f10, $f10
    bg      $f10, $f0, ble_else.35885
ble_then.35885:
    li      0, $i18
.count b_cont
    b       ble_cont.35885
ble_else.35885:
    load    [$i19 + 6], $i19
    load    [$i18 + 4], $f11
    li      1, $i18
    fsqrt   $f10, $f10
    bne     $i19, 0, be_else.35886
be_then.35886:
    fsub    $f14, $f10, $f10
    fmul    $f10, $f11, $fg0
.count b_cont
    b       be_cont.35886
be_else.35886:
    fadd    $f14, $f10, $f10
    fmul    $f10, $f11, $fg0
be_cont.35886:
ble_cont.35885:
be_cont.35882:
be_cont.35880:
be_cont.35868:
    bne     $i18, 0, be_else.35887      # |     10,334 |     10,334 |
be_then.35887:
    li      0, $i10                     # |     10,334 |     10,334 |
.count b_cont
    b       be_cont.35887               # |     10,334 |     10,334 |
be_else.35887:
    bg      $fc7, $fg0, ble_else.35888
ble_then.35888:
    li      0, $i10
.count b_cont
    b       ble_cont.35888
ble_else.35888:
    load    [$i17 + 1], $i18
    bne     $i18, -1, be_else.35889
be_then.35889:
    li      0, $i10
.count b_cont
    b       be_cont.35889
be_else.35889:
    load    [min_caml_and_net + $i18], $i3
    li      0, $i2
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i20
    bne     $i20, 0, be_else.35890
be_then.35890:
    li      2, $i2
.count move_args
    mov     $i17, $i3
    call    shadow_check_one_or_group.2865
.count move_ret
    mov     $i1, $i10
    bne     $i10, 0, be_else.35891
be_then.35891:
    li      0, $i10
.count b_cont
    b       be_cont.35890
be_else.35891:
    li      1, $i10
.count b_cont
    b       be_cont.35890
be_else.35890:
    li      1, $i10
be_cont.35890:
be_cont.35889:
ble_cont.35888:
be_cont.35887:
be_cont.35867:
    bne     $i10, 0, be_else.35892      # |    554,939 |    554,939 |
be_then.35892:
.count stack_load
    load    [$sp + 3], $i10             # |     10,334 |     10,334 |
    add     $i10, 1, $i10               # |     10,334 |     10,334 |
.count stack_load
    load    [$sp + 2], $i11             # |     10,334 |     10,334 |
    load    [$i11 + $i10], $i12         # |     10,334 |     10,334 |
    load    [$i12 + 0], $i2             # |     10,334 |     10,334 |
    bne     $i2, -1, be_else.35893      # |     10,334 |     10,334 |
be_then.35893:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
    li      0, $i1
    ret
be_else.35893:
.count stack_store
    store   $i12, [$sp + 4]             # |     10,334 |     10,334 |
.count stack_store
    store   $i10, [$sp + 5]             # |     10,334 |     10,334 |
    bne     $i2, 99, be_else.35894      # |     10,334 |     10,334 |
be_then.35894:
    li      1, $i17                     # |     10,334 |     10,334 |
.count b_cont
    b       be_cont.35894               # |     10,334 |     10,334 |
be_else.35894:
    call    solver_fast.2796
.count move_ret
    mov     $i1, $i17
    bne     $i17, 0, be_else.35895
be_then.35895:
    li      0, $i17
.count b_cont
    b       be_cont.35895
be_else.35895:
    bg      $fc7, $fg0, ble_else.35896
ble_then.35896:
    li      0, $i17
.count b_cont
    b       ble_cont.35896
ble_else.35896:
    load    [$i12 + 1], $i17
    bne     $i17, -1, be_else.35897
be_then.35897:
    li      0, $i17
.count b_cont
    b       be_cont.35897
be_else.35897:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i17
    bne     $i17, 0, be_else.35898
be_then.35898:
.count stack_load
    load    [$sp + 4], $i17
    load    [$i17 + 2], $i18
    bne     $i18, -1, be_else.35899
be_then.35899:
    li      0, $i17
.count b_cont
    b       be_cont.35898
be_else.35899:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i20
    bne     $i20, 0, be_else.35900
be_then.35900:
    li      3, $i2
.count move_args
    mov     $i17, $i3
    call    shadow_check_one_or_group.2865
.count move_ret
    mov     $i1, $i17
    bne     $i17, 0, be_else.35901
be_then.35901:
    li      0, $i17
.count b_cont
    b       be_cont.35898
be_else.35901:
    li      1, $i17
.count b_cont
    b       be_cont.35898
be_else.35900:
    li      1, $i17
.count b_cont
    b       be_cont.35898
be_else.35898:
    li      1, $i17
be_cont.35898:
be_cont.35897:
ble_cont.35896:
be_cont.35895:
be_cont.35894:
    bne     $i17, 0, be_else.35902      # |     10,334 |     10,334 |
be_then.35902:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
.count stack_load
    load    [$sp - 3], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 6], $i3
    b       shadow_check_one_or_matrix.2868
be_else.35902:
.count stack_load
    load    [$sp + 4], $i17             # |     10,334 |     10,334 |
    load    [$i17 + 1], $i18            # |     10,334 |     10,334 |
    bne     $i18, -1, be_else.35903     # |     10,334 |     10,334 |
be_then.35903:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
.count stack_load
    load    [$sp - 3], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 6], $i3
    b       shadow_check_one_or_matrix.2868
be_else.35903:
    li      0, $i2                      # |     10,334 |     10,334 |
    load    [min_caml_and_net + $i18], $i3# |     10,334 |     10,334 |
    call    shadow_check_and_group.2862 # |     10,334 |     10,334 |
.count move_ret
    mov     $i1, $i18                   # |     10,334 |     10,334 |
    bne     $i18, 0, be_else.35904      # |     10,334 |     10,334 |
be_then.35904:
    load    [$i17 + 2], $i18            # |     10,334 |     10,334 |
    bne     $i18, -1, be_else.35905     # |     10,334 |     10,334 |
be_then.35905:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
.count stack_load
    load    [$sp - 3], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 6], $i3
    b       shadow_check_one_or_matrix.2868
be_else.35905:
    li      0, $i2                      # |     10,334 |     10,334 |
    load    [min_caml_and_net + $i18], $i3# |     10,334 |     10,334 |
    call    shadow_check_and_group.2862 # |     10,334 |     10,334 |
.count move_ret
    mov     $i1, $i20                   # |     10,334 |     10,334 |
    bne     $i20, 0, be_else.35906      # |     10,334 |     10,334 |
be_then.35906:
    li      3, $i2                      # |     10,334 |     10,334 |
.count move_args
    mov     $i17, $i3                   # |     10,334 |     10,334 |
    call    shadow_check_one_or_group.2865# |     10,334 |     10,334 |
.count stack_load
    load    [$sp + 0], $ra              # |     10,334 |     10,334 |
.count stack_move
    add     $sp, 8, $sp                 # |     10,334 |     10,334 |
    bne     $i1, 0, be_else.35907       # |     10,334 |     10,334 |
be_then.35907:
.count stack_load
    load    [$sp - 3], $i1              # |     10,334 |     10,334 |
    add     $i1, 1, $i2                 # |     10,334 |     10,334 |
.count stack_load
    load    [$sp - 6], $i3              # |     10,334 |     10,334 |
    b       shadow_check_one_or_matrix.2868# |     10,334 |     10,334 |
be_else.35907:
    li      1, $i1
    ret
be_else.35906:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
    li      1, $i1
    ret
be_else.35904:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
    li      1, $i1
    ret
be_else.35892:
.count stack_load
    load    [$sp + 1], $i17             # |    544,605 |    544,605 |
    load    [$i17 + 1], $i18            # |    544,605 |    544,605 |
    bne     $i18, -1, be_else.35908     # |    544,605 |    544,605 |
be_then.35908:
    li      0, $i10
.count b_cont
    b       be_cont.35908
be_else.35908:
    load    [min_caml_and_net + $i18], $i3# |    544,605 |    544,605 |
    li      0, $i2                      # |    544,605 |    544,605 |
    call    shadow_check_and_group.2862 # |    544,605 |    544,605 |
.count move_ret
    mov     $i1, $i18                   # |    544,605 |    544,605 |
    bne     $i18, 0, be_else.35909      # |    544,605 |    544,605 |
be_then.35909:
    load    [$i17 + 2], $i18            # |    544,605 |    544,605 |
    bne     $i18, -1, be_else.35910     # |    544,605 |    544,605 |
be_then.35910:
    li      0, $i10
.count b_cont
    b       be_cont.35909
be_else.35910:
    li      0, $i2                      # |    544,605 |    544,605 |
    load    [min_caml_and_net + $i18], $i3# |    544,605 |    544,605 |
    call    shadow_check_and_group.2862 # |    544,605 |    544,605 |
.count move_ret
    mov     $i1, $i18                   # |    544,605 |    544,605 |
    bne     $i18, 0, be_else.35911      # |    544,605 |    544,605 |
be_then.35911:
    load    [$i17 + 3], $i18            # |    543,022 |    543,022 |
    bne     $i18, -1, be_else.35912     # |    543,022 |    543,022 |
be_then.35912:
    li      0, $i10
.count b_cont
    b       be_cont.35909
be_else.35912:
    li      0, $i2                      # |    543,022 |    543,022 |
    load    [min_caml_and_net + $i18], $i3# |    543,022 |    543,022 |
    call    shadow_check_and_group.2862 # |    543,022 |    543,022 |
.count move_ret
    mov     $i1, $i18                   # |    543,022 |    543,022 |
    bne     $i18, 0, be_else.35913      # |    543,022 |    543,022 |
be_then.35913:
    load    [$i17 + 4], $i18            # |    541,069 |    541,069 |
    bne     $i18, -1, be_else.35914     # |    541,069 |    541,069 |
be_then.35914:
    li      0, $i10
.count b_cont
    b       be_cont.35909
be_else.35914:
    li      0, $i2                      # |    541,069 |    541,069 |
    load    [min_caml_and_net + $i18], $i3# |    541,069 |    541,069 |
    call    shadow_check_and_group.2862 # |    541,069 |    541,069 |
.count move_ret
    mov     $i1, $i18                   # |    541,069 |    541,069 |
    bne     $i18, 0, be_else.35915      # |    541,069 |    541,069 |
be_then.35915:
    load    [$i17 + 5], $i18            # |    540,655 |    540,655 |
    bne     $i18, -1, be_else.35916     # |    540,655 |    540,655 |
be_then.35916:
    li      0, $i10                     # |    540,655 |    540,655 |
.count b_cont
    b       be_cont.35909               # |    540,655 |    540,655 |
be_else.35916:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i18
    bne     $i18, 0, be_else.35917
be_then.35917:
    load    [$i17 + 6], $i18
    bne     $i18, -1, be_else.35918
be_then.35918:
    li      0, $i10
.count b_cont
    b       be_cont.35909
be_else.35918:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i18
    bne     $i18, 0, be_else.35919
be_then.35919:
    load    [$i17 + 7], $i18
    bne     $i18, -1, be_else.35920
be_then.35920:
    li      0, $i10
.count b_cont
    b       be_cont.35909
be_else.35920:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i20
    bne     $i20, 0, be_else.35921
be_then.35921:
    li      8, $i2
.count move_args
    mov     $i17, $i3
    call    shadow_check_one_or_group.2865
.count move_ret
    mov     $i1, $i10
.count b_cont
    b       be_cont.35909
be_else.35921:
    li      1, $i10
.count b_cont
    b       be_cont.35909
be_else.35919:
    li      1, $i10
.count b_cont
    b       be_cont.35909
be_else.35917:
    li      1, $i10
.count b_cont
    b       be_cont.35909
be_else.35915:
    li      1, $i10                     # |        414 |        414 |
.count b_cont
    b       be_cont.35909               # |        414 |        414 |
be_else.35913:
    li      1, $i10                     # |      1,953 |      1,953 |
.count b_cont
    b       be_cont.35909               # |      1,953 |      1,953 |
be_else.35911:
    li      1, $i10                     # |      1,583 |      1,583 |
.count b_cont
    b       be_cont.35909               # |      1,583 |      1,583 |
be_else.35909:
    li      1, $i10
be_cont.35909:
be_cont.35908:
    bne     $i10, 0, be_else.35922      # |    544,605 |    544,605 |
be_then.35922:
.count stack_load
    load    [$sp + 3], $i10             # |    540,655 |    540,655 |
    add     $i10, 1, $i10               # |    540,655 |    540,655 |
.count stack_load
    load    [$sp + 2], $i11             # |    540,655 |    540,655 |
    load    [$i11 + $i10], $i12         # |    540,655 |    540,655 |
    load    [$i12 + 0], $i2             # |    540,655 |    540,655 |
    bne     $i2, -1, be_else.35923      # |    540,655 |    540,655 |
be_then.35923:
.count stack_load
    load    [$sp + 0], $ra              # |    540,655 |    540,655 |
.count stack_move
    add     $sp, 8, $sp                 # |    540,655 |    540,655 |
    li      0, $i1                      # |    540,655 |    540,655 |
    ret                                 # |    540,655 |    540,655 |
be_else.35923:
.count stack_store
    store   $i12, [$sp + 6]
.count stack_store
    store   $i10, [$sp + 7]
    bne     $i2, 99, be_else.35924
be_then.35924:
    li      1, $i17
.count b_cont
    b       be_cont.35924
be_else.35924:
    call    solver_fast.2796
.count move_ret
    mov     $i1, $i17
    bne     $i17, 0, be_else.35925
be_then.35925:
    li      0, $i17
.count b_cont
    b       be_cont.35925
be_else.35925:
    bg      $fc7, $fg0, ble_else.35926
ble_then.35926:
    li      0, $i17
.count b_cont
    b       ble_cont.35926
ble_else.35926:
    load    [$i12 + 1], $i17
    bne     $i17, -1, be_else.35927
be_then.35927:
    li      0, $i17
.count b_cont
    b       be_cont.35927
be_else.35927:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i17
    bne     $i17, 0, be_else.35928
be_then.35928:
.count stack_load
    load    [$sp + 6], $i17
    load    [$i17 + 2], $i18
    bne     $i18, -1, be_else.35929
be_then.35929:
    li      0, $i17
.count b_cont
    b       be_cont.35928
be_else.35929:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i20
    bne     $i20, 0, be_else.35930
be_then.35930:
    li      3, $i2
.count move_args
    mov     $i17, $i3
    call    shadow_check_one_or_group.2865
.count move_ret
    mov     $i1, $i17
    bne     $i17, 0, be_else.35931
be_then.35931:
    li      0, $i17
.count b_cont
    b       be_cont.35928
be_else.35931:
    li      1, $i17
.count b_cont
    b       be_cont.35928
be_else.35930:
    li      1, $i17
.count b_cont
    b       be_cont.35928
be_else.35928:
    li      1, $i17
be_cont.35928:
be_cont.35927:
ble_cont.35926:
be_cont.35925:
be_cont.35924:
    bne     $i17, 0, be_else.35932
be_then.35932:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 6], $i3
    b       shadow_check_one_or_matrix.2868
be_else.35932:
.count stack_load
    load    [$sp + 6], $i17
    load    [$i17 + 1], $i18
    bne     $i18, -1, be_else.35933
be_then.35933:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 6], $i3
    b       shadow_check_one_or_matrix.2868
be_else.35933:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i18
    bne     $i18, 0, be_else.35934
be_then.35934:
    load    [$i17 + 2], $i18
    bne     $i18, -1, be_else.35935
be_then.35935:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 6], $i3
    b       shadow_check_one_or_matrix.2868
be_else.35935:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
    call    shadow_check_and_group.2862
.count move_ret
    mov     $i1, $i20
    bne     $i20, 0, be_else.35936
be_then.35936:
    li      3, $i2
.count move_args
    mov     $i17, $i3
    call    shadow_check_one_or_group.2865
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
    bne     $i1, 0, be_else.35937
be_then.35937:
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 6], $i3
    b       shadow_check_one_or_matrix.2868
be_else.35937:
    li      1, $i1
    ret
be_else.35936:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
    li      1, $i1
    ret
be_else.35934:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 8, $sp
    li      1, $i1
    ret
be_else.35922:
.count stack_load
    load    [$sp + 0], $ra              # |      3,950 |      3,950 |
.count stack_move
    add     $sp, 8, $sp                 # |      3,950 |      3,950 |
    li      1, $i1                      # |      3,950 |      3,950 |
    ret                                 # |      3,950 |      3,950 |
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element
######################################################################
.begin solve_each_element
solve_each_element.2871:
    load    [$i3 + $i2], $i10           # |    193,311 |    193,311 |
    bne     $i10, -1, be_else.35938     # |    193,311 |    193,311 |
be_then.35938:
    ret                                 # |     43,491 |     43,491 |
be_else.35938:
    load    [min_caml_objects + $i10], $i11# |    149,820 |    149,820 |
    load    [$i11 + 5], $i12            # |    149,820 |    149,820 |
    load    [$i11 + 5], $i13            # |    149,820 |    149,820 |
    load    [$i11 + 5], $i14            # |    149,820 |    149,820 |
    load    [$i11 + 1], $i15            # |    149,820 |    149,820 |
    load    [$i12 + 0], $f10            # |    149,820 |    149,820 |
    fsub    $fg21, $f10, $f10           # |    149,820 |    149,820 |
    load    [$i13 + 1], $f11            # |    149,820 |    149,820 |
    fsub    $fg22, $f11, $f11           # |    149,820 |    149,820 |
    load    [$i14 + 2], $f12            # |    149,820 |    149,820 |
    fsub    $fg23, $f12, $f12           # |    149,820 |    149,820 |
    load    [$i4 + 0], $f13             # |    149,820 |    149,820 |
    bne     $i15, 1, be_else.35939      # |    149,820 |    149,820 |
be_then.35939:
    bne     $f13, $f0, be_else.35940    # |     50,858 |     50,858 |
be_then.35940:
    li      0, $i12
.count b_cont
    b       be_cont.35940
be_else.35940:
    load    [$i11 + 4], $i12            # |     50,858 |     50,858 |
    load    [$i11 + 6], $i13            # |     50,858 |     50,858 |
    bg      $f0, $f13, ble_else.35941   # |     50,858 |     50,858 |
ble_then.35941:
    li      0, $i14                     # |     50,160 |     50,160 |
.count b_cont
    b       ble_cont.35941              # |     50,160 |     50,160 |
ble_else.35941:
    li      1, $i14                     # |        698 |        698 |
ble_cont.35941:
    bne     $i13, 0, be_else.35942      # |     50,858 |     50,858 |
be_then.35942:
    mov     $i14, $i13                  # |     50,858 |     50,858 |
.count b_cont
    b       be_cont.35942               # |     50,858 |     50,858 |
be_else.35942:
    bne     $i14, 0, be_else.35943
be_then.35943:
    li      1, $i13
.count b_cont
    b       be_cont.35943
be_else.35943:
    li      0, $i13
be_cont.35943:
be_cont.35942:
    load    [$i12 + 0], $f14            # |     50,858 |     50,858 |
    bne     $i13, 0, be_cont.35944      # |     50,858 |     50,858 |
be_then.35944:
    fneg    $f14, $f14                  # |     50,160 |     50,160 |
be_cont.35944:
    fsub    $f14, $f10, $f14            # |     50,858 |     50,858 |
    finv    $f13, $f13                  # |     50,858 |     50,858 |
    fmul    $f14, $f13, $f13            # |     50,858 |     50,858 |
    load    [$i12 + 1], $f14            # |     50,858 |     50,858 |
    load    [$i4 + 1], $f15             # |     50,858 |     50,858 |
    fmul    $f13, $f15, $f15            # |     50,858 |     50,858 |
    fadd_a  $f15, $f11, $f15            # |     50,858 |     50,858 |
    bg      $f14, $f15, ble_else.35945  # |     50,858 |     50,858 |
ble_then.35945:
    li      0, $i12                     # |     41,048 |     41,048 |
.count b_cont
    b       ble_cont.35945              # |     41,048 |     41,048 |
ble_else.35945:
    load    [$i12 + 2], $f14            # |      9,810 |      9,810 |
    load    [$i4 + 2], $f15             # |      9,810 |      9,810 |
    fmul    $f13, $f15, $f15            # |      9,810 |      9,810 |
    fadd_a  $f15, $f12, $f15            # |      9,810 |      9,810 |
    bg      $f14, $f15, ble_else.35946  # |      9,810 |      9,810 |
ble_then.35946:
    li      0, $i12                     # |      5,699 |      5,699 |
.count b_cont
    b       ble_cont.35946              # |      5,699 |      5,699 |
ble_else.35946:
    mov     $f13, $fg0                  # |      4,111 |      4,111 |
    li      1, $i12                     # |      4,111 |      4,111 |
ble_cont.35946:
ble_cont.35945:
be_cont.35940:
    bne     $i12, 0, be_else.35947      # |     50,858 |     50,858 |
be_then.35947:
    load    [$i4 + 1], $f13             # |     46,747 |     46,747 |
    bne     $f13, $f0, be_else.35948    # |     46,747 |     46,747 |
be_then.35948:
    li      0, $i12
.count b_cont
    b       be_cont.35948
be_else.35948:
    load    [$i11 + 4], $i12            # |     46,747 |     46,747 |
    load    [$i11 + 6], $i13            # |     46,747 |     46,747 |
    bg      $f0, $f13, ble_else.35949   # |     46,747 |     46,747 |
ble_then.35949:
    li      0, $i14                     # |        217 |        217 |
.count b_cont
    b       ble_cont.35949              # |        217 |        217 |
ble_else.35949:
    li      1, $i14                     # |     46,530 |     46,530 |
ble_cont.35949:
    bne     $i13, 0, be_else.35950      # |     46,747 |     46,747 |
be_then.35950:
    mov     $i14, $i13                  # |     46,747 |     46,747 |
.count b_cont
    b       be_cont.35950               # |     46,747 |     46,747 |
be_else.35950:
    bne     $i14, 0, be_else.35951
be_then.35951:
    li      1, $i13
.count b_cont
    b       be_cont.35951
be_else.35951:
    li      0, $i13
be_cont.35951:
be_cont.35950:
    load    [$i12 + 1], $f14            # |     46,747 |     46,747 |
    bne     $i13, 0, be_cont.35952      # |     46,747 |     46,747 |
be_then.35952:
    fneg    $f14, $f14                  # |        217 |        217 |
be_cont.35952:
    fsub    $f14, $f11, $f14            # |     46,747 |     46,747 |
    finv    $f13, $f13                  # |     46,747 |     46,747 |
    fmul    $f14, $f13, $f13            # |     46,747 |     46,747 |
    load    [$i12 + 2], $f14            # |     46,747 |     46,747 |
    load    [$i4 + 2], $f15             # |     46,747 |     46,747 |
    fmul    $f13, $f15, $f15            # |     46,747 |     46,747 |
    fadd_a  $f15, $f12, $f15            # |     46,747 |     46,747 |
    bg      $f14, $f15, ble_else.35953  # |     46,747 |     46,747 |
ble_then.35953:
    li      0, $i12                     # |     28,211 |     28,211 |
.count b_cont
    b       ble_cont.35953              # |     28,211 |     28,211 |
ble_else.35953:
    load    [$i12 + 0], $f14            # |     18,536 |     18,536 |
    load    [$i4 + 0], $f15             # |     18,536 |     18,536 |
    fmul    $f13, $f15, $f15            # |     18,536 |     18,536 |
    fadd_a  $f15, $f10, $f15            # |     18,536 |     18,536 |
    bg      $f14, $f15, ble_else.35954  # |     18,536 |     18,536 |
ble_then.35954:
    li      0, $i12                     # |      6,456 |      6,456 |
.count b_cont
    b       ble_cont.35954              # |      6,456 |      6,456 |
ble_else.35954:
    mov     $f13, $fg0                  # |     12,080 |     12,080 |
    li      1, $i12                     # |     12,080 |     12,080 |
ble_cont.35954:
ble_cont.35953:
be_cont.35948:
    bne     $i12, 0, be_else.35955      # |     46,747 |     46,747 |
be_then.35955:
    load    [$i4 + 2], $f13             # |     34,667 |     34,667 |
    bne     $f13, $f0, be_else.35956    # |     34,667 |     34,667 |
be_then.35956:
    li      0, $i11
.count b_cont
    b       be_cont.35939
be_else.35956:
    load    [$i11 + 4], $i12            # |     34,667 |     34,667 |
    load    [$i12 + 0], $f14            # |     34,667 |     34,667 |
    load    [$i4 + 0], $f15             # |     34,667 |     34,667 |
    load    [$i11 + 6], $i11            # |     34,667 |     34,667 |
    bg      $f0, $f13, ble_else.35957   # |     34,667 |     34,667 |
ble_then.35957:
    li      0, $i13                     # |     24,683 |     24,683 |
.count b_cont
    b       ble_cont.35957              # |     24,683 |     24,683 |
ble_else.35957:
    li      1, $i13                     # |      9,984 |      9,984 |
ble_cont.35957:
    bne     $i11, 0, be_else.35958      # |     34,667 |     34,667 |
be_then.35958:
    mov     $i13, $i11                  # |     34,667 |     34,667 |
.count b_cont
    b       be_cont.35958               # |     34,667 |     34,667 |
be_else.35958:
    bne     $i13, 0, be_else.35959
be_then.35959:
    li      1, $i11
.count b_cont
    b       be_cont.35959
be_else.35959:
    li      0, $i11
be_cont.35959:
be_cont.35958:
    load    [$i12 + 2], $f16            # |     34,667 |     34,667 |
    bne     $i11, 0, be_cont.35960      # |     34,667 |     34,667 |
be_then.35960:
    fneg    $f16, $f16                  # |     24,683 |     24,683 |
be_cont.35960:
    fsub    $f16, $f12, $f12            # |     34,667 |     34,667 |
    finv    $f13, $f13                  # |     34,667 |     34,667 |
    fmul    $f12, $f13, $f12            # |     34,667 |     34,667 |
    fmul    $f12, $f15, $f13            # |     34,667 |     34,667 |
    fadd_a  $f13, $f10, $f10            # |     34,667 |     34,667 |
    bg      $f14, $f10, ble_else.35961  # |     34,667 |     34,667 |
ble_then.35961:
    li      0, $i11                     # |     18,798 |     18,798 |
.count b_cont
    b       be_cont.35939               # |     18,798 |     18,798 |
ble_else.35961:
    load    [$i12 + 1], $f10            # |     15,869 |     15,869 |
    load    [$i4 + 1], $f13             # |     15,869 |     15,869 |
    fmul    $f12, $f13, $f13            # |     15,869 |     15,869 |
    fadd_a  $f13, $f11, $f11            # |     15,869 |     15,869 |
    bg      $f10, $f11, ble_else.35962  # |     15,869 |     15,869 |
ble_then.35962:
    li      0, $i11                     # |     12,844 |     12,844 |
.count b_cont
    b       be_cont.35939               # |     12,844 |     12,844 |
ble_else.35962:
    mov     $f12, $fg0                  # |      3,025 |      3,025 |
    li      3, $i11                     # |      3,025 |      3,025 |
.count b_cont
    b       be_cont.35939               # |      3,025 |      3,025 |
be_else.35955:
    li      2, $i11                     # |     12,080 |     12,080 |
.count b_cont
    b       be_cont.35939               # |     12,080 |     12,080 |
be_else.35947:
    li      1, $i11                     # |      4,111 |      4,111 |
.count b_cont
    b       be_cont.35939               # |      4,111 |      4,111 |
be_else.35939:
    bne     $i15, 2, be_else.35963      # |     98,962 |     98,962 |
be_then.35963:
    load    [$i11 + 4], $i11            # |     24,693 |     24,693 |
    load    [$i11 + 0], $f14            # |     24,693 |     24,693 |
    fmul    $f13, $f14, $f13            # |     24,693 |     24,693 |
    load    [$i4 + 1], $f15             # |     24,693 |     24,693 |
    load    [$i11 + 1], $f16            # |     24,693 |     24,693 |
    fmul    $f15, $f16, $f15            # |     24,693 |     24,693 |
    fadd    $f13, $f15, $f13            # |     24,693 |     24,693 |
    load    [$i4 + 2], $f15             # |     24,693 |     24,693 |
    load    [$i11 + 2], $f17            # |     24,693 |     24,693 |
    fmul    $f15, $f17, $f15            # |     24,693 |     24,693 |
    fadd    $f13, $f15, $f13            # |     24,693 |     24,693 |
    bg      $f13, $f0, ble_else.35964   # |     24,693 |     24,693 |
ble_then.35964:
    li      0, $i11                     # |      7,535 |      7,535 |
.count b_cont
    b       be_cont.35963               # |      7,535 |      7,535 |
ble_else.35964:
    fmul    $f14, $f10, $f10            # |     17,158 |     17,158 |
    fmul    $f16, $f11, $f11            # |     17,158 |     17,158 |
    fadd    $f10, $f11, $f10            # |     17,158 |     17,158 |
    fmul    $f17, $f12, $f11            # |     17,158 |     17,158 |
    fadd_n  $f10, $f11, $f10            # |     17,158 |     17,158 |
    finv    $f13, $f11                  # |     17,158 |     17,158 |
    fmul    $f10, $f11, $fg0            # |     17,158 |     17,158 |
    li      1, $i11                     # |     17,158 |     17,158 |
.count b_cont
    b       be_cont.35963               # |     17,158 |     17,158 |
be_else.35963:
    load    [$i11 + 3], $i12            # |     74,269 |     74,269 |
    load    [$i11 + 4], $i13            # |     74,269 |     74,269 |
    load    [$i11 + 4], $i14            # |     74,269 |     74,269 |
    load    [$i11 + 4], $i15            # |     74,269 |     74,269 |
    load    [$i4 + 1], $f14             # |     74,269 |     74,269 |
    load    [$i4 + 2], $f15             # |     74,269 |     74,269 |
    fmul    $f13, $f13, $f16            # |     74,269 |     74,269 |
    load    [$i13 + 0], $f17            # |     74,269 |     74,269 |
    fmul    $f16, $f17, $f16            # |     74,269 |     74,269 |
    fmul    $f14, $f14, $f18            # |     74,269 |     74,269 |
    load    [$i14 + 1], $f1             # |     74,269 |     74,269 |
    fmul    $f18, $f1, $f18             # |     74,269 |     74,269 |
    fadd    $f16, $f18, $f16            # |     74,269 |     74,269 |
    fmul    $f15, $f15, $f18            # |     74,269 |     74,269 |
    load    [$i15 + 2], $f2             # |     74,269 |     74,269 |
    fmul    $f18, $f2, $f18             # |     74,269 |     74,269 |
    fadd    $f16, $f18, $f16            # |     74,269 |     74,269 |
    be      $i12, 0, bne_cont.35965     # |     74,269 |     74,269 |
bne_then.35965:
    fmul    $f14, $f15, $f18
    load    [$i11 + 9], $i13
    load    [$i13 + 0], $f3
    fmul    $f18, $f3, $f18
    fadd    $f16, $f18, $f16
    fmul    $f15, $f13, $f18
    load    [$i11 + 9], $i13
    load    [$i13 + 1], $f3
    fmul    $f18, $f3, $f18
    fadd    $f16, $f18, $f16
    fmul    $f13, $f14, $f18
    load    [$i11 + 9], $i13
    load    [$i13 + 2], $f3
    fmul    $f18, $f3, $f18
    fadd    $f16, $f18, $f16
bne_cont.35965:
    bne     $f16, $f0, be_else.35966    # |     74,269 |     74,269 |
be_then.35966:
    li      0, $i11
.count b_cont
    b       be_cont.35966
be_else.35966:
    load    [$i11 + 1], $i13            # |     74,269 |     74,269 |
    fmul    $f13, $f10, $f18            # |     74,269 |     74,269 |
    fmul    $f18, $f17, $f18            # |     74,269 |     74,269 |
    fmul    $f14, $f11, $f3             # |     74,269 |     74,269 |
    fmul    $f3, $f1, $f3               # |     74,269 |     74,269 |
    fadd    $f18, $f3, $f18             # |     74,269 |     74,269 |
    fmul    $f15, $f12, $f3             # |     74,269 |     74,269 |
    fmul    $f3, $f2, $f3               # |     74,269 |     74,269 |
    fadd    $f18, $f3, $f18             # |     74,269 |     74,269 |
    bne     $i12, 0, be_else.35967      # |     74,269 |     74,269 |
be_then.35967:
    mov     $f18, $f13                  # |     74,269 |     74,269 |
.count b_cont
    b       be_cont.35967               # |     74,269 |     74,269 |
be_else.35967:
    fmul    $f15, $f11, $f3
    fmul    $f14, $f12, $f4
    fadd    $f3, $f4, $f3
    load    [$i11 + 9], $i14
    load    [$i14 + 0], $f4
    fmul    $f3, $f4, $f3
    fmul    $f13, $f12, $f4
    fmul    $f15, $f10, $f15
    fadd    $f4, $f15, $f15
    load    [$i11 + 9], $i14
    load    [$i14 + 1], $f4
    fmul    $f15, $f4, $f15
    fadd    $f3, $f15, $f15
    fmul    $f13, $f11, $f13
    fmul    $f14, $f10, $f14
    fadd    $f13, $f14, $f13
    load    [$i11 + 9], $i14
    load    [$i14 + 2], $f14
    fmul    $f13, $f14, $f13
    fadd    $f15, $f13, $f13
    fmul    $f13, $fc3, $f13
    fadd    $f18, $f13, $f13
be_cont.35967:
    fmul    $f13, $f13, $f14            # |     74,269 |     74,269 |
    fmul    $f10, $f10, $f15            # |     74,269 |     74,269 |
    fmul    $f15, $f17, $f15            # |     74,269 |     74,269 |
    fmul    $f11, $f11, $f17            # |     74,269 |     74,269 |
    fmul    $f17, $f1, $f17             # |     74,269 |     74,269 |
    fadd    $f15, $f17, $f15            # |     74,269 |     74,269 |
    fmul    $f12, $f12, $f17            # |     74,269 |     74,269 |
    fmul    $f17, $f2, $f17             # |     74,269 |     74,269 |
    fadd    $f15, $f17, $f15            # |     74,269 |     74,269 |
    bne     $i12, 0, be_else.35968      # |     74,269 |     74,269 |
be_then.35968:
    mov     $f15, $f10                  # |     74,269 |     74,269 |
.count b_cont
    b       be_cont.35968               # |     74,269 |     74,269 |
be_else.35968:
    fmul    $f11, $f12, $f17
    load    [$i11 + 9], $i12
    load    [$i12 + 0], $f18
    fmul    $f17, $f18, $f17
    fadd    $f15, $f17, $f15
    fmul    $f12, $f10, $f12
    load    [$i11 + 9], $i12
    load    [$i12 + 1], $f17
    fmul    $f12, $f17, $f12
    fadd    $f15, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i11 + 9], $i12
    load    [$i12 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.35968:
    bne     $i13, 3, be_cont.35969      # |     74,269 |     74,269 |
be_then.35969:
    fsub    $f10, $fc0, $f10            # |     74,269 |     74,269 |
be_cont.35969:
    fmul    $f16, $f10, $f10            # |     74,269 |     74,269 |
    fsub    $f14, $f10, $f10            # |     74,269 |     74,269 |
    bg      $f10, $f0, ble_else.35970   # |     74,269 |     74,269 |
ble_then.35970:
    li      0, $i11                     # |     62,376 |     62,376 |
.count b_cont
    b       ble_cont.35970              # |     62,376 |     62,376 |
ble_else.35970:
    load    [$i11 + 6], $i11            # |     11,893 |     11,893 |
    fsqrt   $f10, $f10                  # |     11,893 |     11,893 |
    finv    $f16, $f11                  # |     11,893 |     11,893 |
    bne     $i11, 0, be_else.35971      # |     11,893 |     11,893 |
be_then.35971:
    fneg    $f10, $f10                  # |      9,138 |      9,138 |
    fsub    $f10, $f13, $f10            # |      9,138 |      9,138 |
    fmul    $f10, $f11, $fg0            # |      9,138 |      9,138 |
    li      1, $i11                     # |      9,138 |      9,138 |
.count b_cont
    b       be_cont.35971               # |      9,138 |      9,138 |
be_else.35971:
    fsub    $f10, $f13, $f10            # |      2,755 |      2,755 |
    fmul    $f10, $f11, $fg0            # |      2,755 |      2,755 |
    li      1, $i11                     # |      2,755 |      2,755 |
be_cont.35971:
ble_cont.35970:
be_cont.35966:
be_cont.35963:
be_cont.35939:
    bne     $i11, 0, be_else.35972      # |    149,820 |    149,820 |
be_then.35972:
    load    [min_caml_objects + $i10], $i1# |    101,553 |    101,553 |
    load    [$i1 + 6], $i1              # |    101,553 |    101,553 |
    bne     $i1, 0, be_else.35973       # |    101,553 |    101,553 |
be_then.35973:
    ret                                 # |     92,181 |     92,181 |
be_else.35973:
    add     $i2, 1, $i2                 # |      9,372 |      9,372 |
    b       solve_each_element.2871     # |      9,372 |      9,372 |
be_else.35972:
    bg      $fg0, $f0, ble_else.35974   # |     48,267 |     48,267 |
ble_then.35974:
    add     $i2, 1, $i2                 # |        847 |        847 |
    b       solve_each_element.2871     # |        847 |        847 |
ble_else.35974:
    bg      $fg7, $fg0, ble_else.35975  # |     47,420 |     47,420 |
ble_then.35975:
    add     $i2, 1, $i2                 # |     11,681 |     11,681 |
    b       solve_each_element.2871     # |     11,681 |     11,681 |
ble_else.35975:
.count stack_move
    sub     $sp, 7, $sp                 # |     35,739 |     35,739 |
.count stack_store
    store   $ra, [$sp + 0]              # |     35,739 |     35,739 |
.count stack_store
    store   $i4, [$sp + 1]              # |     35,739 |     35,739 |
.count stack_store
    store   $i3, [$sp + 2]              # |     35,739 |     35,739 |
.count stack_store
    store   $i2, [$sp + 3]              # |     35,739 |     35,739 |
    li      0, $i2                      # |     35,739 |     35,739 |
    load    [$i4 + 0], $f10             # |     35,739 |     35,739 |
    fadd    $fg0, $fc16, $f11           # |     35,739 |     35,739 |
    fmul    $f10, $f11, $f10            # |     35,739 |     35,739 |
    fadd    $f10, $fg21, $f2            # |     35,739 |     35,739 |
.count stack_store
    store   $f2, [$sp + 4]              # |     35,739 |     35,739 |
    load    [$i4 + 1], $f10             # |     35,739 |     35,739 |
    fmul    $f10, $f11, $f10            # |     35,739 |     35,739 |
    fadd    $f10, $fg22, $f3            # |     35,739 |     35,739 |
.count stack_store
    store   $f3, [$sp + 5]              # |     35,739 |     35,739 |
    load    [$i4 + 2], $f10             # |     35,739 |     35,739 |
    fmul    $f10, $f11, $f10            # |     35,739 |     35,739 |
    fadd    $f10, $fg23, $f4            # |     35,739 |     35,739 |
.count stack_store
    store   $f4, [$sp + 6]              # |     35,739 |     35,739 |
    call    check_all_inside.2856       # |     35,739 |     35,739 |
.count stack_load
    load    [$sp + 0], $ra              # |     35,739 |     35,739 |
.count stack_move
    add     $sp, 7, $sp                 # |     35,739 |     35,739 |
    bne     $i1, 0, be_else.35976       # |     35,739 |     35,739 |
be_then.35976:
.count stack_load
    load    [$sp - 4], $i1              # |     10,575 |     10,575 |
    add     $i1, 1, $i2                 # |     10,575 |     10,575 |
.count stack_load
    load    [$sp - 5], $i3              # |     10,575 |     10,575 |
.count stack_load
    load    [$sp - 6], $i4              # |     10,575 |     10,575 |
    b       solve_each_element.2871     # |     10,575 |     10,575 |
be_else.35976:
    mov     $f11, $fg7                  # |     25,164 |     25,164 |
.count stack_load
    load    [$sp - 3], $i1              # |     25,164 |     25,164 |
    store   $i1, [min_caml_intersection_point + 0]# |     25,164 |     25,164 |
.count stack_load
    load    [$sp - 2], $i1              # |     25,164 |     25,164 |
    store   $i1, [min_caml_intersection_point + 1]# |     25,164 |     25,164 |
.count stack_load
    load    [$sp - 1], $i1              # |     25,164 |     25,164 |
    store   $i1, [min_caml_intersection_point + 2]# |     25,164 |     25,164 |
    mov     $i10, $ig5                  # |     25,164 |     25,164 |
    mov     $i11, $ig4                  # |     25,164 |     25,164 |
.count stack_load
    load    [$sp - 4], $i1              # |     25,164 |     25,164 |
    add     $i1, 1, $i2                 # |     25,164 |     25,164 |
.count stack_load
    load    [$sp - 5], $i3              # |     25,164 |     25,164 |
.count stack_load
    load    [$sp - 6], $i4              # |     25,164 |     25,164 |
    b       solve_each_element.2871     # |     25,164 |     25,164 |
.end solve_each_element

######################################################################
# solve_one_or_network
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
    load    [$i3 + $i2], $i16           # |      6,776 |      6,776 |
    bne     $i16, -1, be_else.35977     # |      6,776 |      6,776 |
be_then.35977:
    ret
be_else.35977:
.count stack_move
    sub     $sp, 4, $sp                 # |      6,776 |      6,776 |
.count stack_store
    store   $ra, [$sp + 0]              # |      6,776 |      6,776 |
.count stack_store
    store   $i4, [$sp + 1]              # |      6,776 |      6,776 |
.count stack_store
    store   $i3, [$sp + 2]              # |      6,776 |      6,776 |
.count stack_store
    store   $i2, [$sp + 3]              # |      6,776 |      6,776 |
    li      0, $i2                      # |      6,776 |      6,776 |
    load    [min_caml_and_net + $i16], $i3# |      6,776 |      6,776 |
    call    solve_each_element.2871     # |      6,776 |      6,776 |
.count stack_load
    load    [$sp + 3], $i16             # |      6,776 |      6,776 |
    add     $i16, 1, $i16               # |      6,776 |      6,776 |
.count stack_load
    load    [$sp + 2], $i17             # |      6,776 |      6,776 |
    load    [$i17 + $i16], $i18         # |      6,776 |      6,776 |
    bne     $i18, -1, be_else.35978     # |      6,776 |      6,776 |
be_then.35978:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.35978:
    li      0, $i2                      # |      6,776 |      6,776 |
    load    [min_caml_and_net + $i18], $i3# |      6,776 |      6,776 |
.count stack_load
    load    [$sp + 1], $i4              # |      6,776 |      6,776 |
    call    solve_each_element.2871     # |      6,776 |      6,776 |
    add     $i16, 1, $i16               # |      6,776 |      6,776 |
    load    [$i17 + $i16], $i18         # |      6,776 |      6,776 |
    bne     $i18, -1, be_else.35979     # |      6,776 |      6,776 |
be_then.35979:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.35979:
    li      0, $i2                      # |      6,776 |      6,776 |
    load    [min_caml_and_net + $i18], $i3# |      6,776 |      6,776 |
.count stack_load
    load    [$sp + 1], $i4              # |      6,776 |      6,776 |
    call    solve_each_element.2871     # |      6,776 |      6,776 |
    add     $i16, 1, $i16               # |      6,776 |      6,776 |
    load    [$i17 + $i16], $i18         # |      6,776 |      6,776 |
    bne     $i18, -1, be_else.35980     # |      6,776 |      6,776 |
be_then.35980:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.35980:
    li      0, $i2                      # |      6,776 |      6,776 |
    load    [min_caml_and_net + $i18], $i3# |      6,776 |      6,776 |
.count stack_load
    load    [$sp + 1], $i4              # |      6,776 |      6,776 |
    call    solve_each_element.2871     # |      6,776 |      6,776 |
    add     $i16, 1, $i16               # |      6,776 |      6,776 |
    load    [$i17 + $i16], $i18         # |      6,776 |      6,776 |
    bne     $i18, -1, be_else.35981     # |      6,776 |      6,776 |
be_then.35981:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.35981:
    li      0, $i2                      # |      6,776 |      6,776 |
    load    [min_caml_and_net + $i18], $i3# |      6,776 |      6,776 |
.count stack_load
    load    [$sp + 1], $i4              # |      6,776 |      6,776 |
    call    solve_each_element.2871     # |      6,776 |      6,776 |
    add     $i16, 1, $i16               # |      6,776 |      6,776 |
    load    [$i17 + $i16], $i18         # |      6,776 |      6,776 |
    bne     $i18, -1, be_else.35982     # |      6,776 |      6,776 |
be_then.35982:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.35982:
    li      0, $i2                      # |      6,776 |      6,776 |
    load    [min_caml_and_net + $i18], $i3# |      6,776 |      6,776 |
.count stack_load
    load    [$sp + 1], $i4              # |      6,776 |      6,776 |
    call    solve_each_element.2871     # |      6,776 |      6,776 |
    add     $i16, 1, $i16               # |      6,776 |      6,776 |
    load    [$i17 + $i16], $i18         # |      6,776 |      6,776 |
    bne     $i18, -1, be_else.35983     # |      6,776 |      6,776 |
be_then.35983:
.count stack_load
    load    [$sp + 0], $ra              # |      6,776 |      6,776 |
.count stack_move
    add     $sp, 4, $sp                 # |      6,776 |      6,776 |
    ret                                 # |      6,776 |      6,776 |
be_else.35983:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element.2871
    add     $i16, 1, $i16
    load    [$i17 + $i16], $i18
    bne     $i18, -1, be_else.35984
be_then.35984:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.35984:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element.2871
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    add     $i16, 1, $i2
.count stack_load
    load    [$sp - 3], $i4
.count move_args
    mov     $i17, $i3
    b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
    load    [$i3 + $i2], $i16           # |     23,754 |     23,754 |
    load    [$i16 + 0], $i17            # |     23,754 |     23,754 |
    bne     $i17, -1, be_else.35985     # |     23,754 |     23,754 |
be_then.35985:
    ret
be_else.35985:
.count stack_move
    sub     $sp, 5, $sp                 # |     23,754 |     23,754 |
.count stack_store
    store   $ra, [$sp + 0]              # |     23,754 |     23,754 |
.count stack_store
    store   $i4, [$sp + 1]              # |     23,754 |     23,754 |
.count stack_store
    store   $i3, [$sp + 2]              # |     23,754 |     23,754 |
.count stack_store
    store   $i2, [$sp + 3]              # |     23,754 |     23,754 |
    bne     $i17, 99, be_else.35986     # |     23,754 |     23,754 |
be_then.35986:
    load    [$i16 + 1], $i17            # |     23,754 |     23,754 |
    be      $i17, -1, bne_cont.35987    # |     23,754 |     23,754 |
bne_then.35987:
    li      0, $i2                      # |     23,754 |     23,754 |
    load    [min_caml_and_net + $i17], $i3# |     23,754 |     23,754 |
    call    solve_each_element.2871     # |     23,754 |     23,754 |
    load    [$i16 + 2], $i17            # |     23,754 |     23,754 |
    be      $i17, -1, bne_cont.35988    # |     23,754 |     23,754 |
bne_then.35988:
    li      0, $i2                      # |     23,754 |     23,754 |
    load    [min_caml_and_net + $i17], $i3# |     23,754 |     23,754 |
.count stack_load
    load    [$sp + 1], $i4              # |     23,754 |     23,754 |
    call    solve_each_element.2871     # |     23,754 |     23,754 |
    load    [$i16 + 3], $i17            # |     23,754 |     23,754 |
    be      $i17, -1, bne_cont.35989    # |     23,754 |     23,754 |
bne_then.35989:
    li      0, $i2                      # |     23,754 |     23,754 |
    load    [min_caml_and_net + $i17], $i3# |     23,754 |     23,754 |
.count stack_load
    load    [$sp + 1], $i4              # |     23,754 |     23,754 |
    call    solve_each_element.2871     # |     23,754 |     23,754 |
    load    [$i16 + 4], $i17            # |     23,754 |     23,754 |
    be      $i17, -1, bne_cont.35990    # |     23,754 |     23,754 |
bne_then.35990:
    li      0, $i2                      # |     23,754 |     23,754 |
    load    [min_caml_and_net + $i17], $i3# |     23,754 |     23,754 |
.count stack_load
    load    [$sp + 1], $i4              # |     23,754 |     23,754 |
    call    solve_each_element.2871     # |     23,754 |     23,754 |
    load    [$i16 + 5], $i17            # |     23,754 |     23,754 |
    be      $i17, -1, bne_cont.35991    # |     23,754 |     23,754 |
bne_then.35991:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element.2871
    load    [$i16 + 6], $i17
    be      $i17, -1, bne_cont.35992
bne_then.35992:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element.2871
    li      7, $i2
.count stack_load
    load    [$sp + 1], $i4
.count move_args
    mov     $i16, $i3
    call    solve_one_or_network.2875
bne_cont.35992:
bne_cont.35991:
bne_cont.35990:
bne_cont.35989:
bne_cont.35988:
bne_cont.35987:
.count stack_load
    load    [$sp + 3], $i16             # |     23,754 |     23,754 |
    add     $i16, 1, $i16               # |     23,754 |     23,754 |
.count stack_load
    load    [$sp + 2], $i3              # |     23,754 |     23,754 |
    load    [$i3 + $i16], $i17          # |     23,754 |     23,754 |
    load    [$i17 + 0], $i18            # |     23,754 |     23,754 |
    bne     $i18, -1, be_else.35993     # |     23,754 |     23,754 |
be_then.35993:
.count stack_load
    load    [$sp + 0], $ra              # |     23,754 |     23,754 |
.count stack_move
    add     $sp, 5, $sp                 # |     23,754 |     23,754 |
    ret                                 # |     23,754 |     23,754 |
be_else.35993:
    bne     $i18, 99, be_else.35994
be_then.35994:
    load    [$i17 + 1], $i18
    bne     $i18, -1, be_else.35995
be_then.35995:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i16, 1, $i2
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
be_else.35995:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element.2871
    load    [$i17 + 2], $i18
    bne     $i18, -1, be_else.35996
be_then.35996:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i16, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
be_else.35996:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element.2871
    load    [$i17 + 3], $i18
    bne     $i18, -1, be_else.35997
be_then.35997:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i16, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
be_else.35997:
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element.2871
    load    [$i17 + 4], $i18
    bne     $i18, -1, be_else.35998
be_then.35998:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i16, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
be_else.35998:
.count stack_store
    store   $i16, [$sp + 4]
    li      0, $i2
    load    [min_caml_and_net + $i18], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element.2871
    li      5, $i2
.count stack_load
    load    [$sp + 1], $i4
.count move_args
    mov     $i17, $i3
    call    solve_one_or_network.2875
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
be_else.35994:
.count stack_load
    load    [$sp + 1], $i3
.count move_args
    mov     $i18, $i2
    call    solver.2773
.count move_ret
    mov     $i1, $i19
    bne     $i19, 0, be_else.35999
be_then.35999:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i16, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
be_else.35999:
    bg      $fg7, $fg0, ble_else.36000
ble_then.36000:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i16, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
ble_else.36000:
.count stack_store
    store   $i16, [$sp + 4]
    li      1, $i2
.count stack_load
    load    [$sp + 1], $i4
.count move_args
    mov     $i17, $i3
    call    solve_one_or_network.2875
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
be_else.35986:
.count move_args
    mov     $i17, $i2
.count move_args
    mov     $i4, $i3
    call    solver.2773
.count move_ret
    mov     $i1, $i19
    bne     $i19, 0, be_else.36001
be_then.36001:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 2], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
be_else.36001:
    bg      $fg7, $fg0, ble_else.36002
ble_then.36002:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 2], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
ble_else.36002:
    li      1, $i2
.count stack_load
    load    [$sp + 1], $i4
.count move_args
    mov     $i16, $i3
    call    solve_one_or_network.2875
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 2], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
    load    [$i3 + $i2], $i10           # | 13,852,375 | 13,852,375 |
    bne     $i10, -1, be_else.36003     # | 13,852,375 | 13,852,375 |
be_then.36003:
    ret                                 # |  3,308,310 |  3,308,310 |
be_else.36003:
    load    [min_caml_objects + $i10], $i11# | 10,544,065 | 10,544,065 |
    load    [$i11 + 10], $i12           # | 10,544,065 | 10,544,065 |
    load    [$i4 + 1], $i13             # | 10,544,065 | 10,544,065 |
    load    [$i11 + 1], $i14            # | 10,544,065 | 10,544,065 |
    load    [$i12 + 0], $f10            # | 10,544,065 | 10,544,065 |
    load    [$i12 + 1], $f11            # | 10,544,065 | 10,544,065 |
    load    [$i12 + 2], $f12            # | 10,544,065 | 10,544,065 |
    load    [$i13 + $i10], $i13         # | 10,544,065 | 10,544,065 |
    bne     $i14, 1, be_else.36004      # | 10,544,065 | 10,544,065 |
be_then.36004:
    load    [$i4 + 0], $i12             # |  3,873,912 |  3,873,912 |
    load    [$i11 + 4], $i14            # |  3,873,912 |  3,873,912 |
    load    [$i14 + 1], $f13            # |  3,873,912 |  3,873,912 |
    load    [$i12 + 1], $f14            # |  3,873,912 |  3,873,912 |
    load    [$i13 + 0], $f15            # |  3,873,912 |  3,873,912 |
    fsub    $f15, $f10, $f15            # |  3,873,912 |  3,873,912 |
    load    [$i13 + 1], $f16            # |  3,873,912 |  3,873,912 |
    fmul    $f15, $f16, $f15            # |  3,873,912 |  3,873,912 |
    fmul    $f15, $f14, $f14            # |  3,873,912 |  3,873,912 |
    fadd_a  $f14, $f11, $f14            # |  3,873,912 |  3,873,912 |
    bg      $f13, $f14, ble_else.36005  # |  3,873,912 |  3,873,912 |
ble_then.36005:
    li      0, $i14                     # |  3,045,892 |  3,045,892 |
.count b_cont
    b       ble_cont.36005              # |  3,045,892 |  3,045,892 |
ble_else.36005:
    load    [$i11 + 4], $i14            # |    828,020 |    828,020 |
    load    [$i14 + 2], $f13            # |    828,020 |    828,020 |
    load    [$i12 + 2], $f14            # |    828,020 |    828,020 |
    fmul    $f15, $f14, $f14            # |    828,020 |    828,020 |
    fadd_a  $f14, $f12, $f14            # |    828,020 |    828,020 |
    bg      $f13, $f14, ble_else.36006  # |    828,020 |    828,020 |
ble_then.36006:
    li      0, $i14                     # |    324,595 |    324,595 |
.count b_cont
    b       ble_cont.36006              # |    324,595 |    324,595 |
ble_else.36006:
    load    [$i13 + 1], $f13            # |    503,425 |    503,425 |
    bne     $f13, $f0, be_else.36007    # |    503,425 |    503,425 |
be_then.36007:
    li      0, $i14
.count b_cont
    b       be_cont.36007
be_else.36007:
    li      1, $i14                     # |    503,425 |    503,425 |
be_cont.36007:
ble_cont.36006:
ble_cont.36005:
    bne     $i14, 0, be_else.36008      # |  3,873,912 |  3,873,912 |
be_then.36008:
    load    [$i11 + 4], $i14            # |  3,370,487 |  3,370,487 |
    load    [$i14 + 0], $f13            # |  3,370,487 |  3,370,487 |
    load    [$i12 + 0], $f14            # |  3,370,487 |  3,370,487 |
    load    [$i13 + 2], $f15            # |  3,370,487 |  3,370,487 |
    fsub    $f15, $f11, $f15            # |  3,370,487 |  3,370,487 |
    load    [$i13 + 3], $f16            # |  3,370,487 |  3,370,487 |
    fmul    $f15, $f16, $f15            # |  3,370,487 |  3,370,487 |
    fmul    $f15, $f14, $f14            # |  3,370,487 |  3,370,487 |
    fadd_a  $f14, $f10, $f14            # |  3,370,487 |  3,370,487 |
    bg      $f13, $f14, ble_else.36009  # |  3,370,487 |  3,370,487 |
ble_then.36009:
    li      0, $i14                     # |  1,577,233 |  1,577,233 |
.count b_cont
    b       ble_cont.36009              # |  1,577,233 |  1,577,233 |
ble_else.36009:
    load    [$i11 + 4], $i14            # |  1,793,254 |  1,793,254 |
    load    [$i14 + 2], $f13            # |  1,793,254 |  1,793,254 |
    load    [$i12 + 2], $f14            # |  1,793,254 |  1,793,254 |
    fmul    $f15, $f14, $f14            # |  1,793,254 |  1,793,254 |
    fadd_a  $f14, $f12, $f14            # |  1,793,254 |  1,793,254 |
    bg      $f13, $f14, ble_else.36010  # |  1,793,254 |  1,793,254 |
ble_then.36010:
    li      0, $i14                     # |    570,589 |    570,589 |
.count b_cont
    b       ble_cont.36010              # |    570,589 |    570,589 |
ble_else.36010:
    load    [$i13 + 3], $f13            # |  1,222,665 |  1,222,665 |
    bne     $f13, $f0, be_else.36011    # |  1,222,665 |  1,222,665 |
be_then.36011:
    li      0, $i14
.count b_cont
    b       be_cont.36011
be_else.36011:
    li      1, $i14                     # |  1,222,665 |  1,222,665 |
be_cont.36011:
ble_cont.36010:
ble_cont.36009:
    bne     $i14, 0, be_else.36012      # |  3,370,487 |  3,370,487 |
be_then.36012:
    load    [$i11 + 4], $i14            # |  2,147,822 |  2,147,822 |
    load    [$i14 + 0], $f13            # |  2,147,822 |  2,147,822 |
    load    [$i12 + 0], $f14            # |  2,147,822 |  2,147,822 |
    load    [$i13 + 4], $f15            # |  2,147,822 |  2,147,822 |
    fsub    $f15, $f12, $f12            # |  2,147,822 |  2,147,822 |
    load    [$i13 + 5], $f15            # |  2,147,822 |  2,147,822 |
    fmul    $f12, $f15, $f12            # |  2,147,822 |  2,147,822 |
    fmul    $f12, $f14, $f14            # |  2,147,822 |  2,147,822 |
    fadd_a  $f14, $f10, $f10            # |  2,147,822 |  2,147,822 |
    bg      $f13, $f10, ble_else.36013  # |  2,147,822 |  2,147,822 |
ble_then.36013:
    li      0, $i11                     # |  1,541,308 |  1,541,308 |
.count b_cont
    b       be_cont.36004               # |  1,541,308 |  1,541,308 |
ble_else.36013:
    load    [$i11 + 4], $i11            # |    606,514 |    606,514 |
    load    [$i11 + 1], $f10            # |    606,514 |    606,514 |
    load    [$i12 + 1], $f13            # |    606,514 |    606,514 |
    fmul    $f12, $f13, $f13            # |    606,514 |    606,514 |
    fadd_a  $f13, $f11, $f11            # |    606,514 |    606,514 |
    bg      $f10, $f11, ble_else.36014  # |    606,514 |    606,514 |
ble_then.36014:
    li      0, $i11                     # |    331,936 |    331,936 |
.count b_cont
    b       be_cont.36004               # |    331,936 |    331,936 |
ble_else.36014:
    load    [$i13 + 5], $f10            # |    274,578 |    274,578 |
    bne     $f10, $f0, be_else.36015    # |    274,578 |    274,578 |
be_then.36015:
    li      0, $i11
.count b_cont
    b       be_cont.36004
be_else.36015:
    mov     $f12, $fg0                  # |    274,578 |    274,578 |
    li      3, $i11                     # |    274,578 |    274,578 |
.count b_cont
    b       be_cont.36004               # |    274,578 |    274,578 |
be_else.36012:
    mov     $f15, $fg0                  # |  1,222,665 |  1,222,665 |
    li      2, $i11                     # |  1,222,665 |  1,222,665 |
.count b_cont
    b       be_cont.36004               # |  1,222,665 |  1,222,665 |
be_else.36008:
    mov     $f15, $fg0                  # |    503,425 |    503,425 |
    li      1, $i11                     # |    503,425 |    503,425 |
.count b_cont
    b       be_cont.36004               # |    503,425 |    503,425 |
be_else.36004:
    bne     $i14, 2, be_else.36016      # |  6,670,153 |  6,670,153 |
be_then.36016:
    load    [$i13 + 0], $f10            # |  1,242,328 |  1,242,328 |
    bg      $f0, $f10, ble_else.36017   # |  1,242,328 |  1,242,328 |
ble_then.36017:
    li      0, $i11                     # |    647,143 |    647,143 |
.count b_cont
    b       be_cont.36016               # |    647,143 |    647,143 |
ble_else.36017:
    load    [$i12 + 3], $f11            # |    595,185 |    595,185 |
    fmul    $f10, $f11, $fg0            # |    595,185 |    595,185 |
    li      1, $i11                     # |    595,185 |    595,185 |
.count b_cont
    b       be_cont.36016               # |    595,185 |    595,185 |
be_else.36016:
    load    [$i13 + 0], $f13            # |  5,427,825 |  5,427,825 |
    bne     $f13, $f0, be_else.36018    # |  5,427,825 |  5,427,825 |
be_then.36018:
    li      0, $i11
.count b_cont
    b       be_cont.36018
be_else.36018:
    load    [$i13 + 1], $f14            # |  5,427,825 |  5,427,825 |
    fmul    $f14, $f10, $f10            # |  5,427,825 |  5,427,825 |
    load    [$i13 + 2], $f14            # |  5,427,825 |  5,427,825 |
    fmul    $f14, $f11, $f11            # |  5,427,825 |  5,427,825 |
    fadd    $f10, $f11, $f10            # |  5,427,825 |  5,427,825 |
    load    [$i13 + 3], $f11            # |  5,427,825 |  5,427,825 |
    fmul    $f11, $f12, $f11            # |  5,427,825 |  5,427,825 |
    fadd    $f10, $f11, $f10            # |  5,427,825 |  5,427,825 |
    fmul    $f10, $f10, $f11            # |  5,427,825 |  5,427,825 |
    load    [$i12 + 3], $f12            # |  5,427,825 |  5,427,825 |
    fmul    $f13, $f12, $f12            # |  5,427,825 |  5,427,825 |
    fsub    $f11, $f12, $f11            # |  5,427,825 |  5,427,825 |
    bg      $f11, $f0, ble_else.36019   # |  5,427,825 |  5,427,825 |
ble_then.36019:
    li      0, $i11                     # |  3,746,732 |  3,746,732 |
.count b_cont
    b       ble_cont.36019              # |  3,746,732 |  3,746,732 |
ble_else.36019:
    load    [$i11 + 6], $i11            # |  1,681,093 |  1,681,093 |
    fsqrt   $f11, $f11                  # |  1,681,093 |  1,681,093 |
    bne     $i11, 0, be_else.36020      # |  1,681,093 |  1,681,093 |
be_then.36020:
    fsub    $f10, $f11, $f10            # |  1,260,286 |  1,260,286 |
    load    [$i13 + 4], $f11            # |  1,260,286 |  1,260,286 |
    fmul    $f10, $f11, $fg0            # |  1,260,286 |  1,260,286 |
    li      1, $i11                     # |  1,260,286 |  1,260,286 |
.count b_cont
    b       be_cont.36020               # |  1,260,286 |  1,260,286 |
be_else.36020:
    fadd    $f10, $f11, $f10            # |    420,807 |    420,807 |
    load    [$i13 + 4], $f11            # |    420,807 |    420,807 |
    fmul    $f10, $f11, $fg0            # |    420,807 |    420,807 |
    li      1, $i11                     # |    420,807 |    420,807 |
be_cont.36020:
ble_cont.36019:
be_cont.36018:
be_cont.36016:
be_cont.36004:
    bne     $i11, 0, be_else.36021      # | 10,544,065 | 10,544,065 |
be_then.36021:
    load    [min_caml_objects + $i10], $i1# |  6,267,119 |  6,267,119 |
    load    [$i1 + 6], $i1              # |  6,267,119 |  6,267,119 |
    bne     $i1, 0, be_else.36022       # |  6,267,119 |  6,267,119 |
be_then.36022:
    ret                                 # |  5,339,098 |  5,339,098 |
be_else.36022:
    add     $i2, 1, $i2                 # |    928,021 |    928,021 |
    b       solve_each_element_fast.2885# |    928,021 |    928,021 |
be_else.36021:
    bg      $fg0, $f0, ble_else.36023   # |  4,276,946 |  4,276,946 |
ble_then.36023:
    add     $i2, 1, $i2                 # |  2,880,318 |  2,880,318 |
    b       solve_each_element_fast.2885# |  2,880,318 |  2,880,318 |
ble_else.36023:
    load    [$i4 + 0], $i12             # |  1,396,628 |  1,396,628 |
    bg      $fg7, $fg0, ble_else.36024  # |  1,396,628 |  1,396,628 |
ble_then.36024:
    add     $i2, 1, $i2                 # |    215,261 |    215,261 |
    b       solve_each_element_fast.2885# |    215,261 |    215,261 |
ble_else.36024:
.count stack_move
    sub     $sp, 7, $sp                 # |  1,181,367 |  1,181,367 |
.count stack_store
    store   $ra, [$sp + 0]              # |  1,181,367 |  1,181,367 |
.count stack_store
    store   $i4, [$sp + 1]              # |  1,181,367 |  1,181,367 |
.count stack_store
    store   $i3, [$sp + 2]              # |  1,181,367 |  1,181,367 |
.count stack_store
    store   $i2, [$sp + 3]              # |  1,181,367 |  1,181,367 |
    li      0, $i2                      # |  1,181,367 |  1,181,367 |
    load    [$i12 + 0], $f10            # |  1,181,367 |  1,181,367 |
    fadd    $fg0, $fc16, $f11           # |  1,181,367 |  1,181,367 |
    fmul    $f10, $f11, $f10            # |  1,181,367 |  1,181,367 |
    fadd    $f10, $fg8, $f2             # |  1,181,367 |  1,181,367 |
.count stack_store
    store   $f2, [$sp + 4]              # |  1,181,367 |  1,181,367 |
    load    [$i12 + 1], $f10            # |  1,181,367 |  1,181,367 |
    fmul    $f10, $f11, $f10            # |  1,181,367 |  1,181,367 |
    fadd    $f10, $fg9, $f3             # |  1,181,367 |  1,181,367 |
.count stack_store
    store   $f3, [$sp + 5]              # |  1,181,367 |  1,181,367 |
    load    [$i12 + 2], $f10            # |  1,181,367 |  1,181,367 |
    fmul    $f10, $f11, $f10            # |  1,181,367 |  1,181,367 |
    fadd    $f10, $fg10, $f4            # |  1,181,367 |  1,181,367 |
.count stack_store
    store   $f4, [$sp + 6]              # |  1,181,367 |  1,181,367 |
    call    check_all_inside.2856       # |  1,181,367 |  1,181,367 |
.count stack_load
    load    [$sp + 0], $ra              # |  1,181,367 |  1,181,367 |
.count stack_move
    add     $sp, 7, $sp                 # |  1,181,367 |  1,181,367 |
    bne     $i1, 0, be_else.36025       # |  1,181,367 |  1,181,367 |
be_then.36025:
.count stack_load
    load    [$sp - 4], $i1              # |    424,948 |    424,948 |
    add     $i1, 1, $i2                 # |    424,948 |    424,948 |
.count stack_load
    load    [$sp - 5], $i3              # |    424,948 |    424,948 |
.count stack_load
    load    [$sp - 6], $i4              # |    424,948 |    424,948 |
    b       solve_each_element_fast.2885# |    424,948 |    424,948 |
be_else.36025:
    mov     $f11, $fg7                  # |    756,419 |    756,419 |
.count stack_load
    load    [$sp - 3], $i1              # |    756,419 |    756,419 |
    store   $i1, [min_caml_intersection_point + 0]# |    756,419 |    756,419 |
.count stack_load
    load    [$sp - 2], $i1              # |    756,419 |    756,419 |
    store   $i1, [min_caml_intersection_point + 1]# |    756,419 |    756,419 |
.count stack_load
    load    [$sp - 1], $i1              # |    756,419 |    756,419 |
    store   $i1, [min_caml_intersection_point + 2]# |    756,419 |    756,419 |
    mov     $i10, $ig5                  # |    756,419 |    756,419 |
    mov     $i11, $ig4                  # |    756,419 |    756,419 |
.count stack_load
    load    [$sp - 4], $i1              # |    756,419 |    756,419 |
    add     $i1, 1, $i2                 # |    756,419 |    756,419 |
.count stack_load
    load    [$sp - 5], $i3              # |    756,419 |    756,419 |
.count stack_load
    load    [$sp - 6], $i4              # |    756,419 |    756,419 |
    b       solve_each_element_fast.2885# |    756,419 |    756,419 |
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
    load    [$i3 + $i2], $i15           # |    684,824 |    684,824 |
    bne     $i15, -1, be_else.36026     # |    684,824 |    684,824 |
be_then.36026:
    ret
be_else.36026:
.count stack_move
    sub     $sp, 4, $sp                 # |    684,824 |    684,824 |
.count stack_store
    store   $ra, [$sp + 0]              # |    684,824 |    684,824 |
.count stack_store
    store   $i4, [$sp + 1]              # |    684,824 |    684,824 |
.count stack_store
    store   $i3, [$sp + 2]              # |    684,824 |    684,824 |
.count stack_store
    store   $i2, [$sp + 3]              # |    684,824 |    684,824 |
    li      0, $i2                      # |    684,824 |    684,824 |
    load    [min_caml_and_net + $i15], $i3# |    684,824 |    684,824 |
    call    solve_each_element_fast.2885# |    684,824 |    684,824 |
.count stack_load
    load    [$sp + 3], $i15             # |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
.count stack_load
    load    [$sp + 2], $i16             # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i17         # |    684,824 |    684,824 |
    bne     $i17, -1, be_else.36027     # |    684,824 |    684,824 |
be_then.36027:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.36027:
    li      0, $i2                      # |    684,824 |    684,824 |
    load    [min_caml_and_net + $i17], $i3# |    684,824 |    684,824 |
.count stack_load
    load    [$sp + 1], $i4              # |    684,824 |    684,824 |
    call    solve_each_element_fast.2885# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i17         # |    684,824 |    684,824 |
    bne     $i17, -1, be_else.36028     # |    684,824 |    684,824 |
be_then.36028:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.36028:
    li      0, $i2                      # |    684,824 |    684,824 |
    load    [min_caml_and_net + $i17], $i3# |    684,824 |    684,824 |
.count stack_load
    load    [$sp + 1], $i4              # |    684,824 |    684,824 |
    call    solve_each_element_fast.2885# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i17         # |    684,824 |    684,824 |
    bne     $i17, -1, be_else.36029     # |    684,824 |    684,824 |
be_then.36029:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.36029:
    li      0, $i2                      # |    684,824 |    684,824 |
    load    [min_caml_and_net + $i17], $i3# |    684,824 |    684,824 |
.count stack_load
    load    [$sp + 1], $i4              # |    684,824 |    684,824 |
    call    solve_each_element_fast.2885# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i17         # |    684,824 |    684,824 |
    bne     $i17, -1, be_else.36030     # |    684,824 |    684,824 |
be_then.36030:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.36030:
    li      0, $i2                      # |    684,824 |    684,824 |
    load    [min_caml_and_net + $i17], $i3# |    684,824 |    684,824 |
.count stack_load
    load    [$sp + 1], $i4              # |    684,824 |    684,824 |
    call    solve_each_element_fast.2885# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i17         # |    684,824 |    684,824 |
    bne     $i17, -1, be_else.36031     # |    684,824 |    684,824 |
be_then.36031:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.36031:
    li      0, $i2                      # |    684,824 |    684,824 |
    load    [min_caml_and_net + $i17], $i3# |    684,824 |    684,824 |
.count stack_load
    load    [$sp + 1], $i4              # |    684,824 |    684,824 |
    call    solve_each_element_fast.2885# |    684,824 |    684,824 |
    add     $i15, 1, $i15               # |    684,824 |    684,824 |
    load    [$i16 + $i15], $i17         # |    684,824 |    684,824 |
    bne     $i17, -1, be_else.36032     # |    684,824 |    684,824 |
be_then.36032:
.count stack_load
    load    [$sp + 0], $ra              # |    684,824 |    684,824 |
.count stack_move
    add     $sp, 4, $sp                 # |    684,824 |    684,824 |
    ret                                 # |    684,824 |    684,824 |
be_else.36032:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element_fast.2885
    add     $i15, 1, $i15
    load    [$i16 + $i15], $i17
    bne     $i17, -1, be_else.36033
be_then.36033:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    ret
be_else.36033:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element_fast.2885
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 4, $sp
    add     $i15, 1, $i2
.count stack_load
    load    [$sp - 3], $i4
.count move_args
    mov     $i16, $i3
    b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
    load    [$i3 + $i2], $i15           # |  1,134,616 |  1,134,616 |
    load    [$i15 + 0], $i16            # |  1,134,616 |  1,134,616 |
    bne     $i16, -1, be_else.36034     # |  1,134,616 |  1,134,616 |
be_then.36034:
    ret
be_else.36034:
.count stack_move
    sub     $sp, 5, $sp                 # |  1,134,616 |  1,134,616 |
.count stack_store
    store   $ra, [$sp + 0]              # |  1,134,616 |  1,134,616 |
.count stack_store
    store   $i4, [$sp + 1]              # |  1,134,616 |  1,134,616 |
.count stack_store
    store   $i3, [$sp + 2]              # |  1,134,616 |  1,134,616 |
.count stack_store
    store   $i2, [$sp + 3]              # |  1,134,616 |  1,134,616 |
    bne     $i16, 99, be_else.36035     # |  1,134,616 |  1,134,616 |
be_then.36035:
    load    [$i15 + 1], $i16            # |  1,134,616 |  1,134,616 |
    be      $i16, -1, bne_cont.36036    # |  1,134,616 |  1,134,616 |
bne_then.36036:
    li      0, $i2                      # |  1,134,616 |  1,134,616 |
    load    [min_caml_and_net + $i16], $i3# |  1,134,616 |  1,134,616 |
    call    solve_each_element_fast.2885# |  1,134,616 |  1,134,616 |
    load    [$i15 + 2], $i16            # |  1,134,616 |  1,134,616 |
    be      $i16, -1, bne_cont.36037    # |  1,134,616 |  1,134,616 |
bne_then.36037:
    li      0, $i2                      # |  1,134,616 |  1,134,616 |
    load    [min_caml_and_net + $i16], $i3# |  1,134,616 |  1,134,616 |
.count stack_load
    load    [$sp + 1], $i4              # |  1,134,616 |  1,134,616 |
    call    solve_each_element_fast.2885# |  1,134,616 |  1,134,616 |
    load    [$i15 + 3], $i16            # |  1,134,616 |  1,134,616 |
    be      $i16, -1, bne_cont.36038    # |  1,134,616 |  1,134,616 |
bne_then.36038:
    li      0, $i2                      # |  1,134,616 |  1,134,616 |
    load    [min_caml_and_net + $i16], $i3# |  1,134,616 |  1,134,616 |
.count stack_load
    load    [$sp + 1], $i4              # |  1,134,616 |  1,134,616 |
    call    solve_each_element_fast.2885# |  1,134,616 |  1,134,616 |
    load    [$i15 + 4], $i16            # |  1,134,616 |  1,134,616 |
    be      $i16, -1, bne_cont.36039    # |  1,134,616 |  1,134,616 |
bne_then.36039:
    li      0, $i2                      # |  1,134,616 |  1,134,616 |
    load    [min_caml_and_net + $i16], $i3# |  1,134,616 |  1,134,616 |
.count stack_load
    load    [$sp + 1], $i4              # |  1,134,616 |  1,134,616 |
    call    solve_each_element_fast.2885# |  1,134,616 |  1,134,616 |
    load    [$i15 + 5], $i16            # |  1,134,616 |  1,134,616 |
    be      $i16, -1, bne_cont.36040    # |  1,134,616 |  1,134,616 |
bne_then.36040:
    li      0, $i2
    load    [min_caml_and_net + $i16], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element_fast.2885
    load    [$i15 + 6], $i16
    be      $i16, -1, bne_cont.36041
bne_then.36041:
    li      0, $i2
    load    [min_caml_and_net + $i16], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element_fast.2885
    li      7, $i2
.count stack_load
    load    [$sp + 1], $i4
.count move_args
    mov     $i15, $i3
    call    solve_one_or_network_fast.2889
bne_cont.36041:
bne_cont.36040:
bne_cont.36039:
bne_cont.36038:
bne_cont.36037:
bne_cont.36036:
.count stack_load
    load    [$sp + 3], $i15             # |  1,134,616 |  1,134,616 |
    add     $i15, 1, $i15               # |  1,134,616 |  1,134,616 |
.count stack_load
    load    [$sp + 2], $i3              # |  1,134,616 |  1,134,616 |
    load    [$i3 + $i15], $i16          # |  1,134,616 |  1,134,616 |
    load    [$i16 + 0], $i17            # |  1,134,616 |  1,134,616 |
    bne     $i17, -1, be_else.36042     # |  1,134,616 |  1,134,616 |
be_then.36042:
.count stack_load
    load    [$sp + 0], $ra              # |  1,134,616 |  1,134,616 |
.count stack_move
    add     $sp, 5, $sp                 # |  1,134,616 |  1,134,616 |
    ret                                 # |  1,134,616 |  1,134,616 |
be_else.36042:
    bne     $i17, 99, be_else.36043
be_then.36043:
    load    [$i16 + 1], $i17
    bne     $i17, -1, be_else.36044
be_then.36044:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i15, 1, $i2
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
be_else.36044:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element_fast.2885
    load    [$i16 + 2], $i17
    bne     $i17, -1, be_else.36045
be_then.36045:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i15, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
be_else.36045:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element_fast.2885
    load    [$i16 + 3], $i17
    bne     $i17, -1, be_else.36046
be_then.36046:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i15, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
be_else.36046:
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element_fast.2885
    load    [$i16 + 4], $i17
    bne     $i17, -1, be_else.36047
be_then.36047:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i15, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
be_else.36047:
.count stack_store
    store   $i15, [$sp + 4]
    li      0, $i2
    load    [min_caml_and_net + $i17], $i3
.count stack_load
    load    [$sp + 1], $i4
    call    solve_each_element_fast.2885
    li      5, $i2
.count stack_load
    load    [$sp + 1], $i4
.count move_args
    mov     $i16, $i3
    call    solve_one_or_network_fast.2889
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
be_else.36043:
.count stack_load
    load    [$sp + 1], $i3
.count move_args
    mov     $i17, $i2
    call    solver_fast2.2814
.count move_ret
    mov     $i1, $i18
    bne     $i18, 0, be_else.36048
be_then.36048:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i15, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
be_else.36048:
    bg      $fg7, $fg0, ble_else.36049
ble_then.36049:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    add     $i15, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
ble_else.36049:
.count stack_store
    store   $i15, [$sp + 4]
    li      1, $i2
.count stack_load
    load    [$sp + 1], $i4
.count move_args
    mov     $i16, $i3
    call    solve_one_or_network_fast.2889
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
be_else.36035:
.count move_args
    mov     $i16, $i2
.count move_args
    mov     $i4, $i3
    call    solver_fast2.2814
.count move_ret
    mov     $i1, $i18
    bne     $i18, 0, be_else.36050
be_then.36050:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 2], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
be_else.36050:
    bg      $fg7, $fg0, ble_else.36051
ble_then.36051:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 2], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
ble_else.36051:
    li      1, $i2
.count stack_load
    load    [$sp + 1], $i4
.count move_args
    mov     $i15, $i3
    call    solve_one_or_network_fast.2889
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 2], $i1
    add     $i1, 1, $i2
.count stack_load
    load    [$sp - 3], $i3
.count stack_load
    load    [$sp - 4], $i4
    b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture
######################################################################
.begin utexture
utexture.2908:
    load    [$i2 + 8], $i1              # |    660,661 |    660,661 |
    load    [$i1 + 0], $fg16            # |    660,661 |    660,661 |
    load    [$i2 + 8], $i1              # |    660,661 |    660,661 |
    load    [$i1 + 1], $fg11            # |    660,661 |    660,661 |
    load    [$i2 + 8], $i1              # |    660,661 |    660,661 |
    load    [$i1 + 2], $fg15            # |    660,661 |    660,661 |
    load    [$i2 + 0], $i1              # |    660,661 |    660,661 |
    bne     $i1, 1, be_else.36052       # |    660,661 |    660,661 |
be_then.36052:
.count stack_move
    sub     $sp, 3, $sp                 # |     94,582 |     94,582 |
.count stack_store
    store   $ra, [$sp + 0]              # |     94,582 |     94,582 |
    load    [$i2 + 5], $i1              # |     94,582 |     94,582 |
    load    [$i2 + 5], $i10             # |     94,582 |     94,582 |
    load    [min_caml_intersection_point + 0], $f10# |     94,582 |     94,582 |
    load    [$i1 + 0], $f11             # |     94,582 |     94,582 |
.count load_float
    load    [f.31965], $f12             # |     94,582 |     94,582 |
    fsub    $f10, $f11, $f10            # |     94,582 |     94,582 |
    fmul    $f10, $f12, $f2             # |     94,582 |     94,582 |
    call    min_caml_floor              # |     94,582 |     94,582 |
.count move_ret
    mov     $f1, $f11                   # |     94,582 |     94,582 |
.count load_float
    load    [f.31966], $f13             # |     94,582 |     94,582 |
.count load_float
    load    [f.31967], $f14             # |     94,582 |     94,582 |
    fmul    $f11, $f13, $f11            # |     94,582 |     94,582 |
    fsub    $f10, $f11, $f10            # |     94,582 |     94,582 |
    load    [min_caml_intersection_point + 2], $f11# |     94,582 |     94,582 |
    load    [$i10 + 2], $f15            # |     94,582 |     94,582 |
    fsub    $f11, $f15, $f11            # |     94,582 |     94,582 |
    fmul    $f11, $f12, $f2             # |     94,582 |     94,582 |
    call    min_caml_floor              # |     94,582 |     94,582 |
.count stack_load
    load    [$sp + 0], $ra              # |     94,582 |     94,582 |
.count stack_move
    add     $sp, 3, $sp                 # |     94,582 |     94,582 |
    fmul    $f1, $f13, $f1              # |     94,582 |     94,582 |
    fsub    $f11, $f1, $f1              # |     94,582 |     94,582 |
    bg      $f14, $f10, ble_else.36053  # |     94,582 |     94,582 |
ble_then.36053:
    li      0, $i1                      # |     50,346 |     50,346 |
.count b_cont
    b       ble_cont.36053              # |     50,346 |     50,346 |
ble_else.36053:
    li      1, $i1                      # |     44,236 |     44,236 |
ble_cont.36053:
    bg      $f14, $f1, ble_else.36054   # |     94,582 |     94,582 |
ble_then.36054:
    bne     $i1, 0, be_else.36055       # |     45,724 |     45,724 |
be_then.36055:
    mov     $fc9, $fg11                 # |     24,135 |     24,135 |
    ret                                 # |     24,135 |     24,135 |
be_else.36055:
    mov     $f0, $fg11                  # |     21,589 |     21,589 |
    ret                                 # |     21,589 |     21,589 |
ble_else.36054:
    bne     $i1, 0, be_else.36056       # |     48,858 |     48,858 |
be_then.36056:
    mov     $f0, $fg11                  # |     26,211 |     26,211 |
    ret                                 # |     26,211 |     26,211 |
be_else.36056:
    mov     $fc9, $fg11                 # |     22,647 |     22,647 |
    ret                                 # |     22,647 |     22,647 |
be_else.36052:
    bne     $i1, 2, be_else.36057       # |    566,079 |    566,079 |
be_then.36057:
.count stack_move
    sub     $sp, 3, $sp                 # |      2,885 |      2,885 |
.count stack_store
    store   $ra, [$sp + 0]              # |      2,885 |      2,885 |
    load    [min_caml_intersection_point + 1], $f10# |      2,885 |      2,885 |
.count load_float
    load    [f.31964], $f11             # |      2,885 |      2,885 |
    fmul    $f10, $f11, $f2             # |      2,885 |      2,885 |
    call    min_caml_sin                # |      2,885 |      2,885 |
.count stack_load
    load    [$sp + 0], $ra              # |      2,885 |      2,885 |
.count stack_move
    add     $sp, 3, $sp                 # |      2,885 |      2,885 |
    fmul    $f1, $f1, $f1               # |      2,885 |      2,885 |
    fmul    $fc9, $f1, $fg16            # |      2,885 |      2,885 |
    fsub    $fc0, $f1, $f1              # |      2,885 |      2,885 |
    fmul    $fc9, $f1, $fg11            # |      2,885 |      2,885 |
    ret                                 # |      2,885 |      2,885 |
be_else.36057:
    bne     $i1, 3, be_else.36058       # |    563,194 |    563,194 |
be_then.36058:
.count stack_move
    sub     $sp, 3, $sp
.count stack_store
    store   $ra, [$sp + 0]
    load    [$i2 + 5], $i1
    load    [$i2 + 5], $i10
    load    [min_caml_intersection_point + 0], $f10
    load    [$i1 + 0], $f11
    fsub    $f10, $f11, $f10
    fmul    $f10, $f10, $f10
    load    [min_caml_intersection_point + 2], $f11
    load    [$i10 + 2], $f12
    fsub    $f11, $f12, $f11
    fmul    $f11, $f11, $f11
    fadd    $f10, $f11, $f10
    fsqrt   $f10, $f10
    fmul    $f10, $fc8, $f2
.count stack_store
    store   $f2, [$sp + 1]
    call    min_caml_floor
.count move_ret
    mov     $f1, $f10
.count stack_load
    load    [$sp + 1], $f11
    fsub    $f11, $f10, $f10
    fmul    $f10, $fc15, $f2
    call    min_caml_cos
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    fmul    $f1, $f1, $f1
    fmul    $f1, $fc9, $fg11
    fsub    $fc0, $f1, $f1
    fmul    $f1, $fc9, $fg15
    ret
be_else.36058:
    bne     $i1, 4, be_else.36059       # |    563,194 |    563,194 |
be_then.36059:
.count stack_move
    sub     $sp, 3, $sp
.count stack_store
    store   $ra, [$sp + 0]
.count stack_store
    store   $i2, [$sp + 2]
    load    [$i2 + 5], $i1
    load    [$i2 + 4], $i10
    load    [$i2 + 5], $i11
    load    [$i2 + 4], $i12
.count load_float
    load    [f.31955], $f10
    load    [min_caml_intersection_point + 0], $f11
    load    [$i1 + 0], $f12
    fsub    $f11, $f12, $f11
    load    [$i10 + 0], $f12
    fsqrt   $f12, $f12
    fmul    $f11, $f12, $f11
    fabs    $f11, $f12
    load    [min_caml_intersection_point + 2], $f13
    load    [$i11 + 2], $f14
    fsub    $f13, $f14, $f13
    load    [$i12 + 2], $f14
    fsqrt   $f14, $f14
    fmul    $f13, $f14, $f13
    bg      $f10, $f12, ble_else.36060
ble_then.36060:
    finv    $f11, $f12
    fmul_a  $f13, $f12, $f2
    call    min_caml_atan
.count move_ret
    mov     $f1, $f12
    fmul    $f12, $fc18, $f12
    fmul    $f12, $fc17, $f12
.count b_cont
    b       ble_cont.36060
ble_else.36060:
    mov     $fc19, $f12
ble_cont.36060:
.count stack_load
    load    [$sp + 2], $i1
    load    [$i1 + 5], $i10
    load    [$i1 + 4], $i1
    fmul    $f11, $f11, $f11
    fmul    $f13, $f13, $f13
    fadd    $f11, $f13, $f11
    fabs    $f11, $f13
    load    [min_caml_intersection_point + 1], $f14
    load    [$i10 + 1], $f15
    fsub    $f14, $f15, $f14
    load    [$i1 + 1], $f15
    fsqrt   $f15, $f15
    fmul    $f14, $f15, $f14
    bg      $f10, $f13, ble_else.36061
ble_then.36061:
    finv    $f11, $f10
    fmul_a  $f14, $f10, $f2
    call    min_caml_atan
.count move_ret
    mov     $f1, $f10
    fmul    $f10, $fc18, $f10
    fmul    $f10, $fc17, $f10
.count b_cont
    b       ble_cont.36061
ble_else.36061:
    mov     $fc19, $f10
ble_cont.36061:
.count load_float
    load    [f.31960], $f11
.count move_args
    mov     $f12, $f2
    call    min_caml_floor
.count move_ret
    mov     $f1, $f13
    fsub    $f12, $f13, $f12
    fsub    $fc3, $f12, $f12
    fmul    $f12, $f12, $f12
    fsub    $f11, $f12, $f11
.count move_args
    mov     $f10, $f2
    call    min_caml_floor
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    fsub    $f10, $f1, $f1
    fsub    $fc3, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f11, $f1, $f1
    bg      $f0, $f1, ble_else.36062
ble_then.36062:
    fmul    $fc9, $f1, $f1
.count load_float
    load    [f.31962], $f2
    fmul    $f1, $f2, $fg15
    ret
ble_else.36062:
    mov     $f0, $fg15
    ret
be_else.36059:
    ret                                 # |    563,194 |    563,194 |
.end utexture

######################################################################
# trace_reflections
######################################################################
.begin trace_reflections
trace_reflections.2915:
    bl      $i2, 0, bge_else.36063      # |     36,992 |     36,992 |
bge_then.36063:
.count stack_move
    sub     $sp, 7, $sp                 # |     18,496 |     18,496 |
.count stack_store
    store   $ra, [$sp + 0]              # |     18,496 |     18,496 |
.count stack_store
    store   $i3, [$sp + 1]              # |     18,496 |     18,496 |
.count stack_store
    store   $f3, [$sp + 2]              # |     18,496 |     18,496 |
.count stack_store
    store   $f2, [$sp + 3]              # |     18,496 |     18,496 |
.count stack_store
    store   $i2, [$sp + 4]              # |     18,496 |     18,496 |
    load    [min_caml_reflections + $i2], $i19# |     18,496 |     18,496 |
    load    [$i19 + 1], $i4             # |     18,496 |     18,496 |
.count stack_store
    store   $i4, [$sp + 5]              # |     18,496 |     18,496 |
    mov     $fc14, $fg7                 # |     18,496 |     18,496 |
    load    [$ig2 + 0], $i20            # |     18,496 |     18,496 |
    load    [$i20 + 0], $i21            # |     18,496 |     18,496 |
    be      $i21, -1, bne_cont.36064    # |     18,496 |     18,496 |
bne_then.36064:
    bne     $i21, 99, be_else.36065     # |     18,496 |     18,496 |
be_then.36065:
    load    [$i20 + 1], $i21
    bne     $i21, -1, be_else.36066
be_then.36066:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36065
be_else.36066:
    li      0, $i2
    load    [min_caml_and_net + $i21], $i3
    call    solve_each_element_fast.2885
    load    [$i20 + 2], $i21
.count stack_load
    load    [$sp + 5], $i4
    bne     $i21, -1, be_else.36067
be_then.36067:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36065
be_else.36067:
    li      0, $i2
    load    [min_caml_and_net + $i21], $i3
    call    solve_each_element_fast.2885
    load    [$i20 + 3], $i21
.count stack_load
    load    [$sp + 5], $i4
    bne     $i21, -1, be_else.36068
be_then.36068:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36065
be_else.36068:
    li      0, $i2
    load    [min_caml_and_net + $i21], $i3
    call    solve_each_element_fast.2885
    load    [$i20 + 4], $i21
.count stack_load
    load    [$sp + 5], $i4
    bne     $i21, -1, be_else.36069
be_then.36069:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36065
be_else.36069:
    li      0, $i2
    load    [min_caml_and_net + $i21], $i3
    call    solve_each_element_fast.2885
    li      5, $i2
.count stack_load
    load    [$sp + 5], $i4
.count move_args
    mov     $i20, $i3
    call    solve_one_or_network_fast.2889
    li      1, $i2
.count stack_load
    load    [$sp + 5], $i4
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36065
be_else.36065:
.count move_args
    mov     $i21, $i2                   # |     18,496 |     18,496 |
.count move_args
    mov     $i4, $i3                    # |     18,496 |     18,496 |
    call    solver_fast2.2814           # |     18,496 |     18,496 |
.count move_ret
    mov     $i1, $i21                   # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 5], $i4              # |     18,496 |     18,496 |
    li      1, $i2                      # |     18,496 |     18,496 |
    bne     $i21, 0, be_else.36070      # |     18,496 |     18,496 |
be_then.36070:
.count move_args
    mov     $ig2, $i3                   # |     13,470 |     13,470 |
    call    trace_or_matrix_fast.2893   # |     13,470 |     13,470 |
.count b_cont
    b       be_cont.36070               # |     13,470 |     13,470 |
be_else.36070:
    bg      $fg7, $fg0, ble_else.36071  # |      5,026 |      5,026 |
ble_then.36071:
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       ble_cont.36071
ble_else.36071:
.count move_args
    mov     $i20, $i3                   # |      5,026 |      5,026 |
    call    solve_one_or_network_fast.2889# |      5,026 |      5,026 |
    li      1, $i2                      # |      5,026 |      5,026 |
.count stack_load
    load    [$sp + 5], $i4              # |      5,026 |      5,026 |
.count move_args
    mov     $ig2, $i3                   # |      5,026 |      5,026 |
    call    trace_or_matrix_fast.2893   # |      5,026 |      5,026 |
ble_cont.36071:
be_cont.36070:
be_cont.36065:
bne_cont.36064:
    bg      $fg7, $fc7, ble_else.36072  # |     18,496 |     18,496 |
ble_then.36072:
    li      0, $i22
.count b_cont
    b       ble_cont.36072
ble_else.36072:
    bg      $fc13, $fg7, ble_else.36073 # |     18,496 |     18,496 |
ble_then.36073:
    li      0, $i22                     # |      7,212 |      7,212 |
.count b_cont
    b       ble_cont.36073              # |      7,212 |      7,212 |
ble_else.36073:
    li      1, $i22                     # |     11,284 |     11,284 |
ble_cont.36073:
ble_cont.36072:
    bne     $i22, 0, be_else.36074      # |     18,496 |     18,496 |
be_then.36074:
.count stack_load
    load    [$sp + 0], $ra              # |      7,212 |      7,212 |
.count stack_move
    add     $sp, 7, $sp                 # |      7,212 |      7,212 |
.count stack_load
    load    [$sp - 3], $i1              # |      7,212 |      7,212 |
    sub     $i1, 1, $i2                 # |      7,212 |      7,212 |
.count stack_load
    load    [$sp - 4], $f2              # |      7,212 |      7,212 |
.count stack_load
    load    [$sp - 5], $f3              # |      7,212 |      7,212 |
.count stack_load
    load    [$sp - 6], $i3              # |      7,212 |      7,212 |
    b       trace_reflections.2915      # |      7,212 |      7,212 |
be_else.36074:
    load    [$i19 + 0], $i22            # |     11,284 |     11,284 |
    add     $ig5, $ig5, $i23            # |     11,284 |     11,284 |
    add     $i23, $i23, $i23            # |     11,284 |     11,284 |
    add     $i23, $ig4, $i23            # |     11,284 |     11,284 |
    bne     $i23, $i22, be_else.36075   # |     11,284 |     11,284 |
be_then.36075:
.count stack_store
    store   $i19, [$sp + 6]             # |     10,334 |     10,334 |
    li      0, $i2                      # |     10,334 |     10,334 |
.count move_args
    mov     $ig2, $i3                   # |     10,334 |     10,334 |
    call    shadow_check_one_or_matrix.2868# |     10,334 |     10,334 |
.count stack_load
    load    [$sp + 0], $ra              # |     10,334 |     10,334 |
.count stack_move
    add     $sp, 7, $sp                 # |     10,334 |     10,334 |
.count stack_load
    load    [$sp - 4], $f2              # |     10,334 |     10,334 |
    bne     $i1, 0, be_else.36076       # |     10,334 |     10,334 |
be_then.36076:
.count stack_load
    load    [$sp - 1], $i1              # |     10,334 |     10,334 |
    load    [$i1 + 2], $f1              # |     10,334 |     10,334 |
.count stack_load
    load    [$sp - 2], $i1              # |     10,334 |     10,334 |
    load    [$i1 + 0], $i1              # |     10,334 |     10,334 |
    fmul    $f1, $f2, $f3               # |     10,334 |     10,334 |
    load    [min_caml_nvector + 0], $f4 # |     10,334 |     10,334 |
    load    [$i1 + 0], $f5              # |     10,334 |     10,334 |
    fmul    $f4, $f5, $f4               # |     10,334 |     10,334 |
    load    [min_caml_nvector + 1], $f6 # |     10,334 |     10,334 |
    load    [$i1 + 1], $f7              # |     10,334 |     10,334 |
    fmul    $f6, $f7, $f6               # |     10,334 |     10,334 |
    fadd    $f4, $f6, $f4               # |     10,334 |     10,334 |
    load    [min_caml_nvector + 2], $f6 # |     10,334 |     10,334 |
    load    [$i1 + 2], $f8              # |     10,334 |     10,334 |
    fmul    $f6, $f8, $f6               # |     10,334 |     10,334 |
    fadd    $f4, $f6, $f4               # |     10,334 |     10,334 |
    fmul    $f3, $f4, $f3               # |     10,334 |     10,334 |
    ble     $f3, $f0, bg_cont.36077     # |     10,334 |     10,334 |
bg_then.36077:
    fmul    $f3, $fg16, $f4             # |      9,373 |      9,373 |
    fadd    $fg4, $f4, $fg4             # |      9,373 |      9,373 |
    fmul    $f3, $fg11, $f4             # |      9,373 |      9,373 |
    fadd    $fg5, $f4, $fg5             # |      9,373 |      9,373 |
    fmul    $f3, $fg15, $f3             # |      9,373 |      9,373 |
    fadd    $fg6, $f3, $fg6             # |      9,373 |      9,373 |
bg_cont.36077:
.count stack_load
    load    [$sp - 6], $i3              # |     10,334 |     10,334 |
    load    [$i3 + 0], $f3              # |     10,334 |     10,334 |
    fmul    $f3, $f5, $f3               # |     10,334 |     10,334 |
    load    [$i3 + 1], $f4              # |     10,334 |     10,334 |
    fmul    $f4, $f7, $f4               # |     10,334 |     10,334 |
    fadd    $f3, $f4, $f3               # |     10,334 |     10,334 |
    load    [$i3 + 2], $f4              # |     10,334 |     10,334 |
    fmul    $f4, $f8, $f4               # |     10,334 |     10,334 |
    fadd    $f3, $f4, $f3               # |     10,334 |     10,334 |
    fmul    $f1, $f3, $f1               # |     10,334 |     10,334 |
.count stack_load
    load    [$sp - 5], $f3              # |     10,334 |     10,334 |
.count stack_load
    load    [$sp - 3], $i1              # |     10,334 |     10,334 |
    sub     $i1, 1, $i2                 # |     10,334 |     10,334 |
    ble     $f1, $f0, trace_reflections.2915# |     10,334 |     10,334 |
    fmul    $f1, $f1, $f1               # |      7,720 |      7,720 |
    fmul    $f1, $f1, $f1               # |      7,720 |      7,720 |
    fmul    $f1, $f3, $f1               # |      7,720 |      7,720 |
    fadd    $fg4, $f1, $fg4             # |      7,720 |      7,720 |
    fadd    $fg5, $f1, $fg5             # |      7,720 |      7,720 |
    fadd    $fg6, $f1, $fg6             # |      7,720 |      7,720 |
    b       trace_reflections.2915      # |      7,720 |      7,720 |
be_else.36076:
.count stack_load
    load    [$sp - 3], $i1
    sub     $i1, 1, $i2
.count stack_load
    load    [$sp - 5], $f3
.count stack_load
    load    [$sp - 6], $i3
    b       trace_reflections.2915
be_else.36075:
.count stack_load
    load    [$sp + 0], $ra              # |        950 |        950 |
.count stack_move
    add     $sp, 7, $sp                 # |        950 |        950 |
.count stack_load
    load    [$sp - 3], $i1              # |        950 |        950 |
    sub     $i1, 1, $i2                 # |        950 |        950 |
.count stack_load
    load    [$sp - 4], $f2              # |        950 |        950 |
.count stack_load
    load    [$sp - 5], $f3              # |        950 |        950 |
.count stack_load
    load    [$sp - 6], $i3              # |        950 |        950 |
    b       trace_reflections.2915      # |        950 |        950 |
bge_else.36063:
    ret                                 # |     18,496 |     18,496 |
.end trace_reflections

######################################################################
# trace_ray
######################################################################
.begin trace_ray
trace_ray.2920:
    bg      $i2, 4, ble_else.36079      # |     23,754 |     23,754 |
ble_then.36079:
.count stack_move
    sub     $sp, 10, $sp                # |     23,754 |     23,754 |
.count stack_store
    store   $ra, [$sp + 0]              # |     23,754 |     23,754 |
.count stack_store
    store   $f3, [$sp + 1]              # |     23,754 |     23,754 |
.count stack_store
    store   $f2, [$sp + 2]              # |     23,754 |     23,754 |
.count stack_store
    store   $i3, [$sp + 3]              # |     23,754 |     23,754 |
.count stack_store
    store   $i2, [$sp + 4]              # |     23,754 |     23,754 |
.count stack_store
    store   $i4, [$sp + 5]              # |     23,754 |     23,754 |
    mov     $fc14, $fg7                 # |     23,754 |     23,754 |
    load    [$ig2 + 0], $i20            # |     23,754 |     23,754 |
    load    [$i20 + 0], $i21            # |     23,754 |     23,754 |
    be      $i21, -1, bne_cont.36080    # |     23,754 |     23,754 |
bne_then.36080:
    bne     $i21, 99, be_else.36081     # |     23,754 |     23,754 |
be_then.36081:
    load    [$i20 + 1], $i21
.count move_args
    mov     $i3, $i4
    bne     $i21, -1, be_else.36082
be_then.36082:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix.2879
.count b_cont
    b       be_cont.36081
be_else.36082:
    li      0, $i2
    load    [min_caml_and_net + $i21], $i16
.count move_args
    mov     $i16, $i3
    call    solve_each_element.2871
    load    [$i20 + 2], $i21
.count stack_load
    load    [$sp + 3], $i4
    bne     $i21, -1, be_else.36083
be_then.36083:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix.2879
.count b_cont
    b       be_cont.36081
be_else.36083:
    li      0, $i2
    load    [min_caml_and_net + $i21], $i3
    call    solve_each_element.2871
    load    [$i20 + 3], $i21
.count stack_load
    load    [$sp + 3], $i4
    bne     $i21, -1, be_else.36084
be_then.36084:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix.2879
.count b_cont
    b       be_cont.36081
be_else.36084:
    li      0, $i2
    load    [min_caml_and_net + $i21], $i3
    call    solve_each_element.2871
    load    [$i20 + 4], $i21
.count stack_load
    load    [$sp + 3], $i4
    bne     $i21, -1, be_else.36085
be_then.36085:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix.2879
.count b_cont
    b       be_cont.36081
be_else.36085:
    li      0, $i2
    load    [min_caml_and_net + $i21], $i3
    call    solve_each_element.2871
    li      5, $i2
.count stack_load
    load    [$sp + 3], $i4
.count move_args
    mov     $i20, $i3
    call    solve_one_or_network.2875
    li      1, $i2
.count stack_load
    load    [$sp + 3], $i4
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix.2879
.count b_cont
    b       be_cont.36081
be_else.36081:
.count move_args
    mov     $i21, $i2                   # |     23,754 |     23,754 |
    call    solver.2773                 # |     23,754 |     23,754 |
.count move_ret
    mov     $i1, $i21                   # |     23,754 |     23,754 |
.count stack_load
    load    [$sp + 3], $i4              # |     23,754 |     23,754 |
    li      1, $i2                      # |     23,754 |     23,754 |
    bne     $i21, 0, be_else.36086      # |     23,754 |     23,754 |
be_then.36086:
.count move_args
    mov     $ig2, $i3                   # |     16,978 |     16,978 |
    call    trace_or_matrix.2879        # |     16,978 |     16,978 |
.count b_cont
    b       be_cont.36086               # |     16,978 |     16,978 |
be_else.36086:
    bg      $fg7, $fg0, ble_else.36087  # |      6,776 |      6,776 |
ble_then.36087:
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix.2879
.count b_cont
    b       ble_cont.36087
ble_else.36087:
.count move_args
    mov     $i20, $i3                   # |      6,776 |      6,776 |
    call    solve_one_or_network.2875   # |      6,776 |      6,776 |
    li      1, $i2                      # |      6,776 |      6,776 |
.count stack_load
    load    [$sp + 3], $i4              # |      6,776 |      6,776 |
.count move_args
    mov     $ig2, $i3                   # |      6,776 |      6,776 |
    call    trace_or_matrix.2879        # |      6,776 |      6,776 |
ble_cont.36087:
be_cont.36086:
be_cont.36081:
bne_cont.36080:
.count stack_load
    load    [$sp + 5], $i13             # |     23,754 |     23,754 |
    load    [$i13 + 2], $i14            # |     23,754 |     23,754 |
    bg      $fg7, $fc7, ble_else.36088  # |     23,754 |     23,754 |
ble_then.36088:
    li      0, $i15
.count b_cont
    b       ble_cont.36088
ble_else.36088:
    bg      $fc13, $fg7, ble_else.36089 # |     23,754 |     23,754 |
ble_then.36089:
    li      0, $i15                     # |      5,258 |      5,258 |
.count b_cont
    b       ble_cont.36089              # |      5,258 |      5,258 |
ble_else.36089:
    li      1, $i15                     # |     18,496 |     18,496 |
ble_cont.36089:
ble_cont.36088:
    bne     $i15, 0, be_else.36090      # |     23,754 |     23,754 |
be_then.36090:
.count stack_load
    load    [$sp + 0], $ra              # |      5,258 |      5,258 |
.count stack_move
    add     $sp, 10, $sp                # |      5,258 |      5,258 |
    add     $i0, -1, $i1                # |      5,258 |      5,258 |
.count stack_load
    load    [$sp - 6], $i2              # |      5,258 |      5,258 |
.count storer
    add     $i14, $i2, $tmp             # |      5,258 |      5,258 |
    store   $i1, [$tmp + 0]             # |      5,258 |      5,258 |
    bne     $i2, 0, be_else.36091       # |      5,258 |      5,258 |
be_then.36091:
    ret
be_else.36091:
.count stack_load
    load    [$sp - 7], $i1              # |      5,258 |      5,258 |
    load    [$i1 + 0], $f1              # |      5,258 |      5,258 |
    fmul    $f1, $fg12, $f1             # |      5,258 |      5,258 |
    load    [$i1 + 1], $f2              # |      5,258 |      5,258 |
    fmul    $f2, $fg13, $f2             # |      5,258 |      5,258 |
    fadd    $f1, $f2, $f1               # |      5,258 |      5,258 |
    load    [$i1 + 2], $f2              # |      5,258 |      5,258 |
    fmul    $f2, $fg14, $f2             # |      5,258 |      5,258 |
    fadd_n  $f1, $f2, $f1               # |      5,258 |      5,258 |
    bg      $f1, $f0, ble_else.36092    # |      5,258 |      5,258 |
ble_then.36092:
    ret                                 # |      3,274 |      3,274 |
ble_else.36092:
    fmul    $f1, $f1, $f2               # |      1,984 |      1,984 |
    fmul    $f2, $f1, $f1               # |      1,984 |      1,984 |
.count stack_load
    load    [$sp - 8], $f2              # |      1,984 |      1,984 |
    fmul    $f1, $f2, $f1               # |      1,984 |      1,984 |
    load    [min_caml_beam + 0], $f2    # |      1,984 |      1,984 |
    fmul    $f1, $f2, $f1               # |      1,984 |      1,984 |
    fadd    $fg4, $f1, $fg4             # |      1,984 |      1,984 |
    fadd    $fg5, $f1, $fg5             # |      1,984 |      1,984 |
    fadd    $fg6, $f1, $fg6             # |      1,984 |      1,984 |
    ret                                 # |      1,984 |      1,984 |
be_else.36090:
.count stack_store
    store   $i14, [$sp + 6]             # |     18,496 |     18,496 |
    load    [min_caml_objects + $ig5], $i2# |     18,496 |     18,496 |
.count stack_store
    store   $i2, [$sp + 7]              # |     18,496 |     18,496 |
    load    [$i2 + 1], $i15             # |     18,496 |     18,496 |
    bne     $i15, 1, be_else.36093      # |     18,496 |     18,496 |
be_then.36093:
    store   $f0, [min_caml_nvector + 0] # |      7,910 |      7,910 |
    store   $f0, [min_caml_nvector + 1] # |      7,910 |      7,910 |
    store   $f0, [min_caml_nvector + 2] # |      7,910 |      7,910 |
    sub     $ig4, 1, $i15               # |      7,910 |      7,910 |
.count stack_load
    load    [$sp + 3], $i16             # |      7,910 |      7,910 |
    load    [$i16 + $i15], $f16         # |      7,910 |      7,910 |
    bne     $f16, $f0, be_else.36094    # |      7,910 |      7,910 |
be_then.36094:
    store   $f0, [min_caml_nvector + $i15]
.count b_cont
    b       be_cont.36093
be_else.36094:
    bg      $f16, $f0, ble_else.36095   # |      7,910 |      7,910 |
ble_then.36095:
    store   $fc0, [min_caml_nvector + $i15]# |      6,667 |      6,667 |
.count b_cont
    b       be_cont.36093               # |      6,667 |      6,667 |
ble_else.36095:
    store   $fc4, [min_caml_nvector + $i15]# |      1,243 |      1,243 |
.count b_cont
    b       be_cont.36093               # |      1,243 |      1,243 |
be_else.36093:
    bne     $i15, 2, be_else.36096      # |     10,586 |     10,586 |
be_then.36096:
    load    [$i2 + 4], $i15             # |      7,226 |      7,226 |
    load    [$i15 + 0], $f16            # |      7,226 |      7,226 |
    fneg    $f16, $f16                  # |      7,226 |      7,226 |
    store   $f16, [min_caml_nvector + 0]# |      7,226 |      7,226 |
    load    [$i2 + 4], $i15             # |      7,226 |      7,226 |
    load    [$i15 + 1], $f16            # |      7,226 |      7,226 |
    fneg    $f16, $f16                  # |      7,226 |      7,226 |
    store   $f16, [min_caml_nvector + 1]# |      7,226 |      7,226 |
    load    [$i2 + 4], $i15             # |      7,226 |      7,226 |
    load    [$i15 + 2], $f16            # |      7,226 |      7,226 |
    fneg    $f16, $f16                  # |      7,226 |      7,226 |
    store   $f16, [min_caml_nvector + 2]# |      7,226 |      7,226 |
.count b_cont
    b       be_cont.36096               # |      7,226 |      7,226 |
be_else.36096:
    load    [$i2 + 3], $i15             # |      3,360 |      3,360 |
    load    [$i2 + 4], $i16             # |      3,360 |      3,360 |
    load    [$i16 + 0], $f16            # |      3,360 |      3,360 |
    load    [min_caml_intersection_point + 0], $f17# |      3,360 |      3,360 |
    load    [$i2 + 5], $i16             # |      3,360 |      3,360 |
    load    [$i16 + 0], $f18            # |      3,360 |      3,360 |
    fsub    $f17, $f18, $f17            # |      3,360 |      3,360 |
    fmul    $f17, $f16, $f16            # |      3,360 |      3,360 |
    load    [$i2 + 4], $i16             # |      3,360 |      3,360 |
    load    [$i16 + 1], $f18            # |      3,360 |      3,360 |
    load    [min_caml_intersection_point + 1], $f9# |      3,360 |      3,360 |
    load    [$i2 + 5], $i16             # |      3,360 |      3,360 |
    load    [$i16 + 1], $f10            # |      3,360 |      3,360 |
    fsub    $f9, $f10, $f9              # |      3,360 |      3,360 |
    fmul    $f9, $f18, $f18             # |      3,360 |      3,360 |
    load    [$i2 + 4], $i16             # |      3,360 |      3,360 |
    load    [$i16 + 2], $f10            # |      3,360 |      3,360 |
    load    [min_caml_intersection_point + 2], $f11# |      3,360 |      3,360 |
    load    [$i2 + 5], $i16             # |      3,360 |      3,360 |
    load    [$i16 + 2], $f12            # |      3,360 |      3,360 |
    fsub    $f11, $f12, $f11            # |      3,360 |      3,360 |
    fmul    $f11, $f10, $f10            # |      3,360 |      3,360 |
    bne     $i15, 0, be_else.36097      # |      3,360 |      3,360 |
be_then.36097:
    store   $f16, [min_caml_nvector + 0]# |      3,360 |      3,360 |
    store   $f18, [min_caml_nvector + 1]# |      3,360 |      3,360 |
    store   $f10, [min_caml_nvector + 2]# |      3,360 |      3,360 |
.count b_cont
    b       be_cont.36097               # |      3,360 |      3,360 |
be_else.36097:
    load    [$i2 + 9], $i15
    load    [$i15 + 2], $f12
    fmul    $f9, $f12, $f12
    load    [$i2 + 9], $i15
    load    [$i15 + 1], $f13
    fmul    $f11, $f13, $f13
    fadd    $f12, $f13, $f12
    fmul    $f12, $fc3, $f12
    fadd    $f16, $f12, $f16
    store   $f16, [min_caml_nvector + 0]
    load    [$i2 + 9], $i15
    load    [$i15 + 2], $f16
    fmul    $f17, $f16, $f16
    load    [$i2 + 9], $i15
    load    [$i15 + 0], $f12
    fmul    $f11, $f12, $f11
    fadd    $f16, $f11, $f16
    fmul    $f16, $fc3, $f16
    fadd    $f18, $f16, $f16
    store   $f16, [min_caml_nvector + 1]
    load    [$i2 + 9], $i15
    load    [$i15 + 1], $f16
    fmul    $f17, $f16, $f16
    load    [$i2 + 9], $i15
    load    [$i15 + 0], $f17
    fmul    $f9, $f17, $f17
    fadd    $f16, $f17, $f16
    fmul    $f16, $fc3, $f16
    fadd    $f10, $f16, $f16
    store   $f16, [min_caml_nvector + 2]
be_cont.36097:
    load    [min_caml_nvector + 0], $f16# |      3,360 |      3,360 |
    load    [$i2 + 6], $i15             # |      3,360 |      3,360 |
    fmul    $f16, $f16, $f17            # |      3,360 |      3,360 |
    load    [min_caml_nvector + 1], $f18# |      3,360 |      3,360 |
    fmul    $f18, $f18, $f18            # |      3,360 |      3,360 |
    fadd    $f17, $f18, $f17            # |      3,360 |      3,360 |
    load    [min_caml_nvector + 2], $f18# |      3,360 |      3,360 |
    fmul    $f18, $f18, $f18            # |      3,360 |      3,360 |
    fadd    $f17, $f18, $f17            # |      3,360 |      3,360 |
    fsqrt   $f17, $f17                  # |      3,360 |      3,360 |
    bne     $f17, $f0, be_else.36098    # |      3,360 |      3,360 |
be_then.36098:
    mov     $fc0, $f17
.count b_cont
    b       be_cont.36098
be_else.36098:
    bne     $i15, 0, be_else.36099      # |      3,360 |      3,360 |
be_then.36099:
    finv    $f17, $f17                  # |      3,128 |      3,128 |
.count b_cont
    b       be_cont.36099               # |      3,128 |      3,128 |
be_else.36099:
    finv_n  $f17, $f17                  # |        232 |        232 |
be_cont.36099:
be_cont.36098:
    fmul    $f16, $f17, $f16            # |      3,360 |      3,360 |
    store   $f16, [min_caml_nvector + 0]# |      3,360 |      3,360 |
    load    [min_caml_nvector + 1], $f16# |      3,360 |      3,360 |
    fmul    $f16, $f17, $f16            # |      3,360 |      3,360 |
    store   $f16, [min_caml_nvector + 1]# |      3,360 |      3,360 |
    load    [min_caml_nvector + 2], $f16# |      3,360 |      3,360 |
    fmul    $f16, $f17, $f16            # |      3,360 |      3,360 |
    store   $f16, [min_caml_nvector + 2]# |      3,360 |      3,360 |
be_cont.36096:
be_cont.36093:
    load    [min_caml_intersection_point + 0], $fg21# |     18,496 |     18,496 |
    load    [min_caml_intersection_point + 1], $fg22# |     18,496 |     18,496 |
    load    [min_caml_intersection_point + 2], $fg23# |     18,496 |     18,496 |
    call    utexture.2908               # |     18,496 |     18,496 |
    add     $ig5, $ig5, $i10            # |     18,496 |     18,496 |
    add     $i10, $i10, $i10            # |     18,496 |     18,496 |
    add     $i10, $ig4, $i10            # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 4], $i11             # |     18,496 |     18,496 |
.count storer
    add     $i14, $i11, $tmp            # |     18,496 |     18,496 |
    store   $i10, [$tmp + 0]            # |     18,496 |     18,496 |
    load    [$i13 + 1], $i10            # |     18,496 |     18,496 |
    load    [$i10 + $i11], $i10         # |     18,496 |     18,496 |
    load    [min_caml_intersection_point + 0], $f10# |     18,496 |     18,496 |
    store   $f10, [$i10 + 0]            # |     18,496 |     18,496 |
    load    [min_caml_intersection_point + 1], $f10# |     18,496 |     18,496 |
    store   $f10, [$i10 + 1]            # |     18,496 |     18,496 |
    load    [min_caml_intersection_point + 2], $f10# |     18,496 |     18,496 |
    store   $f10, [$i10 + 2]            # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 7], $i10             # |     18,496 |     18,496 |
    load    [$i10 + 7], $i10            # |     18,496 |     18,496 |
    load    [$i13 + 3], $i12            # |     18,496 |     18,496 |
    load    [$i10 + 0], $f10            # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 2], $f11             # |     18,496 |     18,496 |
    fmul    $f10, $f11, $f11            # |     18,496 |     18,496 |
.count stack_store
    store   $f11, [$sp + 8]             # |     18,496 |     18,496 |
.count storer
    add     $i12, $i11, $tmp            # |     18,496 |     18,496 |
    bg      $fc3, $f10, ble_else.36100  # |     18,496 |     18,496 |
ble_then.36100:
    li      1, $i10                     # |     11,126 |     11,126 |
    store   $i10, [$tmp + 0]            # |     11,126 |     11,126 |
    load    [$i13 + 4], $i10            # |     11,126 |     11,126 |
    load    [$i10 + $i11], $i12         # |     11,126 |     11,126 |
    store   $fg16, [$i12 + 0]           # |     11,126 |     11,126 |
    store   $fg11, [$i12 + 1]           # |     11,126 |     11,126 |
    store   $fg15, [$i12 + 2]           # |     11,126 |     11,126 |
    load    [$i10 + $i11], $i10         # |     11,126 |     11,126 |
.count load_float
    load    [f.31970], $f10             # |     11,126 |     11,126 |
.count load_float
    load    [f.31971], $f10             # |     11,126 |     11,126 |
    fmul    $f10, $f11, $f10            # |     11,126 |     11,126 |
    load    [$i10 + 0], $f11            # |     11,126 |     11,126 |
    fmul    $f11, $f10, $f11            # |     11,126 |     11,126 |
    store   $f11, [$i10 + 0]            # |     11,126 |     11,126 |
    load    [$i10 + 1], $f11            # |     11,126 |     11,126 |
    fmul    $f11, $f10, $f11            # |     11,126 |     11,126 |
    store   $f11, [$i10 + 1]            # |     11,126 |     11,126 |
    load    [$i10 + 2], $f11            # |     11,126 |     11,126 |
    fmul    $f11, $f10, $f10            # |     11,126 |     11,126 |
    store   $f10, [$i10 + 2]            # |     11,126 |     11,126 |
    load    [$i13 + 7], $i10            # |     11,126 |     11,126 |
    load    [$i10 + $i11], $i10         # |     11,126 |     11,126 |
    load    [min_caml_nvector + 0], $f10# |     11,126 |     11,126 |
    store   $f10, [$i10 + 0]            # |     11,126 |     11,126 |
    load    [min_caml_nvector + 1], $f10# |     11,126 |     11,126 |
    store   $f10, [$i10 + 1]            # |     11,126 |     11,126 |
    load    [min_caml_nvector + 2], $f10# |     11,126 |     11,126 |
    store   $f10, [$i10 + 2]            # |     11,126 |     11,126 |
.count b_cont
    b       ble_cont.36100              # |     11,126 |     11,126 |
ble_else.36100:
    li      0, $i10                     # |      7,370 |      7,370 |
    store   $i10, [$tmp + 0]            # |      7,370 |      7,370 |
ble_cont.36100:
    load    [min_caml_nvector + 0], $f10# |     18,496 |     18,496 |
.count load_float
    load    [f.31972], $f11             # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 3], $i10             # |     18,496 |     18,496 |
    load    [$i10 + 0], $f12            # |     18,496 |     18,496 |
    fmul    $f12, $f10, $f13            # |     18,496 |     18,496 |
    load    [$i10 + 1], $f14            # |     18,496 |     18,496 |
    load    [min_caml_nvector + 1], $f15# |     18,496 |     18,496 |
    fmul    $f14, $f15, $f14            # |     18,496 |     18,496 |
    fadd    $f13, $f14, $f13            # |     18,496 |     18,496 |
    load    [$i10 + 2], $f14            # |     18,496 |     18,496 |
    load    [min_caml_nvector + 2], $f15# |     18,496 |     18,496 |
    fmul    $f14, $f15, $f14            # |     18,496 |     18,496 |
    fadd    $f13, $f14, $f13            # |     18,496 |     18,496 |
    fmul    $f11, $f13, $f11            # |     18,496 |     18,496 |
    fmul    $f11, $f10, $f10            # |     18,496 |     18,496 |
    fadd    $f12, $f10, $f10            # |     18,496 |     18,496 |
    store   $f10, [$i10 + 0]            # |     18,496 |     18,496 |
    load    [$i10 + 1], $f10            # |     18,496 |     18,496 |
    load    [min_caml_nvector + 1], $f12# |     18,496 |     18,496 |
    fmul    $f11, $f12, $f12            # |     18,496 |     18,496 |
    fadd    $f10, $f12, $f10            # |     18,496 |     18,496 |
    store   $f10, [$i10 + 1]            # |     18,496 |     18,496 |
    load    [$i10 + 2], $f10            # |     18,496 |     18,496 |
    load    [min_caml_nvector + 2], $f12# |     18,496 |     18,496 |
    fmul    $f11, $f12, $f11            # |     18,496 |     18,496 |
    fadd    $f10, $f11, $f10            # |     18,496 |     18,496 |
    store   $f10, [$i10 + 2]            # |     18,496 |     18,496 |
    load    [$ig2 + 0], $i10            # |     18,496 |     18,496 |
    load    [$i10 + 0], $i2             # |     18,496 |     18,496 |
    bne     $i2, -1, be_else.36101      # |     18,496 |     18,496 |
be_then.36101:
    li      0, $i10
.count b_cont
    b       be_cont.36101
be_else.36101:
.count stack_store
    store   $i10, [$sp + 9]             # |     18,496 |     18,496 |
    bne     $i2, 99, be_else.36102      # |     18,496 |     18,496 |
be_then.36102:
    li      1, $i22
.count b_cont
    b       be_cont.36102
be_else.36102:
    call    solver_fast.2796            # |     18,496 |     18,496 |
.count move_ret
    mov     $i1, $i17                   # |     18,496 |     18,496 |
    bne     $i17, 0, be_else.36103      # |     18,496 |     18,496 |
be_then.36103:
    li      0, $i22                     # |     13,405 |     13,405 |
.count b_cont
    b       be_cont.36103               # |     13,405 |     13,405 |
be_else.36103:
    bg      $fc7, $fg0, ble_else.36104  # |      5,091 |      5,091 |
ble_then.36104:
    li      0, $i22                     # |        207 |        207 |
.count b_cont
    b       ble_cont.36104              # |        207 |        207 |
ble_else.36104:
    load    [$i10 + 1], $i17            # |      4,884 |      4,884 |
    bne     $i17, -1, be_else.36105     # |      4,884 |      4,884 |
be_then.36105:
    li      0, $i22
.count b_cont
    b       be_cont.36105
be_else.36105:
    li      0, $i2                      # |      4,884 |      4,884 |
    load    [min_caml_and_net + $i17], $i3# |      4,884 |      4,884 |
    call    shadow_check_and_group.2862 # |      4,884 |      4,884 |
.count move_ret
    mov     $i1, $i17                   # |      4,884 |      4,884 |
    bne     $i17, 0, be_else.36106      # |      4,884 |      4,884 |
be_then.36106:
.count stack_load
    load    [$sp + 9], $i17             # |      4,517 |      4,517 |
    load    [$i17 + 2], $i18            # |      4,517 |      4,517 |
    bne     $i18, -1, be_else.36107     # |      4,517 |      4,517 |
be_then.36107:
    li      0, $i22
.count b_cont
    b       be_cont.36106
be_else.36107:
    li      0, $i2                      # |      4,517 |      4,517 |
    load    [min_caml_and_net + $i18], $i3# |      4,517 |      4,517 |
    call    shadow_check_and_group.2862 # |      4,517 |      4,517 |
.count move_ret
    mov     $i1, $i20                   # |      4,517 |      4,517 |
    bne     $i20, 0, be_else.36108      # |      4,517 |      4,517 |
be_then.36108:
    li      3, $i2                      # |      4,439 |      4,439 |
.count move_args
    mov     $i17, $i3                   # |      4,439 |      4,439 |
    call    shadow_check_one_or_group.2865# |      4,439 |      4,439 |
.count move_ret
    mov     $i1, $i22                   # |      4,439 |      4,439 |
    bne     $i22, 0, be_else.36109      # |      4,439 |      4,439 |
be_then.36109:
    li      0, $i22                     # |      4,100 |      4,100 |
.count b_cont
    b       be_cont.36106               # |      4,100 |      4,100 |
be_else.36109:
    li      1, $i22                     # |        339 |        339 |
.count b_cont
    b       be_cont.36106               # |        339 |        339 |
be_else.36108:
    li      1, $i22                     # |         78 |         78 |
.count b_cont
    b       be_cont.36106               # |         78 |         78 |
be_else.36106:
    li      1, $i22                     # |        367 |        367 |
be_cont.36106:
be_cont.36105:
ble_cont.36104:
be_cont.36103:
be_cont.36102:
    bne     $i22, 0, be_else.36110      # |     18,496 |     18,496 |
be_then.36110:
    li      1, $i2                      # |     17,712 |     17,712 |
.count move_args
    mov     $ig2, $i3                   # |     17,712 |     17,712 |
    call    shadow_check_one_or_matrix.2868# |     17,712 |     17,712 |
.count move_ret
    mov     $i1, $i10                   # |     17,712 |     17,712 |
.count b_cont
    b       be_cont.36110               # |     17,712 |     17,712 |
be_else.36110:
.count stack_load
    load    [$sp + 9], $i22             # |        784 |        784 |
    load    [$i22 + 1], $i23            # |        784 |        784 |
    bne     $i23, -1, be_else.36111     # |        784 |        784 |
be_then.36111:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    shadow_check_one_or_matrix.2868
.count move_ret
    mov     $i1, $i10
.count b_cont
    b       be_cont.36111
be_else.36111:
    li      0, $i2                      # |        784 |        784 |
    load    [min_caml_and_net + $i23], $i3# |        784 |        784 |
    call    shadow_check_and_group.2862 # |        784 |        784 |
.count move_ret
    mov     $i1, $i23                   # |        784 |        784 |
    bne     $i23, 0, be_else.36112      # |        784 |        784 |
be_then.36112:
    load    [$i22 + 2], $i23            # |        417 |        417 |
    bne     $i23, -1, be_else.36113     # |        417 |        417 |
be_then.36113:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    shadow_check_one_or_matrix.2868
.count move_ret
    mov     $i1, $i10
.count b_cont
    b       be_cont.36112
be_else.36113:
    li      0, $i2                      # |        417 |        417 |
    load    [min_caml_and_net + $i23], $i3# |        417 |        417 |
    call    shadow_check_and_group.2862 # |        417 |        417 |
.count move_ret
    mov     $i1, $i20                   # |        417 |        417 |
    bne     $i20, 0, be_else.36114      # |        417 |        417 |
be_then.36114:
    li      3, $i2                      # |        339 |        339 |
.count move_args
    mov     $i22, $i3                   # |        339 |        339 |
    call    shadow_check_one_or_group.2865# |        339 |        339 |
.count move_ret
    mov     $i1, $i22                   # |        339 |        339 |
    bne     $i22, 0, be_else.36115      # |        339 |        339 |
be_then.36115:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    shadow_check_one_or_matrix.2868
.count move_ret
    mov     $i1, $i10
.count b_cont
    b       be_cont.36112
be_else.36115:
    li      1, $i10                     # |        339 |        339 |
.count b_cont
    b       be_cont.36112               # |        339 |        339 |
be_else.36114:
    li      1, $i10                     # |         78 |         78 |
.count b_cont
    b       be_cont.36112               # |         78 |         78 |
be_else.36112:
    li      1, $i10                     # |        367 |        367 |
be_cont.36112:
be_cont.36111:
be_cont.36110:
be_cont.36101:
.count stack_load
    load    [$sp + 7], $i11             # |     18,496 |     18,496 |
    load    [$i11 + 7], $i11            # |     18,496 |     18,496 |
    load    [$i11 + 1], $f10            # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 2], $f11             # |     18,496 |     18,496 |
    fmul    $f11, $f10, $f10            # |     18,496 |     18,496 |
    bne     $i10, 0, be_cont.36116      # |     18,496 |     18,496 |
be_then.36116:
    load    [min_caml_nvector + 0], $f11# |     17,539 |     17,539 |
    fmul    $f11, $fg12, $f11           # |     17,539 |     17,539 |
    load    [min_caml_nvector + 1], $f12# |     17,539 |     17,539 |
    fmul    $f12, $fg13, $f12           # |     17,539 |     17,539 |
    fadd    $f11, $f12, $f11            # |     17,539 |     17,539 |
    load    [min_caml_nvector + 2], $f12# |     17,539 |     17,539 |
    fmul    $f12, $fg14, $f12           # |     17,539 |     17,539 |
    fadd_n  $f11, $f12, $f11            # |     17,539 |     17,539 |
.count stack_load
    load    [$sp + 8], $f12             # |     17,539 |     17,539 |
    fmul    $f11, $f12, $f11            # |     17,539 |     17,539 |
.count stack_load
    load    [$sp + 3], $i10             # |     17,539 |     17,539 |
    load    [$i10 + 0], $f12            # |     17,539 |     17,539 |
    fmul    $f12, $fg12, $f12           # |     17,539 |     17,539 |
    load    [$i10 + 1], $f13            # |     17,539 |     17,539 |
    fmul    $f13, $fg13, $f13           # |     17,539 |     17,539 |
    fadd    $f12, $f13, $f12            # |     17,539 |     17,539 |
    load    [$i10 + 2], $f13            # |     17,539 |     17,539 |
    fmul    $f13, $fg14, $f13           # |     17,539 |     17,539 |
    fadd_n  $f12, $f13, $f12            # |     17,539 |     17,539 |
    ble     $f11, $f0, bg_cont.36117    # |     17,539 |     17,539 |
bg_then.36117:
    fmul    $f11, $fg16, $f13           # |     17,537 |     17,537 |
    fadd    $fg4, $f13, $fg4            # |     17,537 |     17,537 |
    fmul    $f11, $fg11, $f13           # |     17,537 |     17,537 |
    fadd    $fg5, $f13, $fg5            # |     17,537 |     17,537 |
    fmul    $f11, $fg15, $f11           # |     17,537 |     17,537 |
    fadd    $fg6, $f11, $fg6            # |     17,537 |     17,537 |
bg_cont.36117:
    ble     $f12, $f0, bg_cont.36118    # |     17,539 |     17,539 |
bg_then.36118:
    fmul    $f12, $f12, $f11            # |      6,452 |      6,452 |
    fmul    $f11, $f11, $f11            # |      6,452 |      6,452 |
    fmul    $f11, $f10, $f11            # |      6,452 |      6,452 |
    fadd    $fg4, $f11, $fg4            # |      6,452 |      6,452 |
    fadd    $fg5, $f11, $fg5            # |      6,452 |      6,452 |
    fadd    $fg6, $f11, $fg6            # |      6,452 |      6,452 |
bg_cont.36118:
be_cont.36116:
    li      min_caml_intersection_point, $i2# |     18,496 |     18,496 |
    load    [min_caml_intersection_point + 0], $fg8# |     18,496 |     18,496 |
    load    [min_caml_intersection_point + 1], $fg9# |     18,496 |     18,496 |
    load    [min_caml_intersection_point + 2], $fg10# |     18,496 |     18,496 |
    sub     $ig0, 1, $i3                # |     18,496 |     18,496 |
    call    setup_startp_constants.2831 # |     18,496 |     18,496 |
    sub     $ig6, 1, $i2                # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 8], $f2              # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 3], $i3              # |     18,496 |     18,496 |
.count move_args
    mov     $f10, $f3                   # |     18,496 |     18,496 |
    call    trace_reflections.2915      # |     18,496 |     18,496 |
.count stack_load
    load    [$sp + 0], $ra              # |     18,496 |     18,496 |
.count stack_move
    add     $sp, 10, $sp                # |     18,496 |     18,496 |
.count stack_load
    load    [$sp - 8], $f1              # |     18,496 |     18,496 |
    bg      $f1, $fc8, ble_else.36119   # |     18,496 |     18,496 |
ble_then.36119:
    ret
ble_else.36119:
.count stack_load
    load    [$sp - 6], $i1              # |     18,496 |     18,496 |
    bge     $i1, 4, bl_cont.36120       # |     18,496 |     18,496 |
bl_then.36120:
    add     $i1, 1, $i1                 # |     18,496 |     18,496 |
    add     $i0, -1, $i2                # |     18,496 |     18,496 |
.count stack_load
    load    [$sp - 4], $i3              # |     18,496 |     18,496 |
.count storer
    add     $i3, $i1, $tmp              # |     18,496 |     18,496 |
    store   $i2, [$tmp + 0]             # |     18,496 |     18,496 |
bl_cont.36120:
.count stack_load
    load    [$sp - 3], $i1              # |     18,496 |     18,496 |
    load    [$i1 + 2], $i2              # |     18,496 |     18,496 |
    bne     $i2, 2, be_else.36121       # |     18,496 |     18,496 |
be_then.36121:
    load    [$i1 + 7], $i1              # |      7,370 |      7,370 |
.count stack_load
    load    [$sp - 9], $f2              # |      7,370 |      7,370 |
    fadd    $f2, $fg7, $f3              # |      7,370 |      7,370 |
.count stack_load
    load    [$sp - 6], $i2              # |      7,370 |      7,370 |
    add     $i2, 1, $i2                 # |      7,370 |      7,370 |
    load    [$i1 + 0], $f2              # |      7,370 |      7,370 |
    fsub    $fc0, $f2, $f2              # |      7,370 |      7,370 |
    fmul    $f1, $f2, $f2               # |      7,370 |      7,370 |
.count stack_load
    load    [$sp - 7], $i3              # |      7,370 |      7,370 |
.count stack_load
    load    [$sp - 5], $i4              # |      7,370 |      7,370 |
    b       trace_ray.2920              # |      7,370 |      7,370 |
be_else.36121:
    ret                                 # |     11,126 |     11,126 |
ble_else.36079:
    ret
.end trace_ray

######################################################################
# trace_diffuse_ray
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
.count stack_move
    sub     $sp, 5, $sp                 # |  1,116,120 |  1,116,120 |
.count stack_store
    store   $ra, [$sp + 0]              # |  1,116,120 |  1,116,120 |
.count stack_store
    store   $f2, [$sp + 1]              # |  1,116,120 |  1,116,120 |
.count stack_store
    store   $i2, [$sp + 2]              # |  1,116,120 |  1,116,120 |
    mov     $fc14, $fg7                 # |  1,116,120 |  1,116,120 |
    load    [$ig2 + 0], $i19            # |  1,116,120 |  1,116,120 |
    load    [$i19 + 0], $i20            # |  1,116,120 |  1,116,120 |
    be      $i20, -1, bne_cont.36122    # |  1,116,120 |  1,116,120 |
bne_then.36122:
    bne     $i20, 99, be_else.36123     # |  1,116,120 |  1,116,120 |
be_then.36123:
    load    [$i19 + 1], $i20
.count move_args
    mov     $i2, $i4
    bne     $i20, -1, be_else.36124
be_then.36124:
    li      1, $i19
.count move_args
    mov     $ig2, $i3
.count move_args
    mov     $i19, $i2
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36123
be_else.36124:
    li      0, $i15
    load    [min_caml_and_net + $i20], $i3
.count move_args
    mov     $i15, $i2
    call    solve_each_element_fast.2885
    load    [$i19 + 2], $i20
.count stack_load
    load    [$sp + 2], $i4
    bne     $i20, -1, be_else.36125
be_then.36125:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36123
be_else.36125:
    li      0, $i2
    load    [min_caml_and_net + $i20], $i3
    call    solve_each_element_fast.2885
    load    [$i19 + 3], $i20
.count stack_load
    load    [$sp + 2], $i4
    bne     $i20, -1, be_else.36126
be_then.36126:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36123
be_else.36126:
    li      0, $i2
    load    [min_caml_and_net + $i20], $i3
    call    solve_each_element_fast.2885
    load    [$i19 + 4], $i20
.count stack_load
    load    [$sp + 2], $i4
    bne     $i20, -1, be_else.36127
be_then.36127:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36123
be_else.36127:
    li      0, $i2
    load    [min_caml_and_net + $i20], $i3
    call    solve_each_element_fast.2885
    li      5, $i2
.count stack_load
    load    [$sp + 2], $i4
.count move_args
    mov     $i19, $i3
    call    solve_one_or_network_fast.2889
    li      1, $i2
.count stack_load
    load    [$sp + 2], $i4
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       be_cont.36123
be_else.36123:
.count move_args
    mov     $i2, $i3                    # |  1,116,120 |  1,116,120 |
.count move_args
    mov     $i20, $i2                   # |  1,116,120 |  1,116,120 |
    call    solver_fast2.2814           # |  1,116,120 |  1,116,120 |
.count move_ret
    mov     $i1, $i20                   # |  1,116,120 |  1,116,120 |
.count stack_load
    load    [$sp + 2], $i4              # |  1,116,120 |  1,116,120 |
    li      1, $i2                      # |  1,116,120 |  1,116,120 |
    bne     $i20, 0, be_else.36128      # |  1,116,120 |  1,116,120 |
be_then.36128:
.count move_args
    mov     $ig2, $i3                   # |    436,322 |    436,322 |
    call    trace_or_matrix_fast.2893   # |    436,322 |    436,322 |
.count b_cont
    b       be_cont.36128               # |    436,322 |    436,322 |
be_else.36128:
    bg      $fg7, $fg0, ble_else.36129  # |    679,798 |    679,798 |
ble_then.36129:
.count move_args
    mov     $ig2, $i3
    call    trace_or_matrix_fast.2893
.count b_cont
    b       ble_cont.36129
ble_else.36129:
.count move_args
    mov     $i19, $i3                   # |    679,798 |    679,798 |
    call    solve_one_or_network_fast.2889# |    679,798 |    679,798 |
    li      1, $i2                      # |    679,798 |    679,798 |
.count stack_load
    load    [$sp + 2], $i4              # |    679,798 |    679,798 |
.count move_args
    mov     $ig2, $i3                   # |    679,798 |    679,798 |
    call    trace_or_matrix_fast.2893   # |    679,798 |    679,798 |
ble_cont.36129:
be_cont.36128:
be_cont.36123:
bne_cont.36122:
    bg      $fg7, $fc7, ble_else.36130  # |  1,116,120 |  1,116,120 |
ble_then.36130:
    li      0, $i13
.count b_cont
    b       ble_cont.36130
ble_else.36130:
    bg      $fc13, $fg7, ble_else.36131 # |  1,116,120 |  1,116,120 |
ble_then.36131:
    li      0, $i13                     # |    473,955 |    473,955 |
.count b_cont
    b       ble_cont.36131              # |    473,955 |    473,955 |
ble_else.36131:
    li      1, $i13                     # |    642,165 |    642,165 |
ble_cont.36131:
ble_cont.36130:
    bne     $i13, 0, be_else.36132      # |  1,116,120 |  1,116,120 |
be_then.36132:
.count stack_load
    load    [$sp + 0], $ra              # |    473,955 |    473,955 |
.count stack_move
    add     $sp, 5, $sp                 # |    473,955 |    473,955 |
    ret                                 # |    473,955 |    473,955 |
be_else.36132:
.count stack_load
    load    [$sp + 2], $i13             # |    642,165 |    642,165 |
    load    [$i13 + 0], $i13            # |    642,165 |    642,165 |
    load    [min_caml_objects + $ig5], $i2# |    642,165 |    642,165 |
.count stack_store
    store   $i2, [$sp + 3]              # |    642,165 |    642,165 |
    load    [$i2 + 1], $i14             # |    642,165 |    642,165 |
    bne     $i14, 1, be_else.36133      # |    642,165 |    642,165 |
be_then.36133:
    store   $f0, [min_caml_nvector + 0] # |    114,993 |    114,993 |
    store   $f0, [min_caml_nvector + 1] # |    114,993 |    114,993 |
    store   $f0, [min_caml_nvector + 2] # |    114,993 |    114,993 |
    sub     $ig4, 1, $i14               # |    114,993 |    114,993 |
    load    [$i13 + $i14], $f16         # |    114,993 |    114,993 |
    bne     $f16, $f0, be_else.36134    # |    114,993 |    114,993 |
be_then.36134:
    store   $f0, [min_caml_nvector + $i14]
.count b_cont
    b       be_cont.36133
be_else.36134:
    bg      $f16, $f0, ble_else.36135   # |    114,993 |    114,993 |
ble_then.36135:
    store   $fc0, [min_caml_nvector + $i14]# |     90,204 |     90,204 |
.count b_cont
    b       be_cont.36133               # |     90,204 |     90,204 |
ble_else.36135:
    store   $fc4, [min_caml_nvector + $i14]# |     24,789 |     24,789 |
.count b_cont
    b       be_cont.36133               # |     24,789 |     24,789 |
be_else.36133:
    bne     $i14, 2, be_else.36136      # |    527,172 |    527,172 |
be_then.36136:
    load    [$i2 + 4], $i13             # |    391,509 |    391,509 |
    load    [$i13 + 0], $f16            # |    391,509 |    391,509 |
    fneg    $f16, $f16                  # |    391,509 |    391,509 |
    store   $f16, [min_caml_nvector + 0]# |    391,509 |    391,509 |
    load    [$i2 + 4], $i13             # |    391,509 |    391,509 |
    load    [$i13 + 1], $f16            # |    391,509 |    391,509 |
    fneg    $f16, $f16                  # |    391,509 |    391,509 |
    store   $f16, [min_caml_nvector + 1]# |    391,509 |    391,509 |
    load    [$i2 + 4], $i13             # |    391,509 |    391,509 |
    load    [$i13 + 2], $f16            # |    391,509 |    391,509 |
    fneg    $f16, $f16                  # |    391,509 |    391,509 |
    store   $f16, [min_caml_nvector + 2]# |    391,509 |    391,509 |
.count b_cont
    b       be_cont.36136               # |    391,509 |    391,509 |
be_else.36136:
    load    [$i2 + 3], $i13             # |    135,663 |    135,663 |
    load    [$i2 + 4], $i14             # |    135,663 |    135,663 |
    load    [$i14 + 0], $f16            # |    135,663 |    135,663 |
    load    [min_caml_intersection_point + 0], $f17# |    135,663 |    135,663 |
    load    [$i2 + 5], $i14             # |    135,663 |    135,663 |
    load    [$i14 + 0], $f18            # |    135,663 |    135,663 |
    fsub    $f17, $f18, $f17            # |    135,663 |    135,663 |
    fmul    $f17, $f16, $f16            # |    135,663 |    135,663 |
    load    [$i2 + 4], $i14             # |    135,663 |    135,663 |
    load    [$i14 + 1], $f18            # |    135,663 |    135,663 |
    load    [min_caml_intersection_point + 1], $f9# |    135,663 |    135,663 |
    load    [$i2 + 5], $i14             # |    135,663 |    135,663 |
    load    [$i14 + 1], $f10            # |    135,663 |    135,663 |
    fsub    $f9, $f10, $f9              # |    135,663 |    135,663 |
    fmul    $f9, $f18, $f18             # |    135,663 |    135,663 |
    load    [$i2 + 4], $i14             # |    135,663 |    135,663 |
    load    [$i14 + 2], $f10            # |    135,663 |    135,663 |
    load    [min_caml_intersection_point + 2], $f11# |    135,663 |    135,663 |
    load    [$i2 + 5], $i14             # |    135,663 |    135,663 |
    load    [$i14 + 2], $f12            # |    135,663 |    135,663 |
    fsub    $f11, $f12, $f11            # |    135,663 |    135,663 |
    fmul    $f11, $f10, $f10            # |    135,663 |    135,663 |
    bne     $i13, 0, be_else.36137      # |    135,663 |    135,663 |
be_then.36137:
    store   $f16, [min_caml_nvector + 0]# |    135,663 |    135,663 |
    store   $f18, [min_caml_nvector + 1]# |    135,663 |    135,663 |
    store   $f10, [min_caml_nvector + 2]# |    135,663 |    135,663 |
.count b_cont
    b       be_cont.36137               # |    135,663 |    135,663 |
be_else.36137:
    load    [$i2 + 9], $i13
    load    [$i13 + 2], $f12
    fmul    $f9, $f12, $f12
    load    [$i2 + 9], $i13
    load    [$i13 + 1], $f13
    fmul    $f11, $f13, $f13
    fadd    $f12, $f13, $f12
    fmul    $f12, $fc3, $f12
    fadd    $f16, $f12, $f16
    store   $f16, [min_caml_nvector + 0]
    load    [$i2 + 9], $i13
    load    [$i13 + 2], $f16
    fmul    $f17, $f16, $f16
    load    [$i2 + 9], $i13
    load    [$i13 + 0], $f12
    fmul    $f11, $f12, $f11
    fadd    $f16, $f11, $f16
    fmul    $f16, $fc3, $f16
    fadd    $f18, $f16, $f16
    store   $f16, [min_caml_nvector + 1]
    load    [$i2 + 9], $i13
    load    [$i13 + 1], $f16
    fmul    $f17, $f16, $f16
    load    [$i2 + 9], $i13
    load    [$i13 + 0], $f17
    fmul    $f9, $f17, $f17
    fadd    $f16, $f17, $f16
    fmul    $f16, $fc3, $f16
    fadd    $f10, $f16, $f16
    store   $f16, [min_caml_nvector + 2]
be_cont.36137:
    load    [min_caml_nvector + 0], $f16# |    135,663 |    135,663 |
    load    [$i2 + 6], $i13             # |    135,663 |    135,663 |
    fmul    $f16, $f16, $f17            # |    135,663 |    135,663 |
    load    [min_caml_nvector + 1], $f18# |    135,663 |    135,663 |
    fmul    $f18, $f18, $f18            # |    135,663 |    135,663 |
    fadd    $f17, $f18, $f17            # |    135,663 |    135,663 |
    load    [min_caml_nvector + 2], $f18# |    135,663 |    135,663 |
    fmul    $f18, $f18, $f18            # |    135,663 |    135,663 |
    fadd    $f17, $f18, $f17            # |    135,663 |    135,663 |
    fsqrt   $f17, $f17                  # |    135,663 |    135,663 |
    bne     $f17, $f0, be_else.36138    # |    135,663 |    135,663 |
be_then.36138:
    mov     $fc0, $f17
.count b_cont
    b       be_cont.36138
be_else.36138:
    bne     $i13, 0, be_else.36139      # |    135,663 |    135,663 |
be_then.36139:
    finv    $f17, $f17                  # |    103,786 |    103,786 |
.count b_cont
    b       be_cont.36139               # |    103,786 |    103,786 |
be_else.36139:
    finv_n  $f17, $f17                  # |     31,877 |     31,877 |
be_cont.36139:
be_cont.36138:
    fmul    $f16, $f17, $f16            # |    135,663 |    135,663 |
    store   $f16, [min_caml_nvector + 0]# |    135,663 |    135,663 |
    load    [min_caml_nvector + 1], $f16# |    135,663 |    135,663 |
    fmul    $f16, $f17, $f16            # |    135,663 |    135,663 |
    store   $f16, [min_caml_nvector + 1]# |    135,663 |    135,663 |
    load    [min_caml_nvector + 2], $f16# |    135,663 |    135,663 |
    fmul    $f16, $f17, $f16            # |    135,663 |    135,663 |
    store   $f16, [min_caml_nvector + 2]# |    135,663 |    135,663 |
be_cont.36136:
be_cont.36133:
    call    utexture.2908               # |    642,165 |    642,165 |
    load    [$ig2 + 0], $i10            # |    642,165 |    642,165 |
    load    [$i10 + 0], $i2             # |    642,165 |    642,165 |
    bne     $i2, -1, be_else.36140      # |    642,165 |    642,165 |
be_then.36140:
    li      0, $i1
.count b_cont
    b       be_cont.36140
be_else.36140:
.count stack_store
    store   $i10, [$sp + 4]             # |    642,165 |    642,165 |
    bne     $i2, 99, be_else.36141      # |    642,165 |    642,165 |
be_then.36141:
    li      1, $i22
.count b_cont
    b       be_cont.36141
be_else.36141:
    call    solver_fast.2796            # |    642,165 |    642,165 |
.count move_ret
    mov     $i1, $i17                   # |    642,165 |    642,165 |
    bne     $i17, 0, be_else.36142      # |    642,165 |    642,165 |
be_then.36142:
    li      0, $i22                     # |    441,283 |    441,283 |
.count b_cont
    b       be_cont.36142               # |    441,283 |    441,283 |
be_else.36142:
    bg      $fc7, $fg0, ble_else.36143  # |    200,882 |    200,882 |
ble_then.36143:
    li      0, $i22                     # |      6,953 |      6,953 |
.count b_cont
    b       ble_cont.36143              # |      6,953 |      6,953 |
ble_else.36143:
    load    [$i10 + 1], $i17            # |    193,929 |    193,929 |
    bne     $i17, -1, be_else.36144     # |    193,929 |    193,929 |
be_then.36144:
    li      0, $i22
.count b_cont
    b       be_cont.36144
be_else.36144:
    li      0, $i2                      # |    193,929 |    193,929 |
    load    [min_caml_and_net + $i17], $i3# |    193,929 |    193,929 |
    call    shadow_check_and_group.2862 # |    193,929 |    193,929 |
.count move_ret
    mov     $i1, $i17                   # |    193,929 |    193,929 |
    bne     $i17, 0, be_else.36145      # |    193,929 |    193,929 |
be_then.36145:
.count stack_load
    load    [$sp + 4], $i17             # |    153,646 |    153,646 |
    load    [$i17 + 2], $i18            # |    153,646 |    153,646 |
    bne     $i18, -1, be_else.36146     # |    153,646 |    153,646 |
be_then.36146:
    li      0, $i22
.count b_cont
    b       be_cont.36145
be_else.36146:
    li      0, $i2                      # |    153,646 |    153,646 |
    load    [min_caml_and_net + $i18], $i3# |    153,646 |    153,646 |
    call    shadow_check_and_group.2862 # |    153,646 |    153,646 |
.count move_ret
    mov     $i1, $i20                   # |    153,646 |    153,646 |
    bne     $i20, 0, be_else.36147      # |    153,646 |    153,646 |
be_then.36147:
    li      3, $i2                      # |    143,513 |    143,513 |
.count move_args
    mov     $i17, $i3                   # |    143,513 |    143,513 |
    call    shadow_check_one_or_group.2865# |    143,513 |    143,513 |
.count move_ret
    mov     $i1, $i22                   # |    143,513 |    143,513 |
    bne     $i22, 0, be_else.36148      # |    143,513 |    143,513 |
be_then.36148:
    li      0, $i22                     # |     78,657 |     78,657 |
.count b_cont
    b       be_cont.36145               # |     78,657 |     78,657 |
be_else.36148:
    li      1, $i22                     # |     64,856 |     64,856 |
.count b_cont
    b       be_cont.36145               # |     64,856 |     64,856 |
be_else.36147:
    li      1, $i22                     # |     10,133 |     10,133 |
.count b_cont
    b       be_cont.36145               # |     10,133 |     10,133 |
be_else.36145:
    li      1, $i22                     # |     40,283 |     40,283 |
be_cont.36145:
be_cont.36144:
ble_cont.36143:
be_cont.36142:
be_cont.36141:
    bne     $i22, 0, be_else.36149      # |    642,165 |    642,165 |
be_then.36149:
    li      1, $i2                      # |    526,893 |    526,893 |
.count move_args
    mov     $ig2, $i3                   # |    526,893 |    526,893 |
    call    shadow_check_one_or_matrix.2868# |    526,893 |    526,893 |
.count b_cont
    b       be_cont.36149               # |    526,893 |    526,893 |
be_else.36149:
.count stack_load
    load    [$sp + 4], $i22             # |    115,272 |    115,272 |
    load    [$i22 + 1], $i23            # |    115,272 |    115,272 |
    bne     $i23, -1, be_else.36150     # |    115,272 |    115,272 |
be_then.36150:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    shadow_check_one_or_matrix.2868
.count b_cont
    b       be_cont.36150
be_else.36150:
    li      0, $i2                      # |    115,272 |    115,272 |
    load    [min_caml_and_net + $i23], $i3# |    115,272 |    115,272 |
    call    shadow_check_and_group.2862 # |    115,272 |    115,272 |
.count move_ret
    mov     $i1, $i23                   # |    115,272 |    115,272 |
    bne     $i23, 0, be_else.36151      # |    115,272 |    115,272 |
be_then.36151:
    load    [$i22 + 2], $i23            # |     74,989 |     74,989 |
    bne     $i23, -1, be_else.36152     # |     74,989 |     74,989 |
be_then.36152:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    shadow_check_one_or_matrix.2868
.count b_cont
    b       be_cont.36151
be_else.36152:
    li      0, $i2                      # |     74,989 |     74,989 |
    load    [min_caml_and_net + $i23], $i3# |     74,989 |     74,989 |
    call    shadow_check_and_group.2862 # |     74,989 |     74,989 |
.count move_ret
    mov     $i1, $i20                   # |     74,989 |     74,989 |
    bne     $i20, 0, be_else.36153      # |     74,989 |     74,989 |
be_then.36153:
    li      3, $i2                      # |     64,856 |     64,856 |
.count move_args
    mov     $i22, $i3                   # |     64,856 |     64,856 |
    call    shadow_check_one_or_group.2865# |     64,856 |     64,856 |
.count move_ret
    mov     $i1, $i22                   # |     64,856 |     64,856 |
    bne     $i22, 0, be_else.36154      # |     64,856 |     64,856 |
be_then.36154:
    li      1, $i2
.count move_args
    mov     $ig2, $i3
    call    shadow_check_one_or_matrix.2868
.count b_cont
    b       be_cont.36151
be_else.36154:
    li      1, $i1                      # |     64,856 |     64,856 |
.count b_cont
    b       be_cont.36151               # |     64,856 |     64,856 |
be_else.36153:
    li      1, $i1                      # |     10,133 |     10,133 |
.count b_cont
    b       be_cont.36151               # |     10,133 |     10,133 |
be_else.36151:
    li      1, $i1                      # |     40,283 |     40,283 |
be_cont.36151:
be_cont.36150:
be_cont.36149:
be_cont.36140:
.count stack_load
    load    [$sp + 0], $ra              # |    642,165 |    642,165 |
.count stack_move
    add     $sp, 5, $sp                 # |    642,165 |    642,165 |
    bne     $i1, 0, be_else.36155       # |    642,165 |    642,165 |
be_then.36155:
.count stack_load
    load    [$sp - 2], $i1              # |    523,116 |    523,116 |
    load    [$i1 + 7], $i1              # |    523,116 |    523,116 |
    load    [min_caml_nvector + 0], $f1 # |    523,116 |    523,116 |
    fmul    $f1, $fg12, $f1             # |    523,116 |    523,116 |
    load    [min_caml_nvector + 1], $f2 # |    523,116 |    523,116 |
    fmul    $f2, $fg13, $f2             # |    523,116 |    523,116 |
    fadd    $f1, $f2, $f1               # |    523,116 |    523,116 |
    load    [min_caml_nvector + 2], $f2 # |    523,116 |    523,116 |
    fmul    $f2, $fg14, $f2             # |    523,116 |    523,116 |
    fadd_n  $f1, $f2, $f1               # |    523,116 |    523,116 |
    bg      $f1, $f0, ble_cont.36156    # |    523,116 |    523,116 |
ble_then.36156:
    mov     $f0, $f1                    # |        709 |        709 |
ble_cont.36156:
.count stack_load
    load    [$sp - 4], $f2              # |    523,116 |    523,116 |
    fmul    $f2, $f1, $f1               # |    523,116 |    523,116 |
    load    [$i1 + 0], $f2              # |    523,116 |    523,116 |
    fmul    $f1, $f2, $f1               # |    523,116 |    523,116 |
    fmul    $f1, $fg16, $f2             # |    523,116 |    523,116 |
    fadd    $fg1, $f2, $fg1             # |    523,116 |    523,116 |
    fmul    $f1, $fg11, $f2             # |    523,116 |    523,116 |
    fadd    $fg2, $f2, $fg2             # |    523,116 |    523,116 |
    fmul    $f1, $fg15, $f1             # |    523,116 |    523,116 |
    fadd    $fg3, $f1, $fg3             # |    523,116 |    523,116 |
    ret                                 # |    523,116 |    523,116 |
be_else.36155:
    ret                                 # |    119,049 |    119,049 |
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
    bl      $i4, 0, bge_else.36157      # |    558,060 |    558,060 |
bge_then.36157:
.count stack_move
    sub     $sp, 4, $sp                 # |    558,060 |    558,060 |
.count stack_store
    store   $ra, [$sp + 0]              # |    558,060 |    558,060 |
    load    [$i2 + $i4], $i24           # |    558,060 |    558,060 |
    load    [$i24 + 0], $i24            # |    558,060 |    558,060 |
    load    [$i24 + 0], $f1             # |    558,060 |    558,060 |
    load    [$i3 + 0], $f2              # |    558,060 |    558,060 |
    fmul    $f1, $f2, $f1               # |    558,060 |    558,060 |
    load    [$i24 + 1], $f2             # |    558,060 |    558,060 |
    load    [$i3 + 1], $f3              # |    558,060 |    558,060 |
    fmul    $f2, $f3, $f2               # |    558,060 |    558,060 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |
    load    [$i24 + 2], $f2             # |    558,060 |    558,060 |
    load    [$i3 + 2], $f3              # |    558,060 |    558,060 |
    fmul    $f2, $f3, $f2               # |    558,060 |    558,060 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |
.count stack_store
    store   $i3, [$sp + 1]              # |    558,060 |    558,060 |
.count stack_store
    store   $i2, [$sp + 2]              # |    558,060 |    558,060 |
.count stack_store
    store   $i4, [$sp + 3]              # |    558,060 |    558,060 |
    bg      $f0, $f1, ble_else.36158    # |    558,060 |    558,060 |
ble_then.36158:
    fmul    $f1, $fc1, $f2              # |    381,307 |    381,307 |
    load    [$i2 + $i4], $i2            # |    381,307 |    381,307 |
    call    trace_diffuse_ray.2926      # |    381,307 |    381,307 |
.count stack_load
    load    [$sp + 3], $i24             # |    381,307 |    381,307 |
    sub     $i24, 2, $i24               # |    381,307 |    381,307 |
    bl      $i24, 0, bge_else.36159     # |    381,307 |    381,307 |
bge_then.36159:
.count stack_load
    load    [$sp + 2], $i25             # |    365,736 |    365,736 |
    load    [$i25 + $i24], $i26         # |    365,736 |    365,736 |
    load    [$i26 + 0], $i26            # |    365,736 |    365,736 |
    load    [$i26 + 0], $f1             # |    365,736 |    365,736 |
.count stack_load
    load    [$sp + 1], $i27             # |    365,736 |    365,736 |
    load    [$i27 + 0], $f2             # |    365,736 |    365,736 |
    fmul    $f1, $f2, $f1               # |    365,736 |    365,736 |
    load    [$i26 + 1], $f2             # |    365,736 |    365,736 |
    load    [$i27 + 1], $f3             # |    365,736 |    365,736 |
    fmul    $f2, $f3, $f2               # |    365,736 |    365,736 |
    fadd    $f1, $f2, $f1               # |    365,736 |    365,736 |
    load    [$i26 + 2], $f2             # |    365,736 |    365,736 |
    load    [$i27 + 2], $f3             # |    365,736 |    365,736 |
    fmul    $f2, $f3, $f2               # |    365,736 |    365,736 |
    fadd    $f1, $f2, $f1               # |    365,736 |    365,736 |
    bg      $f0, $f1, ble_else.36160    # |    365,736 |    365,736 |
ble_then.36160:
    fmul    $f1, $fc1, $f2              # |    191,017 |    191,017 |
    load    [$i25 + $i24], $i2          # |    191,017 |    191,017 |
    call    trace_diffuse_ray.2926      # |    191,017 |    191,017 |
.count stack_load
    load    [$sp + 0], $ra              # |    191,017 |    191,017 |
.count stack_move
    add     $sp, 4, $sp                 # |    191,017 |    191,017 |
    sub     $i24, 2, $i4                # |    191,017 |    191,017 |
.count move_args
    mov     $i25, $i2                   # |    191,017 |    191,017 |
.count move_args
    mov     $i27, $i3                   # |    191,017 |    191,017 |
    b       iter_trace_diffuse_rays.2929# |    191,017 |    191,017 |
ble_else.36160:
    fmul    $f1, $fc2, $f2              # |    174,719 |    174,719 |
    add     $i24, 1, $i26               # |    174,719 |    174,719 |
    load    [$i25 + $i26], $i2          # |    174,719 |    174,719 |
    call    trace_diffuse_ray.2926      # |    174,719 |    174,719 |
.count stack_load
    load    [$sp + 0], $ra              # |    174,719 |    174,719 |
.count stack_move
    add     $sp, 4, $sp                 # |    174,719 |    174,719 |
    sub     $i24, 2, $i4                # |    174,719 |    174,719 |
.count move_args
    mov     $i25, $i2                   # |    174,719 |    174,719 |
.count move_args
    mov     $i27, $i3                   # |    174,719 |    174,719 |
    b       iter_trace_diffuse_rays.2929# |    174,719 |    174,719 |
bge_else.36159:
.count stack_load
    load    [$sp + 0], $ra              # |     15,571 |     15,571 |
.count stack_move
    add     $sp, 4, $sp                 # |     15,571 |     15,571 |
    ret                                 # |     15,571 |     15,571 |
ble_else.36158:
    fmul    $f1, $fc2, $f2              # |    176,753 |    176,753 |
    add     $i4, 1, $i24                # |    176,753 |    176,753 |
    load    [$i2 + $i24], $i2           # |    176,753 |    176,753 |
    call    trace_diffuse_ray.2926      # |    176,753 |    176,753 |
.count stack_load
    load    [$sp + 3], $i24             # |    176,753 |    176,753 |
    sub     $i24, 2, $i24               # |    176,753 |    176,753 |
    bl      $i24, 0, bge_else.36161     # |    176,753 |    176,753 |
bge_then.36161:
.count stack_load
    load    [$sp + 2], $i25             # |    173,722 |    173,722 |
    load    [$i25 + $i24], $i26         # |    173,722 |    173,722 |
    load    [$i26 + 0], $i26            # |    173,722 |    173,722 |
    load    [$i26 + 0], $f1             # |    173,722 |    173,722 |
.count stack_load
    load    [$sp + 1], $i27             # |    173,722 |    173,722 |
    load    [$i27 + 0], $f2             # |    173,722 |    173,722 |
    fmul    $f1, $f2, $f1               # |    173,722 |    173,722 |
    load    [$i26 + 1], $f2             # |    173,722 |    173,722 |
    load    [$i27 + 1], $f3             # |    173,722 |    173,722 |
    fmul    $f2, $f3, $f2               # |    173,722 |    173,722 |
    fadd    $f1, $f2, $f1               # |    173,722 |    173,722 |
    load    [$i26 + 2], $f2             # |    173,722 |    173,722 |
    load    [$i27 + 2], $f3             # |    173,722 |    173,722 |
    fmul    $f2, $f3, $f2               # |    173,722 |    173,722 |
    fadd    $f1, $f2, $f1               # |    173,722 |    173,722 |
    bg      $f0, $f1, ble_else.36162    # |    173,722 |    173,722 |
ble_then.36162:
    fmul    $f1, $fc1, $f2              # |     20,153 |     20,153 |
    load    [$i25 + $i24], $i2          # |     20,153 |     20,153 |
    call    trace_diffuse_ray.2926      # |     20,153 |     20,153 |
.count stack_load
    load    [$sp + 0], $ra              # |     20,153 |     20,153 |
.count stack_move
    add     $sp, 4, $sp                 # |     20,153 |     20,153 |
    sub     $i24, 2, $i4                # |     20,153 |     20,153 |
.count move_args
    mov     $i25, $i2                   # |     20,153 |     20,153 |
.count move_args
    mov     $i27, $i3                   # |     20,153 |     20,153 |
    b       iter_trace_diffuse_rays.2929# |     20,153 |     20,153 |
ble_else.36162:
    fmul    $f1, $fc2, $f2              # |    153,569 |    153,569 |
    add     $i24, 1, $i26               # |    153,569 |    153,569 |
    load    [$i25 + $i26], $i2          # |    153,569 |    153,569 |
    call    trace_diffuse_ray.2926      # |    153,569 |    153,569 |
.count stack_load
    load    [$sp + 0], $ra              # |    153,569 |    153,569 |
.count stack_move
    add     $sp, 4, $sp                 # |    153,569 |    153,569 |
    sub     $i24, 2, $i4                # |    153,569 |    153,569 |
.count move_args
    mov     $i25, $i2                   # |    153,569 |    153,569 |
.count move_args
    mov     $i27, $i3                   # |    153,569 |    153,569 |
    b       iter_trace_diffuse_rays.2929# |    153,569 |    153,569 |
bge_else.36161:
.count stack_load
    load    [$sp + 0], $ra              # |      3,031 |      3,031 |
.count stack_move
    add     $sp, 4, $sp                 # |      3,031 |      3,031 |
    ret                                 # |      3,031 |      3,031 |
bge_else.36157:
    ret
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
.count stack_move
    sub     $sp, 11, $sp                # |      1,737 |      1,737 |
.count stack_store
    store   $ra, [$sp + 0]              # |      1,737 |      1,737 |
.count stack_store
    store   $i3, [$sp + 1]              # |      1,737 |      1,737 |
.count stack_store
    store   $i2, [$sp + 2]              # |      1,737 |      1,737 |
    load    [$i2 + 5], $i10             # |      1,737 |      1,737 |
    load    [$i10 + $i3], $i10          # |      1,737 |      1,737 |
    load    [$i10 + 0], $fg1            # |      1,737 |      1,737 |
    load    [$i10 + 1], $fg2            # |      1,737 |      1,737 |
    load    [$i10 + 2], $fg3            # |      1,737 |      1,737 |
    load    [$i2 + 7], $i10             # |      1,737 |      1,737 |
    load    [$i2 + 1], $i11             # |      1,737 |      1,737 |
    load    [$i2 + 6], $i12             # |      1,737 |      1,737 |
    load    [$i10 + $i3], $i10          # |      1,737 |      1,737 |
.count stack_store
    store   $i10, [$sp + 3]             # |      1,737 |      1,737 |
    load    [$i11 + $i3], $i2           # |      1,737 |      1,737 |
.count stack_store
    store   $i2, [$sp + 4]              # |      1,737 |      1,737 |
    load    [$i12 + 0], $i11            # |      1,737 |      1,737 |
.count stack_store
    store   $i11, [$sp + 5]             # |      1,737 |      1,737 |
    be      $i11, 0, bne_cont.36163     # |      1,737 |      1,737 |
bne_then.36163:
    load    [min_caml_dirvecs + 0], $i11# |      1,389 |      1,389 |
    load    [$i2 + 0], $fg8             # |      1,389 |      1,389 |
    load    [$i2 + 1], $fg9             # |      1,389 |      1,389 |
    load    [$i2 + 2], $fg10            # |      1,389 |      1,389 |
    sub     $ig0, 1, $i3                # |      1,389 |      1,389 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |
    load    [$i11 + 118], $i24          # |      1,389 |      1,389 |
    load    [$i24 + 0], $i24            # |      1,389 |      1,389 |
    load    [$i24 + 0], $f10            # |      1,389 |      1,389 |
    load    [$i10 + 0], $f11            # |      1,389 |      1,389 |
    fmul    $f10, $f11, $f10            # |      1,389 |      1,389 |
    load    [$i24 + 1], $f11            # |      1,389 |      1,389 |
    load    [$i10 + 1], $f12            # |      1,389 |      1,389 |
    fmul    $f11, $f12, $f11            # |      1,389 |      1,389 |
    fadd    $f10, $f11, $f10            # |      1,389 |      1,389 |
    load    [$i24 + 2], $f11            # |      1,389 |      1,389 |
    load    [$i10 + 2], $f12            # |      1,389 |      1,389 |
    fmul    $f11, $f12, $f11            # |      1,389 |      1,389 |
    fadd    $f10, $f11, $f10            # |      1,389 |      1,389 |
.count stack_store
    store   $i11, [$sp + 6]             # |      1,389 |      1,389 |
    bg      $f0, $f10, ble_else.36164   # |      1,389 |      1,389 |
ble_then.36164:
    load    [$i11 + 118], $i2           # |         89 |         89 |
    fmul    $f10, $fc1, $f2             # |         89 |         89 |
    call    trace_diffuse_ray.2926      # |         89 |         89 |
    li      116, $i4                    # |         89 |         89 |
.count stack_load
    load    [$sp + 6], $i2              # |         89 |         89 |
.count stack_load
    load    [$sp + 3], $i3              # |         89 |         89 |
    call    iter_trace_diffuse_rays.2929# |         89 |         89 |
.count b_cont
    b       ble_cont.36164              # |         89 |         89 |
ble_else.36164:
    load    [$i11 + 119], $i2           # |      1,300 |      1,300 |
    fmul    $f10, $fc2, $f2             # |      1,300 |      1,300 |
    call    trace_diffuse_ray.2926      # |      1,300 |      1,300 |
    li      116, $i4                    # |      1,300 |      1,300 |
.count stack_load
    load    [$sp + 6], $i2              # |      1,300 |      1,300 |
.count stack_load
    load    [$sp + 3], $i3              # |      1,300 |      1,300 |
    call    iter_trace_diffuse_rays.2929# |      1,300 |      1,300 |
ble_cont.36164:
bne_cont.36163:
.count stack_load
    load    [$sp + 5], $i10             # |      1,737 |      1,737 |
    be      $i10, 1, bne_cont.36165     # |      1,737 |      1,737 |
bne_then.36165:
    load    [min_caml_dirvecs + 1], $i10# |      1,389 |      1,389 |
.count stack_load
    load    [$sp + 4], $i2              # |      1,389 |      1,389 |
    load    [$i2 + 0], $fg8             # |      1,389 |      1,389 |
    load    [$i2 + 1], $fg9             # |      1,389 |      1,389 |
    load    [$i2 + 2], $fg10            # |      1,389 |      1,389 |
    sub     $ig0, 1, $i3                # |      1,389 |      1,389 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |
    load    [$i10 + 118], $i24          # |      1,389 |      1,389 |
    load    [$i24 + 0], $i24            # |      1,389 |      1,389 |
    load    [$i24 + 0], $f10            # |      1,389 |      1,389 |
.count stack_load
    load    [$sp + 3], $i25             # |      1,389 |      1,389 |
    load    [$i25 + 0], $f11            # |      1,389 |      1,389 |
    fmul    $f10, $f11, $f10            # |      1,389 |      1,389 |
    load    [$i24 + 1], $f11            # |      1,389 |      1,389 |
    load    [$i25 + 1], $f12            # |      1,389 |      1,389 |
    fmul    $f11, $f12, $f11            # |      1,389 |      1,389 |
    fadd    $f10, $f11, $f10            # |      1,389 |      1,389 |
    load    [$i24 + 2], $f11            # |      1,389 |      1,389 |
    load    [$i25 + 2], $f12            # |      1,389 |      1,389 |
    fmul    $f11, $f12, $f11            # |      1,389 |      1,389 |
    fadd    $f10, $f11, $f10            # |      1,389 |      1,389 |
.count stack_store
    store   $i10, [$sp + 7]             # |      1,389 |      1,389 |
    bg      $f0, $f10, ble_else.36166   # |      1,389 |      1,389 |
ble_then.36166:
    load    [$i10 + 118], $i2           # |         96 |         96 |
    fmul    $f10, $fc1, $f2             # |         96 |         96 |
    call    trace_diffuse_ray.2926      # |         96 |         96 |
    li      116, $i4                    # |         96 |         96 |
.count stack_load
    load    [$sp + 7], $i2              # |         96 |         96 |
.count move_args
    mov     $i25, $i3                   # |         96 |         96 |
    call    iter_trace_diffuse_rays.2929# |         96 |         96 |
.count b_cont
    b       ble_cont.36166              # |         96 |         96 |
ble_else.36166:
    load    [$i10 + 119], $i2           # |      1,293 |      1,293 |
    fmul    $f10, $fc2, $f2             # |      1,293 |      1,293 |
    call    trace_diffuse_ray.2926      # |      1,293 |      1,293 |
    li      116, $i4                    # |      1,293 |      1,293 |
.count stack_load
    load    [$sp + 7], $i2              # |      1,293 |      1,293 |
.count move_args
    mov     $i25, $i3                   # |      1,293 |      1,293 |
    call    iter_trace_diffuse_rays.2929# |      1,293 |      1,293 |
ble_cont.36166:
bne_cont.36165:
.count stack_load
    load    [$sp + 5], $i10             # |      1,737 |      1,737 |
    be      $i10, 2, bne_cont.36167     # |      1,737 |      1,737 |
bne_then.36167:
    load    [min_caml_dirvecs + 2], $i10# |      1,400 |      1,400 |
.count stack_load
    load    [$sp + 4], $i2              # |      1,400 |      1,400 |
    load    [$i2 + 0], $fg8             # |      1,400 |      1,400 |
    load    [$i2 + 1], $fg9             # |      1,400 |      1,400 |
    load    [$i2 + 2], $fg10            # |      1,400 |      1,400 |
    sub     $ig0, 1, $i3                # |      1,400 |      1,400 |
    call    setup_startp_constants.2831 # |      1,400 |      1,400 |
    load    [$i10 + 118], $i24          # |      1,400 |      1,400 |
    load    [$i24 + 0], $i24            # |      1,400 |      1,400 |
    load    [$i24 + 0], $f10            # |      1,400 |      1,400 |
.count stack_load
    load    [$sp + 3], $i25             # |      1,400 |      1,400 |
    load    [$i25 + 0], $f11            # |      1,400 |      1,400 |
    fmul    $f10, $f11, $f10            # |      1,400 |      1,400 |
    load    [$i24 + 1], $f11            # |      1,400 |      1,400 |
    load    [$i25 + 1], $f12            # |      1,400 |      1,400 |
    fmul    $f11, $f12, $f11            # |      1,400 |      1,400 |
    fadd    $f10, $f11, $f10            # |      1,400 |      1,400 |
    load    [$i24 + 2], $f11            # |      1,400 |      1,400 |
    load    [$i25 + 2], $f12            # |      1,400 |      1,400 |
    fmul    $f11, $f12, $f11            # |      1,400 |      1,400 |
    fadd    $f10, $f11, $f10            # |      1,400 |      1,400 |
.count stack_store
    store   $i10, [$sp + 8]             # |      1,400 |      1,400 |
    bg      $f0, $f10, ble_else.36168   # |      1,400 |      1,400 |
ble_then.36168:
    load    [$i10 + 118], $i2           # |        125 |        125 |
    fmul    $f10, $fc1, $f2             # |        125 |        125 |
    call    trace_diffuse_ray.2926      # |        125 |        125 |
    li      116, $i4                    # |        125 |        125 |
.count stack_load
    load    [$sp + 8], $i2              # |        125 |        125 |
.count move_args
    mov     $i25, $i3                   # |        125 |        125 |
    call    iter_trace_diffuse_rays.2929# |        125 |        125 |
.count b_cont
    b       ble_cont.36168              # |        125 |        125 |
ble_else.36168:
    load    [$i10 + 119], $i2           # |      1,275 |      1,275 |
    fmul    $f10, $fc2, $f2             # |      1,275 |      1,275 |
    call    trace_diffuse_ray.2926      # |      1,275 |      1,275 |
    li      116, $i4                    # |      1,275 |      1,275 |
.count stack_load
    load    [$sp + 8], $i2              # |      1,275 |      1,275 |
.count move_args
    mov     $i25, $i3                   # |      1,275 |      1,275 |
    call    iter_trace_diffuse_rays.2929# |      1,275 |      1,275 |
ble_cont.36168:
bne_cont.36167:
.count stack_load
    load    [$sp + 5], $i10             # |      1,737 |      1,737 |
    be      $i10, 3, bne_cont.36169     # |      1,737 |      1,737 |
bne_then.36169:
    load    [min_caml_dirvecs + 3], $i10# |      1,385 |      1,385 |
.count stack_load
    load    [$sp + 4], $i2              # |      1,385 |      1,385 |
    load    [$i2 + 0], $fg8             # |      1,385 |      1,385 |
    load    [$i2 + 1], $fg9             # |      1,385 |      1,385 |
    load    [$i2 + 2], $fg10            # |      1,385 |      1,385 |
    sub     $ig0, 1, $i3                # |      1,385 |      1,385 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |
    load    [$i10 + 118], $i24          # |      1,385 |      1,385 |
    load    [$i24 + 0], $i24            # |      1,385 |      1,385 |
    load    [$i24 + 0], $f10            # |      1,385 |      1,385 |
.count stack_load
    load    [$sp + 3], $i25             # |      1,385 |      1,385 |
    load    [$i25 + 0], $f11            # |      1,385 |      1,385 |
    fmul    $f10, $f11, $f10            # |      1,385 |      1,385 |
    load    [$i24 + 1], $f11            # |      1,385 |      1,385 |
    load    [$i25 + 1], $f12            # |      1,385 |      1,385 |
    fmul    $f11, $f12, $f11            # |      1,385 |      1,385 |
    fadd    $f10, $f11, $f10            # |      1,385 |      1,385 |
    load    [$i24 + 2], $f11            # |      1,385 |      1,385 |
    load    [$i25 + 2], $f12            # |      1,385 |      1,385 |
    fmul    $f11, $f12, $f11            # |      1,385 |      1,385 |
    fadd    $f10, $f11, $f10            # |      1,385 |      1,385 |
.count stack_store
    store   $i10, [$sp + 9]             # |      1,385 |      1,385 |
    bg      $f0, $f10, ble_else.36170   # |      1,385 |      1,385 |
ble_then.36170:
    load    [$i10 + 118], $i2           # |        114 |        114 |
    fmul    $f10, $fc1, $f2             # |        114 |        114 |
    call    trace_diffuse_ray.2926      # |        114 |        114 |
    li      116, $i4                    # |        114 |        114 |
.count stack_load
    load    [$sp + 9], $i2              # |        114 |        114 |
.count move_args
    mov     $i25, $i3                   # |        114 |        114 |
    call    iter_trace_diffuse_rays.2929# |        114 |        114 |
.count b_cont
    b       ble_cont.36170              # |        114 |        114 |
ble_else.36170:
    load    [$i10 + 119], $i2           # |      1,271 |      1,271 |
    fmul    $f10, $fc2, $f2             # |      1,271 |      1,271 |
    call    trace_diffuse_ray.2926      # |      1,271 |      1,271 |
    li      116, $i4                    # |      1,271 |      1,271 |
.count stack_load
    load    [$sp + 9], $i2              # |      1,271 |      1,271 |
.count move_args
    mov     $i25, $i3                   # |      1,271 |      1,271 |
    call    iter_trace_diffuse_rays.2929# |      1,271 |      1,271 |
ble_cont.36170:
bne_cont.36169:
.count stack_load
    load    [$sp + 5], $i10             # |      1,737 |      1,737 |
    be      $i10, 4, bne_cont.36171     # |      1,737 |      1,737 |
bne_then.36171:
    load    [min_caml_dirvecs + 4], $i10# |      1,385 |      1,385 |
.count stack_load
    load    [$sp + 4], $i2              # |      1,385 |      1,385 |
    load    [$i2 + 0], $fg8             # |      1,385 |      1,385 |
    load    [$i2 + 1], $fg9             # |      1,385 |      1,385 |
    load    [$i2 + 2], $fg10            # |      1,385 |      1,385 |
    sub     $ig0, 1, $i3                # |      1,385 |      1,385 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |
    load    [$i10 + 118], $i24          # |      1,385 |      1,385 |
    load    [$i24 + 0], $i24            # |      1,385 |      1,385 |
    load    [$i24 + 0], $f1             # |      1,385 |      1,385 |
.count stack_load
    load    [$sp + 3], $i25             # |      1,385 |      1,385 |
    load    [$i25 + 0], $f2             # |      1,385 |      1,385 |
    fmul    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i24 + 1], $f2             # |      1,385 |      1,385 |
    load    [$i25 + 1], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i24 + 2], $f2             # |      1,385 |      1,385 |
    load    [$i25 + 2], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
.count stack_store
    store   $i10, [$sp + 10]            # |      1,385 |      1,385 |
    bg      $f0, $f1, ble_else.36172    # |      1,385 |      1,385 |
ble_then.36172:
    load    [$i10 + 118], $i2           # |         97 |         97 |
    fmul    $f1, $fc1, $f2              # |         97 |         97 |
    call    trace_diffuse_ray.2926      # |         97 |         97 |
    li      116, $i4                    # |         97 |         97 |
.count stack_load
    load    [$sp + 10], $i2             # |         97 |         97 |
.count move_args
    mov     $i25, $i3                   # |         97 |         97 |
    call    iter_trace_diffuse_rays.2929# |         97 |         97 |
.count b_cont
    b       ble_cont.36172              # |         97 |         97 |
ble_else.36172:
    load    [$i10 + 119], $i2           # |      1,288 |      1,288 |
    fmul    $f1, $fc2, $f2              # |      1,288 |      1,288 |
    call    trace_diffuse_ray.2926      # |      1,288 |      1,288 |
    li      116, $i4                    # |      1,288 |      1,288 |
.count stack_load
    load    [$sp + 10], $i2             # |      1,288 |      1,288 |
.count move_args
    mov     $i25, $i3                   # |      1,288 |      1,288 |
    call    iter_trace_diffuse_rays.2929# |      1,288 |      1,288 |
ble_cont.36172:
bne_cont.36171:
.count stack_load
    load    [$sp + 0], $ra              # |      1,737 |      1,737 |
.count stack_move
    add     $sp, 11, $sp                # |      1,737 |      1,737 |
.count stack_load
    load    [$sp - 9], $i1              # |      1,737 |      1,737 |
    load    [$i1 + 4], $i1              # |      1,737 |      1,737 |
.count stack_load
    load    [$sp - 10], $i2             # |      1,737 |      1,737 |
    load    [$i1 + $i2], $i1            # |      1,737 |      1,737 |
    load    [$i1 + 0], $f1              # |      1,737 |      1,737 |
    fmul    $f1, $fg1, $f1              # |      1,737 |      1,737 |
    fadd    $fg4, $f1, $fg4             # |      1,737 |      1,737 |
    load    [$i1 + 1], $f1              # |      1,737 |      1,737 |
    fmul    $f1, $fg2, $f1              # |      1,737 |      1,737 |
    fadd    $fg5, $f1, $fg5             # |      1,737 |      1,737 |
    load    [$i1 + 2], $f1              # |      1,737 |      1,737 |
    fmul    $f1, $fg3, $f1              # |      1,737 |      1,737 |
    fadd    $fg6, $f1, $fg6             # |      1,737 |      1,737 |
    ret                                 # |      1,737 |      1,737 |
.end calc_diffuse_using_1point

######################################################################
# do_without_neighbors
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
    bg      $i3, 4, ble_else.36173      # |      2,430 |      2,430 |
ble_then.36173:
    load    [$i2 + 2], $i28             # |      2,430 |      2,430 |
    load    [$i28 + $i3], $i29          # |      2,430 |      2,430 |
    bl      $i29, 0, bge_else.36174     # |      2,430 |      2,430 |
bge_then.36174:
    load    [$i2 + 3], $i29             # |        143 |        143 |
    load    [$i29 + $i3], $i30          # |        143 |        143 |
    bne     $i30, 0, be_else.36175      # |        143 |        143 |
be_then.36175:
    add     $i3, 1, $i3                 # |         11 |         11 |
    bg      $i3, 4, ble_else.36176      # |         11 |         11 |
ble_then.36176:
    load    [$i28 + $i3], $i28          # |         11 |         11 |
    bl      $i28, 0, bge_else.36177     # |         11 |         11 |
bge_then.36177:
    load    [$i29 + $i3], $i28          # |          1 |          1 |
    bne     $i28, 0, be_else.36178      # |          1 |          1 |
be_then.36178:
    add     $i3, 1, $i3
    b       do_without_neighbors.2951
be_else.36178:
.count stack_move
    sub     $sp, 13, $sp                # |          1 |          1 |
.count stack_store
    store   $ra, [$sp + 0]              # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 1]              # |          1 |          1 |
.count stack_store
    store   $i3, [$sp + 2]              # |          1 |          1 |
    call    calc_diffuse_using_1point.2942# |          1 |          1 |
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 13, $sp                # |          1 |          1 |
.count stack_load
    load    [$sp - 11], $i1             # |          1 |          1 |
    add     $i1, 1, $i3                 # |          1 |          1 |
.count stack_load
    load    [$sp - 12], $i2             # |          1 |          1 |
    b       do_without_neighbors.2951   # |          1 |          1 |
bge_else.36177:
    ret                                 # |         10 |         10 |
ble_else.36176:
    ret
be_else.36175:
.count stack_move
    sub     $sp, 13, $sp                # |        132 |        132 |
.count stack_store
    store   $ra, [$sp + 0]              # |        132 |        132 |
.count stack_store
    store   $i3, [$sp + 3]              # |        132 |        132 |
.count stack_store
    store   $i2, [$sp + 1]              # |        132 |        132 |
    load    [$i2 + 5], $i10             # |        132 |        132 |
    load    [$i10 + $i3], $i10          # |        132 |        132 |
    load    [$i10 + 0], $fg1            # |        132 |        132 |
    load    [$i10 + 1], $fg2            # |        132 |        132 |
    load    [$i10 + 2], $fg3            # |        132 |        132 |
    load    [$i2 + 7], $i10             # |        132 |        132 |
    load    [$i2 + 1], $i11             # |        132 |        132 |
    load    [$i2 + 6], $i12             # |        132 |        132 |
    load    [$i10 + $i3], $i10          # |        132 |        132 |
.count stack_store
    store   $i10, [$sp + 4]             # |        132 |        132 |
    load    [$i11 + $i3], $i2           # |        132 |        132 |
.count stack_store
    store   $i2, [$sp + 5]              # |        132 |        132 |
    load    [$i12 + 0], $i11            # |        132 |        132 |
.count stack_store
    store   $i11, [$sp + 6]             # |        132 |        132 |
    be      $i11, 0, bne_cont.36179     # |        132 |        132 |
bne_then.36179:
    load    [min_caml_dirvecs + 0], $i11# |        107 |        107 |
    load    [$i2 + 0], $fg8             # |        107 |        107 |
    load    [$i2 + 1], $fg9             # |        107 |        107 |
    load    [$i2 + 2], $fg10            # |        107 |        107 |
    sub     $ig0, 1, $i3                # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i11 + 118], $i24          # |        107 |        107 |
    load    [$i24 + 0], $i24            # |        107 |        107 |
    load    [$i24 + 0], $f10            # |        107 |        107 |
    load    [$i10 + 0], $f11            # |        107 |        107 |
    fmul    $f10, $f11, $f10            # |        107 |        107 |
    load    [$i24 + 1], $f11            # |        107 |        107 |
    load    [$i10 + 1], $f12            # |        107 |        107 |
    fmul    $f11, $f12, $f11            # |        107 |        107 |
    fadd    $f10, $f11, $f10            # |        107 |        107 |
    load    [$i24 + 2], $f11            # |        107 |        107 |
    load    [$i10 + 2], $f12            # |        107 |        107 |
    fmul    $f11, $f12, $f11            # |        107 |        107 |
    fadd    $f10, $f11, $f10            # |        107 |        107 |
.count stack_store
    store   $i11, [$sp + 7]             # |        107 |        107 |
    bg      $f0, $f10, ble_else.36180   # |        107 |        107 |
ble_then.36180:
    fmul    $f10, $fc1, $f2
    load    [$i11 + 118], $i2
    call    trace_diffuse_ray.2926
    li      116, $i4
.count stack_load
    load    [$sp + 7], $i2
.count stack_load
    load    [$sp + 4], $i3
    call    iter_trace_diffuse_rays.2929
.count b_cont
    b       ble_cont.36180
ble_else.36180:
    fmul    $f10, $fc2, $f2             # |        107 |        107 |
    load    [$i11 + 119], $i2           # |        107 |        107 |
    call    trace_diffuse_ray.2926      # |        107 |        107 |
    li      116, $i4                    # |        107 |        107 |
.count stack_load
    load    [$sp + 7], $i2              # |        107 |        107 |
.count stack_load
    load    [$sp + 4], $i3              # |        107 |        107 |
    call    iter_trace_diffuse_rays.2929# |        107 |        107 |
ble_cont.36180:
bne_cont.36179:
.count stack_load
    load    [$sp + 6], $i10             # |        132 |        132 |
    be      $i10, 1, bne_cont.36181     # |        132 |        132 |
bne_then.36181:
    load    [min_caml_dirvecs + 1], $i10# |        104 |        104 |
.count stack_load
    load    [$sp + 5], $i2              # |        104 |        104 |
    load    [$i2 + 0], $fg8             # |        104 |        104 |
    load    [$i2 + 1], $fg9             # |        104 |        104 |
    load    [$i2 + 2], $fg10            # |        104 |        104 |
    sub     $ig0, 1, $i3                # |        104 |        104 |
    call    setup_startp_constants.2831 # |        104 |        104 |
    load    [$i10 + 118], $i24          # |        104 |        104 |
    load    [$i24 + 0], $i24            # |        104 |        104 |
    load    [$i24 + 0], $f10            # |        104 |        104 |
.count stack_load
    load    [$sp + 4], $i25             # |        104 |        104 |
    load    [$i25 + 0], $f11            # |        104 |        104 |
    fmul    $f10, $f11, $f10            # |        104 |        104 |
    load    [$i24 + 1], $f11            # |        104 |        104 |
    load    [$i25 + 1], $f12            # |        104 |        104 |
    fmul    $f11, $f12, $f11            # |        104 |        104 |
    fadd    $f10, $f11, $f10            # |        104 |        104 |
    load    [$i24 + 2], $f11            # |        104 |        104 |
    load    [$i25 + 2], $f12            # |        104 |        104 |
    fmul    $f11, $f12, $f11            # |        104 |        104 |
    fadd    $f10, $f11, $f10            # |        104 |        104 |
.count stack_store
    store   $i10, [$sp + 8]             # |        104 |        104 |
    bg      $f0, $f10, ble_else.36182   # |        104 |        104 |
ble_then.36182:
    fmul    $f10, $fc1, $f2
    load    [$i10 + 118], $i2
    call    trace_diffuse_ray.2926
    li      116, $i4
.count stack_load
    load    [$sp + 8], $i2
.count move_args
    mov     $i25, $i3
    call    iter_trace_diffuse_rays.2929
.count b_cont
    b       ble_cont.36182
ble_else.36182:
    fmul    $f10, $fc2, $f2             # |        104 |        104 |
    load    [$i10 + 119], $i2           # |        104 |        104 |
    call    trace_diffuse_ray.2926      # |        104 |        104 |
    li      116, $i4                    # |        104 |        104 |
.count stack_load
    load    [$sp + 8], $i2              # |        104 |        104 |
.count move_args
    mov     $i25, $i3                   # |        104 |        104 |
    call    iter_trace_diffuse_rays.2929# |        104 |        104 |
ble_cont.36182:
bne_cont.36181:
.count stack_load
    load    [$sp + 6], $i10             # |        132 |        132 |
    be      $i10, 2, bne_cont.36183     # |        132 |        132 |
bne_then.36183:
    load    [min_caml_dirvecs + 2], $i10# |        107 |        107 |
.count stack_load
    load    [$sp + 5], $i2              # |        107 |        107 |
    load    [$i2 + 0], $fg8             # |        107 |        107 |
    load    [$i2 + 1], $fg9             # |        107 |        107 |
    load    [$i2 + 2], $fg10            # |        107 |        107 |
    sub     $ig0, 1, $i3                # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i10 + 118], $i24          # |        107 |        107 |
    load    [$i24 + 0], $i24            # |        107 |        107 |
    load    [$i24 + 0], $f10            # |        107 |        107 |
.count stack_load
    load    [$sp + 4], $i25             # |        107 |        107 |
    load    [$i25 + 0], $f11            # |        107 |        107 |
    fmul    $f10, $f11, $f10            # |        107 |        107 |
    load    [$i24 + 1], $f11            # |        107 |        107 |
    load    [$i25 + 1], $f12            # |        107 |        107 |
    fmul    $f11, $f12, $f11            # |        107 |        107 |
    fadd    $f10, $f11, $f10            # |        107 |        107 |
    load    [$i24 + 2], $f11            # |        107 |        107 |
    load    [$i25 + 2], $f12            # |        107 |        107 |
    fmul    $f11, $f12, $f11            # |        107 |        107 |
    fadd    $f10, $f11, $f10            # |        107 |        107 |
.count stack_store
    store   $i10, [$sp + 9]             # |        107 |        107 |
    bg      $f0, $f10, ble_else.36184   # |        107 |        107 |
ble_then.36184:
    fmul    $f10, $fc1, $f2
    load    [$i10 + 118], $i2
    call    trace_diffuse_ray.2926
    li      116, $i4
.count stack_load
    load    [$sp + 9], $i2
.count move_args
    mov     $i25, $i3
    call    iter_trace_diffuse_rays.2929
.count b_cont
    b       ble_cont.36184
ble_else.36184:
    fmul    $f10, $fc2, $f2             # |        107 |        107 |
    load    [$i10 + 119], $i2           # |        107 |        107 |
    call    trace_diffuse_ray.2926      # |        107 |        107 |
    li      116, $i4                    # |        107 |        107 |
.count stack_load
    load    [$sp + 9], $i2              # |        107 |        107 |
.count move_args
    mov     $i25, $i3                   # |        107 |        107 |
    call    iter_trace_diffuse_rays.2929# |        107 |        107 |
ble_cont.36184:
bne_cont.36183:
.count stack_load
    load    [$sp + 6], $i10             # |        132 |        132 |
    be      $i10, 3, bne_cont.36185     # |        132 |        132 |
bne_then.36185:
    load    [min_caml_dirvecs + 3], $i10# |        103 |        103 |
.count stack_load
    load    [$sp + 5], $i2              # |        103 |        103 |
    load    [$i2 + 0], $fg8             # |        103 |        103 |
    load    [$i2 + 1], $fg9             # |        103 |        103 |
    load    [$i2 + 2], $fg10            # |        103 |        103 |
    sub     $ig0, 1, $i3                # |        103 |        103 |
    call    setup_startp_constants.2831 # |        103 |        103 |
    load    [$i10 + 118], $i24          # |        103 |        103 |
    load    [$i24 + 0], $i24            # |        103 |        103 |
    load    [$i24 + 0], $f10            # |        103 |        103 |
.count stack_load
    load    [$sp + 4], $i25             # |        103 |        103 |
    load    [$i25 + 0], $f11            # |        103 |        103 |
    fmul    $f10, $f11, $f10            # |        103 |        103 |
    load    [$i24 + 1], $f11            # |        103 |        103 |
    load    [$i25 + 1], $f12            # |        103 |        103 |
    fmul    $f11, $f12, $f11            # |        103 |        103 |
    fadd    $f10, $f11, $f10            # |        103 |        103 |
    load    [$i24 + 2], $f11            # |        103 |        103 |
    load    [$i25 + 2], $f12            # |        103 |        103 |
    fmul    $f11, $f12, $f11            # |        103 |        103 |
    fadd    $f10, $f11, $f10            # |        103 |        103 |
.count stack_store
    store   $i10, [$sp + 10]            # |        103 |        103 |
    bg      $f0, $f10, ble_else.36186   # |        103 |        103 |
ble_then.36186:
    fmul    $f10, $fc1, $f2
    load    [$i10 + 118], $i2
    call    trace_diffuse_ray.2926
    li      116, $i4
.count stack_load
    load    [$sp + 10], $i2
.count move_args
    mov     $i25, $i3
    call    iter_trace_diffuse_rays.2929
.count b_cont
    b       ble_cont.36186
ble_else.36186:
    fmul    $f10, $fc2, $f2             # |        103 |        103 |
    load    [$i10 + 119], $i2           # |        103 |        103 |
    call    trace_diffuse_ray.2926      # |        103 |        103 |
    li      116, $i4                    # |        103 |        103 |
.count stack_load
    load    [$sp + 10], $i2             # |        103 |        103 |
.count move_args
    mov     $i25, $i3                   # |        103 |        103 |
    call    iter_trace_diffuse_rays.2929# |        103 |        103 |
ble_cont.36186:
bne_cont.36185:
.count stack_load
    load    [$sp + 6], $i10             # |        132 |        132 |
    be      $i10, 4, bne_cont.36187     # |        132 |        132 |
bne_then.36187:
    load    [min_caml_dirvecs + 4], $i10# |        107 |        107 |
.count stack_load
    load    [$sp + 5], $i2              # |        107 |        107 |
    load    [$i2 + 0], $fg8             # |        107 |        107 |
    load    [$i2 + 1], $fg9             # |        107 |        107 |
    load    [$i2 + 2], $fg10            # |        107 |        107 |
    sub     $ig0, 1, $i3                # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i10 + 118], $i24          # |        107 |        107 |
    load    [$i24 + 0], $i24            # |        107 |        107 |
    load    [$i24 + 0], $f1             # |        107 |        107 |
.count stack_load
    load    [$sp + 4], $i25             # |        107 |        107 |
    load    [$i25 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i24 + 1], $f2             # |        107 |        107 |
    load    [$i25 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i24 + 2], $f2             # |        107 |        107 |
    load    [$i25 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
.count stack_store
    store   $i10, [$sp + 11]            # |        107 |        107 |
    bg      $f0, $f1, ble_else.36188    # |        107 |        107 |
ble_then.36188:
    fmul    $f1, $fc1, $f2
    load    [$i10 + 118], $i2
    call    trace_diffuse_ray.2926
    li      116, $i4
.count stack_load
    load    [$sp + 11], $i2
.count move_args
    mov     $i25, $i3
    call    iter_trace_diffuse_rays.2929
.count b_cont
    b       ble_cont.36188
ble_else.36188:
    fmul    $f1, $fc2, $f2              # |        107 |        107 |
    load    [$i10 + 119], $i2           # |        107 |        107 |
    call    trace_diffuse_ray.2926      # |        107 |        107 |
    li      116, $i4                    # |        107 |        107 |
.count stack_load
    load    [$sp + 11], $i2             # |        107 |        107 |
.count move_args
    mov     $i25, $i3                   # |        107 |        107 |
    call    iter_trace_diffuse_rays.2929# |        107 |        107 |
ble_cont.36188:
bne_cont.36187:
.count stack_load
    load    [$sp + 1], $i2              # |        132 |        132 |
    load    [$i2 + 4], $i30             # |        132 |        132 |
.count stack_load
    load    [$sp + 3], $i31             # |        132 |        132 |
    load    [$i30 + $i31], $i30         # |        132 |        132 |
    load    [$i30 + 0], $f1             # |        132 |        132 |
    fmul    $f1, $fg1, $f1              # |        132 |        132 |
    fadd    $fg4, $f1, $fg4             # |        132 |        132 |
    load    [$i30 + 1], $f1             # |        132 |        132 |
    fmul    $f1, $fg2, $f1              # |        132 |        132 |
    fadd    $fg5, $f1, $fg5             # |        132 |        132 |
    load    [$i30 + 2], $f1             # |        132 |        132 |
    fmul    $f1, $fg3, $f1              # |        132 |        132 |
    fadd    $fg6, $f1, $fg6             # |        132 |        132 |
    add     $i31, 1, $i3                # |        132 |        132 |
    bg      $i3, 4, ble_else.36189      # |        132 |        132 |
ble_then.36189:
    load    [$i28 + $i3], $i28          # |        132 |        132 |
    bl      $i28, 0, bge_else.36190     # |        132 |        132 |
bge_then.36190:
    load    [$i29 + $i3], $i28
    bne     $i28, 0, be_else.36191
be_then.36191:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 13, $sp
    add     $i3, 1, $i3
    b       do_without_neighbors.2951
be_else.36191:
.count stack_store
    store   $i3, [$sp + 12]
    call    calc_diffuse_using_1point.2942
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 13, $sp
.count stack_load
    load    [$sp - 1], $i1
    add     $i1, 1, $i3
.count stack_load
    load    [$sp - 12], $i2
    b       do_without_neighbors.2951
bge_else.36190:
.count stack_load
    load    [$sp + 0], $ra              # |        132 |        132 |
.count stack_move
    add     $sp, 13, $sp                # |        132 |        132 |
    ret                                 # |        132 |        132 |
ble_else.36189:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 13, $sp
    ret
bge_else.36174:
    ret                                 # |      2,287 |      2,287 |
ble_else.36173:
    ret
.end do_without_neighbors

######################################################################
# try_exploit_neighbors
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
    bg      $i6, 4, ble_else.36192      # |     23,861 |     23,861 |
ble_then.36192:
    load    [$i4 + $i2], $i32           # |     23,861 |     23,861 |
    load    [$i32 + 2], $i33            # |     23,861 |     23,861 |
    load    [$i33 + $i6], $i33          # |     23,861 |     23,861 |
    bl      $i33, 0, bge_else.36193     # |     23,861 |     23,861 |
bge_then.36193:
    load    [$i3 + $i2], $i34           # |      9,906 |      9,906 |
    load    [$i34 + 2], $i35            # |      9,906 |      9,906 |
    load    [$i35 + $i6], $i35          # |      9,906 |      9,906 |
    bne     $i35, $i33, be_else.36194   # |      9,906 |      9,906 |
be_then.36194:
    load    [$i5 + $i2], $i35           # |      9,429 |      9,429 |
    load    [$i35 + 2], $i35            # |      9,429 |      9,429 |
    load    [$i35 + $i6], $i35          # |      9,429 |      9,429 |
    bne     $i35, $i33, be_else.36195   # |      9,429 |      9,429 |
be_then.36195:
    sub     $i2, 1, $i35                # |      9,028 |      9,028 |
    load    [$i4 + $i35], $i35          # |      9,028 |      9,028 |
    load    [$i35 + 2], $i35            # |      9,028 |      9,028 |
    load    [$i35 + $i6], $i35          # |      9,028 |      9,028 |
    bne     $i35, $i33, be_else.36196   # |      9,028 |      9,028 |
be_then.36196:
    add     $i2, 1, $i35                # |      8,880 |      8,880 |
    load    [$i4 + $i35], $i35          # |      8,880 |      8,880 |
    load    [$i35 + 2], $i35            # |      8,880 |      8,880 |
    load    [$i35 + $i6], $i35          # |      8,880 |      8,880 |
    bne     $i35, $i33, be_else.36197   # |      8,880 |      8,880 |
be_then.36197:
    li      1, $i33                     # |      8,752 |      8,752 |
.count b_cont
    b       be_cont.36194               # |      8,752 |      8,752 |
be_else.36197:
    li      0, $i33                     # |        128 |        128 |
.count b_cont
    b       be_cont.36194               # |        128 |        128 |
be_else.36196:
    li      0, $i33                     # |        148 |        148 |
.count b_cont
    b       be_cont.36194               # |        148 |        148 |
be_else.36195:
    li      0, $i33                     # |        401 |        401 |
.count b_cont
    b       be_cont.36194               # |        401 |        401 |
be_else.36194:
    li      0, $i33                     # |        477 |        477 |
be_cont.36194:
    bne     $i33, 0, be_else.36198      # |      9,906 |      9,906 |
be_then.36198:
    bg      $i6, 4, ble_else.36199      # |      1,154 |      1,154 |
ble_then.36199:
    load    [$i4 + $i2], $i2            # |      1,154 |      1,154 |
    load    [$i2 + 2], $i32             # |      1,154 |      1,154 |
    load    [$i32 + $i6], $i32          # |      1,154 |      1,154 |
    bl      $i32, 0, bge_else.36200     # |      1,154 |      1,154 |
bge_then.36200:
    load    [$i2 + 3], $i32             # |      1,154 |      1,154 |
    load    [$i32 + $i6], $i32          # |      1,154 |      1,154 |
    bne     $i32, 0, be_else.36201      # |      1,154 |      1,154 |
be_then.36201:
    add     $i6, 1, $i3                 # |        178 |        178 |
    b       do_without_neighbors.2951   # |        178 |        178 |
be_else.36201:
.count stack_move
    sub     $sp, 3, $sp                 # |        976 |        976 |
.count stack_store
    store   $ra, [$sp + 0]              # |        976 |        976 |
.count stack_store
    store   $i2, [$sp + 1]              # |        976 |        976 |
.count stack_store
    store   $i6, [$sp + 2]              # |        976 |        976 |
.count move_args
    mov     $i6, $i3                    # |        976 |        976 |
    call    calc_diffuse_using_1point.2942# |        976 |        976 |
.count stack_load
    load    [$sp + 0], $ra              # |        976 |        976 |
.count stack_move
    add     $sp, 3, $sp                 # |        976 |        976 |
.count stack_load
    load    [$sp - 1], $i32             # |        976 |        976 |
    add     $i32, 1, $i3                # |        976 |        976 |
.count stack_load
    load    [$sp - 2], $i2              # |        976 |        976 |
    b       do_without_neighbors.2951   # |        976 |        976 |
bge_else.36200:
    ret
ble_else.36199:
    ret
be_else.36198:
    load    [$i32 + 3], $i1             # |      8,752 |      8,752 |
    load    [$i1 + $i6], $i1            # |      8,752 |      8,752 |
    bne     $i1, 0, be_else.36202       # |      8,752 |      8,752 |
be_then.36202:
    add     $i6, 1, $i6                 # |      3,348 |      3,348 |
    b       try_exploit_neighbors.2967  # |      3,348 |      3,348 |
be_else.36202:
    load    [$i34 + 5], $i1             # |      5,404 |      5,404 |
    load    [$i1 + $i6], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 0], $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $fg3             # |      5,404 |      5,404 |
    sub     $i2, 1, $i1                 # |      5,404 |      5,404 |
    load    [$i4 + $i1], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i6], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fadd    $fg1, $f1, $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fadd    $fg2, $f1, $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fadd    $fg3, $f1, $fg3             # |      5,404 |      5,404 |
    load    [$i4 + $i2], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i6], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fadd    $fg1, $f1, $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fadd    $fg2, $f1, $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fadd    $fg3, $f1, $fg3             # |      5,404 |      5,404 |
    add     $i2, 1, $i1                 # |      5,404 |      5,404 |
    load    [$i4 + $i1], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i6], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fadd    $fg1, $f1, $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fadd    $fg2, $f1, $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fadd    $fg3, $f1, $fg3             # |      5,404 |      5,404 |
    load    [$i5 + $i2], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 5], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i6], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fadd    $fg1, $f1, $fg1             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fadd    $fg2, $f1, $fg2             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fadd    $fg3, $f1, $fg3             # |      5,404 |      5,404 |
    load    [$i4 + $i2], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 4], $i1              # |      5,404 |      5,404 |
    load    [$i1 + $i6], $i1            # |      5,404 |      5,404 |
    load    [$i1 + 0], $f1              # |      5,404 |      5,404 |
    fmul    $f1, $fg1, $f1              # |      5,404 |      5,404 |
    fadd    $fg4, $f1, $fg4             # |      5,404 |      5,404 |
    load    [$i1 + 1], $f1              # |      5,404 |      5,404 |
    fmul    $f1, $fg2, $f1              # |      5,404 |      5,404 |
    fadd    $fg5, $f1, $fg5             # |      5,404 |      5,404 |
    load    [$i1 + 2], $f1              # |      5,404 |      5,404 |
    fmul    $f1, $fg3, $f1              # |      5,404 |      5,404 |
    fadd    $fg6, $f1, $fg6             # |      5,404 |      5,404 |
    add     $i6, 1, $i6                 # |      5,404 |      5,404 |
    b       try_exploit_neighbors.2967  # |      5,404 |      5,404 |
bge_else.36193:
    ret                                 # |     13,955 |     13,955 |
ble_else.36192:
    ret
.end try_exploit_neighbors

######################################################################
# pretrace_diffuse_rays
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
    bg      $i3, 4, ble_else.36203      # |     16,395 |     16,395 |
ble_then.36203:
    load    [$i2 + 2], $i10             # |     16,395 |     16,395 |
    load    [$i10 + $i3], $i11          # |     16,395 |     16,395 |
    bl      $i11, 0, bge_else.36204     # |     16,395 |     16,395 |
bge_then.36204:
    load    [$i2 + 3], $i11             # |      2,101 |      2,101 |
    load    [$i11 + $i3], $i12          # |      2,101 |      2,101 |
    bne     $i12, 0, be_else.36205      # |      2,101 |      2,101 |
be_then.36205:
    add     $i3, 1, $i12                # |         67 |         67 |
    bg      $i12, 4, ble_else.36206     # |         67 |         67 |
ble_then.36206:
    load    [$i10 + $i12], $i10         # |         67 |         67 |
    bl      $i10, 0, bge_else.36207     # |         67 |         67 |
bge_then.36207:
    load    [$i11 + $i12], $i10         # |         11 |         11 |
    bne     $i10, 0, be_else.36208      # |         11 |         11 |
be_then.36208:
    add     $i12, 1, $i3                # |          2 |          2 |
    b       pretrace_diffuse_rays.2980  # |          2 |          2 |
be_else.36208:
.count stack_move
    sub     $sp, 10, $sp                # |          9 |          9 |
.count stack_store
    store   $ra, [$sp + 0]              # |          9 |          9 |
.count stack_store
    store   $i12, [$sp + 1]             # |          9 |          9 |
.count stack_store
    store   $i2, [$sp + 2]              # |          9 |          9 |
    mov     $f0, $fg1                   # |          9 |          9 |
    mov     $f0, $fg2                   # |          9 |          9 |
    mov     $f0, $fg3                   # |          9 |          9 |
    load    [$i2 + 6], $i10             # |          9 |          9 |
    load    [$i2 + 7], $i11             # |          9 |          9 |
    load    [$i2 + 1], $i13             # |          9 |          9 |
    load    [$i13 + $i12], $i2          # |          9 |          9 |
    load    [$i2 + 0], $fg8             # |          9 |          9 |
    load    [$i2 + 1], $fg9             # |          9 |          9 |
    load    [$i2 + 2], $fg10            # |          9 |          9 |
    sub     $ig0, 1, $i3                # |          9 |          9 |
    call    setup_startp_constants.2831 # |          9 |          9 |
    load    [$i10 + 0], $i24            # |          9 |          9 |
    load    [min_caml_dirvecs + $i24], $i24# |          9 |          9 |
    load    [$i24 + 118], $i25          # |          9 |          9 |
    load    [$i25 + 0], $i25            # |          9 |          9 |
    load    [$i11 + $i12], $i26         # |          9 |          9 |
    load    [$i25 + 0], $f1             # |          9 |          9 |
    load    [$i26 + 0], $f2             # |          9 |          9 |
    fmul    $f1, $f2, $f1               # |          9 |          9 |
    load    [$i25 + 1], $f2             # |          9 |          9 |
    load    [$i26 + 1], $f3             # |          9 |          9 |
    fmul    $f2, $f3, $f2               # |          9 |          9 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |
    load    [$i25 + 2], $f2             # |          9 |          9 |
    load    [$i26 + 2], $f3             # |          9 |          9 |
    fmul    $f2, $f3, $f2               # |          9 |          9 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |
    bg      $f0, $f1, ble_else.36209    # |          9 |          9 |
ble_then.36209:
    fmul    $f1, $fc1, $f2
    load    [$i24 + 118], $i2
    call    trace_diffuse_ray.2926
    li      116, $i4
.count move_args
    mov     $i24, $i2
.count move_args
    mov     $i26, $i3
    call    iter_trace_diffuse_rays.2929
.count b_cont
    b       ble_cont.36209
ble_else.36209:
    fmul    $f1, $fc2, $f2              # |          9 |          9 |
    load    [$i24 + 119], $i2           # |          9 |          9 |
    call    trace_diffuse_ray.2926      # |          9 |          9 |
    li      116, $i4                    # |          9 |          9 |
.count move_args
    mov     $i24, $i2                   # |          9 |          9 |
.count move_args
    mov     $i26, $i3                   # |          9 |          9 |
    call    iter_trace_diffuse_rays.2929# |          9 |          9 |
ble_cont.36209:
.count stack_load
    load    [$sp + 0], $ra              # |          9 |          9 |
.count stack_move
    add     $sp, 10, $sp                # |          9 |          9 |
.count stack_load
    load    [$sp - 8], $i2              # |          9 |          9 |
    load    [$i2 + 5], $i1              # |          9 |          9 |
.count stack_load
    load    [$sp - 9], $i3              # |          9 |          9 |
    load    [$i1 + $i3], $i1            # |          9 |          9 |
    store   $fg1, [$i1 + 0]             # |          9 |          9 |
    store   $fg2, [$i1 + 1]             # |          9 |          9 |
    store   $fg3, [$i1 + 2]             # |          9 |          9 |
    add     $i3, 1, $i3                 # |          9 |          9 |
    b       pretrace_diffuse_rays.2980  # |          9 |          9 |
bge_else.36207:
    ret                                 # |         56 |         56 |
ble_else.36206:
    ret
be_else.36205:
.count stack_move
    sub     $sp, 10, $sp                # |      2,034 |      2,034 |
.count stack_store
    store   $ra, [$sp + 0]              # |      2,034 |      2,034 |
.count stack_store
    store   $i11, [$sp + 3]             # |      2,034 |      2,034 |
.count stack_store
    store   $i10, [$sp + 4]             # |      2,034 |      2,034 |
.count stack_store
    store   $i2, [$sp + 2]              # |      2,034 |      2,034 |
.count stack_store
    store   $i3, [$sp + 5]              # |      2,034 |      2,034 |
    mov     $f0, $fg1                   # |      2,034 |      2,034 |
    mov     $f0, $fg2                   # |      2,034 |      2,034 |
    mov     $f0, $fg3                   # |      2,034 |      2,034 |
    load    [$i2 + 6], $i10             # |      2,034 |      2,034 |
    load    [$i2 + 7], $i11             # |      2,034 |      2,034 |
.count stack_store
    store   $i11, [$sp + 6]             # |      2,034 |      2,034 |
    load    [$i2 + 1], $i12             # |      2,034 |      2,034 |
.count stack_store
    store   $i12, [$sp + 7]             # |      2,034 |      2,034 |
    load    [$i12 + $i3], $i2           # |      2,034 |      2,034 |
    load    [$i2 + 0], $fg8             # |      2,034 |      2,034 |
    load    [$i2 + 1], $fg9             # |      2,034 |      2,034 |
    load    [$i2 + 2], $fg10            # |      2,034 |      2,034 |
    sub     $ig0, 1, $i3                # |      2,034 |      2,034 |
    call    setup_startp_constants.2831 # |      2,034 |      2,034 |
    load    [$i10 + 0], $i24            # |      2,034 |      2,034 |
    load    [min_caml_dirvecs + $i24], $i24# |      2,034 |      2,034 |
    load    [$i24 + 118], $i25          # |      2,034 |      2,034 |
    load    [$i25 + 0], $i25            # |      2,034 |      2,034 |
    load    [$i25 + 0], $f10            # |      2,034 |      2,034 |
.count stack_load
    load    [$sp + 5], $i26             # |      2,034 |      2,034 |
    load    [$i11 + $i26], $i26         # |      2,034 |      2,034 |
    load    [$i26 + 0], $f11            # |      2,034 |      2,034 |
    fmul    $f10, $f11, $f10            # |      2,034 |      2,034 |
    load    [$i25 + 1], $f11            # |      2,034 |      2,034 |
    load    [$i26 + 1], $f12            # |      2,034 |      2,034 |
    fmul    $f11, $f12, $f11            # |      2,034 |      2,034 |
    fadd    $f10, $f11, $f10            # |      2,034 |      2,034 |
    load    [$i25 + 2], $f11            # |      2,034 |      2,034 |
    load    [$i26 + 2], $f12            # |      2,034 |      2,034 |
    fmul    $f11, $f12, $f11            # |      2,034 |      2,034 |
    fadd    $f10, $f11, $f10            # |      2,034 |      2,034 |
    bg      $f0, $f10, ble_else.36210   # |      2,034 |      2,034 |
ble_then.36210:
    load    [$i24 + 118], $i2           # |        292 |        292 |
    fmul    $f10, $fc1, $f2             # |        292 |        292 |
    call    trace_diffuse_ray.2926      # |        292 |        292 |
.count b_cont
    b       ble_cont.36210              # |        292 |        292 |
ble_else.36210:
    load    [$i24 + 119], $i2           # |      1,742 |      1,742 |
    fmul    $f10, $fc2, $f2             # |      1,742 |      1,742 |
    call    trace_diffuse_ray.2926      # |      1,742 |      1,742 |
ble_cont.36210:
    li      116, $i4                    # |      2,034 |      2,034 |
.count move_args
    mov     $i24, $i2                   # |      2,034 |      2,034 |
.count move_args
    mov     $i26, $i3                   # |      2,034 |      2,034 |
    call    iter_trace_diffuse_rays.2929# |      2,034 |      2,034 |
.count stack_load
    load    [$sp + 2], $i2              # |      2,034 |      2,034 |
    load    [$i2 + 5], $i10             # |      2,034 |      2,034 |
.count stack_load
    load    [$sp + 5], $i11             # |      2,034 |      2,034 |
    load    [$i10 + $i11], $i12         # |      2,034 |      2,034 |
    store   $fg1, [$i12 + 0]            # |      2,034 |      2,034 |
    store   $fg2, [$i12 + 1]            # |      2,034 |      2,034 |
    store   $fg3, [$i12 + 2]            # |      2,034 |      2,034 |
    add     $i11, 1, $i11               # |      2,034 |      2,034 |
    bg      $i11, 4, ble_else.36211     # |      2,034 |      2,034 |
ble_then.36211:
.count stack_load
    load    [$sp + 4], $i12             # |      2,034 |      2,034 |
    load    [$i12 + $i11], $i12         # |      2,034 |      2,034 |
    bl      $i12, 0, bge_else.36212     # |      2,034 |      2,034 |
bge_then.36212:
.count stack_load
    load    [$sp + 3], $i12
    load    [$i12 + $i11], $i12
    bne     $i12, 0, be_else.36213
be_then.36213:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 10, $sp
    add     $i11, 1, $i3
    b       pretrace_diffuse_rays.2980
be_else.36213:
.count stack_store
    store   $i11, [$sp + 8]
.count stack_store
    store   $i10, [$sp + 9]
    mov     $f0, $fg1
    mov     $f0, $fg2
    mov     $f0, $fg3
    load    [$i2 + 6], $i10
.count stack_load
    load    [$sp + 7], $i12
    load    [$i12 + $i11], $i2
    load    [$i2 + 0], $fg8
    load    [$i2 + 1], $fg9
    load    [$i2 + 2], $fg10
    sub     $ig0, 1, $i3
    call    setup_startp_constants.2831
    load    [$i10 + 0], $i24
    load    [min_caml_dirvecs + $i24], $i24
    load    [$i24 + 118], $i25
    load    [$i25 + 0], $i25
.count stack_load
    load    [$sp + 6], $i26
    load    [$i26 + $i11], $i26
    load    [$i25 + 0], $f1
    load    [$i26 + 0], $f2
    fmul    $f1, $f2, $f1
    load    [$i25 + 1], $f2
    load    [$i26 + 1], $f3
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    load    [$i25 + 2], $f2
    load    [$i26 + 2], $f3
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    bg      $f0, $f1, ble_else.36214
ble_then.36214:
    fmul    $f1, $fc1, $f2
    load    [$i24 + 118], $i2
    call    trace_diffuse_ray.2926
    li      116, $i4
.count move_args
    mov     $i24, $i2
.count move_args
    mov     $i26, $i3
    call    iter_trace_diffuse_rays.2929
.count b_cont
    b       ble_cont.36214
ble_else.36214:
    fmul    $f1, $fc2, $f2
    load    [$i24 + 119], $i2
    call    trace_diffuse_ray.2926
    li      116, $i4
.count move_args
    mov     $i24, $i2
.count move_args
    mov     $i26, $i3
    call    iter_trace_diffuse_rays.2929
ble_cont.36214:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 10, $sp
.count stack_load
    load    [$sp - 2], $i1
.count stack_load
    load    [$sp - 1], $i2
    load    [$i2 + $i1], $i2
    store   $fg1, [$i2 + 0]
    store   $fg2, [$i2 + 1]
    store   $fg3, [$i2 + 2]
    add     $i1, 1, $i3
.count stack_load
    load    [$sp - 8], $i2
    b       pretrace_diffuse_rays.2980
bge_else.36212:
.count stack_load
    load    [$sp + 0], $ra              # |      2,034 |      2,034 |
.count stack_move
    add     $sp, 10, $sp                # |      2,034 |      2,034 |
    ret                                 # |      2,034 |      2,034 |
ble_else.36211:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 10, $sp
    ret
bge_else.36204:
    ret                                 # |     14,294 |     14,294 |
ble_else.36203:
    ret
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
    bl      $i3, 0, bge_else.36215      # |     16,512 |     16,512 |
bge_then.36215:
.count stack_move
    sub     $sp, 10, $sp                # |     16,384 |     16,384 |
.count stack_store
    store   $ra, [$sp + 0]              # |     16,384 |     16,384 |
.count stack_store
    store   $f4, [$sp + 1]              # |     16,384 |     16,384 |
.count stack_store
    store   $i4, [$sp + 2]              # |     16,384 |     16,384 |
.count stack_store
    store   $i3, [$sp + 3]              # |     16,384 |     16,384 |
.count stack_store
    store   $i2, [$sp + 4]              # |     16,384 |     16,384 |
.count stack_store
    store   $f3, [$sp + 5]              # |     16,384 |     16,384 |
.count stack_store
    store   $f2, [$sp + 6]              # |     16,384 |     16,384 |
    load    [min_caml_screenx_dir + 0], $f10# |     16,384 |     16,384 |
    sub     $i3, $ig8, $i2              # |     16,384 |     16,384 |
    call    min_caml_float_of_int       # |     16,384 |     16,384 |
.count move_ret
    mov     $f1, $f11                   # |     16,384 |     16,384 |
    fmul    $fg17, $f11, $f11           # |     16,384 |     16,384 |
    fmul    $f11, $f10, $f10            # |     16,384 |     16,384 |
.count stack_load
    load    [$sp + 6], $f12             # |     16,384 |     16,384 |
    fadd    $f10, $f12, $f10            # |     16,384 |     16,384 |
    store   $f10, [min_caml_ptrace_dirvec + 0]# |     16,384 |     16,384 |
    load    [min_caml_screenx_dir + 1], $f10# |     16,384 |     16,384 |
    fmul    $f11, $f10, $f10            # |     16,384 |     16,384 |
.count stack_load
    load    [$sp + 5], $f12             # |     16,384 |     16,384 |
    fadd    $f10, $f12, $f10            # |     16,384 |     16,384 |
    store   $f10, [min_caml_ptrace_dirvec + 1]# |     16,384 |     16,384 |
    load    [min_caml_screenx_dir + 2], $f10# |     16,384 |     16,384 |
    fmul    $f11, $f10, $f10            # |     16,384 |     16,384 |
    fadd    $f10, $f4, $f10             # |     16,384 |     16,384 |
    store   $f10, [min_caml_ptrace_dirvec + 2]# |     16,384 |     16,384 |
    load    [min_caml_ptrace_dirvec + 0], $f10# |     16,384 |     16,384 |
    fmul    $f10, $f10, $f11            # |     16,384 |     16,384 |
    load    [min_caml_ptrace_dirvec + 1], $f12# |     16,384 |     16,384 |
    fmul    $f12, $f12, $f12            # |     16,384 |     16,384 |
    fadd    $f11, $f12, $f11            # |     16,384 |     16,384 |
    load    [min_caml_ptrace_dirvec + 2], $f12# |     16,384 |     16,384 |
    fmul    $f12, $f12, $f12            # |     16,384 |     16,384 |
    fadd    $f11, $f12, $f11            # |     16,384 |     16,384 |
    fsqrt   $f11, $f11                  # |     16,384 |     16,384 |
    bne     $f11, $f0, be_else.36216    # |     16,384 |     16,384 |
be_then.36216:
    mov     $fc0, $f11
.count b_cont
    b       be_cont.36216
be_else.36216:
    finv    $f11, $f11                  # |     16,384 |     16,384 |
be_cont.36216:
    fmul    $f10, $f11, $f10            # |     16,384 |     16,384 |
    store   $f10, [min_caml_ptrace_dirvec + 0]# |     16,384 |     16,384 |
    load    [min_caml_ptrace_dirvec + 1], $f10# |     16,384 |     16,384 |
    fmul    $f10, $f11, $f10            # |     16,384 |     16,384 |
    store   $f10, [min_caml_ptrace_dirvec + 1]# |     16,384 |     16,384 |
    load    [min_caml_ptrace_dirvec + 2], $f10# |     16,384 |     16,384 |
    fmul    $f10, $f11, $f10            # |     16,384 |     16,384 |
    store   $f10, [min_caml_ptrace_dirvec + 2]# |     16,384 |     16,384 |
    mov     $f0, $fg4                   # |     16,384 |     16,384 |
    mov     $f0, $fg5                   # |     16,384 |     16,384 |
    mov     $f0, $fg6                   # |     16,384 |     16,384 |
    load    [min_caml_viewpoint + 0], $fg21# |     16,384 |     16,384 |
    load    [min_caml_viewpoint + 1], $fg22# |     16,384 |     16,384 |
    load    [min_caml_viewpoint + 2], $fg23# |     16,384 |     16,384 |
    li      min_caml_ptrace_dirvec, $i3 # |     16,384 |     16,384 |
    li      0, $i2                      # |     16,384 |     16,384 |
.count stack_load
    load    [$sp + 3], $i24             # |     16,384 |     16,384 |
.count stack_load
    load    [$sp + 4], $i25             # |     16,384 |     16,384 |
    load    [$i25 + $i24], $i4          # |     16,384 |     16,384 |
.count move_args
    mov     $fc0, $f2                   # |     16,384 |     16,384 |
.count move_args
    mov     $f0, $f3                    # |     16,384 |     16,384 |
    call    trace_ray.2920              # |     16,384 |     16,384 |
    load    [$i25 + $i24], $i28         # |     16,384 |     16,384 |
    load    [$i28 + 0], $i28            # |     16,384 |     16,384 |
    store   $fg4, [$i28 + 0]            # |     16,384 |     16,384 |
    store   $fg5, [$i28 + 1]            # |     16,384 |     16,384 |
    store   $fg6, [$i28 + 2]            # |     16,384 |     16,384 |
    load    [$i25 + $i24], $i28         # |     16,384 |     16,384 |
    load    [$i28 + 6], $i28            # |     16,384 |     16,384 |
.count stack_load
    load    [$sp + 2], $i29             # |     16,384 |     16,384 |
    store   $i29, [$i28 + 0]            # |     16,384 |     16,384 |
    load    [$i25 + $i24], $i2          # |     16,384 |     16,384 |
    load    [$i2 + 2], $i28             # |     16,384 |     16,384 |
    load    [$i28 + 0], $i28            # |     16,384 |     16,384 |
    bl      $i28, 0, bge_cont.36217     # |     16,384 |     16,384 |
bge_then.36217:
    load    [$i2 + 3], $i28             # |     16,384 |     16,384 |
    load    [$i28 + 0], $i28            # |     16,384 |     16,384 |
    bne     $i28, 0, be_else.36218      # |     16,384 |     16,384 |
be_then.36218:
    li      1, $i3                      # |      7,301 |      7,301 |
    call    pretrace_diffuse_rays.2980  # |      7,301 |      7,301 |
.count b_cont
    b       be_cont.36218               # |      7,301 |      7,301 |
be_else.36218:
.count stack_store
    store   $i2, [$sp + 7]              # |      9,083 |      9,083 |
    load    [$i2 + 6], $i10             # |      9,083 |      9,083 |
    load    [$i10 + 0], $i10            # |      9,083 |      9,083 |
    mov     $f0, $fg1                   # |      9,083 |      9,083 |
    mov     $f0, $fg2                   # |      9,083 |      9,083 |
    mov     $f0, $fg3                   # |      9,083 |      9,083 |
    load    [$i2 + 7], $i11             # |      9,083 |      9,083 |
    load    [$i2 + 1], $i12             # |      9,083 |      9,083 |
    load    [min_caml_dirvecs + $i10], $i10# |      9,083 |      9,083 |
    load    [$i11 + 0], $i11            # |      9,083 |      9,083 |
    load    [$i12 + 0], $i2             # |      9,083 |      9,083 |
    load    [$i2 + 0], $fg8             # |      9,083 |      9,083 |
    load    [$i2 + 1], $fg9             # |      9,083 |      9,083 |
    load    [$i2 + 2], $fg10            # |      9,083 |      9,083 |
    sub     $ig0, 1, $i3                # |      9,083 |      9,083 |
    call    setup_startp_constants.2831 # |      9,083 |      9,083 |
    load    [$i10 + 118], $i24          # |      9,083 |      9,083 |
    load    [$i24 + 0], $i24            # |      9,083 |      9,083 |
    load    [$i24 + 0], $f1             # |      9,083 |      9,083 |
    load    [$i11 + 0], $f2             # |      9,083 |      9,083 |
    fmul    $f1, $f2, $f1               # |      9,083 |      9,083 |
    load    [$i24 + 1], $f2             # |      9,083 |      9,083 |
    load    [$i11 + 1], $f3             # |      9,083 |      9,083 |
    fmul    $f2, $f3, $f2               # |      9,083 |      9,083 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |
    load    [$i24 + 2], $f2             # |      9,083 |      9,083 |
    load    [$i11 + 2], $f3             # |      9,083 |      9,083 |
    fmul    $f2, $f3, $f2               # |      9,083 |      9,083 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |
.count stack_store
    store   $i11, [$sp + 8]             # |      9,083 |      9,083 |
.count stack_store
    store   $i10, [$sp + 9]             # |      9,083 |      9,083 |
    bg      $f0, $f1, ble_else.36219    # |      9,083 |      9,083 |
ble_then.36219:
    fmul    $f1, $fc1, $f2              # |         14 |         14 |
    load    [$i10 + 118], $i2           # |         14 |         14 |
    call    trace_diffuse_ray.2926      # |         14 |         14 |
    li      116, $i4                    # |         14 |         14 |
.count stack_load
    load    [$sp + 9], $i2              # |         14 |         14 |
.count stack_load
    load    [$sp + 8], $i3              # |         14 |         14 |
    call    iter_trace_diffuse_rays.2929# |         14 |         14 |
.count b_cont
    b       ble_cont.36219              # |         14 |         14 |
ble_else.36219:
    fmul    $f1, $fc2, $f2              # |      9,069 |      9,069 |
    load    [$i10 + 119], $i2           # |      9,069 |      9,069 |
    call    trace_diffuse_ray.2926      # |      9,069 |      9,069 |
    li      116, $i4                    # |      9,069 |      9,069 |
.count stack_load
    load    [$sp + 9], $i2              # |      9,069 |      9,069 |
.count stack_load
    load    [$sp + 8], $i3              # |      9,069 |      9,069 |
    call    iter_trace_diffuse_rays.2929# |      9,069 |      9,069 |
ble_cont.36219:
.count stack_load
    load    [$sp + 7], $i2              # |      9,083 |      9,083 |
    load    [$i2 + 5], $i28             # |      9,083 |      9,083 |
    load    [$i28 + 0], $i28            # |      9,083 |      9,083 |
    store   $fg1, [$i28 + 0]            # |      9,083 |      9,083 |
    store   $fg2, [$i28 + 1]            # |      9,083 |      9,083 |
    store   $fg3, [$i28 + 2]            # |      9,083 |      9,083 |
    li      1, $i3                      # |      9,083 |      9,083 |
    call    pretrace_diffuse_rays.2980  # |      9,083 |      9,083 |
be_cont.36218:
bge_cont.36217:
.count stack_load
    load    [$sp + 0], $ra              # |     16,384 |     16,384 |
.count stack_move
    add     $sp, 10, $sp                # |     16,384 |     16,384 |
.count stack_load
    load    [$sp - 7], $i1              # |     16,384 |     16,384 |
    sub     $i1, 1, $i3                 # |     16,384 |     16,384 |
    add     $i29, 1, $i4                # |     16,384 |     16,384 |
.count stack_load
    load    [$sp - 9], $f4              # |     16,384 |     16,384 |
.count stack_load
    load    [$sp - 5], $f3              # |     16,384 |     16,384 |
.count stack_load
    load    [$sp - 4], $f2              # |     16,384 |     16,384 |
.count stack_load
    load    [$sp - 6], $i2              # |     16,384 |     16,384 |
    bl      $i4, 5, pretrace_pixels.2983# |     16,384 |     16,384 |
    sub     $i4, 5, $i4                 # |      3,277 |      3,277 |
    b       pretrace_pixels.2983        # |      3,277 |      3,277 |
bge_else.36215:
    ret                                 # |        128 |        128 |
.end pretrace_pixels

######################################################################
# scan_pixel
######################################################################
.begin scan_pixel
scan_pixel.2994:
    bg      $ig1, $i2, ble_else.36221   # |      8,256 |      8,256 |
ble_then.36221:
    ret                                 # |         64 |         64 |
ble_else.36221:
.count stack_move
    sub     $sp, 11, $sp                # |      8,192 |      8,192 |
.count stack_store
    store   $ra, [$sp + 0]              # |      8,192 |      8,192 |
.count stack_store
    store   $i6, [$sp + 1]              # |      8,192 |      8,192 |
.count stack_store
    store   $i4, [$sp + 2]              # |      8,192 |      8,192 |
.count stack_store
    store   $i3, [$sp + 3]              # |      8,192 |      8,192 |
.count stack_store
    store   $i5, [$sp + 4]              # |      8,192 |      8,192 |
.count stack_store
    store   $i2, [$sp + 5]              # |      8,192 |      8,192 |
    load    [$i5 + $i2], $i32           # |      8,192 |      8,192 |
    load    [$i32 + 0], $i32            # |      8,192 |      8,192 |
    load    [$i32 + 0], $fg4            # |      8,192 |      8,192 |
    load    [$i32 + 1], $fg5            # |      8,192 |      8,192 |
    load    [$i32 + 2], $fg6            # |      8,192 |      8,192 |
    add     $i3, 1, $i32                # |      8,192 |      8,192 |
.count stack_store
    store   $i32, [$sp + 6]             # |      8,192 |      8,192 |
    bg      $ig3, $i32, ble_else.36222  # |      8,192 |      8,192 |
ble_then.36222:
    li      0, $i32                     # |         64 |         64 |
.count b_cont
    b       ble_cont.36222              # |         64 |         64 |
ble_else.36222:
    bg      $i3, 0, ble_else.36223      # |      8,128 |      8,128 |
ble_then.36223:
    li      0, $i32                     # |         64 |         64 |
.count b_cont
    b       ble_cont.36223              # |         64 |         64 |
ble_else.36223:
    add     $i2, 1, $i32                # |      8,064 |      8,064 |
    bg      $ig1, $i32, ble_else.36224  # |      8,064 |      8,064 |
ble_then.36224:
    li      0, $i32                     # |         63 |         63 |
.count b_cont
    b       ble_cont.36224              # |         63 |         63 |
ble_else.36224:
    bg      $i2, 0, ble_else.36225      # |      8,001 |      8,001 |
ble_then.36225:
    li      0, $i32                     # |         63 |         63 |
.count b_cont
    b       ble_cont.36225              # |         63 |         63 |
ble_else.36225:
    li      1, $i32                     # |      7,938 |      7,938 |
ble_cont.36225:
ble_cont.36224:
ble_cont.36223:
ble_cont.36222:
    bne     $i32, 0, be_else.36226      # |      8,192 |      8,192 |
be_then.36226:
    load    [$i5 + $i2], $i2            # |        254 |        254 |
    li      0, $i32                     # |        254 |        254 |
    load    [$i2 + 2], $i33             # |        254 |        254 |
    load    [$i33 + 0], $i33            # |        254 |        254 |
    bl      $i33, 0, be_cont.36226      # |        254 |        254 |
bge_then.36227:
    load    [$i2 + 3], $i33             # |        254 |        254 |
    load    [$i33 + 0], $i33            # |        254 |        254 |
    bne     $i33, 0, be_else.36228      # |        254 |        254 |
be_then.36228:
    li      1, $i3                      # |        180 |        180 |
    call    do_without_neighbors.2951   # |        180 |        180 |
.count b_cont
    b       be_cont.36226               # |        180 |        180 |
be_else.36228:
.count stack_store
    store   $i2, [$sp + 7]              # |         74 |         74 |
.count move_args
    mov     $i32, $i3                   # |         74 |         74 |
    call    calc_diffuse_using_1point.2942# |         74 |         74 |
    li      1, $i3                      # |         74 |         74 |
.count stack_load
    load    [$sp + 7], $i2              # |         74 |         74 |
    call    do_without_neighbors.2951   # |         74 |         74 |
.count b_cont
    b       be_cont.36226               # |         74 |         74 |
be_else.36226:
    li      0, $i32                     # |      7,938 |      7,938 |
    load    [$i5 + $i2], $i33           # |      7,938 |      7,938 |
    load    [$i33 + 2], $i34            # |      7,938 |      7,938 |
    load    [$i34 + 0], $i34            # |      7,938 |      7,938 |
    bl      $i34, 0, bge_cont.36229     # |      7,938 |      7,938 |
bge_then.36229:
    load    [$i4 + $i2], $i35           # |      7,938 |      7,938 |
    load    [$i35 + 2], $i36            # |      7,938 |      7,938 |
    load    [$i36 + 0], $i36            # |      7,938 |      7,938 |
    bne     $i36, $i34, be_else.36230   # |      7,938 |      7,938 |
be_then.36230:
    load    [$i6 + $i2], $i36           # |      7,620 |      7,620 |
    load    [$i36 + 2], $i36            # |      7,620 |      7,620 |
    load    [$i36 + 0], $i36            # |      7,620 |      7,620 |
    bne     $i36, $i34, be_else.36231   # |      7,620 |      7,620 |
be_then.36231:
    sub     $i2, 1, $i36                # |      7,330 |      7,330 |
    load    [$i5 + $i36], $i36          # |      7,330 |      7,330 |
    load    [$i36 + 2], $i36            # |      7,330 |      7,330 |
    load    [$i36 + 0], $i36            # |      7,330 |      7,330 |
    bne     $i36, $i34, be_else.36232   # |      7,330 |      7,330 |
be_then.36232:
    add     $i2, 1, $i36                # |      7,251 |      7,251 |
    load    [$i5 + $i36], $i36          # |      7,251 |      7,251 |
    load    [$i36 + 2], $i36            # |      7,251 |      7,251 |
    load    [$i36 + 0], $i36            # |      7,251 |      7,251 |
    bne     $i36, $i34, be_else.36233   # |      7,251 |      7,251 |
be_then.36233:
    li      1, $i34                     # |      7,171 |      7,171 |
.count b_cont
    b       be_cont.36230               # |      7,171 |      7,171 |
be_else.36233:
    li      0, $i34                     # |         80 |         80 |
.count b_cont
    b       be_cont.36230               # |         80 |         80 |
be_else.36232:
    li      0, $i34                     # |         79 |         79 |
.count b_cont
    b       be_cont.36230               # |         79 |         79 |
be_else.36231:
    li      0, $i34                     # |        290 |        290 |
.count b_cont
    b       be_cont.36230               # |        290 |        290 |
be_else.36230:
    li      0, $i34                     # |        318 |        318 |
be_cont.36230:
    bne     $i34, 0, be_else.36234      # |      7,938 |      7,938 |
be_then.36234:
    load    [$i5 + $i2], $i2            # |        767 |        767 |
    load    [$i2 + 2], $i33             # |        767 |        767 |
    load    [$i33 + 0], $i33            # |        767 |        767 |
    bl      $i33, 0, be_cont.36234      # |        767 |        767 |
bge_then.36235:
    load    [$i2 + 3], $i33             # |        767 |        767 |
    load    [$i33 + 0], $i33            # |        767 |        767 |
    bne     $i33, 0, be_else.36236      # |        767 |        767 |
be_then.36236:
    li      1, $i3                      # |        155 |        155 |
    call    do_without_neighbors.2951   # |        155 |        155 |
.count b_cont
    b       be_cont.36234               # |        155 |        155 |
be_else.36236:
.count stack_store
    store   $i2, [$sp + 8]              # |        612 |        612 |
.count move_args
    mov     $i32, $i3                   # |        612 |        612 |
    call    calc_diffuse_using_1point.2942# |        612 |        612 |
    li      1, $i3                      # |        612 |        612 |
.count stack_load
    load    [$sp + 8], $i2              # |        612 |        612 |
    call    do_without_neighbors.2951   # |        612 |        612 |
.count b_cont
    b       be_cont.36234               # |        612 |        612 |
be_else.36234:
    load    [$i33 + 3], $i36            # |      7,171 |      7,171 |
    load    [$i36 + 0], $i36            # |      7,171 |      7,171 |
.count move_args
    mov     $i4, $i3                    # |      7,171 |      7,171 |
.count move_args
    mov     $i5, $i4                    # |      7,171 |      7,171 |
    bne     $i36, 0, be_else.36237      # |      7,171 |      7,171 |
be_then.36237:
    li      1, $i36                     # |      3,318 |      3,318 |
.count move_args
    mov     $i6, $i5                    # |      3,318 |      3,318 |
.count move_args
    mov     $i36, $i6                   # |      3,318 |      3,318 |
    call    try_exploit_neighbors.2967  # |      3,318 |      3,318 |
.count b_cont
    b       be_cont.36237               # |      3,318 |      3,318 |
be_else.36237:
    load    [$i35 + 5], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $fg1            # |      3,853 |      3,853 |
    load    [$i36 + 1], $fg2            # |      3,853 |      3,853 |
    load    [$i36 + 2], $fg3            # |      3,853 |      3,853 |
    sub     $i2, 1, $i36                # |      3,853 |      3,853 |
    load    [$i5 + $i36], $i36          # |      3,853 |      3,853 |
    load    [$i36 + 5], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $f1             # |      3,853 |      3,853 |
    fadd    $fg1, $f1, $fg1             # |      3,853 |      3,853 |
    load    [$i36 + 1], $f1             # |      3,853 |      3,853 |
    fadd    $fg2, $f1, $fg2             # |      3,853 |      3,853 |
    load    [$i36 + 2], $f1             # |      3,853 |      3,853 |
    fadd    $fg3, $f1, $fg3             # |      3,853 |      3,853 |
    load    [$i5 + $i2], $i36           # |      3,853 |      3,853 |
    load    [$i36 + 5], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $f1             # |      3,853 |      3,853 |
    fadd    $fg1, $f1, $fg1             # |      3,853 |      3,853 |
    load    [$i36 + 1], $f1             # |      3,853 |      3,853 |
    fadd    $fg2, $f1, $fg2             # |      3,853 |      3,853 |
    load    [$i36 + 2], $f1             # |      3,853 |      3,853 |
    fadd    $fg3, $f1, $fg3             # |      3,853 |      3,853 |
    add     $i2, 1, $i36                # |      3,853 |      3,853 |
    load    [$i5 + $i36], $i36          # |      3,853 |      3,853 |
    load    [$i36 + 5], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $f1             # |      3,853 |      3,853 |
    fadd    $fg1, $f1, $fg1             # |      3,853 |      3,853 |
    load    [$i36 + 1], $f1             # |      3,853 |      3,853 |
    fadd    $fg2, $f1, $fg2             # |      3,853 |      3,853 |
    load    [$i36 + 2], $f1             # |      3,853 |      3,853 |
    fadd    $fg3, $f1, $fg3             # |      3,853 |      3,853 |
    load    [$i6 + $i2], $i36           # |      3,853 |      3,853 |
    load    [$i36 + 5], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $f1             # |      3,853 |      3,853 |
    fadd    $fg1, $f1, $fg1             # |      3,853 |      3,853 |
    load    [$i36 + 1], $f1             # |      3,853 |      3,853 |
    fadd    $fg2, $f1, $fg2             # |      3,853 |      3,853 |
    load    [$i36 + 2], $f1             # |      3,853 |      3,853 |
    fadd    $fg3, $f1, $fg3             # |      3,853 |      3,853 |
    load    [$i5 + $i2], $i36           # |      3,853 |      3,853 |
    load    [$i36 + 4], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $i36            # |      3,853 |      3,853 |
    load    [$i36 + 0], $f1             # |      3,853 |      3,853 |
    fmul    $f1, $fg1, $f1              # |      3,853 |      3,853 |
    fadd    $fg4, $f1, $fg4             # |      3,853 |      3,853 |
    load    [$i36 + 1], $f1             # |      3,853 |      3,853 |
    fmul    $f1, $fg2, $f1              # |      3,853 |      3,853 |
    fadd    $fg5, $f1, $fg5             # |      3,853 |      3,853 |
    load    [$i36 + 2], $f1             # |      3,853 |      3,853 |
    fmul    $f1, $fg3, $f1              # |      3,853 |      3,853 |
    fadd    $fg6, $f1, $fg6             # |      3,853 |      3,853 |
    li      1, $i36                     # |      3,853 |      3,853 |
.count move_args
    mov     $i6, $i5                    # |      3,853 |      3,853 |
.count move_args
    mov     $i36, $i6                   # |      3,853 |      3,853 |
    call    try_exploit_neighbors.2967  # |      3,853 |      3,853 |
be_cont.36237:
be_cont.36234:
bge_cont.36229:
be_cont.36226:
    li      255, $i10                   # |      8,192 |      8,192 |
.count move_args
    mov     $fg4, $f2                   # |      8,192 |      8,192 |
    call    min_caml_int_of_float       # |      8,192 |      8,192 |
    mov     $i1, $i2                    # |      8,192 |      8,192 |
    bg      $i2, $i10, ble_else.36238   # |      8,192 |      8,192 |
ble_then.36238:
    bl      $i2, 0, bge_else.36239      # |      5,132 |      5,132 |
bge_then.36239:
    call    min_caml_write              # |      5,132 |      5,132 |
.count b_cont
    b       ble_cont.36238              # |      5,132 |      5,132 |
bge_else.36239:
    li      0, $i2
    call    min_caml_write
.count b_cont
    b       ble_cont.36238
ble_else.36238:
    li      255, $i2                    # |      3,060 |      3,060 |
    call    min_caml_write              # |      3,060 |      3,060 |
ble_cont.36238:
    li      255, $i10                   # |      8,192 |      8,192 |
.count move_args
    mov     $fg5, $f2                   # |      8,192 |      8,192 |
    call    min_caml_int_of_float       # |      8,192 |      8,192 |
    mov     $i1, $i2                    # |      8,192 |      8,192 |
    bg      $i2, $i10, ble_else.36240   # |      8,192 |      8,192 |
ble_then.36240:
    bl      $i2, 0, bge_else.36241      # |      6,128 |      6,128 |
bge_then.36241:
    call    min_caml_write              # |      6,128 |      6,128 |
.count b_cont
    b       ble_cont.36240              # |      6,128 |      6,128 |
bge_else.36241:
    li      0, $i2
    call    min_caml_write
.count b_cont
    b       ble_cont.36240
ble_else.36240:
    li      255, $i2                    # |      2,064 |      2,064 |
    call    min_caml_write              # |      2,064 |      2,064 |
ble_cont.36240:
    li      255, $i10                   # |      8,192 |      8,192 |
.count move_args
    mov     $fg6, $f2                   # |      8,192 |      8,192 |
    call    min_caml_int_of_float       # |      8,192 |      8,192 |
    mov     $i1, $i2                    # |      8,192 |      8,192 |
    bg      $i2, $i10, ble_else.36242   # |      8,192 |      8,192 |
ble_then.36242:
    bl      $i2, 0, bge_else.36243      # |      5,450 |      5,450 |
bge_then.36243:
    call    min_caml_write              # |      5,450 |      5,450 |
.count b_cont
    b       ble_cont.36242              # |      5,450 |      5,450 |
bge_else.36243:
    li      0, $i2
    call    min_caml_write
.count b_cont
    b       ble_cont.36242
ble_else.36242:
    li      255, $i2                    # |      2,742 |      2,742 |
    call    min_caml_write              # |      2,742 |      2,742 |
ble_cont.36242:
.count stack_load
    load    [$sp + 5], $i32             # |      8,192 |      8,192 |
    add     $i32, 1, $i32               # |      8,192 |      8,192 |
    bg      $ig1, $i32, ble_else.36244  # |      8,192 |      8,192 |
ble_then.36244:
.count stack_load
    load    [$sp + 0], $ra              # |         64 |         64 |
.count stack_move
    add     $sp, 11, $sp                # |         64 |         64 |
    ret                                 # |         64 |         64 |
ble_else.36244:
.count stack_store
    store   $i32, [$sp + 9]             # |      8,128 |      8,128 |
.count stack_load
    load    [$sp + 4], $i33             # |      8,128 |      8,128 |
    load    [$i33 + $i32], $i34         # |      8,128 |      8,128 |
    load    [$i34 + 0], $i34            # |      8,128 |      8,128 |
    load    [$i34 + 0], $fg4            # |      8,128 |      8,128 |
    load    [$i34 + 1], $fg5            # |      8,128 |      8,128 |
    load    [$i34 + 2], $fg6            # |      8,128 |      8,128 |
.count stack_load
    load    [$sp + 6], $i34             # |      8,128 |      8,128 |
    bg      $ig3, $i34, ble_else.36245  # |      8,128 |      8,128 |
ble_then.36245:
    li      0, $i34                     # |         64 |         64 |
.count b_cont
    b       ble_cont.36245              # |         64 |         64 |
ble_else.36245:
.count stack_load
    load    [$sp + 3], $i34             # |      8,064 |      8,064 |
    bg      $i34, 0, ble_else.36246     # |      8,064 |      8,064 |
ble_then.36246:
    li      0, $i34                     # |         63 |         63 |
.count b_cont
    b       ble_cont.36246              # |         63 |         63 |
ble_else.36246:
    add     $i32, 1, $i34               # |      8,001 |      8,001 |
    bg      $ig1, $i34, ble_else.36247  # |      8,001 |      8,001 |
ble_then.36247:
    li      0, $i34                     # |         63 |         63 |
.count b_cont
    b       ble_cont.36247              # |         63 |         63 |
ble_else.36247:
    bg      $i32, 0, ble_else.36248     # |      7,938 |      7,938 |
ble_then.36248:
    li      0, $i34
.count b_cont
    b       ble_cont.36248
ble_else.36248:
    li      1, $i34                     # |      7,938 |      7,938 |
ble_cont.36248:
ble_cont.36247:
ble_cont.36246:
ble_cont.36245:
    bne     $i34, 0, be_else.36249      # |      8,128 |      8,128 |
be_then.36249:
    load    [$i33 + $i32], $i2          # |        190 |        190 |
    li      0, $i32                     # |        190 |        190 |
    load    [$i2 + 2], $i33             # |        190 |        190 |
    load    [$i33 + 0], $i33            # |        190 |        190 |
    bl      $i33, 0, be_cont.36249      # |        190 |        190 |
bge_then.36250:
    load    [$i2 + 3], $i33             # |        190 |        190 |
    load    [$i33 + 0], $i33            # |        190 |        190 |
    bne     $i33, 0, be_else.36251      # |        190 |        190 |
be_then.36251:
    li      1, $i3                      # |        123 |        123 |
    call    do_without_neighbors.2951   # |        123 |        123 |
.count b_cont
    b       be_cont.36249               # |        123 |        123 |
be_else.36251:
.count stack_store
    store   $i2, [$sp + 10]             # |         67 |         67 |
.count move_args
    mov     $i32, $i3                   # |         67 |         67 |
    call    calc_diffuse_using_1point.2942# |         67 |         67 |
    li      1, $i3                      # |         67 |         67 |
.count stack_load
    load    [$sp + 10], $i2             # |         67 |         67 |
    call    do_without_neighbors.2951   # |         67 |         67 |
.count b_cont
    b       be_cont.36249               # |         67 |         67 |
be_else.36249:
    li      0, $i6                      # |      7,938 |      7,938 |
.count stack_load
    load    [$sp + 2], $i3              # |      7,938 |      7,938 |
.count stack_load
    load    [$sp + 1], $i5              # |      7,938 |      7,938 |
.count move_args
    mov     $i32, $i2                   # |      7,938 |      7,938 |
.count move_args
    mov     $i33, $i4                   # |      7,938 |      7,938 |
    call    try_exploit_neighbors.2967  # |      7,938 |      7,938 |
be_cont.36249:
    li      255, $i10                   # |      8,128 |      8,128 |
.count move_args
    mov     $fg4, $f2                   # |      8,128 |      8,128 |
    call    min_caml_int_of_float       # |      8,128 |      8,128 |
    bg      $i1, $i10, ble_else.36252   # |      8,128 |      8,128 |
ble_then.36252:
    bge     $i1, 0, ble_cont.36252      # |      5,076 |      5,076 |
bl_then.36253:
    li      0, $i1
.count b_cont
    b       ble_cont.36252
ble_else.36252:
    li      255, $i1                    # |      3,052 |      3,052 |
ble_cont.36252:
    mov     $i1, $i2                    # |      8,128 |      8,128 |
    call    min_caml_write              # |      8,128 |      8,128 |
    li      255, $i10                   # |      8,128 |      8,128 |
.count move_args
    mov     $fg5, $f2                   # |      8,128 |      8,128 |
    call    min_caml_int_of_float       # |      8,128 |      8,128 |
    bg      $i1, $i10, ble_else.36254   # |      8,128 |      8,128 |
ble_then.36254:
    bge     $i1, 0, ble_cont.36254      # |      6,031 |      6,031 |
bl_then.36255:
    li      0, $i1
.count b_cont
    b       ble_cont.36254
ble_else.36254:
    li      255, $i1                    # |      2,097 |      2,097 |
ble_cont.36254:
    mov     $i1, $i2                    # |      8,128 |      8,128 |
    call    min_caml_write              # |      8,128 |      8,128 |
    li      255, $i10                   # |      8,128 |      8,128 |
.count move_args
    mov     $fg6, $f2                   # |      8,128 |      8,128 |
    call    min_caml_int_of_float       # |      8,128 |      8,128 |
    bg      $i1, $i10, ble_else.36256   # |      8,128 |      8,128 |
ble_then.36256:
    bge     $i1, 0, ble_cont.36256      # |      5,384 |      5,384 |
bl_then.36257:
    li      0, $i1
.count b_cont
    b       ble_cont.36256
ble_else.36256:
    li      255, $i1                    # |      2,744 |      2,744 |
ble_cont.36256:
    mov     $i1, $i2                    # |      8,128 |      8,128 |
    call    min_caml_write              # |      8,128 |      8,128 |
.count stack_load
    load    [$sp + 0], $ra              # |      8,128 |      8,128 |
.count stack_move
    add     $sp, 11, $sp                # |      8,128 |      8,128 |
.count stack_load
    load    [$sp - 2], $i1              # |      8,128 |      8,128 |
    add     $i1, 1, $i2                 # |      8,128 |      8,128 |
.count stack_load
    load    [$sp - 8], $i3              # |      8,128 |      8,128 |
.count stack_load
    load    [$sp - 9], $i4              # |      8,128 |      8,128 |
.count stack_load
    load    [$sp - 7], $i5              # |      8,128 |      8,128 |
.count stack_load
    load    [$sp - 10], $i6             # |      8,128 |      8,128 |
    b       scan_pixel.2994             # |      8,128 |      8,128 |
.end scan_pixel

######################################################################
# scan_line
######################################################################
.begin scan_line
scan_line.3000:
    bg      $ig3, $i2, ble_else.36258   # |         65 |         65 |
ble_then.36258:
    ret                                 # |          1 |          1 |
ble_else.36258:
.count stack_move
    sub     $sp, 9, $sp                 # |         64 |         64 |
.count stack_store
    store   $ra, [$sp + 0]              # |         64 |         64 |
.count stack_store
    store   $i6, [$sp + 1]              # |         64 |         64 |
.count stack_store
    store   $i5, [$sp + 2]              # |         64 |         64 |
.count stack_store
    store   $i3, [$sp + 3]              # |         64 |         64 |
.count stack_store
    store   $i2, [$sp + 4]              # |         64 |         64 |
.count stack_store
    store   $i4, [$sp + 5]              # |         64 |         64 |
    sub     $ig3, 1, $i1                # |         64 |         64 |
    ble     $i1, $i2, bg_cont.36259     # |         64 |         64 |
bg_then.36259:
    add     $i2, 1, $i1                 # |         64 |         64 |
    sub     $i1, $ig7, $i2              # |         64 |         64 |
    call    min_caml_float_of_int       # |         64 |         64 |
    fmul    $fg17, $f1, $f1             # |         64 |         64 |
    fmul    $f1, $fg24, $f10            # |         64 |         64 |
    fadd    $f10, $fg18, $f2            # |         64 |         64 |
    load    [min_caml_screeny_dir + 1], $f10# |         64 |         64 |
    fmul    $f1, $f10, $f10             # |         64 |         64 |
    fadd    $f10, $fg19, $f3            # |         64 |         64 |
    load    [min_caml_screeny_dir + 2], $f10# |         64 |         64 |
    fmul    $f1, $f10, $f1              # |         64 |         64 |
    fadd    $f1, $fg20, $f4             # |         64 |         64 |
    sub     $ig1, 1, $i3                # |         64 |         64 |
.count move_args
    mov     $i5, $i2                    # |         64 |         64 |
.count move_args
    mov     $i6, $i4                    # |         64 |         64 |
    call    pretrace_pixels.2983        # |         64 |         64 |
bg_cont.36259:
    li      0, $i32                     # |         64 |         64 |
    ble     $ig1, 0, bg_cont.36260      # |         64 |         64 |
bg_then.36260:
.count stack_load
    load    [$sp + 5], $i33             # |         64 |         64 |
    load    [$i33 + 0], $i34            # |         64 |         64 |
    load    [$i34 + 0], $i34            # |         64 |         64 |
    load    [$i34 + 0], $fg4            # |         64 |         64 |
    load    [$i34 + 1], $fg5            # |         64 |         64 |
    load    [$i34 + 2], $fg6            # |         64 |         64 |
.count stack_load
    load    [$sp + 4], $i34             # |         64 |         64 |
    add     $i34, 1, $i35               # |         64 |         64 |
    bg      $ig3, $i35, ble_else.36261  # |         64 |         64 |
ble_then.36261:
    li      0, $i34
.count b_cont
    b       ble_cont.36261
ble_else.36261:
    bg      $i34, 0, ble_else.36262     # |         64 |         64 |
ble_then.36262:
    li      0, $i34                     # |          1 |          1 |
.count b_cont
    b       ble_cont.36262              # |          1 |          1 |
ble_else.36262:
    li      0, $i34                     # |         63 |         63 |
ble_cont.36262:
ble_cont.36261:
    bne     $i34, 0, be_else.36263      # |         64 |         64 |
be_then.36263:
    load    [$i33 + 0], $i2             # |         64 |         64 |
    li      0, $i32                     # |         64 |         64 |
    load    [$i2 + 2], $i33             # |         64 |         64 |
    load    [$i33 + 0], $i33            # |         64 |         64 |
    bl      $i33, 0, be_cont.36263      # |         64 |         64 |
bge_then.36264:
    load    [$i2 + 3], $i33             # |         64 |         64 |
    load    [$i33 + 0], $i33            # |         64 |         64 |
    bne     $i33, 0, be_else.36265      # |         64 |         64 |
be_then.36265:
    li      1, $i3                      # |         57 |         57 |
    call    do_without_neighbors.2951   # |         57 |         57 |
.count b_cont
    b       be_cont.36263               # |         57 |         57 |
be_else.36265:
.count stack_store
    store   $i2, [$sp + 6]              # |          7 |          7 |
.count move_args
    mov     $i32, $i3                   # |          7 |          7 |
    call    calc_diffuse_using_1point.2942# |          7 |          7 |
    li      1, $i3                      # |          7 |          7 |
.count stack_load
    load    [$sp + 6], $i2              # |          7 |          7 |
    call    do_without_neighbors.2951   # |          7 |          7 |
.count b_cont
    b       be_cont.36263               # |          7 |          7 |
be_else.36263:
    li      0, $i6
.count stack_load
    load    [$sp + 3], $i3
.count stack_load
    load    [$sp + 2], $i5
.count move_args
    mov     $i32, $i2
.count move_args
    mov     $i33, $i4
    call    try_exploit_neighbors.2967
be_cont.36263:
.count move_args
    mov     $fg4, $f2                   # |         64 |         64 |
    call    min_caml_int_of_float       # |         64 |         64 |
    li      255, $i10                   # |         64 |         64 |
    bg      $i1, $i10, ble_else.36266   # |         64 |         64 |
ble_then.36266:
    bge     $i1, 0, ble_cont.36266      # |         47 |         47 |
bl_then.36267:
    li      0, $i1
.count b_cont
    b       ble_cont.36266
ble_else.36266:
    li      255, $i1                    # |         17 |         17 |
ble_cont.36266:
    mov     $i1, $i2                    # |         64 |         64 |
    call    min_caml_write              # |         64 |         64 |
.count move_args
    mov     $fg5, $f2                   # |         64 |         64 |
    call    min_caml_int_of_float       # |         64 |         64 |
    li      255, $i10                   # |         64 |         64 |
    bg      $i1, $i10, ble_else.36268   # |         64 |         64 |
ble_then.36268:
    bge     $i1, 0, ble_cont.36268      # |         56 |         56 |
bl_then.36269:
    li      0, $i1
.count b_cont
    b       ble_cont.36268
ble_else.36268:
    li      255, $i1                    # |          8 |          8 |
ble_cont.36268:
    mov     $i1, $i2                    # |         64 |         64 |
    call    min_caml_write              # |         64 |         64 |
    li      255, $i10                   # |         64 |         64 |
.count move_args
    mov     $fg6, $f2                   # |         64 |         64 |
    call    min_caml_int_of_float       # |         64 |         64 |
    bg      $i1, $i10, ble_else.36270   # |         64 |         64 |
ble_then.36270:
    bge     $i1, 0, ble_cont.36270      # |         59 |         59 |
bl_then.36271:
    li      0, $i1
.count b_cont
    b       ble_cont.36270
ble_else.36270:
    li      255, $i1                    # |          5 |          5 |
ble_cont.36270:
    mov     $i1, $i2                    # |         64 |         64 |
    call    min_caml_write              # |         64 |         64 |
    li      1, $i2                      # |         64 |         64 |
.count stack_load
    load    [$sp + 4], $i3              # |         64 |         64 |
.count stack_load
    load    [$sp + 3], $i4              # |         64 |         64 |
.count stack_load
    load    [$sp + 5], $i5              # |         64 |         64 |
.count stack_load
    load    [$sp + 2], $i6              # |         64 |         64 |
    call    scan_pixel.2994             # |         64 |         64 |
bg_cont.36260:
.count stack_load
    load    [$sp + 4], $i1              # |         64 |         64 |
    add     $i1, 1, $i1                 # |         64 |         64 |
    bg      $ig3, $i1, ble_else.36272   # |         64 |         64 |
ble_then.36272:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 9, $sp
    ret
ble_else.36272:
.count stack_store
    store   $i1, [$sp + 7]              # |         64 |         64 |
    sub     $ig3, 1, $i10               # |         64 |         64 |
.count stack_load
    load    [$sp + 1], $i11             # |         64 |         64 |
    add     $i11, 2, $i11               # |         64 |         64 |
    bl      $i11, 5, bge_cont.36273     # |         64 |         64 |
bge_then.36273:
    sub     $i11, 5, $i11               # |         25 |         25 |
bge_cont.36273:
.count stack_store
    store   $i11, [$sp + 8]             # |         64 |         64 |
    ble     $i10, $i1, bg_cont.36274    # |         64 |         64 |
bg_then.36274:
    add     $i1, 1, $i1                 # |         63 |         63 |
    sub     $ig1, 1, $i10               # |         63 |         63 |
    sub     $i1, $ig7, $i2              # |         63 |         63 |
    call    min_caml_float_of_int       # |         63 |         63 |
    fmul    $fg17, $f1, $f1             # |         63 |         63 |
    fmul    $f1, $fg24, $f2             # |         63 |         63 |
    fadd    $f2, $fg18, $f2             # |         63 |         63 |
    load    [min_caml_screeny_dir + 1], $f3# |         63 |         63 |
    fmul    $f1, $f3, $f3               # |         63 |         63 |
    fadd    $f3, $fg19, $f3             # |         63 |         63 |
    load    [min_caml_screeny_dir + 2], $f4# |         63 |         63 |
    fmul    $f1, $f4, $f1               # |         63 |         63 |
    fadd    $f1, $fg20, $f4             # |         63 |         63 |
.count stack_load
    load    [$sp + 3], $i2              # |         63 |         63 |
.count move_args
    mov     $i10, $i3                   # |         63 |         63 |
.count move_args
    mov     $i11, $i4                   # |         63 |         63 |
    call    pretrace_pixels.2983        # |         63 |         63 |
bg_cont.36274:
    li      0, $i2                      # |         64 |         64 |
.count stack_load
    load    [$sp + 7], $i3              # |         64 |         64 |
.count stack_load
    load    [$sp + 5], $i4              # |         64 |         64 |
.count stack_load
    load    [$sp + 2], $i5              # |         64 |         64 |
.count stack_load
    load    [$sp + 3], $i6              # |         64 |         64 |
    call    scan_pixel.2994             # |         64 |         64 |
.count stack_load
    load    [$sp + 0], $ra              # |         64 |         64 |
.count stack_move
    add     $sp, 9, $sp                 # |         64 |         64 |
.count stack_load
    load    [$sp - 2], $i1              # |         64 |         64 |
    add     $i1, 1, $i2                 # |         64 |         64 |
.count stack_load
    load    [$sp - 1], $i1              # |         64 |         64 |
    add     $i1, 2, $i6                 # |         64 |         64 |
.count stack_load
    load    [$sp - 4], $i5              # |         64 |         64 |
.count stack_load
    load    [$sp - 6], $i4              # |         64 |         64 |
.count stack_load
    load    [$sp - 7], $i3              # |         64 |         64 |
    bl      $i6, 5, scan_line.3000      # |         64 |         64 |
    sub     $i6, 5, $i6                 # |         26 |         26 |
    b       scan_line.3000              # |         26 |         26 |
.end scan_line

######################################################################
# create_pixel
######################################################################
.begin create_pixel
create_pixel.3008:
.count stack_move
    sub     $sp, 1, $sp                 # |        192 |        192 |
.count stack_store
    store   $ra, [$sp + 0]              # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i10                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i3                    # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
    call    min_caml_create_array_int   # |        192 |        192 |
.count move_ret
    mov     $i1, $i11                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i12                   # |        192 |        192 |
    store   $i12, [$i11 + 1]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i12                   # |        192 |        192 |
    store   $i12, [$i11 + 2]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i12                   # |        192 |        192 |
    store   $i12, [$i11 + 3]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i12                   # |        192 |        192 |
    store   $i12, [$i11 + 4]            # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
    li      0, $i3                      # |        192 |        192 |
    call    min_caml_create_array_int   # |        192 |        192 |
.count move_ret
    mov     $i1, $i12                   # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
    li      0, $i3                      # |        192 |        192 |
    call    min_caml_create_array_int   # |        192 |        192 |
.count move_ret
    mov     $i1, $i13                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i3                    # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
    call    min_caml_create_array_int   # |        192 |        192 |
.count move_ret
    mov     $i1, $i14                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i15                   # |        192 |        192 |
    store   $i15, [$i14 + 1]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i15                   # |        192 |        192 |
    store   $i15, [$i14 + 2]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i15                   # |        192 |        192 |
    store   $i15, [$i14 + 3]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i15                   # |        192 |        192 |
    store   $i15, [$i14 + 4]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i3                    # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
    call    min_caml_create_array_int   # |        192 |        192 |
.count move_ret
    mov     $i1, $i15                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i16                   # |        192 |        192 |
    store   $i16, [$i15 + 1]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i16                   # |        192 |        192 |
    store   $i16, [$i15 + 2]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i16                   # |        192 |        192 |
    store   $i16, [$i15 + 3]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i16                   # |        192 |        192 |
    store   $i16, [$i15 + 4]            # |        192 |        192 |
    li      1, $i2                      # |        192 |        192 |
    li      0, $i3                      # |        192 |        192 |
    call    min_caml_create_array_int   # |        192 |        192 |
.count move_ret
    mov     $i1, $i16                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i3                    # |        192 |        192 |
    li      5, $i2                      # |        192 |        192 |
    call    min_caml_create_array_int   # |        192 |        192 |
.count move_ret
    mov     $i1, $i17                   # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i18                   # |        192 |        192 |
    store   $i18, [$i17 + 1]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i18                   # |        192 |        192 |
    store   $i18, [$i17 + 2]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count move_ret
    mov     $i1, $i18                   # |        192 |        192 |
    store   $i18, [$i17 + 3]            # |        192 |        192 |
    li      3, $i2                      # |        192 |        192 |
.count move_args
    mov     $f0, $f2                    # |        192 |        192 |
    call    min_caml_create_array_float # |        192 |        192 |
.count stack_load
    load    [$sp + 0], $ra              # |        192 |        192 |
.count stack_move
    add     $sp, 1, $sp                 # |        192 |        192 |
    store   $i1, [$i17 + 4]             # |        192 |        192 |
    mov     $hp, $i1                    # |        192 |        192 |
    add     $hp, 8, $hp                 # |        192 |        192 |
    store   $i17, [$i1 + 7]             # |        192 |        192 |
    store   $i16, [$i1 + 6]             # |        192 |        192 |
    store   $i15, [$i1 + 5]             # |        192 |        192 |
    store   $i14, [$i1 + 4]             # |        192 |        192 |
    store   $i13, [$i1 + 3]             # |        192 |        192 |
    store   $i12, [$i1 + 2]             # |        192 |        192 |
    store   $i11, [$i1 + 1]             # |        192 |        192 |
    store   $i10, [$i1 + 0]             # |        192 |        192 |
    ret                                 # |        192 |        192 |
.end create_pixel

######################################################################
# init_line_elements
######################################################################
.begin init_line_elements
init_line_elements.3010:
    bl      $i3, 0, bge_else.36276      # |         96 |         96 |
bge_then.36276:
.count stack_move
    sub     $sp, 3, $sp                 # |         96 |         96 |
.count stack_store
    store   $ra, [$sp + 0]              # |         96 |         96 |
.count stack_store
    store   $i3, [$sp + 1]              # |         96 |         96 |
.count stack_store
    store   $i2, [$sp + 2]              # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i10                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i11                   # |         96 |         96 |
    mov     $i11, $i3                   # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
    call    min_caml_create_array_int   # |         96 |         96 |
.count move_ret
    mov     $i1, $i11                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i12                   # |         96 |         96 |
    store   $i12, [$i11 + 1]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i12                   # |         96 |         96 |
    store   $i12, [$i11 + 2]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i12                   # |         96 |         96 |
    store   $i12, [$i11 + 3]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i12                   # |         96 |         96 |
    store   $i12, [$i11 + 4]            # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
    li      0, $i3                      # |         96 |         96 |
    call    min_caml_create_array_int   # |         96 |         96 |
.count move_ret
    mov     $i1, $i12                   # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
    li      0, $i3                      # |         96 |         96 |
    call    min_caml_create_array_int   # |         96 |         96 |
.count move_ret
    mov     $i1, $i13                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i14                   # |         96 |         96 |
    mov     $i14, $i3                   # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
    call    min_caml_create_array_int   # |         96 |         96 |
.count move_ret
    mov     $i1, $i14                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i15                   # |         96 |         96 |
    store   $i15, [$i14 + 1]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i15                   # |         96 |         96 |
    store   $i15, [$i14 + 2]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i15                   # |         96 |         96 |
    store   $i15, [$i14 + 3]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i15                   # |         96 |         96 |
    store   $i15, [$i14 + 4]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i15                   # |         96 |         96 |
    mov     $i15, $i3                   # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
    call    min_caml_create_array_int   # |         96 |         96 |
.count move_ret
    mov     $i1, $i15                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i16                   # |         96 |         96 |
    store   $i16, [$i15 + 1]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i16                   # |         96 |         96 |
    store   $i16, [$i15 + 2]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i16                   # |         96 |         96 |
    store   $i16, [$i15 + 3]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i16                   # |         96 |         96 |
    store   $i16, [$i15 + 4]            # |         96 |         96 |
    li      1, $i2                      # |         96 |         96 |
    li      0, $i3                      # |         96 |         96 |
    call    min_caml_create_array_int   # |         96 |         96 |
.count move_ret
    mov     $i1, $i16                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i17                   # |         96 |         96 |
    mov     $i17, $i3                   # |         96 |         96 |
    li      5, $i2                      # |         96 |         96 |
    call    min_caml_create_array_int   # |         96 |         96 |
.count move_ret
    mov     $i1, $i17                   # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i18                   # |         96 |         96 |
    store   $i18, [$i17 + 1]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i18                   # |         96 |         96 |
    store   $i18, [$i17 + 2]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i18                   # |         96 |         96 |
    store   $i18, [$i17 + 3]            # |         96 |         96 |
    li      3, $i2                      # |         96 |         96 |
.count move_args
    mov     $f0, $f2                    # |         96 |         96 |
    call    min_caml_create_array_float # |         96 |         96 |
.count move_ret
    mov     $i1, $i19                   # |         96 |         96 |
    store   $i19, [$i17 + 4]            # |         96 |         96 |
    mov     $hp, $i19                   # |         96 |         96 |
    add     $hp, 8, $hp                 # |         96 |         96 |
    store   $i17, [$i19 + 7]            # |         96 |         96 |
    store   $i16, [$i19 + 6]            # |         96 |         96 |
    store   $i15, [$i19 + 5]            # |         96 |         96 |
    store   $i14, [$i19 + 4]            # |         96 |         96 |
    store   $i13, [$i19 + 3]            # |         96 |         96 |
    store   $i12, [$i19 + 2]            # |         96 |         96 |
    store   $i11, [$i19 + 1]            # |         96 |         96 |
    store   $i10, [$i19 + 0]            # |         96 |         96 |
.count stack_load
    load    [$sp + 1], $i20             # |         96 |         96 |
.count stack_load
    load    [$sp + 2], $i21             # |         96 |         96 |
.count storer
    add     $i21, $i20, $tmp            # |         96 |         96 |
    store   $i19, [$tmp + 0]            # |         96 |         96 |
    sub     $i20, 1, $i19               # |         96 |         96 |
    bl      $i19, 0, bge_else.36277     # |         96 |         96 |
bge_then.36277:
    call    create_pixel.3008           # |         96 |         96 |
.count move_ret
    mov     $i1, $i10                   # |         96 |         96 |
.count storer
    add     $i21, $i19, $tmp            # |         96 |         96 |
    store   $i10, [$tmp + 0]            # |         96 |         96 |
    sub     $i19, 1, $i10               # |         96 |         96 |
    bl      $i10, 0, bge_else.36278     # |         96 |         96 |
bge_then.36278:
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i11                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i3                    # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
    call    min_caml_create_array_int   # |         93 |         93 |
.count move_ret
    mov     $i1, $i12                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i13                   # |         93 |         93 |
    store   $i13, [$i12 + 1]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i13                   # |         93 |         93 |
    store   $i13, [$i12 + 2]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i13                   # |         93 |         93 |
    store   $i13, [$i12 + 3]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i13                   # |         93 |         93 |
    store   $i13, [$i12 + 4]            # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
    li      0, $i3                      # |         93 |         93 |
    call    min_caml_create_array_int   # |         93 |         93 |
.count move_ret
    mov     $i1, $i13                   # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
    li      0, $i3                      # |         93 |         93 |
    call    min_caml_create_array_int   # |         93 |         93 |
.count move_ret
    mov     $i1, $i14                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i3                    # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
    call    min_caml_create_array_int   # |         93 |         93 |
.count move_ret
    mov     $i1, $i15                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i16                   # |         93 |         93 |
    store   $i16, [$i15 + 1]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i16                   # |         93 |         93 |
    store   $i16, [$i15 + 2]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i16                   # |         93 |         93 |
    store   $i16, [$i15 + 3]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i16                   # |         93 |         93 |
    store   $i16, [$i15 + 4]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i3                    # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
    call    min_caml_create_array_int   # |         93 |         93 |
.count move_ret
    mov     $i1, $i16                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i17                   # |         93 |         93 |
    store   $i17, [$i16 + 1]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i17                   # |         93 |         93 |
    store   $i17, [$i16 + 2]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i17                   # |         93 |         93 |
    store   $i17, [$i16 + 3]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i17                   # |         93 |         93 |
    store   $i17, [$i16 + 4]            # |         93 |         93 |
    li      1, $i2                      # |         93 |         93 |
    li      0, $i3                      # |         93 |         93 |
    call    min_caml_create_array_int   # |         93 |         93 |
.count move_ret
    mov     $i1, $i17                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i3                    # |         93 |         93 |
    li      5, $i2                      # |         93 |         93 |
    call    min_caml_create_array_int   # |         93 |         93 |
.count move_ret
    mov     $i1, $i18                   # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i19                   # |         93 |         93 |
    store   $i19, [$i18 + 1]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i19                   # |         93 |         93 |
    store   $i19, [$i18 + 2]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i19                   # |         93 |         93 |
    store   $i19, [$i18 + 3]            # |         93 |         93 |
    li      3, $i2                      # |         93 |         93 |
.count move_args
    mov     $f0, $f2                    # |         93 |         93 |
    call    min_caml_create_array_float # |         93 |         93 |
.count move_ret
    mov     $i1, $i19                   # |         93 |         93 |
    store   $i19, [$i18 + 4]            # |         93 |         93 |
    mov     $hp, $i19                   # |         93 |         93 |
    add     $hp, 8, $hp                 # |         93 |         93 |
    store   $i18, [$i19 + 7]            # |         93 |         93 |
    store   $i17, [$i19 + 6]            # |         93 |         93 |
    store   $i16, [$i19 + 5]            # |         93 |         93 |
    store   $i15, [$i19 + 4]            # |         93 |         93 |
    store   $i14, [$i19 + 3]            # |         93 |         93 |
    store   $i13, [$i19 + 2]            # |         93 |         93 |
    store   $i12, [$i19 + 1]            # |         93 |         93 |
    store   $i11, [$i19 + 0]            # |         93 |         93 |
.count storer
    add     $i21, $i10, $tmp            # |         93 |         93 |
    store   $i19, [$tmp + 0]            # |         93 |         93 |
    sub     $i10, 1, $i19               # |         93 |         93 |
    bl      $i19, 0, bge_else.36279     # |         93 |         93 |
bge_then.36279:
    call    create_pixel.3008           # |         93 |         93 |
.count stack_load
    load    [$sp + 0], $ra              # |         93 |         93 |
.count stack_move
    add     $sp, 3, $sp                 # |         93 |         93 |
.count storer
    add     $i21, $i19, $tmp            # |         93 |         93 |
    store   $i1, [$tmp + 0]             # |         93 |         93 |
    sub     $i19, 1, $i3                # |         93 |         93 |
.count move_args
    mov     $i21, $i2                   # |         93 |         93 |
    b       init_line_elements.3010     # |         93 |         93 |
bge_else.36279:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    mov     $i21, $i1
    ret
bge_else.36278:
.count stack_load
    load    [$sp + 0], $ra              # |          3 |          3 |
.count stack_move
    add     $sp, 3, $sp                 # |          3 |          3 |
    mov     $i21, $i1                   # |          3 |          3 |
    ret                                 # |          3 |          3 |
bge_else.36277:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 3, $sp
    mov     $i21, $i1
    ret
bge_else.36276:
    mov     $i2, $i1
    ret
.end init_line_elements

######################################################################
# calc_dirvec
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
    bl      $i2, 5, bge_else.36280      # |        600 |        600 |
bge_then.36280:
    load    [min_caml_dirvecs + $i3], $i1# |        100 |        100 |
    load    [$i1 + $i4], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    fmul    $f2, $f2, $f1               # |        100 |        100 |
    fmul    $f3, $f3, $f4               # |        100 |        100 |
    fadd    $f1, $f4, $f1               # |        100 |        100 |
    fadd    $f1, $fc0, $f1              # |        100 |        100 |
    fsqrt   $f1, $f1                    # |        100 |        100 |
    finv    $f1, $f1                    # |        100 |        100 |
    fmul    $f2, $f1, $f2               # |        100 |        100 |
    store   $f2, [$i2 + 0]              # |        100 |        100 |
    fmul    $f3, $f1, $f3               # |        100 |        100 |
    store   $f3, [$i2 + 1]              # |        100 |        100 |
    store   $f1, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 40, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    store   $f2, [$i2 + 0]              # |        100 |        100 |
    store   $f1, [$i2 + 1]              # |        100 |        100 |
    fneg    $f3, $f4                    # |        100 |        100 |
    store   $f4, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 80, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    store   $f1, [$i2 + 0]              # |        100 |        100 |
    fneg    $f2, $f5                    # |        100 |        100 |
    store   $f5, [$i2 + 1]              # |        100 |        100 |
    store   $f4, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 1, $i2                 # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    store   $f5, [$i2 + 0]              # |        100 |        100 |
    store   $f4, [$i2 + 1]              # |        100 |        100 |
    fneg    $f1, $f1                    # |        100 |        100 |
    store   $f1, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 41, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    store   $f5, [$i2 + 0]              # |        100 |        100 |
    store   $f1, [$i2 + 1]              # |        100 |        100 |
    store   $f3, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 81, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i1            # |        100 |        100 |
    load    [$i1 + 0], $i1              # |        100 |        100 |
    store   $f1, [$i1 + 0]              # |        100 |        100 |
    store   $f2, [$i1 + 1]              # |        100 |        100 |
    store   $f3, [$i1 + 2]              # |        100 |        100 |
    ret                                 # |        100 |        100 |
bge_else.36280:
.count stack_move
    sub     $sp, 6, $sp                 # |        500 |        500 |
.count stack_store
    store   $ra, [$sp + 0]              # |        500 |        500 |
.count stack_store
    store   $i2, [$sp + 1]              # |        500 |        500 |
.count stack_store
    store   $f5, [$sp + 2]              # |        500 |        500 |
.count stack_store
    store   $f4, [$sp + 3]              # |        500 |        500 |
    fmul    $f3, $f3, $f10              # |        500 |        500 |
    fadd    $f10, $fc8, $f10            # |        500 |        500 |
    fsqrt   $f10, $f10                  # |        500 |        500 |
    finv    $f10, $f2                   # |        500 |        500 |
    call    min_caml_atan               # |        500 |        500 |
.count move_ret
    mov     $f1, $f11                   # |        500 |        500 |
.count stack_load
    load    [$sp + 3], $f12             # |        500 |        500 |
    fmul    $f11, $f12, $f2             # |        500 |        500 |
.count stack_store
    store   $f2, [$sp + 4]              # |        500 |        500 |
    call    min_caml_sin                # |        500 |        500 |
.count move_ret
    mov     $f1, $f11                   # |        500 |        500 |
.count stack_load
    load    [$sp + 4], $f2              # |        500 |        500 |
    call    min_caml_cos                # |        500 |        500 |
.count move_ret
    mov     $f1, $f13                   # |        500 |        500 |
    finv    $f13, $f13                  # |        500 |        500 |
    fmul    $f11, $f13, $f11            # |        500 |        500 |
    fmul    $f11, $f10, $f10            # |        500 |        500 |
    fmul    $f10, $f10, $f11            # |        500 |        500 |
    fadd    $f11, $fc8, $f11            # |        500 |        500 |
    fsqrt   $f11, $f11                  # |        500 |        500 |
    finv    $f11, $f2                   # |        500 |        500 |
    call    min_caml_atan               # |        500 |        500 |
.count move_ret
    mov     $f1, $f13                   # |        500 |        500 |
.count stack_load
    load    [$sp + 2], $f14             # |        500 |        500 |
    fmul    $f13, $f14, $f2             # |        500 |        500 |
.count stack_store
    store   $f2, [$sp + 5]              # |        500 |        500 |
    call    min_caml_sin                # |        500 |        500 |
.count move_ret
    mov     $f1, $f13                   # |        500 |        500 |
.count stack_load
    load    [$sp + 5], $f2              # |        500 |        500 |
    call    min_caml_cos                # |        500 |        500 |
.count stack_load
    load    [$sp + 0], $ra              # |        500 |        500 |
.count stack_move
    add     $sp, 6, $sp                 # |        500 |        500 |
    finv    $f1, $f1                    # |        500 |        500 |
    fmul    $f13, $f1, $f1              # |        500 |        500 |
    fmul    $f1, $f11, $f3              # |        500 |        500 |
.count stack_load
    load    [$sp - 5], $i1              # |        500 |        500 |
    add     $i1, 1, $i2                 # |        500 |        500 |
.count move_args
    mov     $f10, $f2                   # |        500 |        500 |
.count move_args
    mov     $f12, $f4                   # |        500 |        500 |
.count move_args
    mov     $f14, $f5                   # |        500 |        500 |
    b       calc_dirvec.3020            # |        500 |        500 |
.end calc_dirvec

######################################################################
# calc_dirvecs
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
    bl      $i2, 0, bge_else.36281      # |         11 |         11 |
bge_then.36281:
.count stack_move
    sub     $sp, 9, $sp                 # |         11 |         11 |
.count stack_store
    store   $ra, [$sp + 0]              # |         11 |         11 |
.count stack_store
    store   $i2, [$sp + 1]              # |         11 |         11 |
.count stack_store
    store   $i4, [$sp + 2]              # |         11 |         11 |
.count stack_store
    store   $i3, [$sp + 3]              # |         11 |         11 |
.count stack_store
    store   $f2, [$sp + 4]              # |         11 |         11 |
    li      0, $i1                      # |         11 |         11 |
    call    min_caml_float_of_int       # |         11 |         11 |
.count move_ret
    mov     $f1, $f15                   # |         11 |         11 |
    fmul    $f15, $fc12, $f15           # |         11 |         11 |
    fsub    $f15, $fc11, $f4            # |         11 |         11 |
.count stack_load
    load    [$sp + 4], $f5              # |         11 |         11 |
.count stack_load
    load    [$sp + 3], $i3              # |         11 |         11 |
.count stack_load
    load    [$sp + 2], $i4              # |         11 |         11 |
.count move_args
    mov     $i1, $i2                    # |         11 |         11 |
.count move_args
    mov     $f0, $f2                    # |         11 |         11 |
.count move_args
    mov     $f0, $f3                    # |         11 |         11 |
    call    calc_dirvec.3020            # |         11 |         11 |
    li      0, $i2                      # |         11 |         11 |
.count stack_load
    load    [$sp + 2], $i10             # |         11 |         11 |
    add     $i10, 2, $i4                # |         11 |         11 |
.count stack_store
    store   $i4, [$sp + 5]              # |         11 |         11 |
    fadd    $f15, $fc8, $f4             # |         11 |         11 |
.count stack_load
    load    [$sp + 4], $f5              # |         11 |         11 |
.count stack_load
    load    [$sp + 3], $i3              # |         11 |         11 |
.count move_args
    mov     $f0, $f2                    # |         11 |         11 |
.count move_args
    mov     $f0, $f3                    # |         11 |         11 |
    call    calc_dirvec.3020            # |         11 |         11 |
.count stack_load
    load    [$sp + 1], $i1              # |         11 |         11 |
    sub     $i1, 1, $i2                 # |         11 |         11 |
    bl      $i2, 0, bge_else.36282      # |         11 |         11 |
bge_then.36282:
.count stack_store
    store   $i2, [$sp + 6]              # |         10 |         10 |
    li      0, $i1                      # |         10 |         10 |
.count stack_load
    load    [$sp + 3], $i11             # |         10 |         10 |
    add     $i11, 1, $i11               # |         10 |         10 |
    bl      $i11, 5, bge_cont.36283     # |         10 |         10 |
bge_then.36283:
    sub     $i11, 5, $i11               # |          2 |          2 |
bge_cont.36283:
    call    min_caml_float_of_int       # |         10 |         10 |
.count move_ret
    mov     $f1, $f15                   # |         10 |         10 |
    fmul    $f15, $fc12, $f15           # |         10 |         10 |
    fsub    $f15, $fc11, $f4            # |         10 |         10 |
.count stack_load
    load    [$sp + 4], $f5              # |         10 |         10 |
.count move_args
    mov     $i1, $i2                    # |         10 |         10 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |
.count move_args
    mov     $f0, $f3                    # |         10 |         10 |
.count move_args
    mov     $i11, $i3                   # |         10 |         10 |
.count move_args
    mov     $i10, $i4                   # |         10 |         10 |
    call    calc_dirvec.3020            # |         10 |         10 |
    li      0, $i2                      # |         10 |         10 |
    fadd    $f15, $fc8, $f4             # |         10 |         10 |
.count stack_load
    load    [$sp + 4], $f5              # |         10 |         10 |
.count stack_load
    load    [$sp + 5], $i4              # |         10 |         10 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |
.count move_args
    mov     $f0, $f3                    # |         10 |         10 |
.count move_args
    mov     $i11, $i3                   # |         10 |         10 |
    call    calc_dirvec.3020            # |         10 |         10 |
.count stack_load
    load    [$sp + 6], $i1              # |         10 |         10 |
    sub     $i1, 1, $i2                 # |         10 |         10 |
    bl      $i2, 0, bge_else.36284      # |         10 |         10 |
bge_then.36284:
.count stack_store
    store   $i2, [$sp + 7]              # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    add     $i11, 1, $i11               # |          5 |          5 |
    bl      $i11, 5, bge_cont.36285     # |          5 |          5 |
bge_then.36285:
    sub     $i11, 5, $i11               # |          1 |          1 |
bge_cont.36285:
    call    min_caml_float_of_int       # |          5 |          5 |
.count move_ret
    mov     $f1, $f15                   # |          5 |          5 |
    fmul    $f15, $fc12, $f15           # |          5 |          5 |
    fsub    $f15, $fc11, $f4            # |          5 |          5 |
.count stack_load
    load    [$sp + 4], $f5              # |          5 |          5 |
.count move_args
    mov     $i1, $i2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i3                   # |          5 |          5 |
.count move_args
    mov     $i10, $i4                   # |          5 |          5 |
    call    calc_dirvec.3020            # |          5 |          5 |
    li      0, $i2                      # |          5 |          5 |
    fadd    $f15, $fc8, $f4             # |          5 |          5 |
.count stack_load
    load    [$sp + 4], $f5              # |          5 |          5 |
.count stack_load
    load    [$sp + 5], $i4              # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i3                   # |          5 |          5 |
    call    calc_dirvec.3020            # |          5 |          5 |
.count stack_load
    load    [$sp + 7], $i1              # |          5 |          5 |
    sub     $i1, 1, $i2                 # |          5 |          5 |
    bl      $i2, 0, bge_else.36286      # |          5 |          5 |
bge_then.36286:
.count stack_store
    store   $i2, [$sp + 8]              # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    add     $i11, 1, $i11               # |          1 |          1 |
    bl      $i11, 5, bge_cont.36287     # |          1 |          1 |
bge_then.36287:
    sub     $i11, 5, $i11
bge_cont.36287:
    call    min_caml_float_of_int       # |          1 |          1 |
.count move_ret
    mov     $f1, $f15                   # |          1 |          1 |
    fmul    $f15, $fc12, $f15           # |          1 |          1 |
    fsub    $f15, $fc11, $f4            # |          1 |          1 |
.count stack_load
    load    [$sp + 4], $f5              # |          1 |          1 |
.count move_args
    mov     $i1, $i2                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f0, $f3                    # |          1 |          1 |
.count move_args
    mov     $i11, $i3                   # |          1 |          1 |
.count move_args
    mov     $i10, $i4                   # |          1 |          1 |
    call    calc_dirvec.3020            # |          1 |          1 |
    li      0, $i2                      # |          1 |          1 |
    fadd    $f15, $fc8, $f4             # |          1 |          1 |
.count stack_load
    load    [$sp + 4], $f5              # |          1 |          1 |
.count stack_load
    load    [$sp + 5], $i4              # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f0, $f3                    # |          1 |          1 |
.count move_args
    mov     $i11, $i3                   # |          1 |          1 |
    call    calc_dirvec.3020            # |          1 |          1 |
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 9, $sp                 # |          1 |          1 |
.count stack_load
    load    [$sp - 1], $i1              # |          1 |          1 |
    sub     $i1, 1, $i2                 # |          1 |          1 |
    add     $i11, 1, $i3                # |          1 |          1 |
.count move_args
    mov     $i10, $i4                   # |          1 |          1 |
.count stack_load
    load    [$sp - 5], $f2              # |          1 |          1 |
    bl      $i3, 5, calc_dirvecs.3028   # |          1 |          1 |
    sub     $i3, 5, $i3
    b       calc_dirvecs.3028
bge_else.36286:
.count stack_load
    load    [$sp + 0], $ra              # |          4 |          4 |
.count stack_move
    add     $sp, 9, $sp                 # |          4 |          4 |
    ret                                 # |          4 |          4 |
bge_else.36284:
.count stack_load
    load    [$sp + 0], $ra              # |          5 |          5 |
.count stack_move
    add     $sp, 9, $sp                 # |          5 |          5 |
    ret                                 # |          5 |          5 |
bge_else.36282:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 9, $sp                 # |          1 |          1 |
    ret                                 # |          1 |          1 |
bge_else.36281:
    ret
.end calc_dirvecs

######################################################################
# calc_dirvec_rows
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
    bl      $i2, 0, bge_else.36289      # |          5 |          5 |
bge_then.36289:
.count stack_move
    sub     $sp, 17, $sp                # |          5 |          5 |
.count stack_store
    store   $ra, [$sp + 0]              # |          5 |          5 |
.count stack_store
    store   $i4, [$sp + 1]              # |          5 |          5 |
.count stack_store
    store   $i3, [$sp + 2]              # |          5 |          5 |
.count stack_store
    store   $i2, [$sp + 3]              # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    li      4, $i2                      # |          5 |          5 |
    call    min_caml_float_of_int       # |          5 |          5 |
.count move_ret
    mov     $f1, $f10                   # |          5 |          5 |
    fmul    $f10, $fc12, $f10           # |          5 |          5 |
.count stack_store
    store   $f10, [$sp + 4]             # |          5 |          5 |
    fsub    $f10, $fc11, $f10           # |          5 |          5 |
.count stack_store
    store   $f10, [$sp + 5]             # |          5 |          5 |
.count stack_load
    load    [$sp + 3], $i2              # |          5 |          5 |
    call    min_caml_float_of_int       # |          5 |          5 |
.count move_ret
    mov     $f1, $f15                   # |          5 |          5 |
    fmul    $f15, $fc12, $f15           # |          5 |          5 |
    fsub    $f15, $fc11, $f5            # |          5 |          5 |
.count stack_store
    store   $f5, [$sp + 6]              # |          5 |          5 |
.count stack_load
    load    [$sp + 2], $i3              # |          5 |          5 |
.count stack_load
    load    [$sp + 1], $i4              # |          5 |          5 |
.count move_args
    mov     $i1, $i2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f3                    # |          5 |          5 |
.count move_args
    mov     $f10, $f4                   # |          5 |          5 |
    call    calc_dirvec.3020            # |          5 |          5 |
    li      0, $i2                      # |          5 |          5 |
.count stack_load
    load    [$sp + 1], $i10             # |          5 |          5 |
    add     $i10, 2, $i4                # |          5 |          5 |
.count stack_store
    store   $i4, [$sp + 7]              # |          5 |          5 |
.count stack_load
    load    [$sp + 4], $f15             # |          5 |          5 |
    fadd    $f15, $fc8, $f4             # |          5 |          5 |
.count stack_store
    store   $f4, [$sp + 8]              # |          5 |          5 |
.count stack_load
    load    [$sp + 6], $f5              # |          5 |          5 |
.count stack_load
    load    [$sp + 2], $i3              # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f3                    # |          5 |          5 |
    call    calc_dirvec.3020            # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
.count stack_load
    load    [$sp + 2], $i11             # |          5 |          5 |
    add     $i11, 1, $i11               # |          5 |          5 |
    bl      $i11, 5, bge_cont.36290     # |          5 |          5 |
bge_then.36290:
    sub     $i11, 5, $i11               # |          1 |          1 |
bge_cont.36290:
    li      3, $i2                      # |          5 |          5 |
    call    min_caml_float_of_int       # |          5 |          5 |
.count move_ret
    mov     $f1, $f15                   # |          5 |          5 |
    fmul    $f15, $fc12, $f15           # |          5 |          5 |
    fsub    $f15, $fc11, $f4            # |          5 |          5 |
.count stack_store
    store   $f4, [$sp + 9]              # |          5 |          5 |
.count stack_load
    load    [$sp + 6], $f5              # |          5 |          5 |
.count move_args
    mov     $i1, $i2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i3                   # |          5 |          5 |
.count move_args
    mov     $i10, $i4                   # |          5 |          5 |
    call    calc_dirvec.3020            # |          5 |          5 |
    li      0, $i2                      # |          5 |          5 |
    fadd    $f15, $fc8, $f4             # |          5 |          5 |
.count stack_store
    store   $f4, [$sp + 10]             # |          5 |          5 |
.count stack_load
    load    [$sp + 6], $f5              # |          5 |          5 |
.count stack_load
    load    [$sp + 7], $i4              # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i3                   # |          5 |          5 |
    call    calc_dirvec.3020            # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    add     $i11, 1, $i11               # |          5 |          5 |
    bl      $i11, 5, bge_cont.36291     # |          5 |          5 |
bge_then.36291:
    sub     $i11, 5, $i11               # |          1 |          1 |
bge_cont.36291:
    li      2, $i2                      # |          5 |          5 |
    call    min_caml_float_of_int       # |          5 |          5 |
.count move_ret
    mov     $f1, $f15                   # |          5 |          5 |
    fmul    $f15, $fc12, $f15           # |          5 |          5 |
    fsub    $f15, $fc11, $f4            # |          5 |          5 |
.count stack_load
    load    [$sp + 6], $f5              # |          5 |          5 |
.count move_args
    mov     $i1, $i2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i3                   # |          5 |          5 |
.count move_args
    mov     $i10, $i4                   # |          5 |          5 |
    call    calc_dirvec.3020            # |          5 |          5 |
    li      0, $i2                      # |          5 |          5 |
    fadd    $f15, $fc8, $f4             # |          5 |          5 |
.count stack_load
    load    [$sp + 6], $f5              # |          5 |          5 |
.count stack_load
    load    [$sp + 7], $i4              # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i3                   # |          5 |          5 |
    call    calc_dirvec.3020            # |          5 |          5 |
    li      1, $i2                      # |          5 |          5 |
    add     $i11, 1, $i12               # |          5 |          5 |
    bl      $i12, 5, bge_cont.36292     # |          5 |          5 |
bge_then.36292:
    sub     $i12, 5, $i12               # |          1 |          1 |
bge_cont.36292:
    mov     $i12, $i3                   # |          5 |          5 |
.count stack_load
    load    [$sp + 6], $f2              # |          5 |          5 |
.count move_args
    mov     $i10, $i4                   # |          5 |          5 |
    call    calc_dirvecs.3028           # |          5 |          5 |
.count stack_load
    load    [$sp + 3], $i1              # |          5 |          5 |
    sub     $i1, 1, $i2                 # |          5 |          5 |
    bl      $i2, 0, bge_else.36293      # |          5 |          5 |
bge_then.36293:
.count stack_store
    store   $i2, [$sp + 11]             # |          4 |          4 |
.count stack_load
    load    [$sp + 2], $i1              # |          4 |          4 |
    add     $i1, 2, $i1                 # |          4 |          4 |
    bl      $i1, 5, bge_cont.36294      # |          4 |          4 |
bge_then.36294:
    sub     $i1, 5, $i1                 # |          1 |          1 |
bge_cont.36294:
.count stack_store
    store   $i1, [$sp + 12]             # |          4 |          4 |
.count stack_load
    load    [$sp + 1], $i10             # |          4 |          4 |
    add     $i10, 4, $i10               # |          4 |          4 |
.count stack_store
    store   $i10, [$sp + 13]            # |          4 |          4 |
    li      0, $i11                     # |          4 |          4 |
    call    min_caml_float_of_int       # |          4 |          4 |
.count move_ret
    mov     $f1, $f15                   # |          4 |          4 |
    fmul    $f15, $fc12, $f15           # |          4 |          4 |
    fsub    $f15, $fc11, $f5            # |          4 |          4 |
.count stack_store
    store   $f5, [$sp + 14]             # |          4 |          4 |
.count stack_load
    load    [$sp + 5], $f4              # |          4 |          4 |
.count move_args
    mov     $i11, $i2                   # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f0, $f3                    # |          4 |          4 |
.count move_args
    mov     $i1, $i3                    # |          4 |          4 |
.count move_args
    mov     $i10, $i4                   # |          4 |          4 |
    call    calc_dirvec.3020            # |          4 |          4 |
    li      0, $i2                      # |          4 |          4 |
    add     $i10, 2, $i4                # |          4 |          4 |
.count stack_store
    store   $i4, [$sp + 15]             # |          4 |          4 |
.count stack_load
    load    [$sp + 8], $f4              # |          4 |          4 |
.count stack_load
    load    [$sp + 14], $f5             # |          4 |          4 |
.count stack_load
    load    [$sp + 12], $i3             # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f0, $f3                    # |          4 |          4 |
    call    calc_dirvec.3020            # |          4 |          4 |
    li      0, $i2                      # |          4 |          4 |
.count stack_load
    load    [$sp + 12], $i11            # |          4 |          4 |
    add     $i11, 1, $i11               # |          4 |          4 |
    bl      $i11, 5, bge_cont.36295     # |          4 |          4 |
bge_then.36295:
    sub     $i11, 5, $i11               # |          1 |          1 |
bge_cont.36295:
    mov     $i11, $i3                   # |          4 |          4 |
.count stack_store
    store   $i3, [$sp + 16]             # |          4 |          4 |
.count stack_load
    load    [$sp + 9], $f4              # |          4 |          4 |
.count stack_load
    load    [$sp + 14], $f5             # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f0, $f3                    # |          4 |          4 |
.count move_args
    mov     $i10, $i4                   # |          4 |          4 |
    call    calc_dirvec.3020            # |          4 |          4 |
    li      0, $i2                      # |          4 |          4 |
.count stack_load
    load    [$sp + 10], $f4             # |          4 |          4 |
.count stack_load
    load    [$sp + 14], $f5             # |          4 |          4 |
.count stack_load
    load    [$sp + 16], $i3             # |          4 |          4 |
.count stack_load
    load    [$sp + 15], $i4             # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f0, $f3                    # |          4 |          4 |
    call    calc_dirvec.3020            # |          4 |          4 |
    li      2, $i2                      # |          4 |          4 |
.count stack_load
    load    [$sp + 16], $i12            # |          4 |          4 |
    add     $i12, 1, $i12               # |          4 |          4 |
    bl      $i12, 5, bge_cont.36296     # |          4 |          4 |
bge_then.36296:
    sub     $i12, 5, $i12               # |          1 |          1 |
bge_cont.36296:
    mov     $i12, $i3                   # |          4 |          4 |
.count stack_load
    load    [$sp + 14], $f2             # |          4 |          4 |
.count move_args
    mov     $i10, $i4                   # |          4 |          4 |
    call    calc_dirvecs.3028           # |          4 |          4 |
.count stack_load
    load    [$sp + 0], $ra              # |          4 |          4 |
.count stack_move
    add     $sp, 17, $sp                # |          4 |          4 |
.count stack_load
    load    [$sp - 6], $i1              # |          4 |          4 |
    sub     $i1, 1, $i2                 # |          4 |          4 |
.count stack_load
    load    [$sp - 5], $i1              # |          4 |          4 |
    add     $i1, 2, $i3                 # |          4 |          4 |
.count stack_load
    load    [$sp - 4], $i1              # |          4 |          4 |
    add     $i1, 4, $i4                 # |          4 |          4 |
    bl      $i3, 5, calc_dirvec_rows.3033# |          4 |          4 |
    sub     $i3, 5, $i3                 # |          2 |          2 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |
bge_else.36293:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 17, $sp                # |          1 |          1 |
    ret                                 # |          1 |          1 |
bge_else.36289:
    ret
.end calc_dirvec_rows

######################################################################
# create_dirvec_elements
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
    bl      $i3, 0, bge_else.36298      # |        150 |        150 |
bge_then.36298:
.count stack_move
    sub     $sp, 7, $sp                 # |        148 |        148 |
.count stack_store
    store   $ra, [$sp + 0]              # |        148 |        148 |
.count stack_store
    store   $i3, [$sp + 1]              # |        148 |        148 |
.count stack_store
    store   $i2, [$sp + 2]              # |        148 |        148 |
    li      3, $i2                      # |        148 |        148 |
.count move_args
    mov     $f0, $f2                    # |        148 |        148 |
    call    min_caml_create_array_float # |        148 |        148 |
.count move_ret
    mov     $i1, $i10                   # |        148 |        148 |
    mov     $i10, $i3                   # |        148 |        148 |
.count stack_store
    store   $i3, [$sp + 3]              # |        148 |        148 |
.count move_args
    mov     $ig0, $i2                   # |        148 |        148 |
    call    min_caml_create_array_int   # |        148 |        148 |
.count move_ret
    mov     $i1, $i10                   # |        148 |        148 |
    mov     $hp, $i11                   # |        148 |        148 |
    add     $hp, 2, $hp                 # |        148 |        148 |
    store   $i10, [$i11 + 1]            # |        148 |        148 |
.count stack_load
    load    [$sp + 3], $i10             # |        148 |        148 |
    store   $i10, [$i11 + 0]            # |        148 |        148 |
.count stack_load
    load    [$sp + 1], $i10             # |        148 |        148 |
.count stack_load
    load    [$sp + 2], $i12             # |        148 |        148 |
.count storer
    add     $i12, $i10, $tmp            # |        148 |        148 |
    store   $i11, [$tmp + 0]            # |        148 |        148 |
    sub     $i10, 1, $i10               # |        148 |        148 |
    bl      $i10, 0, bge_else.36299     # |        148 |        148 |
bge_then.36299:
    li      3, $i2                      # |        146 |        146 |
.count move_args
    mov     $f0, $f2                    # |        146 |        146 |
    call    min_caml_create_array_float # |        146 |        146 |
.count move_ret
    mov     $i1, $i3                    # |        146 |        146 |
.count stack_store
    store   $i3, [$sp + 4]              # |        146 |        146 |
.count move_args
    mov     $ig0, $i2                   # |        146 |        146 |
    call    min_caml_create_array_int   # |        146 |        146 |
.count move_ret
    mov     $i1, $i11                   # |        146 |        146 |
    mov     $hp, $i13                   # |        146 |        146 |
    add     $hp, 2, $hp                 # |        146 |        146 |
    store   $i11, [$i13 + 1]            # |        146 |        146 |
.count stack_load
    load    [$sp + 4], $i11             # |        146 |        146 |
    store   $i11, [$i13 + 0]            # |        146 |        146 |
.count storer
    add     $i12, $i10, $tmp            # |        146 |        146 |
    store   $i13, [$tmp + 0]            # |        146 |        146 |
    sub     $i10, 1, $i10               # |        146 |        146 |
    bl      $i10, 0, bge_else.36300     # |        146 |        146 |
bge_then.36300:
    li      3, $i2                      # |        146 |        146 |
.count move_args
    mov     $f0, $f2                    # |        146 |        146 |
    call    min_caml_create_array_float # |        146 |        146 |
.count move_ret
    mov     $i1, $i3                    # |        146 |        146 |
.count stack_store
    store   $i3, [$sp + 5]              # |        146 |        146 |
.count move_args
    mov     $ig0, $i2                   # |        146 |        146 |
    call    min_caml_create_array_int   # |        146 |        146 |
.count move_ret
    mov     $i1, $i11                   # |        146 |        146 |
    mov     $hp, $i13                   # |        146 |        146 |
    add     $hp, 2, $hp                 # |        146 |        146 |
    store   $i11, [$i13 + 1]            # |        146 |        146 |
.count stack_load
    load    [$sp + 5], $i11             # |        146 |        146 |
    store   $i11, [$i13 + 0]            # |        146 |        146 |
.count storer
    add     $i12, $i10, $tmp            # |        146 |        146 |
    store   $i13, [$tmp + 0]            # |        146 |        146 |
    sub     $i10, 1, $i10               # |        146 |        146 |
    bl      $i10, 0, bge_else.36301     # |        146 |        146 |
bge_then.36301:
    li      3, $i2                      # |        145 |        145 |
.count move_args
    mov     $f0, $f2                    # |        145 |        145 |
    call    min_caml_create_array_float # |        145 |        145 |
.count move_ret
    mov     $i1, $i3                    # |        145 |        145 |
.count stack_store
    store   $i3, [$sp + 6]              # |        145 |        145 |
.count move_args
    mov     $ig0, $i2                   # |        145 |        145 |
    call    min_caml_create_array_int   # |        145 |        145 |
.count stack_load
    load    [$sp + 0], $ra              # |        145 |        145 |
.count stack_move
    add     $sp, 7, $sp                 # |        145 |        145 |
    mov     $hp, $i2                    # |        145 |        145 |
    add     $hp, 2, $hp                 # |        145 |        145 |
    store   $i1, [$i2 + 1]              # |        145 |        145 |
.count stack_load
    load    [$sp - 1], $i1              # |        145 |        145 |
    store   $i1, [$i2 + 0]              # |        145 |        145 |
.count storer
    add     $i12, $i10, $tmp            # |        145 |        145 |
    store   $i2, [$tmp + 0]             # |        145 |        145 |
    sub     $i10, 1, $i3                # |        145 |        145 |
.count move_args
    mov     $i12, $i2                   # |        145 |        145 |
    b       create_dirvec_elements.3039 # |        145 |        145 |
bge_else.36301:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 7, $sp                 # |          1 |          1 |
    ret                                 # |          1 |          1 |
bge_else.36300:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 7, $sp
    ret
bge_else.36299:
.count stack_load
    load    [$sp + 0], $ra              # |          2 |          2 |
.count stack_move
    add     $sp, 7, $sp                 # |          2 |          2 |
    ret                                 # |          2 |          2 |
bge_else.36298:
    ret                                 # |          2 |          2 |
.end create_dirvec_elements

######################################################################
# create_dirvecs
######################################################################
.begin create_dirvecs
create_dirvecs.3042:
    bl      $i2, 0, bge_else.36302      # |          3 |          3 |
bge_then.36302:
.count stack_move
    sub     $sp, 10, $sp                # |          2 |          2 |
.count stack_store
    store   $ra, [$sp + 0]              # |          2 |          2 |
.count stack_store
    store   $i2, [$sp + 1]              # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    min_caml_create_array_float # |          2 |          2 |
.count move_ret
    mov     $i1, $i10                   # |          2 |          2 |
    mov     $i10, $i3                   # |          2 |          2 |
.count stack_store
    store   $i3, [$sp + 2]              # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i10                   # |          2 |          2 |
    li      120, $i2                    # |          2 |          2 |
    mov     $hp, $i3                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i10, [$i3 + 1]             # |          2 |          2 |
.count stack_load
    load    [$sp + 2], $i10             # |          2 |          2 |
    store   $i10, [$i3 + 0]             # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i10                   # |          2 |          2 |
.count stack_load
    load    [$sp + 1], $i11             # |          2 |          2 |
    store   $i10, [min_caml_dirvecs + $i11]# |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    min_caml_create_array_float # |          2 |          2 |
.count move_ret
    mov     $i1, $i3                    # |          2 |          2 |
.count stack_store
    store   $i3, [$sp + 3]              # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i10                   # |          2 |          2 |
    load    [min_caml_dirvecs + $i11], $i11# |          2 |          2 |
    mov     $hp, $i12                   # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i10, [$i12 + 1]            # |          2 |          2 |
.count stack_load
    load    [$sp + 3], $i10             # |          2 |          2 |
    store   $i10, [$i12 + 0]            # |          2 |          2 |
    store   $i12, [$i11 + 118]          # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    min_caml_create_array_float # |          2 |          2 |
.count move_ret
    mov     $i1, $i3                    # |          2 |          2 |
.count stack_store
    store   $i3, [$sp + 4]              # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i10                   # |          2 |          2 |
    mov     $hp, $i12                   # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i10, [$i12 + 1]            # |          2 |          2 |
.count stack_load
    load    [$sp + 4], $i10             # |          2 |          2 |
    store   $i10, [$i12 + 0]            # |          2 |          2 |
    store   $i12, [$i11 + 117]          # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    min_caml_create_array_float # |          2 |          2 |
.count move_ret
    mov     $i1, $i3                    # |          2 |          2 |
.count stack_store
    store   $i3, [$sp + 5]              # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i14                   # |          2 |          2 |
    mov     $hp, $i15                   # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i14, [$i15 + 1]            # |          2 |          2 |
.count stack_load
    load    [$sp + 5], $i14             # |          2 |          2 |
    store   $i14, [$i15 + 0]            # |          2 |          2 |
    store   $i15, [$i11 + 116]          # |          2 |          2 |
    li      115, $i3                    # |          2 |          2 |
.count move_args
    mov     $i11, $i2                   # |          2 |          2 |
    call    create_dirvec_elements.3039 # |          2 |          2 |
.count stack_load
    load    [$sp + 1], $i10             # |          2 |          2 |
    sub     $i10, 1, $i10               # |          2 |          2 |
    bl      $i10, 0, bge_else.36303     # |          2 |          2 |
bge_then.36303:
.count stack_store
    store   $i10, [$sp + 6]             # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    min_caml_create_array_float # |          2 |          2 |
.count move_ret
    mov     $i1, $i3                    # |          2 |          2 |
.count stack_store
    store   $i3, [$sp + 7]              # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i11                   # |          2 |          2 |
    li      120, $i2                    # |          2 |          2 |
    mov     $hp, $i3                    # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i11, [$i3 + 1]             # |          2 |          2 |
.count stack_load
    load    [$sp + 7], $i11             # |          2 |          2 |
    store   $i11, [$i3 + 0]             # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i11                   # |          2 |          2 |
    store   $i11, [min_caml_dirvecs + $i10]# |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    min_caml_create_array_float # |          2 |          2 |
.count move_ret
    mov     $i1, $i3                    # |          2 |          2 |
.count stack_store
    store   $i3, [$sp + 8]              # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i11                   # |          2 |          2 |
    load    [min_caml_dirvecs + $i10], $i10# |          2 |          2 |
    mov     $hp, $i12                   # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i11, [$i12 + 1]            # |          2 |          2 |
.count stack_load
    load    [$sp + 8], $i11             # |          2 |          2 |
    store   $i11, [$i12 + 0]            # |          2 |          2 |
    store   $i12, [$i10 + 118]          # |          2 |          2 |
    li      3, $i2                      # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
    call    min_caml_create_array_float # |          2 |          2 |
.count move_ret
    mov     $i1, $i3                    # |          2 |          2 |
.count stack_store
    store   $i3, [$sp + 9]              # |          2 |          2 |
.count move_args
    mov     $ig0, $i2                   # |          2 |          2 |
    call    min_caml_create_array_int   # |          2 |          2 |
.count move_ret
    mov     $i1, $i14                   # |          2 |          2 |
    mov     $hp, $i15                   # |          2 |          2 |
    add     $hp, 2, $hp                 # |          2 |          2 |
    store   $i14, [$i15 + 1]            # |          2 |          2 |
.count stack_load
    load    [$sp + 9], $i14             # |          2 |          2 |
    store   $i14, [$i15 + 0]            # |          2 |          2 |
    store   $i15, [$i10 + 117]          # |          2 |          2 |
    li      116, $i3                    # |          2 |          2 |
.count move_args
    mov     $i10, $i2                   # |          2 |          2 |
    call    create_dirvec_elements.3039 # |          2 |          2 |
.count stack_load
    load    [$sp + 0], $ra              # |          2 |          2 |
.count stack_move
    add     $sp, 10, $sp                # |          2 |          2 |
.count stack_load
    load    [$sp - 4], $i1              # |          2 |          2 |
    sub     $i1, 1, $i2                 # |          2 |          2 |
    b       create_dirvecs.3042         # |          2 |          2 |
bge_else.36303:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 10, $sp
    ret
bge_else.36302:
    ret                                 # |          1 |          1 |
.end create_dirvecs

######################################################################
# init_dirvec_constants
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
    bl      $i3, 0, bge_else.36304      # |        152 |        152 |
bge_then.36304:
.count stack_move
    sub     $sp, 5, $sp                 # |        150 |        150 |
.count stack_store
    store   $ra, [$sp + 0]              # |        150 |        150 |
.count stack_store
    store   $i2, [$sp + 1]              # |        150 |        150 |
.count stack_store
    store   $i3, [$sp + 2]              # |        150 |        150 |
    sub     $ig0, 1, $i10               # |        150 |        150 |
    load    [$i2 + $i3], $i11           # |        150 |        150 |
    bl      $i10, 0, bge_cont.36305     # |        150 |        150 |
bge_then.36305:
    load    [$i11 + 1], $i12            # |        150 |        150 |
    load    [min_caml_objects + $i10], $i13# |        150 |        150 |
    load    [$i13 + 1], $i14            # |        150 |        150 |
    load    [$i11 + 0], $i15            # |        150 |        150 |
.count move_args
    mov     $f0, $f2                    # |        150 |        150 |
    bne     $i14, 1, be_else.36306      # |        150 |        150 |
be_then.36306:
    li      6, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i15 + 0], $f10
    bne     $f10, $f0, be_else.36307
be_then.36307:
    store   $f0, [$i16 + 1]
.count b_cont
    b       be_cont.36307
be_else.36307:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36308
ble_then.36308:
    li      0, $i18
.count b_cont
    b       ble_cont.36308
ble_else.36308:
    li      1, $i18
ble_cont.36308:
    bne     $i17, 0, be_else.36309
be_then.36309:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36309
be_else.36309:
    bne     $i18, 0, be_else.36310
be_then.36310:
    li      1, $i17
.count b_cont
    b       be_cont.36310
be_else.36310:
    li      0, $i17
be_cont.36310:
be_cont.36309:
    load    [$i13 + 4], $i18
    load    [$i18 + 0], $f10
    bne     $i17, 0, be_else.36311
be_then.36311:
    fneg    $f10, $f10
    store   $f10, [$i16 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
.count b_cont
    b       be_cont.36311
be_else.36311:
    store   $f10, [$i16 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
be_cont.36311:
be_cont.36307:
    load    [$i15 + 1], $f10
    bne     $f10, $f0, be_else.36312
be_then.36312:
    store   $f0, [$i16 + 3]
.count b_cont
    b       be_cont.36312
be_else.36312:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36313
ble_then.36313:
    li      0, $i18
.count b_cont
    b       ble_cont.36313
ble_else.36313:
    li      1, $i18
ble_cont.36313:
    bne     $i17, 0, be_else.36314
be_then.36314:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36314
be_else.36314:
    bne     $i18, 0, be_else.36315
be_then.36315:
    li      1, $i17
.count b_cont
    b       be_cont.36315
be_else.36315:
    li      0, $i17
be_cont.36315:
be_cont.36314:
    load    [$i13 + 4], $i18
    load    [$i18 + 1], $f10
    bne     $i17, 0, be_else.36316
be_then.36316:
    fneg    $f10, $f10
    store   $f10, [$i16 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
.count b_cont
    b       be_cont.36316
be_else.36316:
    store   $f10, [$i16 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
be_cont.36316:
be_cont.36312:
    load    [$i15 + 2], $f10
    bne     $f10, $f0, be_else.36317
be_then.36317:
    store   $f0, [$i16 + 5]
.count storer
    add     $i12, $i10, $tmp
    store   $i16, [$tmp + 0]
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36306
be_else.36317:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36318
ble_then.36318:
    li      0, $i18
.count b_cont
    b       ble_cont.36318
ble_else.36318:
    li      1, $i18
ble_cont.36318:
    bne     $i17, 0, be_else.36319
be_then.36319:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36319
be_else.36319:
    bne     $i18, 0, be_else.36320
be_then.36320:
    li      1, $i17
.count b_cont
    b       be_cont.36320
be_else.36320:
    li      0, $i17
be_cont.36320:
be_cont.36319:
    load    [$i13 + 4], $i18
    load    [$i18 + 2], $f10
    bne     $i17, 0, be_cont.36321
be_then.36321:
    fneg    $f10, $f10
be_cont.36321:
    store   $f10, [$i16 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
.count storer
    add     $i12, $i10, $tmp
    store   $i16, [$tmp + 0]
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36306
be_else.36306:
    bne     $i14, 2, be_else.36322      # |        150 |        150 |
be_then.36322:
    li      4, $i2                      # |        150 |        150 |
    call    min_caml_create_array_float # |        150 |        150 |
.count move_ret
    mov     $i1, $i16                   # |        150 |        150 |
    load    [$i13 + 4], $i17            # |        150 |        150 |
    load    [$i13 + 4], $i18            # |        150 |        150 |
    load    [$i13 + 4], $i19            # |        150 |        150 |
    load    [$i15 + 0], $f10            # |        150 |        150 |
    load    [$i17 + 0], $f11            # |        150 |        150 |
    fmul    $f10, $f11, $f10            # |        150 |        150 |
    load    [$i15 + 1], $f11            # |        150 |        150 |
    load    [$i18 + 1], $f12            # |        150 |        150 |
    fmul    $f11, $f12, $f11            # |        150 |        150 |
    fadd    $f10, $f11, $f10            # |        150 |        150 |
    load    [$i15 + 2], $f11            # |        150 |        150 |
    load    [$i19 + 2], $f12            # |        150 |        150 |
    fmul    $f11, $f12, $f11            # |        150 |        150 |
    fadd    $f10, $f11, $f10            # |        150 |        150 |
.count move_args
    mov     $i11, $i2                   # |        150 |        150 |
    sub     $i10, 1, $i3                # |        150 |        150 |
.count storer
    add     $i12, $i10, $tmp            # |        150 |        150 |
    bg      $f10, $f0, ble_else.36323   # |        150 |        150 |
ble_then.36323:
    store   $f0, [$i16 + 0]             # |         80 |         80 |
    store   $i16, [$tmp + 0]            # |         80 |         80 |
    call    iter_setup_dirvec_constants.2826# |         80 |         80 |
.count b_cont
    b       be_cont.36322               # |         80 |         80 |
ble_else.36323:
    finv    $f10, $f10                  # |         70 |         70 |
    fneg    $f10, $f11                  # |         70 |         70 |
    store   $f11, [$i16 + 0]            # |         70 |         70 |
    load    [$i13 + 4], $i17            # |         70 |         70 |
    load    [$i17 + 0], $f11            # |         70 |         70 |
    fmul_n  $f11, $f10, $f11            # |         70 |         70 |
    store   $f11, [$i16 + 1]            # |         70 |         70 |
    load    [$i13 + 4], $i17            # |         70 |         70 |
    load    [$i17 + 1], $f11            # |         70 |         70 |
    fmul_n  $f11, $f10, $f11            # |         70 |         70 |
    store   $f11, [$i16 + 2]            # |         70 |         70 |
    load    [$i13 + 4], $i17            # |         70 |         70 |
    load    [$i17 + 2], $f11            # |         70 |         70 |
    fmul_n  $f11, $f10, $f10            # |         70 |         70 |
    store   $f10, [$i16 + 3]            # |         70 |         70 |
    store   $i16, [$tmp + 0]            # |         70 |         70 |
    call    iter_setup_dirvec_constants.2826# |         70 |         70 |
.count b_cont
    b       be_cont.36322               # |         70 |         70 |
be_else.36322:
    li      5, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i13 + 3], $i17
    load    [$i13 + 4], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i15 + 0], $f10
    load    [$i15 + 1], $f11
    load    [$i15 + 2], $f12
    fmul    $f10, $f10, $f13
    load    [$i18 + 0], $f14
    fmul    $f13, $f14, $f13
    fmul    $f11, $f11, $f14
    load    [$i19 + 1], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f12, $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    bne     $i17, 0, be_else.36324
be_then.36324:
    mov     $f13, $f10
.count b_cont
    b       be_cont.36324
be_else.36324:
    fmul    $f11, $f12, $f14
    load    [$i13 + 9], $i18
    load    [$i18 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f10, $f12
    load    [$i13 + 9], $i18
    load    [$i18 + 1], $f14
    fmul    $f12, $f14, $f12
    fadd    $f13, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i13 + 9], $i18
    load    [$i18 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.36324:
    store   $f10, [$i16 + 0]
    load    [$i13 + 4], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i15 + 0], $f11
    load    [$i18 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 1], $f12
    load    [$i19 + 1], $f13
    fmul    $f12, $f13, $f13
    load    [$i15 + 2], $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f15
    fneg    $f11, $f11
    fneg    $f13, $f13
    fneg    $f15, $f15
.count storer
    add     $i12, $i10, $tmp
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    bne     $i17, 0, be_else.36325
be_then.36325:
    store   $f11, [$i16 + 1]
    store   $f13, [$i16 + 2]
    store   $f15, [$i16 + 3]
    bne     $f10, $f0, be_else.36326
be_then.36326:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36325
be_else.36326:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36325
be_else.36325:
    load    [$i13 + 9], $i17
    load    [$i13 + 9], $i18
    load    [$i17 + 1], $f16
    fmul    $f14, $f16, $f14
    load    [$i18 + 2], $f17
    fmul    $f12, $f17, $f12
    fadd    $f14, $f12, $f12
    fmul    $f12, $fc3, $f12
    fsub    $f11, $f12, $f11
    store   $f11, [$i16 + 1]
    load    [$i13 + 9], $i17
    load    [$i15 + 2], $f11
    load    [$i17 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f14
    fmul    $f14, $f17, $f14
    fadd    $f11, $f14, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f13, $f11, $f11
    store   $f11, [$i16 + 2]
    load    [$i15 + 1], $f11
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f12
    fmul    $f12, $f16, $f12
    fadd    $f11, $f12, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f15, $f11, $f11
    store   $f11, [$i16 + 3]
    bne     $f10, $f0, be_else.36327
be_then.36327:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36327
be_else.36327:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
be_cont.36327:
be_cont.36325:
be_cont.36322:
be_cont.36306:
bge_cont.36305:
.count stack_load
    load    [$sp + 2], $i10             # |        150 |        150 |
    sub     $i10, 1, $i10               # |        150 |        150 |
    bl      $i10, 0, bge_else.36328     # |        150 |        150 |
bge_then.36328:
.count stack_store
    store   $i10, [$sp + 3]             # |        149 |        149 |
    sub     $ig0, 1, $i11               # |        149 |        149 |
.count stack_load
    load    [$sp + 1], $i12             # |        149 |        149 |
    load    [$i12 + $i10], $i10         # |        149 |        149 |
    bl      $i11, 0, bge_cont.36329     # |        149 |        149 |
bge_then.36329:
    load    [$i10 + 1], $i12            # |        149 |        149 |
    load    [min_caml_objects + $i11], $i13# |        149 |        149 |
    load    [$i13 + 1], $i14            # |        149 |        149 |
    load    [$i10 + 0], $i15            # |        149 |        149 |
.count move_args
    mov     $f0, $f2                    # |        149 |        149 |
    bne     $i14, 1, be_else.36330      # |        149 |        149 |
be_then.36330:
    li      6, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i15 + 0], $f10
    bne     $f10, $f0, be_else.36331
be_then.36331:
    store   $f0, [$i16 + 1]
.count b_cont
    b       be_cont.36331
be_else.36331:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36332
ble_then.36332:
    li      0, $i18
.count b_cont
    b       ble_cont.36332
ble_else.36332:
    li      1, $i18
ble_cont.36332:
    bne     $i17, 0, be_else.36333
be_then.36333:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36333
be_else.36333:
    bne     $i18, 0, be_else.36334
be_then.36334:
    li      1, $i17
.count b_cont
    b       be_cont.36334
be_else.36334:
    li      0, $i17
be_cont.36334:
be_cont.36333:
    load    [$i13 + 4], $i18
    load    [$i18 + 0], $f10
    bne     $i17, 0, be_else.36335
be_then.36335:
    fneg    $f10, $f10
    store   $f10, [$i16 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
.count b_cont
    b       be_cont.36335
be_else.36335:
    store   $f10, [$i16 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
be_cont.36335:
be_cont.36331:
    load    [$i15 + 1], $f10
    bne     $f10, $f0, be_else.36336
be_then.36336:
    store   $f0, [$i16 + 3]
.count b_cont
    b       be_cont.36336
be_else.36336:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36337
ble_then.36337:
    li      0, $i18
.count b_cont
    b       ble_cont.36337
ble_else.36337:
    li      1, $i18
ble_cont.36337:
    bne     $i17, 0, be_else.36338
be_then.36338:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36338
be_else.36338:
    bne     $i18, 0, be_else.36339
be_then.36339:
    li      1, $i17
.count b_cont
    b       be_cont.36339
be_else.36339:
    li      0, $i17
be_cont.36339:
be_cont.36338:
    load    [$i13 + 4], $i18
    load    [$i18 + 1], $f10
    bne     $i17, 0, be_else.36340
be_then.36340:
    fneg    $f10, $f10
    store   $f10, [$i16 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
.count b_cont
    b       be_cont.36340
be_else.36340:
    store   $f10, [$i16 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
be_cont.36340:
be_cont.36336:
    load    [$i15 + 2], $f10
    bne     $f10, $f0, be_else.36341
be_then.36341:
    store   $f0, [$i16 + 5]
.count storer
    add     $i12, $i11, $tmp
    store   $i16, [$tmp + 0]
    sub     $i11, 1, $i3
.count move_args
    mov     $i10, $i2
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36330
be_else.36341:
    load    [$i13 + 6], $i17
    load    [$i13 + 4], $i18
    bg      $f0, $f10, ble_else.36342
ble_then.36342:
    li      0, $i19
.count b_cont
    b       ble_cont.36342
ble_else.36342:
    li      1, $i19
ble_cont.36342:
    bne     $i17, 0, be_else.36343
be_then.36343:
    mov     $i19, $i17
.count b_cont
    b       be_cont.36343
be_else.36343:
    bne     $i19, 0, be_else.36344
be_then.36344:
    li      1, $i17
.count b_cont
    b       be_cont.36344
be_else.36344:
    li      0, $i17
be_cont.36344:
be_cont.36343:
    load    [$i18 + 2], $f10
.count move_args
    mov     $i10, $i2
    sub     $i11, 1, $i3
.count storer
    add     $i12, $i11, $tmp
    bne     $i17, 0, be_else.36345
be_then.36345:
    fneg    $f10, $f10
    store   $f10, [$i16 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36330
be_else.36345:
    store   $f10, [$i16 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36330
be_else.36330:
    bne     $i14, 2, be_else.36346      # |        149 |        149 |
be_then.36346:
    li      4, $i2                      # |        149 |        149 |
    call    min_caml_create_array_float # |        149 |        149 |
.count move_ret
    mov     $i1, $i16                   # |        149 |        149 |
    load    [$i13 + 4], $i17            # |        149 |        149 |
    load    [$i13 + 4], $i18            # |        149 |        149 |
    load    [$i13 + 4], $i19            # |        149 |        149 |
    load    [$i15 + 0], $f10            # |        149 |        149 |
    load    [$i17 + 0], $f11            # |        149 |        149 |
    fmul    $f10, $f11, $f10            # |        149 |        149 |
    load    [$i15 + 1], $f11            # |        149 |        149 |
    load    [$i18 + 1], $f12            # |        149 |        149 |
    fmul    $f11, $f12, $f11            # |        149 |        149 |
    fadd    $f10, $f11, $f10            # |        149 |        149 |
    load    [$i15 + 2], $f11            # |        149 |        149 |
    load    [$i19 + 2], $f12            # |        149 |        149 |
    fmul    $f11, $f12, $f11            # |        149 |        149 |
    fadd    $f10, $f11, $f10            # |        149 |        149 |
.count move_args
    mov     $i10, $i2                   # |        149 |        149 |
    sub     $i11, 1, $i3                # |        149 |        149 |
.count storer
    add     $i12, $i11, $tmp            # |        149 |        149 |
    bg      $f10, $f0, ble_else.36347   # |        149 |        149 |
ble_then.36347:
    store   $f0, [$i16 + 0]             # |         69 |         69 |
    store   $i16, [$tmp + 0]            # |         69 |         69 |
    call    iter_setup_dirvec_constants.2826# |         69 |         69 |
.count b_cont
    b       be_cont.36346               # |         69 |         69 |
ble_else.36347:
    finv    $f10, $f10                  # |         80 |         80 |
    fneg    $f10, $f11                  # |         80 |         80 |
    store   $f11, [$i16 + 0]            # |         80 |         80 |
    load    [$i13 + 4], $i17            # |         80 |         80 |
    load    [$i17 + 0], $f11            # |         80 |         80 |
    fmul_n  $f11, $f10, $f11            # |         80 |         80 |
    store   $f11, [$i16 + 1]            # |         80 |         80 |
    load    [$i13 + 4], $i17            # |         80 |         80 |
    load    [$i17 + 1], $f11            # |         80 |         80 |
    fmul_n  $f11, $f10, $f11            # |         80 |         80 |
    store   $f11, [$i16 + 2]            # |         80 |         80 |
    load    [$i13 + 4], $i17            # |         80 |         80 |
    load    [$i17 + 2], $f11            # |         80 |         80 |
    fmul_n  $f11, $f10, $f10            # |         80 |         80 |
    store   $f10, [$i16 + 3]            # |         80 |         80 |
    store   $i16, [$tmp + 0]            # |         80 |         80 |
    call    iter_setup_dirvec_constants.2826# |         80 |         80 |
.count b_cont
    b       be_cont.36346               # |         80 |         80 |
be_else.36346:
    li      5, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i13 + 3], $i17
    load    [$i13 + 4], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i15 + 0], $f10
    load    [$i15 + 1], $f11
    load    [$i15 + 2], $f12
    fmul    $f10, $f10, $f13
    load    [$i18 + 0], $f14
    fmul    $f13, $f14, $f13
    fmul    $f11, $f11, $f14
    load    [$i19 + 1], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f12, $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    bne     $i17, 0, be_else.36348
be_then.36348:
    mov     $f13, $f10
.count b_cont
    b       be_cont.36348
be_else.36348:
    fmul    $f11, $f12, $f14
    load    [$i13 + 9], $i18
    load    [$i18 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f10, $f12
    load    [$i13 + 9], $i18
    load    [$i18 + 1], $f14
    fmul    $f12, $f14, $f12
    fadd    $f13, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i13 + 9], $i18
    load    [$i18 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.36348:
    store   $f10, [$i16 + 0]
    load    [$i13 + 4], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i15 + 0], $f11
    load    [$i18 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 1], $f12
    load    [$i19 + 1], $f13
    fmul    $f12, $f13, $f13
    load    [$i15 + 2], $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f15
    fneg    $f11, $f11
    fneg    $f13, $f13
    fneg    $f15, $f15
.count storer
    add     $i12, $i11, $tmp
    sub     $i11, 1, $i3
.count move_args
    mov     $i10, $i2
    bne     $i17, 0, be_else.36349
be_then.36349:
    store   $f11, [$i16 + 1]
    store   $f13, [$i16 + 2]
    store   $f15, [$i16 + 3]
    bne     $f10, $f0, be_else.36350
be_then.36350:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36349
be_else.36350:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36349
be_else.36349:
    load    [$i13 + 9], $i17
    load    [$i13 + 9], $i18
    load    [$i17 + 1], $f16
    fmul    $f14, $f16, $f14
    load    [$i18 + 2], $f17
    fmul    $f12, $f17, $f12
    fadd    $f14, $f12, $f12
    fmul    $f12, $fc3, $f12
    fsub    $f11, $f12, $f11
    store   $f11, [$i16 + 1]
    load    [$i13 + 9], $i17
    load    [$i15 + 2], $f11
    load    [$i17 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f14
    fmul    $f14, $f17, $f14
    fadd    $f11, $f14, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f13, $f11, $f11
    store   $f11, [$i16 + 2]
    load    [$i15 + 1], $f11
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f12
    fmul    $f12, $f16, $f12
    fadd    $f11, $f12, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f15, $f11, $f11
    store   $f11, [$i16 + 3]
    bne     $f10, $f0, be_else.36351
be_then.36351:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36351
be_else.36351:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
be_cont.36351:
be_cont.36349:
be_cont.36346:
be_cont.36330:
bge_cont.36329:
.count stack_load
    load    [$sp + 3], $i16             # |        149 |        149 |
    sub     $i16, 1, $i16               # |        149 |        149 |
    bl      $i16, 0, bge_else.36352     # |        149 |        149 |
bge_then.36352:
    sub     $ig0, 1, $i3                # |        148 |        148 |
.count stack_load
    load    [$sp + 1], $i17             # |        148 |        148 |
    load    [$i17 + $i16], $i2          # |        148 |        148 |
    call    iter_setup_dirvec_constants.2826# |        148 |        148 |
    sub     $i16, 1, $i10               # |        148 |        148 |
    bl      $i10, 0, bge_else.36353     # |        148 |        148 |
bge_then.36353:
    sub     $ig0, 1, $i11               # |        147 |        147 |
    bl      $i11, 0, bge_else.36354     # |        147 |        147 |
bge_then.36354:
    load    [$i17 + $i10], $i12         # |        147 |        147 |
    load    [$i12 + 1], $i13            # |        147 |        147 |
    load    [min_caml_objects + $i11], $i14# |        147 |        147 |
    load    [$i14 + 1], $i15            # |        147 |        147 |
    load    [$i12 + 0], $i16            # |        147 |        147 |
.count stack_store
    store   $i10, [$sp + 4]             # |        147 |        147 |
.count move_args
    mov     $f0, $f2                    # |        147 |        147 |
    bne     $i15, 1, be_else.36355      # |        147 |        147 |
be_then.36355:
    li      6, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i18
    load    [$i16 + 0], $f10
    bne     $f10, $f0, be_else.36356
be_then.36356:
    store   $f0, [$i18 + 1]
.count b_cont
    b       be_cont.36356
be_else.36356:
    load    [$i14 + 6], $i19
    bg      $f0, $f10, ble_else.36357
ble_then.36357:
    li      0, $i20
.count b_cont
    b       ble_cont.36357
ble_else.36357:
    li      1, $i20
ble_cont.36357:
    bne     $i19, 0, be_else.36358
be_then.36358:
    mov     $i20, $i19
.count b_cont
    b       be_cont.36358
be_else.36358:
    bne     $i20, 0, be_else.36359
be_then.36359:
    li      1, $i19
.count b_cont
    b       be_cont.36359
be_else.36359:
    li      0, $i19
be_cont.36359:
be_cont.36358:
    load    [$i14 + 4], $i20
    load    [$i20 + 0], $f10
    bne     $i19, 0, be_else.36360
be_then.36360:
    fneg    $f10, $f10
    store   $f10, [$i18 + 0]
    load    [$i16 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i18 + 1]
.count b_cont
    b       be_cont.36360
be_else.36360:
    store   $f10, [$i18 + 0]
    load    [$i16 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i18 + 1]
be_cont.36360:
be_cont.36356:
    load    [$i16 + 1], $f10
    bne     $f10, $f0, be_else.36361
be_then.36361:
    store   $f0, [$i18 + 3]
.count b_cont
    b       be_cont.36361
be_else.36361:
    load    [$i14 + 6], $i19
    bg      $f0, $f10, ble_else.36362
ble_then.36362:
    li      0, $i20
.count b_cont
    b       ble_cont.36362
ble_else.36362:
    li      1, $i20
ble_cont.36362:
    bne     $i19, 0, be_else.36363
be_then.36363:
    mov     $i20, $i19
.count b_cont
    b       be_cont.36363
be_else.36363:
    bne     $i20, 0, be_else.36364
be_then.36364:
    li      1, $i19
.count b_cont
    b       be_cont.36364
be_else.36364:
    li      0, $i19
be_cont.36364:
be_cont.36363:
    load    [$i14 + 4], $i20
    load    [$i20 + 1], $f10
    bne     $i19, 0, be_else.36365
be_then.36365:
    fneg    $f10, $f10
    store   $f10, [$i18 + 2]
    load    [$i16 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i18 + 3]
.count b_cont
    b       be_cont.36365
be_else.36365:
    store   $f10, [$i18 + 2]
    load    [$i16 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i18 + 3]
be_cont.36365:
be_cont.36361:
    load    [$i16 + 2], $f10
    bne     $f10, $f0, be_else.36366
be_then.36366:
    store   $f0, [$i18 + 5]
    mov     $i18, $i16
.count b_cont
    b       be_cont.36366
be_else.36366:
    load    [$i14 + 6], $i19
    load    [$i14 + 4], $i20
    bg      $f0, $f10, ble_else.36367
ble_then.36367:
    li      0, $i21
.count b_cont
    b       ble_cont.36367
ble_else.36367:
    li      1, $i21
ble_cont.36367:
    bne     $i19, 0, be_else.36368
be_then.36368:
    mov     $i21, $i19
.count b_cont
    b       be_cont.36368
be_else.36368:
    bne     $i21, 0, be_else.36369
be_then.36369:
    li      1, $i19
.count b_cont
    b       be_cont.36369
be_else.36369:
    li      0, $i19
be_cont.36369:
be_cont.36368:
    load    [$i20 + 2], $f10
    bne     $i19, 0, be_else.36370
be_then.36370:
    fneg    $f10, $f10
    store   $f10, [$i18 + 4]
    load    [$i16 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i18 + 5]
    mov     $i18, $i16
.count b_cont
    b       be_cont.36370
be_else.36370:
    store   $f10, [$i18 + 4]
    load    [$i16 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i18 + 5]
    mov     $i18, $i16
be_cont.36370:
be_cont.36366:
.count storer
    add     $i13, $i11, $tmp
    store   $i16, [$tmp + 0]
    sub     $i11, 1, $i3
.count move_args
    mov     $i12, $i2
    call    iter_setup_dirvec_constants.2826
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
.count stack_load
    load    [$sp - 1], $i1
    sub     $i1, 1, $i3
.count move_args
    mov     $i17, $i2
    b       init_dirvec_constants.3044
be_else.36355:
    bne     $i15, 2, be_else.36371      # |        147 |        147 |
be_then.36371:
    li      4, $i2                      # |        147 |        147 |
    call    min_caml_create_array_float # |        147 |        147 |
.count move_ret
    mov     $i1, $i18                   # |        147 |        147 |
    load    [$i14 + 4], $i19            # |        147 |        147 |
    load    [$i14 + 4], $i20            # |        147 |        147 |
    load    [$i14 + 4], $i21            # |        147 |        147 |
    load    [$i16 + 0], $f10            # |        147 |        147 |
    load    [$i19 + 0], $f11            # |        147 |        147 |
    fmul    $f10, $f11, $f10            # |        147 |        147 |
    load    [$i16 + 1], $f11            # |        147 |        147 |
    load    [$i20 + 1], $f12            # |        147 |        147 |
    fmul    $f11, $f12, $f11            # |        147 |        147 |
    fadd    $f10, $f11, $f10            # |        147 |        147 |
    load    [$i16 + 2], $f11            # |        147 |        147 |
    load    [$i21 + 2], $f12            # |        147 |        147 |
    fmul    $f11, $f12, $f11            # |        147 |        147 |
    fadd    $f10, $f11, $f10            # |        147 |        147 |
.count storer
    add     $i13, $i11, $tmp            # |        147 |        147 |
    bg      $f10, $f0, ble_else.36372   # |        147 |        147 |
ble_then.36372:
    store   $f0, [$i18 + 0]             # |         68 |         68 |
    store   $i18, [$tmp + 0]            # |         68 |         68 |
.count b_cont
    b       be_cont.36371               # |         68 |         68 |
ble_else.36372:
    finv    $f10, $f10                  # |         79 |         79 |
    fneg    $f10, $f11                  # |         79 |         79 |
    store   $f11, [$i18 + 0]            # |         79 |         79 |
    load    [$i14 + 4], $i16            # |         79 |         79 |
    load    [$i16 + 0], $f11            # |         79 |         79 |
    fmul_n  $f11, $f10, $f11            # |         79 |         79 |
    store   $f11, [$i18 + 1]            # |         79 |         79 |
    load    [$i14 + 4], $i16            # |         79 |         79 |
    load    [$i16 + 1], $f11            # |         79 |         79 |
    fmul_n  $f11, $f10, $f11            # |         79 |         79 |
    store   $f11, [$i18 + 2]            # |         79 |         79 |
    load    [$i14 + 4], $i16            # |         79 |         79 |
    load    [$i16 + 2], $f11            # |         79 |         79 |
    fmul_n  $f11, $f10, $f10            # |         79 |         79 |
    store   $f10, [$i18 + 3]            # |         79 |         79 |
    store   $i18, [$tmp + 0]            # |         79 |         79 |
.count b_cont
    b       be_cont.36371               # |         79 |         79 |
be_else.36371:
    li      5, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i18
    load    [$i14 + 3], $i19
    load    [$i14 + 4], $i20
    load    [$i14 + 4], $i21
    load    [$i14 + 4], $i22
    load    [$i16 + 0], $f10
    load    [$i16 + 1], $f11
    load    [$i16 + 2], $f12
    fmul    $f10, $f10, $f13
    load    [$i20 + 0], $f14
    fmul    $f13, $f14, $f13
    fmul    $f11, $f11, $f14
    load    [$i21 + 1], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f12, $f14
    load    [$i22 + 2], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    bne     $i19, 0, be_else.36373
be_then.36373:
    mov     $f13, $f10
.count b_cont
    b       be_cont.36373
be_else.36373:
    fmul    $f11, $f12, $f14
    load    [$i14 + 9], $i20
    load    [$i20 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f10, $f12
    load    [$i14 + 9], $i20
    load    [$i20 + 1], $f14
    fmul    $f12, $f14, $f12
    fadd    $f13, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i14 + 9], $i20
    load    [$i20 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.36373:
    store   $f10, [$i18 + 0]
    load    [$i14 + 4], $i20
    load    [$i14 + 4], $i21
    load    [$i14 + 4], $i22
    load    [$i16 + 0], $f11
    load    [$i20 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i16 + 1], $f12
    load    [$i21 + 1], $f13
    fmul    $f12, $f13, $f13
    load    [$i16 + 2], $f14
    load    [$i22 + 2], $f15
    fmul    $f14, $f15, $f15
    fneg    $f11, $f11
    fneg    $f13, $f13
    fneg    $f15, $f15
.count storer
    add     $i13, $i11, $tmp
    bne     $i19, 0, be_else.36374
be_then.36374:
    store   $f11, [$i18 + 1]
    store   $f13, [$i18 + 2]
    store   $f15, [$i18 + 3]
    bne     $f10, $f0, be_else.36375
be_then.36375:
    store   $i18, [$tmp + 0]
.count b_cont
    b       be_cont.36374
be_else.36375:
    finv    $f10, $f10
    store   $f10, [$i18 + 4]
    store   $i18, [$tmp + 0]
.count b_cont
    b       be_cont.36374
be_else.36374:
    load    [$i14 + 9], $i19
    load    [$i14 + 9], $i20
    load    [$i19 + 1], $f16
    fmul    $f14, $f16, $f14
    load    [$i20 + 2], $f17
    fmul    $f12, $f17, $f12
    fadd    $f14, $f12, $f12
    fmul    $f12, $fc3, $f12
    fsub    $f11, $f12, $f11
    store   $f11, [$i18 + 1]
    load    [$i14 + 9], $i19
    load    [$i16 + 2], $f11
    load    [$i19 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i16 + 0], $f14
    fmul    $f14, $f17, $f14
    fadd    $f11, $f14, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f13, $f11, $f11
    store   $f11, [$i18 + 2]
    load    [$i16 + 1], $f11
    fmul    $f11, $f12, $f11
    load    [$i16 + 0], $f12
    fmul    $f12, $f16, $f12
    fadd    $f11, $f12, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f15, $f11, $f11
    store   $f11, [$i18 + 3]
    bne     $f10, $f0, be_else.36376
be_then.36376:
    store   $i18, [$tmp + 0]
.count b_cont
    b       be_cont.36376
be_else.36376:
    finv    $f10, $f10
    store   $f10, [$i18 + 4]
    store   $i18, [$tmp + 0]
be_cont.36376:
be_cont.36374:
be_cont.36371:
    sub     $i11, 1, $i3                # |        147 |        147 |
.count move_args
    mov     $i12, $i2                   # |        147 |        147 |
    call    iter_setup_dirvec_constants.2826# |        147 |        147 |
.count stack_load
    load    [$sp + 0], $ra              # |        147 |        147 |
.count stack_move
    add     $sp, 5, $sp                 # |        147 |        147 |
.count stack_load
    load    [$sp - 1], $i1              # |        147 |        147 |
    sub     $i1, 1, $i3                 # |        147 |        147 |
.count move_args
    mov     $i17, $i2                   # |        147 |        147 |
    b       init_dirvec_constants.3044  # |        147 |        147 |
bge_else.36354:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 5, $sp
    sub     $i10, 1, $i3
.count move_args
    mov     $i17, $i2
    b       init_dirvec_constants.3044
bge_else.36353:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 5, $sp                 # |          1 |          1 |
    ret                                 # |          1 |          1 |
bge_else.36352:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 5, $sp                 # |          1 |          1 |
    ret                                 # |          1 |          1 |
bge_else.36328:
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 5, $sp                 # |          1 |          1 |
    ret                                 # |          1 |          1 |
bge_else.36304:
    ret                                 # |          2 |          2 |
.end init_dirvec_constants

######################################################################
# init_vecset_constants
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
    bl      $i2, 0, bge_else.36377      # |          2 |          2 |
bge_then.36377:
.count stack_move
    sub     $sp, 6, $sp                 # |          1 |          1 |
.count stack_store
    store   $ra, [$sp + 0]              # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 1]              # |          1 |          1 |
    sub     $ig0, 1, $i10               # |          1 |          1 |
    load    [min_caml_dirvecs + $i2], $i11# |          1 |          1 |
.count stack_store
    store   $i11, [$sp + 2]             # |          1 |          1 |
    load    [$i11 + 119], $i11          # |          1 |          1 |
    bl      $i10, 0, bge_cont.36378     # |          1 |          1 |
bge_then.36378:
    load    [$i11 + 1], $i12            # |          1 |          1 |
    load    [min_caml_objects + $i10], $i13# |          1 |          1 |
    load    [$i13 + 1], $i14            # |          1 |          1 |
    load    [$i11 + 0], $i15            # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i14, 1, be_else.36379      # |          1 |          1 |
be_then.36379:
    li      6, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i15 + 0], $f10
    bne     $f10, $f0, be_else.36380
be_then.36380:
    store   $f0, [$i16 + 1]
.count b_cont
    b       be_cont.36380
be_else.36380:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36381
ble_then.36381:
    li      0, $i18
.count b_cont
    b       ble_cont.36381
ble_else.36381:
    li      1, $i18
ble_cont.36381:
    bne     $i17, 0, be_else.36382
be_then.36382:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36382
be_else.36382:
    bne     $i18, 0, be_else.36383
be_then.36383:
    li      1, $i17
.count b_cont
    b       be_cont.36383
be_else.36383:
    li      0, $i17
be_cont.36383:
be_cont.36382:
    load    [$i13 + 4], $i18
    load    [$i18 + 0], $f10
    bne     $i17, 0, be_else.36384
be_then.36384:
    fneg    $f10, $f10
    store   $f10, [$i16 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
.count b_cont
    b       be_cont.36384
be_else.36384:
    store   $f10, [$i16 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
be_cont.36384:
be_cont.36380:
    load    [$i15 + 1], $f10
    bne     $f10, $f0, be_else.36385
be_then.36385:
    store   $f0, [$i16 + 3]
.count b_cont
    b       be_cont.36385
be_else.36385:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36386
ble_then.36386:
    li      0, $i18
.count b_cont
    b       ble_cont.36386
ble_else.36386:
    li      1, $i18
ble_cont.36386:
    bne     $i17, 0, be_else.36387
be_then.36387:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36387
be_else.36387:
    bne     $i18, 0, be_else.36388
be_then.36388:
    li      1, $i17
.count b_cont
    b       be_cont.36388
be_else.36388:
    li      0, $i17
be_cont.36388:
be_cont.36387:
    load    [$i13 + 4], $i18
    load    [$i18 + 1], $f10
    bne     $i17, 0, be_else.36389
be_then.36389:
    fneg    $f10, $f10
    store   $f10, [$i16 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
.count b_cont
    b       be_cont.36389
be_else.36389:
    store   $f10, [$i16 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
be_cont.36389:
be_cont.36385:
    load    [$i15 + 2], $f10
    bne     $f10, $f0, be_else.36390
be_then.36390:
    store   $f0, [$i16 + 5]
.count storer
    add     $i12, $i10, $tmp
    store   $i16, [$tmp + 0]
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36379
be_else.36390:
    load    [$i13 + 6], $i17
    load    [$i13 + 4], $i18
    bg      $f0, $f10, ble_else.36391
ble_then.36391:
    li      0, $i19
.count b_cont
    b       ble_cont.36391
ble_else.36391:
    li      1, $i19
ble_cont.36391:
    bne     $i17, 0, be_else.36392
be_then.36392:
    mov     $i19, $i17
.count b_cont
    b       be_cont.36392
be_else.36392:
    bne     $i19, 0, be_else.36393
be_then.36393:
    li      1, $i17
.count b_cont
    b       be_cont.36393
be_else.36393:
    li      0, $i17
be_cont.36393:
be_cont.36392:
    load    [$i18 + 2], $f10
.count move_args
    mov     $i11, $i2
    sub     $i10, 1, $i3
.count storer
    add     $i12, $i10, $tmp
    bne     $i17, 0, be_else.36394
be_then.36394:
    fneg    $f10, $f10
    store   $f10, [$i16 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36379
be_else.36394:
    store   $f10, [$i16 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36379
be_else.36379:
    bne     $i14, 2, be_else.36395      # |          1 |          1 |
be_then.36395:
    li      4, $i2                      # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    load    [$i13 + 4], $i17            # |          1 |          1 |
    load    [$i13 + 4], $i18            # |          1 |          1 |
    load    [$i13 + 4], $i19            # |          1 |          1 |
    load    [$i15 + 0], $f10            # |          1 |          1 |
    load    [$i17 + 0], $f11            # |          1 |          1 |
    fmul    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i15 + 1], $f11            # |          1 |          1 |
    load    [$i18 + 1], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i15 + 2], $f11            # |          1 |          1 |
    load    [$i19 + 2], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
.count move_args
    mov     $i11, $i2                   # |          1 |          1 |
    sub     $i10, 1, $i3                # |          1 |          1 |
.count storer
    add     $i12, $i10, $tmp            # |          1 |          1 |
    bg      $f10, $f0, ble_else.36396   # |          1 |          1 |
ble_then.36396:
    store   $f0, [$i16 + 0]             # |          1 |          1 |
    store   $i16, [$tmp + 0]            # |          1 |          1 |
    call    iter_setup_dirvec_constants.2826# |          1 |          1 |
.count b_cont
    b       be_cont.36395               # |          1 |          1 |
ble_else.36396:
    finv    $f10, $f10
    fneg    $f10, $f11
    store   $f11, [$i16 + 0]
    load    [$i13 + 4], $i17
    load    [$i17 + 0], $f11
    fmul_n  $f11, $f10, $f11
    store   $f11, [$i16 + 1]
    load    [$i13 + 4], $i17
    load    [$i17 + 1], $f11
    fmul_n  $f11, $f10, $f11
    store   $f11, [$i16 + 2]
    load    [$i13 + 4], $i17
    load    [$i17 + 2], $f11
    fmul_n  $f11, $f10, $f10
    store   $f10, [$i16 + 3]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36395
be_else.36395:
    li      5, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i13 + 3], $i17
    load    [$i13 + 4], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i15 + 0], $f10
    load    [$i15 + 1], $f11
    load    [$i15 + 2], $f12
    fmul    $f10, $f10, $f13
    load    [$i18 + 0], $f14
    fmul    $f13, $f14, $f13
    fmul    $f11, $f11, $f14
    load    [$i19 + 1], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f12, $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    bne     $i17, 0, be_else.36397
be_then.36397:
    mov     $f13, $f10
.count b_cont
    b       be_cont.36397
be_else.36397:
    fmul    $f11, $f12, $f14
    load    [$i13 + 9], $i18
    load    [$i18 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f10, $f12
    load    [$i13 + 9], $i18
    load    [$i18 + 1], $f14
    fmul    $f12, $f14, $f12
    fadd    $f13, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i13 + 9], $i18
    load    [$i18 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.36397:
    store   $f10, [$i16 + 0]
    load    [$i13 + 4], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i15 + 0], $f11
    load    [$i18 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 1], $f12
    load    [$i19 + 1], $f13
    fmul    $f12, $f13, $f13
    load    [$i15 + 2], $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f15
    fneg    $f11, $f11
    fneg    $f13, $f13
    fneg    $f15, $f15
.count storer
    add     $i12, $i10, $tmp
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    bne     $i17, 0, be_else.36398
be_then.36398:
    store   $f11, [$i16 + 1]
    store   $f13, [$i16 + 2]
    store   $f15, [$i16 + 3]
    bne     $f10, $f0, be_else.36399
be_then.36399:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36398
be_else.36399:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36398
be_else.36398:
    load    [$i13 + 9], $i17
    load    [$i13 + 9], $i18
    load    [$i17 + 1], $f16
    fmul    $f14, $f16, $f14
    load    [$i18 + 2], $f17
    fmul    $f12, $f17, $f12
    fadd    $f14, $f12, $f12
    fmul    $f12, $fc3, $f12
    fsub    $f11, $f12, $f11
    store   $f11, [$i16 + 1]
    load    [$i13 + 9], $i17
    load    [$i15 + 2], $f11
    load    [$i17 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f14
    fmul    $f14, $f17, $f14
    fadd    $f11, $f14, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f13, $f11, $f11
    store   $f11, [$i16 + 2]
    load    [$i15 + 1], $f11
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f12
    fmul    $f12, $f16, $f12
    fadd    $f11, $f12, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f15, $f11, $f11
    store   $f11, [$i16 + 3]
    bne     $f10, $f0, be_else.36400
be_then.36400:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36400
be_else.36400:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
be_cont.36400:
be_cont.36398:
be_cont.36395:
be_cont.36379:
bge_cont.36378:
    sub     $ig0, 1, $i3                # |          1 |          1 |
.count stack_load
    load    [$sp + 2], $i16             # |          1 |          1 |
    load    [$i16 + 118], $i2           # |          1 |          1 |
    call    iter_setup_dirvec_constants.2826# |          1 |          1 |
    sub     $ig0, 1, $i10               # |          1 |          1 |
    load    [$i16 + 117], $i11          # |          1 |          1 |
    bl      $i10, 0, bge_cont.36401     # |          1 |          1 |
bge_then.36401:
    load    [$i11 + 1], $i12            # |          1 |          1 |
    load    [min_caml_objects + $i10], $i13# |          1 |          1 |
    load    [$i13 + 1], $i14            # |          1 |          1 |
    load    [$i11 + 0], $i15            # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i14, 1, be_else.36402      # |          1 |          1 |
be_then.36402:
    li      6, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i17
    load    [$i15 + 0], $f10
    bne     $f10, $f0, be_else.36403
be_then.36403:
    store   $f0, [$i17 + 1]
.count b_cont
    b       be_cont.36403
be_else.36403:
    load    [$i13 + 6], $i18
    bg      $f0, $f10, ble_else.36404
ble_then.36404:
    li      0, $i19
.count b_cont
    b       ble_cont.36404
ble_else.36404:
    li      1, $i19
ble_cont.36404:
    bne     $i18, 0, be_else.36405
be_then.36405:
    mov     $i19, $i18
.count b_cont
    b       be_cont.36405
be_else.36405:
    bne     $i19, 0, be_else.36406
be_then.36406:
    li      1, $i18
.count b_cont
    b       be_cont.36406
be_else.36406:
    li      0, $i18
be_cont.36406:
be_cont.36405:
    load    [$i13 + 4], $i19
    load    [$i19 + 0], $f10
    bne     $i18, 0, be_else.36407
be_then.36407:
    fneg    $f10, $f10
    store   $f10, [$i17 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 1]
.count b_cont
    b       be_cont.36407
be_else.36407:
    store   $f10, [$i17 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 1]
be_cont.36407:
be_cont.36403:
    load    [$i15 + 1], $f10
    bne     $f10, $f0, be_else.36408
be_then.36408:
    store   $f0, [$i17 + 3]
.count b_cont
    b       be_cont.36408
be_else.36408:
    load    [$i13 + 6], $i18
    bg      $f0, $f10, ble_else.36409
ble_then.36409:
    li      0, $i19
.count b_cont
    b       ble_cont.36409
ble_else.36409:
    li      1, $i19
ble_cont.36409:
    bne     $i18, 0, be_else.36410
be_then.36410:
    mov     $i19, $i18
.count b_cont
    b       be_cont.36410
be_else.36410:
    bne     $i19, 0, be_else.36411
be_then.36411:
    li      1, $i18
.count b_cont
    b       be_cont.36411
be_else.36411:
    li      0, $i18
be_cont.36411:
be_cont.36410:
    load    [$i13 + 4], $i19
    load    [$i19 + 1], $f10
    bne     $i18, 0, be_else.36412
be_then.36412:
    fneg    $f10, $f10
    store   $f10, [$i17 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 3]
.count b_cont
    b       be_cont.36412
be_else.36412:
    store   $f10, [$i17 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 3]
be_cont.36412:
be_cont.36408:
    load    [$i15 + 2], $f10
    bne     $f10, $f0, be_else.36413
be_then.36413:
    store   $f0, [$i17 + 5]
.count storer
    add     $i12, $i10, $tmp
    store   $i17, [$tmp + 0]
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36402
be_else.36413:
    load    [$i13 + 6], $i18
    load    [$i13 + 4], $i19
    bg      $f0, $f10, ble_else.36414
ble_then.36414:
    li      0, $i20
.count b_cont
    b       ble_cont.36414
ble_else.36414:
    li      1, $i20
ble_cont.36414:
    bne     $i18, 0, be_else.36415
be_then.36415:
    mov     $i20, $i18
.count b_cont
    b       be_cont.36415
be_else.36415:
    bne     $i20, 0, be_else.36416
be_then.36416:
    li      1, $i18
.count b_cont
    b       be_cont.36416
be_else.36416:
    li      0, $i18
be_cont.36416:
be_cont.36415:
    load    [$i19 + 2], $f10
.count move_args
    mov     $i11, $i2
    sub     $i10, 1, $i3
.count storer
    add     $i12, $i10, $tmp
    bne     $i18, 0, be_else.36417
be_then.36417:
    fneg    $f10, $f10
    store   $f10, [$i17 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 5]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36402
be_else.36417:
    store   $f10, [$i17 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 5]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36402
be_else.36402:
    bne     $i14, 2, be_else.36418      # |          1 |          1 |
be_then.36418:
    li      4, $i2                      # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i17                   # |          1 |          1 |
    load    [$i13 + 4], $i18            # |          1 |          1 |
    load    [$i13 + 4], $i19            # |          1 |          1 |
    load    [$i13 + 4], $i20            # |          1 |          1 |
    load    [$i15 + 0], $f10            # |          1 |          1 |
    load    [$i18 + 0], $f11            # |          1 |          1 |
    fmul    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i15 + 1], $f11            # |          1 |          1 |
    load    [$i19 + 1], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i15 + 2], $f11            # |          1 |          1 |
    load    [$i20 + 2], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
.count move_args
    mov     $i11, $i2                   # |          1 |          1 |
    sub     $i10, 1, $i3                # |          1 |          1 |
.count storer
    add     $i12, $i10, $tmp            # |          1 |          1 |
    bg      $f10, $f0, ble_else.36419   # |          1 |          1 |
ble_then.36419:
    store   $f0, [$i17 + 0]             # |          1 |          1 |
    store   $i17, [$tmp + 0]            # |          1 |          1 |
    call    iter_setup_dirvec_constants.2826# |          1 |          1 |
.count b_cont
    b       be_cont.36418               # |          1 |          1 |
ble_else.36419:
    finv    $f10, $f10
    fneg    $f10, $f11
    store   $f11, [$i17 + 0]
    load    [$i13 + 4], $i18
    load    [$i18 + 0], $f11
    fmul_n  $f11, $f10, $f11
    store   $f11, [$i17 + 1]
    load    [$i13 + 4], $i18
    load    [$i18 + 1], $f11
    fmul_n  $f11, $f10, $f11
    store   $f11, [$i17 + 2]
    load    [$i13 + 4], $i18
    load    [$i18 + 2], $f11
    fmul_n  $f11, $f10, $f10
    store   $f10, [$i17 + 3]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36418
be_else.36418:
    li      5, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i17
    load    [$i13 + 3], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i13 + 4], $i21
    load    [$i15 + 0], $f10
    load    [$i15 + 1], $f11
    load    [$i15 + 2], $f12
    fmul    $f10, $f10, $f13
    load    [$i19 + 0], $f14
    fmul    $f13, $f14, $f13
    fmul    $f11, $f11, $f14
    load    [$i20 + 1], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f12, $f14
    load    [$i21 + 2], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    bne     $i18, 0, be_else.36420
be_then.36420:
    mov     $f13, $f10
.count b_cont
    b       be_cont.36420
be_else.36420:
    fmul    $f11, $f12, $f14
    load    [$i13 + 9], $i19
    load    [$i19 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f10, $f12
    load    [$i13 + 9], $i19
    load    [$i19 + 1], $f14
    fmul    $f12, $f14, $f12
    fadd    $f13, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i13 + 9], $i19
    load    [$i19 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.36420:
    store   $f10, [$i17 + 0]
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i13 + 4], $i21
    load    [$i15 + 0], $f11
    load    [$i19 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 1], $f12
    load    [$i20 + 1], $f13
    fmul    $f12, $f13, $f13
    load    [$i15 + 2], $f14
    load    [$i21 + 2], $f15
    fmul    $f14, $f15, $f15
    fneg    $f11, $f11
    fneg    $f13, $f13
    fneg    $f15, $f15
.count storer
    add     $i12, $i10, $tmp
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    bne     $i18, 0, be_else.36421
be_then.36421:
    store   $f11, [$i17 + 1]
    store   $f13, [$i17 + 2]
    store   $f15, [$i17 + 3]
    bne     $f10, $f0, be_else.36422
be_then.36422:
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36421
be_else.36422:
    finv    $f10, $f10
    store   $f10, [$i17 + 4]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36421
be_else.36421:
    load    [$i13 + 9], $i18
    load    [$i13 + 9], $i19
    load    [$i18 + 1], $f16
    fmul    $f14, $f16, $f14
    load    [$i19 + 2], $f17
    fmul    $f12, $f17, $f12
    fadd    $f14, $f12, $f12
    fmul    $f12, $fc3, $f12
    fsub    $f11, $f12, $f11
    store   $f11, [$i17 + 1]
    load    [$i13 + 9], $i18
    load    [$i15 + 2], $f11
    load    [$i18 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f14
    fmul    $f14, $f17, $f14
    fadd    $f11, $f14, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f13, $f11, $f11
    store   $f11, [$i17 + 2]
    load    [$i15 + 1], $f11
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f12
    fmul    $f12, $f16, $f12
    fadd    $f11, $f12, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f15, $f11, $f11
    store   $f11, [$i17 + 3]
    bne     $f10, $f0, be_else.36423
be_then.36423:
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36423
be_else.36423:
    finv    $f10, $f10
    store   $f10, [$i17 + 4]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
be_cont.36423:
be_cont.36421:
be_cont.36418:
be_cont.36402:
bge_cont.36401:
    li      116, $i3                    # |          1 |          1 |
.count move_args
    mov     $i16, $i2                   # |          1 |          1 |
    call    init_dirvec_constants.3044  # |          1 |          1 |
.count stack_load
    load    [$sp + 1], $i16             # |          1 |          1 |
    sub     $i16, 1, $i16               # |          1 |          1 |
    bl      $i16, 0, bge_else.36424     # |          1 |          1 |
bge_then.36424:
.count stack_store
    store   $i16, [$sp + 3]             # |          1 |          1 |
    sub     $ig0, 1, $i3                # |          1 |          1 |
    load    [min_caml_dirvecs + $i16], $i16# |          1 |          1 |
    load    [$i16 + 119], $i2           # |          1 |          1 |
    call    iter_setup_dirvec_constants.2826# |          1 |          1 |
    sub     $ig0, 1, $i10               # |          1 |          1 |
    load    [$i16 + 118], $i11          # |          1 |          1 |
    bl      $i10, 0, bge_cont.36425     # |          1 |          1 |
bge_then.36425:
    load    [$i11 + 1], $i12            # |          1 |          1 |
    load    [min_caml_objects + $i10], $i13# |          1 |          1 |
    load    [$i13 + 1], $i14            # |          1 |          1 |
    load    [$i11 + 0], $i15            # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i14, 1, be_else.36426      # |          1 |          1 |
be_then.36426:
    li      6, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i17
    load    [$i15 + 0], $f10
    bne     $f10, $f0, be_else.36427
be_then.36427:
    store   $f0, [$i17 + 1]
.count b_cont
    b       be_cont.36427
be_else.36427:
    load    [$i13 + 6], $i18
    bg      $f0, $f10, ble_else.36428
ble_then.36428:
    li      0, $i19
.count b_cont
    b       ble_cont.36428
ble_else.36428:
    li      1, $i19
ble_cont.36428:
    bne     $i18, 0, be_else.36429
be_then.36429:
    mov     $i19, $i18
.count b_cont
    b       be_cont.36429
be_else.36429:
    bne     $i19, 0, be_else.36430
be_then.36430:
    li      1, $i18
.count b_cont
    b       be_cont.36430
be_else.36430:
    li      0, $i18
be_cont.36430:
be_cont.36429:
    load    [$i13 + 4], $i19
    load    [$i19 + 0], $f10
    bne     $i18, 0, be_else.36431
be_then.36431:
    fneg    $f10, $f10
    store   $f10, [$i17 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 1]
.count b_cont
    b       be_cont.36431
be_else.36431:
    store   $f10, [$i17 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 1]
be_cont.36431:
be_cont.36427:
    load    [$i15 + 1], $f10
    bne     $f10, $f0, be_else.36432
be_then.36432:
    store   $f0, [$i17 + 3]
.count b_cont
    b       be_cont.36432
be_else.36432:
    load    [$i13 + 6], $i18
    bg      $f0, $f10, ble_else.36433
ble_then.36433:
    li      0, $i19
.count b_cont
    b       ble_cont.36433
ble_else.36433:
    li      1, $i19
ble_cont.36433:
    bne     $i18, 0, be_else.36434
be_then.36434:
    mov     $i19, $i18
.count b_cont
    b       be_cont.36434
be_else.36434:
    bne     $i19, 0, be_else.36435
be_then.36435:
    li      1, $i18
.count b_cont
    b       be_cont.36435
be_else.36435:
    li      0, $i18
be_cont.36435:
be_cont.36434:
    load    [$i13 + 4], $i19
    load    [$i19 + 1], $f10
    bne     $i18, 0, be_else.36436
be_then.36436:
    fneg    $f10, $f10
    store   $f10, [$i17 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 3]
.count b_cont
    b       be_cont.36436
be_else.36436:
    store   $f10, [$i17 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 3]
be_cont.36436:
be_cont.36432:
    load    [$i15 + 2], $f10
    bne     $f10, $f0, be_else.36437
be_then.36437:
    store   $f0, [$i17 + 5]
.count storer
    add     $i12, $i10, $tmp
    store   $i17, [$tmp + 0]
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36426
be_else.36437:
    load    [$i13 + 6], $i18
    load    [$i13 + 4], $i19
    bg      $f0, $f10, ble_else.36438
ble_then.36438:
    li      0, $i20
.count b_cont
    b       ble_cont.36438
ble_else.36438:
    li      1, $i20
ble_cont.36438:
    bne     $i18, 0, be_else.36439
be_then.36439:
    mov     $i20, $i18
.count b_cont
    b       be_cont.36439
be_else.36439:
    bne     $i20, 0, be_else.36440
be_then.36440:
    li      1, $i18
.count b_cont
    b       be_cont.36440
be_else.36440:
    li      0, $i18
be_cont.36440:
be_cont.36439:
    load    [$i19 + 2], $f10
.count move_args
    mov     $i11, $i2
    sub     $i10, 1, $i3
.count storer
    add     $i12, $i10, $tmp
    bne     $i18, 0, be_else.36441
be_then.36441:
    fneg    $f10, $f10
    store   $f10, [$i17 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 5]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36426
be_else.36441:
    store   $f10, [$i17 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i17 + 5]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36426
be_else.36426:
    bne     $i14, 2, be_else.36442      # |          1 |          1 |
be_then.36442:
    li      4, $i2                      # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i17                   # |          1 |          1 |
    load    [$i13 + 4], $i18            # |          1 |          1 |
    load    [$i13 + 4], $i19            # |          1 |          1 |
    load    [$i13 + 4], $i20            # |          1 |          1 |
    load    [$i15 + 0], $f10            # |          1 |          1 |
    load    [$i18 + 0], $f11            # |          1 |          1 |
    fmul    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i15 + 1], $f11            # |          1 |          1 |
    load    [$i19 + 1], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i15 + 2], $f11            # |          1 |          1 |
    load    [$i20 + 2], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
.count move_args
    mov     $i11, $i2                   # |          1 |          1 |
    sub     $i10, 1, $i3                # |          1 |          1 |
.count storer
    add     $i12, $i10, $tmp            # |          1 |          1 |
    bg      $f10, $f0, ble_else.36443   # |          1 |          1 |
ble_then.36443:
    store   $f0, [$i17 + 0]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36442
ble_else.36443:
    finv    $f10, $f10                  # |          1 |          1 |
    fneg    $f10, $f11                  # |          1 |          1 |
    store   $f11, [$i17 + 0]            # |          1 |          1 |
    load    [$i13 + 4], $i18            # |          1 |          1 |
    load    [$i18 + 0], $f11            # |          1 |          1 |
    fmul_n  $f11, $f10, $f11            # |          1 |          1 |
    store   $f11, [$i17 + 1]            # |          1 |          1 |
    load    [$i13 + 4], $i18            # |          1 |          1 |
    load    [$i18 + 1], $f11            # |          1 |          1 |
    fmul_n  $f11, $f10, $f11            # |          1 |          1 |
    store   $f11, [$i17 + 2]            # |          1 |          1 |
    load    [$i13 + 4], $i18            # |          1 |          1 |
    load    [$i18 + 2], $f11            # |          1 |          1 |
    fmul_n  $f11, $f10, $f10            # |          1 |          1 |
    store   $f10, [$i17 + 3]            # |          1 |          1 |
    store   $i17, [$tmp + 0]            # |          1 |          1 |
    call    iter_setup_dirvec_constants.2826# |          1 |          1 |
.count b_cont
    b       be_cont.36442               # |          1 |          1 |
be_else.36442:
    li      5, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i17
    load    [$i13 + 3], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i13 + 4], $i21
    load    [$i15 + 0], $f10
    load    [$i15 + 1], $f11
    load    [$i15 + 2], $f12
    fmul    $f10, $f10, $f13
    load    [$i19 + 0], $f14
    fmul    $f13, $f14, $f13
    fmul    $f11, $f11, $f14
    load    [$i20 + 1], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f12, $f14
    load    [$i21 + 2], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    bne     $i18, 0, be_else.36444
be_then.36444:
    mov     $f13, $f10
.count b_cont
    b       be_cont.36444
be_else.36444:
    fmul    $f11, $f12, $f14
    load    [$i13 + 9], $i19
    load    [$i19 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f10, $f12
    load    [$i13 + 9], $i19
    load    [$i19 + 1], $f14
    fmul    $f12, $f14, $f12
    fadd    $f13, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i13 + 9], $i19
    load    [$i19 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.36444:
    store   $f10, [$i17 + 0]
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i13 + 4], $i21
    load    [$i15 + 0], $f11
    load    [$i19 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 1], $f12
    load    [$i20 + 1], $f13
    fmul    $f12, $f13, $f13
    load    [$i15 + 2], $f14
    load    [$i21 + 2], $f15
    fmul    $f14, $f15, $f15
    fneg    $f11, $f11
    fneg    $f13, $f13
    fneg    $f15, $f15
.count storer
    add     $i12, $i10, $tmp
    sub     $i10, 1, $i3
.count move_args
    mov     $i11, $i2
    bne     $i18, 0, be_else.36445
be_then.36445:
    store   $f11, [$i17 + 1]
    store   $f13, [$i17 + 2]
    store   $f15, [$i17 + 3]
    bne     $f10, $f0, be_else.36446
be_then.36446:
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36445
be_else.36446:
    finv    $f10, $f10
    store   $f10, [$i17 + 4]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36445
be_else.36445:
    load    [$i13 + 9], $i18
    load    [$i13 + 9], $i19
    load    [$i18 + 1], $f16
    fmul    $f14, $f16, $f14
    load    [$i19 + 2], $f17
    fmul    $f12, $f17, $f12
    fadd    $f14, $f12, $f12
    fmul    $f12, $fc3, $f12
    fsub    $f11, $f12, $f11
    store   $f11, [$i17 + 1]
    load    [$i13 + 9], $i18
    load    [$i15 + 2], $f11
    load    [$i18 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f14
    fmul    $f14, $f17, $f14
    fadd    $f11, $f14, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f13, $f11, $f11
    store   $f11, [$i17 + 2]
    load    [$i15 + 1], $f11
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f12
    fmul    $f12, $f16, $f12
    fadd    $f11, $f12, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f15, $f11, $f11
    store   $f11, [$i17 + 3]
    bne     $f10, $f0, be_else.36447
be_then.36447:
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36447
be_else.36447:
    finv    $f10, $f10
    store   $f10, [$i17 + 4]
    store   $i17, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
be_cont.36447:
be_cont.36445:
be_cont.36442:
be_cont.36426:
bge_cont.36425:
    li      117, $i3                    # |          1 |          1 |
.count move_args
    mov     $i16, $i2                   # |          1 |          1 |
    call    init_dirvec_constants.3044  # |          1 |          1 |
.count stack_load
    load    [$sp + 3], $i10             # |          1 |          1 |
    sub     $i10, 1, $i10               # |          1 |          1 |
    bl      $i10, 0, bge_else.36448     # |          1 |          1 |
bge_then.36448:
.count stack_store
    store   $i10, [$sp + 4]             # |          1 |          1 |
    sub     $ig0, 1, $i11               # |          1 |          1 |
    load    [min_caml_dirvecs + $i10], $i10# |          1 |          1 |
.count stack_store
    store   $i10, [$sp + 5]             # |          1 |          1 |
    load    [$i10 + 119], $i10          # |          1 |          1 |
    bl      $i11, 0, bge_cont.36449     # |          1 |          1 |
bge_then.36449:
    load    [$i10 + 1], $i12            # |          1 |          1 |
    load    [min_caml_objects + $i11], $i13# |          1 |          1 |
    load    [$i13 + 1], $i14            # |          1 |          1 |
    load    [$i10 + 0], $i15            # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i14, 1, be_else.36450      # |          1 |          1 |
be_then.36450:
    li      6, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i15 + 0], $f10
    bne     $f10, $f0, be_else.36451
be_then.36451:
    store   $f0, [$i16 + 1]
.count b_cont
    b       be_cont.36451
be_else.36451:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36452
ble_then.36452:
    li      0, $i18
.count b_cont
    b       ble_cont.36452
ble_else.36452:
    li      1, $i18
ble_cont.36452:
    bne     $i17, 0, be_else.36453
be_then.36453:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36453
be_else.36453:
    bne     $i18, 0, be_else.36454
be_then.36454:
    li      1, $i17
.count b_cont
    b       be_cont.36454
be_else.36454:
    li      0, $i17
be_cont.36454:
be_cont.36453:
    load    [$i13 + 4], $i18
    load    [$i18 + 0], $f10
    bne     $i17, 0, be_else.36455
be_then.36455:
    fneg    $f10, $f10
    store   $f10, [$i16 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
.count b_cont
    b       be_cont.36455
be_else.36455:
    store   $f10, [$i16 + 0]
    load    [$i15 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
be_cont.36455:
be_cont.36451:
    load    [$i15 + 1], $f10
    bne     $f10, $f0, be_else.36456
be_then.36456:
    store   $f0, [$i16 + 3]
.count b_cont
    b       be_cont.36456
be_else.36456:
    load    [$i13 + 6], $i17
    bg      $f0, $f10, ble_else.36457
ble_then.36457:
    li      0, $i18
.count b_cont
    b       ble_cont.36457
ble_else.36457:
    li      1, $i18
ble_cont.36457:
    bne     $i17, 0, be_else.36458
be_then.36458:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36458
be_else.36458:
    bne     $i18, 0, be_else.36459
be_then.36459:
    li      1, $i17
.count b_cont
    b       be_cont.36459
be_else.36459:
    li      0, $i17
be_cont.36459:
be_cont.36458:
    load    [$i13 + 4], $i18
    load    [$i18 + 1], $f10
    bne     $i17, 0, be_else.36460
be_then.36460:
    fneg    $f10, $f10
    store   $f10, [$i16 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
.count b_cont
    b       be_cont.36460
be_else.36460:
    store   $f10, [$i16 + 2]
    load    [$i15 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
be_cont.36460:
be_cont.36456:
    load    [$i15 + 2], $f10
    bne     $f10, $f0, be_else.36461
be_then.36461:
    store   $f0, [$i16 + 5]
.count storer
    add     $i12, $i11, $tmp
    store   $i16, [$tmp + 0]
    sub     $i11, 1, $i3
.count move_args
    mov     $i10, $i2
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36450
be_else.36461:
    load    [$i13 + 6], $i17
    load    [$i13 + 4], $i18
    bg      $f0, $f10, ble_else.36462
ble_then.36462:
    li      0, $i19
.count b_cont
    b       ble_cont.36462
ble_else.36462:
    li      1, $i19
ble_cont.36462:
    bne     $i17, 0, be_else.36463
be_then.36463:
    mov     $i19, $i17
.count b_cont
    b       be_cont.36463
be_else.36463:
    bne     $i19, 0, be_else.36464
be_then.36464:
    li      1, $i17
.count b_cont
    b       be_cont.36464
be_else.36464:
    li      0, $i17
be_cont.36464:
be_cont.36463:
    load    [$i18 + 2], $f10
.count move_args
    mov     $i10, $i2
    sub     $i11, 1, $i3
.count storer
    add     $i12, $i11, $tmp
    bne     $i17, 0, be_else.36465
be_then.36465:
    fneg    $f10, $f10
    store   $f10, [$i16 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36450
be_else.36465:
    store   $f10, [$i16 + 4]
    load    [$i15 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36450
be_else.36450:
    bne     $i14, 2, be_else.36466      # |          1 |          1 |
be_then.36466:
    li      4, $i2                      # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    load    [$i13 + 4], $i17            # |          1 |          1 |
    load    [$i13 + 4], $i18            # |          1 |          1 |
    load    [$i13 + 4], $i19            # |          1 |          1 |
    load    [$i15 + 0], $f10            # |          1 |          1 |
    load    [$i17 + 0], $f11            # |          1 |          1 |
    fmul    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i15 + 1], $f11            # |          1 |          1 |
    load    [$i18 + 1], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i15 + 2], $f11            # |          1 |          1 |
    load    [$i19 + 2], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
.count move_args
    mov     $i10, $i2                   # |          1 |          1 |
    sub     $i11, 1, $i3                # |          1 |          1 |
.count storer
    add     $i12, $i11, $tmp            # |          1 |          1 |
    bg      $f10, $f0, ble_else.36467   # |          1 |          1 |
ble_then.36467:
    store   $f0, [$i16 + 0]             # |          1 |          1 |
    store   $i16, [$tmp + 0]            # |          1 |          1 |
    call    iter_setup_dirvec_constants.2826# |          1 |          1 |
.count b_cont
    b       be_cont.36466               # |          1 |          1 |
ble_else.36467:
    finv    $f10, $f10
    fneg    $f10, $f11
    store   $f11, [$i16 + 0]
    load    [$i13 + 4], $i17
    load    [$i17 + 0], $f11
    fmul_n  $f11, $f10, $f11
    store   $f11, [$i16 + 1]
    load    [$i13 + 4], $i17
    load    [$i17 + 1], $f11
    fmul_n  $f11, $f10, $f11
    store   $f11, [$i16 + 2]
    load    [$i13 + 4], $i17
    load    [$i17 + 2], $f11
    fmul_n  $f11, $f10, $f10
    store   $f10, [$i16 + 3]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36466
be_else.36466:
    li      5, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i13 + 3], $i17
    load    [$i13 + 4], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i15 + 0], $f10
    load    [$i15 + 1], $f11
    load    [$i15 + 2], $f12
    fmul    $f10, $f10, $f13
    load    [$i18 + 0], $f14
    fmul    $f13, $f14, $f13
    fmul    $f11, $f11, $f14
    load    [$i19 + 1], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f12, $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    bne     $i17, 0, be_else.36468
be_then.36468:
    mov     $f13, $f10
.count b_cont
    b       be_cont.36468
be_else.36468:
    fmul    $f11, $f12, $f14
    load    [$i13 + 9], $i18
    load    [$i18 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f10, $f12
    load    [$i13 + 9], $i18
    load    [$i18 + 1], $f14
    fmul    $f12, $f14, $f12
    fadd    $f13, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i13 + 9], $i18
    load    [$i18 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.36468:
    store   $f10, [$i16 + 0]
    load    [$i13 + 4], $i18
    load    [$i13 + 4], $i19
    load    [$i13 + 4], $i20
    load    [$i15 + 0], $f11
    load    [$i18 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 1], $f12
    load    [$i19 + 1], $f13
    fmul    $f12, $f13, $f13
    load    [$i15 + 2], $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f15
    fneg    $f11, $f11
    fneg    $f13, $f13
    fneg    $f15, $f15
.count storer
    add     $i12, $i11, $tmp
    sub     $i11, 1, $i3
.count move_args
    mov     $i10, $i2
    bne     $i17, 0, be_else.36469
be_then.36469:
    store   $f11, [$i16 + 1]
    store   $f13, [$i16 + 2]
    store   $f15, [$i16 + 3]
    bne     $f10, $f0, be_else.36470
be_then.36470:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36469
be_else.36470:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36469
be_else.36469:
    load    [$i13 + 9], $i17
    load    [$i13 + 9], $i18
    load    [$i17 + 1], $f16
    fmul    $f14, $f16, $f14
    load    [$i18 + 2], $f17
    fmul    $f12, $f17, $f12
    fadd    $f14, $f12, $f12
    fmul    $f12, $fc3, $f12
    fsub    $f11, $f12, $f11
    store   $f11, [$i16 + 1]
    load    [$i13 + 9], $i17
    load    [$i15 + 2], $f11
    load    [$i17 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f14
    fmul    $f14, $f17, $f14
    fadd    $f11, $f14, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f13, $f11, $f11
    store   $f11, [$i16 + 2]
    load    [$i15 + 1], $f11
    fmul    $f11, $f12, $f11
    load    [$i15 + 0], $f12
    fmul    $f12, $f16, $f12
    fadd    $f11, $f12, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f15, $f11, $f11
    store   $f11, [$i16 + 3]
    bne     $f10, $f0, be_else.36471
be_then.36471:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36471
be_else.36471:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
be_cont.36471:
be_cont.36469:
be_cont.36466:
be_cont.36450:
bge_cont.36449:
    li      118, $i3                    # |          1 |          1 |
.count stack_load
    load    [$sp + 5], $i2              # |          1 |          1 |
    call    init_dirvec_constants.3044  # |          1 |          1 |
.count stack_load
    load    [$sp + 4], $i23             # |          1 |          1 |
    sub     $i23, 1, $i23               # |          1 |          1 |
    bl      $i23, 0, bge_else.36472     # |          1 |          1 |
bge_then.36472:
    load    [min_caml_dirvecs + $i23], $i2# |          1 |          1 |
    li      119, $i3                    # |          1 |          1 |
    call    init_dirvec_constants.3044  # |          1 |          1 |
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 6, $sp                 # |          1 |          1 |
    sub     $i23, 1, $i2                # |          1 |          1 |
    b       init_vecset_constants.3047  # |          1 |          1 |
bge_else.36472:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 6, $sp
    ret
bge_else.36448:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 6, $sp
    ret
bge_else.36424:
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 6, $sp
    ret
bge_else.36377:
    ret                                 # |          1 |          1 |
.end init_vecset_constants

######################################################################
# setup_reflections
######################################################################
.begin setup_reflections
setup_reflections.3064:
    bl      $i2, 0, bge_else.36473      # |          1 |          1 |
bge_then.36473:
    load    [min_caml_objects + $i2], $i10# |          1 |          1 |
    load    [$i10 + 2], $i11            # |          1 |          1 |
    bne     $i11, 2, be_else.36474      # |          1 |          1 |
be_then.36474:
    load    [$i10 + 7], $i11            # |          1 |          1 |
    load    [$i11 + 0], $f1             # |          1 |          1 |
    bg      $fc0, $f1, ble_else.36475   # |          1 |          1 |
ble_then.36475:
    ret
ble_else.36475:
    load    [$i10 + 1], $i11            # |          1 |          1 |
    bne     $i11, 1, be_else.36476      # |          1 |          1 |
be_then.36476:
.count stack_move
    sub     $sp, 14, $sp
.count stack_store
    store   $ra, [$sp + 0]
.count stack_store
    store   $i2, [$sp + 1]
    load    [$i10 + 7], $i10
.count stack_store
    store   $i10, [$sp + 2]
    li      3, $i2
.count move_args
    mov     $f0, $f2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i10
    mov     $i10, $i3
.count stack_store
    store   $i3, [$sp + 3]
.count move_args
    mov     $ig0, $i2
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i16
.count stack_load
    load    [$sp + 3], $i17
    store   $fg12, [$i17 + 0]
    fneg    $fg13, $f10
    store   $f10, [$i17 + 1]
    fneg    $fg14, $f11
    store   $f11, [$i17 + 2]
    sub     $ig0, 1, $i3
    mov     $hp, $i2
.count stack_store
    store   $i2, [$sp + 4]
    add     $hp, 2, $hp
    store   $i16, [$i2 + 1]
    store   $i17, [$i2 + 0]
    call    iter_setup_dirvec_constants.2826
.count stack_load
    load    [$sp + 1], $i10
    add     $i10, $i10, $i10
    add     $i10, $i10, $i10
.count stack_store
    store   $i10, [$sp + 5]
    add     $i10, 1, $i10
.count stack_load
    load    [$sp + 2], $i11
    load    [$i11 + 0], $f1
    fsub    $fc0, $f1, $f1
.count stack_store
    store   $f1, [$sp + 6]
    mov     $hp, $i11
    add     $hp, 3, $hp
    store   $f1, [$i11 + 2]
.count stack_load
    load    [$sp + 4], $i12
    store   $i12, [$i11 + 1]
    store   $i10, [$i11 + 0]
    store   $i11, [min_caml_reflections + $ig6]
    li      3, $i2
.count move_args
    mov     $f0, $f2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i3
.count stack_store
    store   $i3, [$sp + 7]
.count move_args
    mov     $ig0, $i2
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i16
    fneg    $fg12, $f12
.count stack_load
    load    [$sp + 7], $i17
    store   $f12, [$i17 + 0]
    store   $fg13, [$i17 + 1]
    store   $f11, [$i17 + 2]
    sub     $ig0, 1, $i3
    mov     $hp, $i2
.count stack_store
    store   $i2, [$sp + 8]
    add     $hp, 2, $hp
    store   $i16, [$i2 + 1]
    store   $i17, [$i2 + 0]
    call    iter_setup_dirvec_constants.2826
    add     $ig6, 1, $i10
.count stack_load
    load    [$sp + 5], $i11
    add     $i11, 2, $i11
    mov     $hp, $i12
    add     $hp, 3, $hp
.count stack_load
    load    [$sp + 6], $i13
    store   $i13, [$i12 + 2]
.count stack_load
    load    [$sp + 8], $i13
    store   $i13, [$i12 + 1]
    store   $i11, [$i12 + 0]
    store   $i12, [min_caml_reflections + $i10]
    li      3, $i2
.count move_args
    mov     $f0, $f2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i3
.count stack_store
    store   $i3, [$sp + 9]
.count move_args
    mov     $ig0, $i2
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i16
.count stack_load
    load    [$sp + 9], $i17
    store   $f12, [$i17 + 0]
    store   $f10, [$i17 + 1]
    store   $fg14, [$i17 + 2]
    sub     $ig0, 1, $i3
    mov     $hp, $i2
.count stack_store
    store   $i2, [$sp + 10]
    add     $hp, 2, $hp
    store   $i16, [$i2 + 1]
    store   $i17, [$i2 + 0]
    call    iter_setup_dirvec_constants.2826
.count stack_load
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 14, $sp
    add     $ig6, 2, $i1
.count stack_load
    load    [$sp - 9], $i2
    add     $i2, 3, $i2
    mov     $hp, $i3
    add     $hp, 3, $hp
.count stack_load
    load    [$sp - 8], $i4
    store   $i4, [$i3 + 2]
.count stack_load
    load    [$sp - 4], $i4
    store   $i4, [$i3 + 1]
    store   $i2, [$i3 + 0]
    store   $i3, [min_caml_reflections + $i1]
    add     $ig6, 3, $ig6
    ret
be_else.36476:
    bne     $i11, 2, be_else.36477      # |          1 |          1 |
be_then.36477:
.count stack_move
    sub     $sp, 14, $sp                # |          1 |          1 |
.count stack_store
    store   $ra, [$sp + 0]              # |          1 |          1 |
.count stack_store
    store   $f1, [$sp + 11]             # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 1]              # |          1 |          1 |
    load    [$i10 + 4], $i11            # |          1 |          1 |
    load    [$i10 + 4], $i10            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    mov     $i12, $i3                   # |          1 |          1 |
.count stack_store
    store   $i3, [$sp + 12]             # |          1 |          1 |
.count move_args
    mov     $ig0, $i2                   # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    load    [$i11 + 0], $f10            # |          1 |          1 |
    fmul    $fc10, $f10, $f11           # |          1 |          1 |
    fmul    $fg12, $f10, $f10           # |          1 |          1 |
    load    [$i10 + 1], $f12            # |          1 |          1 |
    fmul    $fg13, $f12, $f13           # |          1 |          1 |
    fadd    $f10, $f13, $f10            # |          1 |          1 |
    load    [$i10 + 2], $f13            # |          1 |          1 |
    fmul    $fg14, $f13, $f14           # |          1 |          1 |
    fadd    $f10, $f14, $f10            # |          1 |          1 |
    fmul    $f11, $f10, $f11            # |          1 |          1 |
    fsub    $f11, $fg12, $f11           # |          1 |          1 |
.count stack_load
    load    [$sp + 12], $i17            # |          1 |          1 |
    store   $f11, [$i17 + 0]            # |          1 |          1 |
    fmul    $fc10, $f12, $f11           # |          1 |          1 |
    fmul    $f11, $f10, $f11            # |          1 |          1 |
    fsub    $f11, $fg13, $f11           # |          1 |          1 |
    store   $f11, [$i17 + 1]            # |          1 |          1 |
    fmul    $fc10, $f13, $f11           # |          1 |          1 |
    fmul    $f11, $f10, $f10            # |          1 |          1 |
    fsub    $f10, $fg14, $f10           # |          1 |          1 |
    store   $f10, [$i17 + 2]            # |          1 |          1 |
    sub     $ig0, 1, $i3                # |          1 |          1 |
    mov     $hp, $i2                    # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 13]             # |          1 |          1 |
    add     $hp, 2, $hp                 # |          1 |          1 |
    store   $i16, [$i2 + 1]             # |          1 |          1 |
    store   $i17, [$i2 + 0]             # |          1 |          1 |
    call    iter_setup_dirvec_constants.2826# |          1 |          1 |
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 14, $sp                # |          1 |          1 |
.count stack_load
    load    [$sp - 3], $f1              # |          1 |          1 |
    fsub    $fc0, $f1, $f1              # |          1 |          1 |
.count stack_load
    load    [$sp - 13], $i1             # |          1 |          1 |
    add     $i1, $i1, $i1               # |          1 |          1 |
    add     $i1, $i1, $i1               # |          1 |          1 |
    add     $i1, 1, $i1                 # |          1 |          1 |
    mov     $hp, $i2                    # |          1 |          1 |
    add     $hp, 3, $hp                 # |          1 |          1 |
    store   $f1, [$i2 + 2]              # |          1 |          1 |
.count stack_load
    load    [$sp - 1], $i3              # |          1 |          1 |
    store   $i3, [$i2 + 1]              # |          1 |          1 |
    store   $i1, [$i2 + 0]              # |          1 |          1 |
    store   $i2, [min_caml_reflections + $ig6]# |          1 |          1 |
    add     $ig6, 1, $ig6               # |          1 |          1 |
    ret                                 # |          1 |          1 |
be_else.36477:
    ret
be_else.36474:
    ret
bge_else.36473:
    ret
.end setup_reflections

######################################################################
# main
######################################################################
.begin main
min_caml_main:
.count stack_move
    sub     $sp, 18, $sp                # |          1 |          1 |
.count stack_store
    store   $ra, [$sp + 0]              # |          1 |          1 |
    load    [min_caml_n_objects + 0], $ig0# |          1 |          1 |
    load    [min_caml_solver_dist + 0], $fg0# |          1 |          1 |
    load    [min_caml_diffuse_ray + 0], $fg1# |          1 |          1 |
    load    [min_caml_diffuse_ray + 1], $fg2# |          1 |          1 |
    load    [min_caml_diffuse_ray + 2], $fg3# |          1 |          1 |
    load    [min_caml_rgb + 0], $fg4    # |          1 |          1 |
    load    [min_caml_rgb + 1], $fg5    # |          1 |          1 |
    load    [min_caml_rgb + 2], $fg6    # |          1 |          1 |
    load    [min_caml_tmin + 0], $fg7   # |          1 |          1 |
    load    [min_caml_image_size + 0], $ig1# |          1 |          1 |
    load    [min_caml_startp_fast + 0], $fg8# |          1 |          1 |
    load    [min_caml_startp_fast + 1], $fg9# |          1 |          1 |
    load    [min_caml_startp_fast + 2], $fg10# |          1 |          1 |
    load    [min_caml_texture_color + 1], $fg11# |          1 |          1 |
    load    [min_caml_light + 0], $fg12 # |          1 |          1 |
    load    [min_caml_light + 1], $fg13 # |          1 |          1 |
    load    [min_caml_light + 2], $fg14 # |          1 |          1 |
    load    [min_caml_texture_color + 2], $fg15# |          1 |          1 |
    load    [min_caml_or_net + 0], $ig2 # |          1 |          1 |
    load    [min_caml_image_size + 1], $ig3# |          1 |          1 |
    load    [min_caml_intsec_rectside + 0], $ig4# |          1 |          1 |
    load    [min_caml_texture_color + 0], $fg16# |          1 |          1 |
    load    [min_caml_intersected_object_id + 0], $ig5# |          1 |          1 |
    load    [min_caml_n_reflections + 0], $ig6# |          1 |          1 |
    load    [min_caml_scan_pitch + 0], $fg17# |          1 |          1 |
    load    [min_caml_screenz_dir + 0], $fg18# |          1 |          1 |
    load    [min_caml_screenz_dir + 1], $fg19# |          1 |          1 |
    load    [min_caml_screenz_dir + 2], $fg20# |          1 |          1 |
    load    [min_caml_startp + 0], $fg21# |          1 |          1 |
    load    [min_caml_startp + 1], $fg22# |          1 |          1 |
    load    [min_caml_startp + 2], $fg23# |          1 |          1 |
    load    [min_caml_image_center + 1], $ig7# |          1 |          1 |
    load    [min_caml_screeny_dir + 0], $fg24# |          1 |          1 |
    load    [min_caml_image_center + 0], $ig8# |          1 |          1 |
    load    [f.31950 + 0], $fc0         # |          1 |          1 |
    load    [f.31974 + 0], $fc1         # |          1 |          1 |
    load    [f.31973 + 0], $fc2         # |          1 |          1 |
    load    [f.31951 + 0], $fc3         # |          1 |          1 |
    load    [f.31949 + 0], $fc4         # |          1 |          1 |
    load    [f.31976 + 0], $fc5         # |          1 |          1 |
    load    [f.31975 + 0], $fc6         # |          1 |          1 |
    load    [f.31954 + 0], $fc7         # |          1 |          1 |
    load    [f.31963 + 0], $fc8         # |          1 |          1 |
    load    [f.31961 + 0], $fc9         # |          1 |          1 |
    load    [f.31948 + 0], $fc10        # |          1 |          1 |
    load    [f.32005 + 0], $fc11        # |          1 |          1 |
    load    [f.32004 + 0], $fc12        # |          1 |          1 |
    load    [f.31969 + 0], $fc13        # |          1 |          1 |
    load    [f.31968 + 0], $fc14        # |          1 |          1 |
    load    [f.31958 + 0], $fc15        # |          1 |          1 |
    load    [f.31953 + 0], $fc16        # |          1 |          1 |
    load    [f.31959 + 0], $fc17        # |          1 |          1 |
    load    [f.31957 + 0], $fc18        # |          1 |          1 |
    load    [f.31956 + 0], $fc19        # |          1 |          1 |
    li      128, $i2                    # |          1 |          1 |
    mov     $i2, $ig1                   # |          1 |          1 |
    li      128, $ig3                   # |          1 |          1 |
    li      64, $ig8                    # |          1 |          1 |
    li      64, $ig7                    # |          1 |          1 |
.count load_float
    load    [f.32067], $f10             # |          1 |          1 |
    call    min_caml_float_of_int       # |          1 |          1 |
    finv    $f1, $f1                    # |          1 |          1 |
    fmul    $f10, $f1, $fg17            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i3                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 4]            # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i13                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i3                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i14                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 4]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i3                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 4]            # |          1 |          1 |
    li      1, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i3                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i17                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 4]            # |          1 |          1 |
    mov     $hp, $i3                    # |          1 |          1 |
    add     $hp, 8, $hp                 # |          1 |          1 |
    store   $i17, [$i3 + 7]             # |          1 |          1 |
    store   $i16, [$i3 + 6]             # |          1 |          1 |
    store   $i15, [$i3 + 5]             # |          1 |          1 |
    store   $i14, [$i3 + 4]             # |          1 |          1 |
    store   $i13, [$i3 + 3]             # |          1 |          1 |
    store   $i12, [$i3 + 2]             # |          1 |          1 |
    store   $i11, [$i3 + 1]             # |          1 |          1 |
    store   $i10, [$i3 + 0]             # |          1 |          1 |
.count move_args
    mov     $ig1, $i2                   # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i19                   # |          1 |          1 |
    sub     $ig1, 2, $i20               # |          1 |          1 |
    bl      $i20, 0, bge_else.36478     # |          1 |          1 |
bge_then.36478:
    call    create_pixel.3008           # |          1 |          1 |
.count move_ret
    mov     $i1, $i22                   # |          1 |          1 |
.count storer
    add     $i19, $i20, $tmp            # |          1 |          1 |
    store   $i22, [$tmp + 0]            # |          1 |          1 |
    sub     $i20, 1, $i3                # |          1 |          1 |
.count move_args
    mov     $i19, $i2                   # |          1 |          1 |
    call    init_line_elements.3010     # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count b_cont
    b       bge_cont.36478              # |          1 |          1 |
bge_else.36478:
    mov     $i19, $i10
bge_cont.36478:
.count stack_store
    store   $i10, [$sp + 1]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i3                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 4]            # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i13                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i3                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i14                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 4]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i3                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 4]            # |          1 |          1 |
    li      1, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i3                    # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i17                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 4]            # |          1 |          1 |
    mov     $hp, $i3                    # |          1 |          1 |
    add     $hp, 8, $hp                 # |          1 |          1 |
    store   $i17, [$i3 + 7]             # |          1 |          1 |
    store   $i16, [$i3 + 6]             # |          1 |          1 |
    store   $i15, [$i3 + 5]             # |          1 |          1 |
    store   $i14, [$i3 + 4]             # |          1 |          1 |
    store   $i13, [$i3 + 3]             # |          1 |          1 |
    store   $i12, [$i3 + 2]             # |          1 |          1 |
    store   $i11, [$i3 + 1]             # |          1 |          1 |
    store   $i10, [$i3 + 0]             # |          1 |          1 |
.count move_args
    mov     $ig1, $i2                   # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i19                   # |          1 |          1 |
    sub     $ig1, 2, $i20               # |          1 |          1 |
    bl      $i20, 0, bge_else.36479     # |          1 |          1 |
bge_then.36479:
    call    create_pixel.3008           # |          1 |          1 |
.count move_ret
    mov     $i1, $i22                   # |          1 |          1 |
.count storer
    add     $i19, $i20, $tmp            # |          1 |          1 |
    store   $i22, [$tmp + 0]            # |          1 |          1 |
    sub     $i20, 1, $i3                # |          1 |          1 |
.count move_args
    mov     $i19, $i2                   # |          1 |          1 |
    call    init_line_elements.3010     # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count b_cont
    b       bge_cont.36479              # |          1 |          1 |
bge_else.36479:
    mov     $i19, $i10
bge_cont.36479:
.count stack_store
    store   $i10, [$sp + 2]             # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    mov     $i11, $i3                   # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    store   $i12, [$i11 + 4]            # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i13                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i14                   # |          1 |          1 |
    mov     $i14, $i3                   # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i14                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    store   $i15, [$i14 + 4]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    mov     $i15, $i3                   # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i15                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    store   $i16, [$i15 + 4]            # |          1 |          1 |
    li      1, $i2                      # |          1 |          1 |
    li      0, $i3                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i17                   # |          1 |          1 |
    mov     $i17, $i3                   # |          1 |          1 |
    li      5, $i2                      # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i17                   # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 1]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 2]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 3]            # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
    store   $i18, [$i17 + 4]            # |          1 |          1 |
    mov     $hp, $i3                    # |          1 |          1 |
    add     $hp, 8, $hp                 # |          1 |          1 |
    store   $i17, [$i3 + 7]             # |          1 |          1 |
    store   $i16, [$i3 + 6]             # |          1 |          1 |
    store   $i15, [$i3 + 5]             # |          1 |          1 |
    store   $i14, [$i3 + 4]             # |          1 |          1 |
    store   $i13, [$i3 + 3]             # |          1 |          1 |
    store   $i12, [$i3 + 2]             # |          1 |          1 |
    store   $i11, [$i3 + 1]             # |          1 |          1 |
    store   $i10, [$i3 + 0]             # |          1 |          1 |
.count move_args
    mov     $ig1, $i2                   # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i19                   # |          1 |          1 |
    sub     $ig1, 2, $i20               # |          1 |          1 |
    bl      $i20, 0, bge_else.36480     # |          1 |          1 |
bge_then.36480:
    call    create_pixel.3008           # |          1 |          1 |
.count move_ret
    mov     $i1, $i22                   # |          1 |          1 |
.count storer
    add     $i19, $i20, $tmp            # |          1 |          1 |
    store   $i22, [$tmp + 0]            # |          1 |          1 |
    sub     $i20, 1, $i3                # |          1 |          1 |
.count move_args
    mov     $i19, $i2                   # |          1 |          1 |
    call    init_line_elements.3010     # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count b_cont
    b       bge_cont.36480              # |          1 |          1 |
bge_else.36480:
    mov     $i19, $i10
bge_cont.36480:
.count stack_store
    store   $i10, [$sp + 3]             # |          1 |          1 |
    call    min_caml_read_float         # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    store   $f10, [min_caml_screen + 0] # |          1 |          1 |
    call    min_caml_read_float         # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    store   $f10, [min_caml_screen + 1] # |          1 |          1 |
    call    min_caml_read_float         # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    store   $f10, [min_caml_screen + 2] # |          1 |          1 |
    call    min_caml_read_float         # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
.count load_float
    load    [f.31935], $f11             # |          1 |          1 |
    fmul    $f10, $f11, $f2             # |          1 |          1 |
.count stack_store
    store   $f2, [$sp + 4]              # |          1 |          1 |
    call    min_caml_cos                # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
.count stack_load
    load    [$sp + 4], $f2              # |          1 |          1 |
    call    min_caml_sin                # |          1 |          1 |
.count move_ret
    mov     $f1, $f12                   # |          1 |          1 |
    call    min_caml_read_float         # |          1 |          1 |
.count move_ret
    mov     $f1, $f13                   # |          1 |          1 |
    fmul    $f13, $f11, $f2             # |          1 |          1 |
.count stack_store
    store   $f2, [$sp + 5]              # |          1 |          1 |
    call    min_caml_cos                # |          1 |          1 |
.count move_ret
    mov     $f1, $f13                   # |          1 |          1 |
.count stack_load
    load    [$sp + 5], $f2              # |          1 |          1 |
    call    min_caml_sin                # |          1 |          1 |
    fmul    $f10, $f1, $f14             # |          1 |          1 |
.count load_float
    load    [f.32095], $f15             # |          1 |          1 |
    fmul    $f14, $f15, $fg18           # |          1 |          1 |
.count load_float
    load    [f.32096], $f14             # |          1 |          1 |
    fmul    $f12, $f14, $fg19           # |          1 |          1 |
    fmul    $f10, $f13, $f14            # |          1 |          1 |
    fmul    $f14, $f15, $fg20           # |          1 |          1 |
    store   $f13, [min_caml_screenx_dir + 0]# |          1 |          1 |
    store   $f0, [min_caml_screenx_dir + 1]# |          1 |          1 |
    fneg    $f1, $f14                   # |          1 |          1 |
    store   $f14, [min_caml_screenx_dir + 2]# |          1 |          1 |
    fneg    $f12, $f12                  # |          1 |          1 |
    fmul    $f12, $f1, $fg24            # |          1 |          1 |
    fneg    $f10, $f1                   # |          1 |          1 |
    store   $f1, [min_caml_screeny_dir + 1]# |          1 |          1 |
    fmul    $f12, $f13, $f1             # |          1 |          1 |
    store   $f1, [min_caml_screeny_dir + 2]# |          1 |          1 |
    load    [min_caml_screen + 0], $f1  # |          1 |          1 |
    fsub    $f1, $fg18, $f1             # |          1 |          1 |
    store   $f1, [min_caml_viewpoint + 0]# |          1 |          1 |
    load    [min_caml_screen + 1], $f1  # |          1 |          1 |
    fsub    $f1, $fg19, $f1             # |          1 |          1 |
    store   $f1, [min_caml_viewpoint + 1]# |          1 |          1 |
    load    [min_caml_screen + 2], $f1  # |          1 |          1 |
    fsub    $f1, $fg20, $f1             # |          1 |          1 |
    store   $f1, [min_caml_viewpoint + 2]# |          1 |          1 |
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    call    min_caml_read_float         # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    fmul    $f10, $f11, $f2             # |          1 |          1 |
.count stack_store
    store   $f2, [$sp + 6]              # |          1 |          1 |
    call    min_caml_sin                # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    fneg    $f10, $fg13                 # |          1 |          1 |
    call    min_caml_read_float         # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
.count stack_load
    load    [$sp + 6], $f2              # |          1 |          1 |
    call    min_caml_cos                # |          1 |          1 |
.count move_ret
    mov     $f1, $f12                   # |          1 |          1 |
    fmul    $f10, $f11, $f2             # |          1 |          1 |
.count stack_store
    store   $f2, [$sp + 7]              # |          1 |          1 |
    call    min_caml_sin                # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    fmul    $f12, $f10, $fg12           # |          1 |          1 |
.count stack_load
    load    [$sp + 7], $f2              # |          1 |          1 |
    call    min_caml_cos                # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    fmul    $f12, $f10, $fg14           # |          1 |          1 |
    call    min_caml_read_float         # |          1 |          1 |
.count move_ret
    mov     $f1, $f18                   # |          1 |          1 |
    store   $f18, [min_caml_beam + 0]   # |          1 |          1 |
    li      0, $i2                      # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 8]              # |          1 |          1 |
    call    read_nth_object.2719        # |          1 |          1 |
.count move_ret
    mov     $i1, $i22                   # |          1 |          1 |
    bne     $i22, 0, be_else.36481      # |          1 |          1 |
be_then.36481:
.count stack_load
    load    [$sp + 8], $i10
    mov     $i10, $ig0
.count b_cont
    b       be_cont.36481
be_else.36481:
    li      1, $i2                      # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 9]              # |          1 |          1 |
    call    read_nth_object.2719        # |          1 |          1 |
.count move_ret
    mov     $i1, $i22                   # |          1 |          1 |
    bne     $i22, 0, be_else.36482      # |          1 |          1 |
be_then.36482:
.count stack_load
    load    [$sp + 9], $i10
    mov     $i10, $ig0
.count b_cont
    b       be_cont.36482
be_else.36482:
    li      2, $i2                      # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 10]             # |          1 |          1 |
    call    read_nth_object.2719        # |          1 |          1 |
.count move_ret
    mov     $i1, $i22                   # |          1 |          1 |
    bne     $i22, 0, be_else.36483      # |          1 |          1 |
be_then.36483:
.count stack_load
    load    [$sp + 10], $i10
    mov     $i10, $ig0
.count b_cont
    b       be_cont.36483
be_else.36483:
    li      3, $i2                      # |          1 |          1 |
.count stack_store
    store   $i2, [$sp + 11]             # |          1 |          1 |
    call    read_nth_object.2719        # |          1 |          1 |
.count move_ret
    mov     $i1, $i23                   # |          1 |          1 |
    bne     $i23, 0, be_else.36484      # |          1 |          1 |
be_then.36484:
.count stack_load
    load    [$sp + 11], $i10
    mov     $i10, $ig0
.count b_cont
    b       be_cont.36484
be_else.36484:
    li      4, $i2                      # |          1 |          1 |
    call    read_object.2721            # |          1 |          1 |
be_cont.36484:
be_cont.36483:
be_cont.36482:
be_cont.36481:
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    bne     $i10, -1, be_else.36485     # |          1 |          1 |
be_then.36485:
    li      1, $i2
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i18
.count b_cont
    b       be_cont.36485
be_else.36485:
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    li      2, $i2                      # |          1 |          1 |
    bne     $i11, -1, be_else.36486     # |          1 |          1 |
be_then.36486:
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i18
    store   $i10, [$i18 + 0]
.count b_cont
    b       be_cont.36486
be_else.36486:
.count stack_store
    store   $i10, [$sp + 12]            # |          1 |          1 |
.count stack_store
    store   $i11, [$sp + 13]            # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
.count move_ret
    mov     $i1, $i18                   # |          1 |          1 |
.count stack_load
    load    [$sp + 13], $i19            # |          1 |          1 |
    store   $i19, [$i18 + 1]            # |          1 |          1 |
.count stack_load
    load    [$sp + 12], $i19            # |          1 |          1 |
    store   $i19, [$i18 + 0]            # |          1 |          1 |
be_cont.36486:
be_cont.36485:
    load    [$i18 + 0], $i19            # |          1 |          1 |
    be      $i19, -1, bne_cont.36487    # |          1 |          1 |
bne_then.36487:
    store   $i18, [min_caml_and_net + 0]# |          1 |          1 |
    li      1, $i2                      # |          1 |          1 |
    call    read_and_network.2729       # |          1 |          1 |
bne_cont.36487:
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    bne     $i10, -1, be_else.36488     # |          1 |          1 |
be_then.36488:
    li      1, $i2
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i10
.count b_cont
    b       be_cont.36488
be_else.36488:
    call    min_caml_read_int           # |          1 |          1 |
.count move_ret
    mov     $i1, $i11                   # |          1 |          1 |
    li      2, $i2                      # |          1 |          1 |
    bne     $i11, -1, be_else.36489     # |          1 |          1 |
be_then.36489:
    add     $i0, -1, $i3
    call    min_caml_create_array_int
.count move_ret
    mov     $i1, $i11
    store   $i10, [$i11 + 0]
    mov     $i11, $i10
.count b_cont
    b       be_cont.36489
be_else.36489:
.count stack_store
    store   $i10, [$sp + 14]            # |          1 |          1 |
.count stack_store
    store   $i11, [$sp + 15]            # |          1 |          1 |
    call    read_net_item.2725          # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
.count stack_load
    load    [$sp + 15], $i11            # |          1 |          1 |
    store   $i11, [$i10 + 1]            # |          1 |          1 |
.count stack_load
    load    [$sp + 14], $i11            # |          1 |          1 |
    store   $i11, [$i10 + 0]            # |          1 |          1 |
be_cont.36489:
be_cont.36488:
    mov     $i10, $i3                   # |          1 |          1 |
    load    [$i3 + 0], $i10             # |          1 |          1 |
    li      1, $i2                      # |          1 |          1 |
    bne     $i10, -1, be_else.36490     # |          1 |          1 |
be_then.36490:
    call    min_caml_create_array_int
.count b_cont
    b       be_cont.36490
be_else.36490:
.count stack_store
    store   $i3, [$sp + 16]             # |          1 |          1 |
    call    read_or_network.2727        # |          1 |          1 |
.count stack_load
    load    [$sp + 16], $i10            # |          1 |          1 |
    store   $i10, [$i1 + 0]             # |          1 |          1 |
be_cont.36490:
    mov     $i1, $ig2                   # |          1 |          1 |
    li      80, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      54, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      10, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      49, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      50, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      56, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      32, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      49, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      50, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      56, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      32, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      50, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      53, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      53, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      10, $i2                     # |          1 |          1 |
    call    min_caml_write              # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    mov     $i10, $i3                   # |          1 |          1 |
.count stack_store
    store   $i3, [$sp + 17]             # |          1 |          1 |
.count move_args
    mov     $ig0, $i2                   # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i10                   # |          1 |          1 |
    li      120, $i2                    # |          1 |          1 |
    mov     $hp, $i3                    # |          1 |          1 |
    add     $hp, 2, $hp                 # |          1 |          1 |
    store   $i10, [$i3 + 1]             # |          1 |          1 |
.count stack_load
    load    [$sp + 17], $i10            # |          1 |          1 |
    store   $i10, [$i3 + 0]             # |          1 |          1 |
    call    min_caml_create_array_int   # |          1 |          1 |
.count move_ret
    mov     $i1, $i14                   # |          1 |          1 |
    store   $i14, [min_caml_dirvecs + 4]# |          1 |          1 |
    load    [min_caml_dirvecs + 4], $i2 # |          1 |          1 |
    li      118, $i3                    # |          1 |          1 |
    call    create_dirvec_elements.3039 # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
    call    create_dirvecs.3042         # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    li      0, $i10                     # |          1 |          1 |
    li      4, $i11                     # |          1 |          1 |
    li      9, $i2                      # |          1 |          1 |
    call    min_caml_float_of_int       # |          1 |          1 |
.count move_ret
    mov     $f1, $f16                   # |          1 |          1 |
    fmul    $f16, $fc12, $f16           # |          1 |          1 |
    fsub    $f16, $fc11, $f2            # |          1 |          1 |
.count move_args
    mov     $i11, $i2                   # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
.count move_args
    mov     $i10, $i4                   # |          1 |          1 |
    call    calc_dirvecs.3028           # |          1 |          1 |
    li      8, $i2                      # |          1 |          1 |
    li      2, $i3                      # |          1 |          1 |
    li      4, $i4                      # |          1 |          1 |
    call    calc_dirvec_rows.3033       # |          1 |          1 |
    load    [min_caml_dirvecs + 4], $i2 # |          1 |          1 |
    li      119, $i3                    # |          1 |          1 |
    call    init_dirvec_constants.3044  # |          1 |          1 |
    li      3, $i2                      # |          1 |          1 |
    call    init_vecset_constants.3047  # |          1 |          1 |
    li      min_caml_light_dirvec, $i10 # |          1 |          1 |
    load    [min_caml_light_dirvec + 0], $i11# |          1 |          1 |
    store   $fg12, [$i11 + 0]           # |          1 |          1 |
    store   $fg13, [$i11 + 1]           # |          1 |          1 |
    store   $fg14, [$i11 + 2]           # |          1 |          1 |
    sub     $ig0, 1, $i12               # |          1 |          1 |
    bl      $i12, 0, bge_cont.36491     # |          1 |          1 |
bge_then.36491:
    load    [min_caml_light_dirvec + 1], $i13# |          1 |          1 |
    load    [min_caml_objects + $i12], $i14# |          1 |          1 |
    load    [$i14 + 1], $i15            # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
    bne     $i15, 1, be_else.36492      # |          1 |          1 |
be_then.36492:
    li      6, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i11 + 0], $f10
    bne     $f10, $f0, be_else.36493
be_then.36493:
    store   $f0, [$i16 + 1]
.count b_cont
    b       be_cont.36493
be_else.36493:
    load    [$i14 + 6], $i17
    bg      $f0, $f10, ble_else.36494
ble_then.36494:
    li      0, $i18
.count b_cont
    b       ble_cont.36494
ble_else.36494:
    li      1, $i18
ble_cont.36494:
    bne     $i17, 0, be_else.36495
be_then.36495:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36495
be_else.36495:
    bne     $i18, 0, be_else.36496
be_then.36496:
    li      1, $i17
.count b_cont
    b       be_cont.36496
be_else.36496:
    li      0, $i17
be_cont.36496:
be_cont.36495:
    load    [$i14 + 4], $i18
    load    [$i18 + 0], $f10
    bne     $i17, 0, be_else.36497
be_then.36497:
    fneg    $f10, $f10
    store   $f10, [$i16 + 0]
    load    [$i11 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
.count b_cont
    b       be_cont.36497
be_else.36497:
    store   $f10, [$i16 + 0]
    load    [$i11 + 0], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 1]
be_cont.36497:
be_cont.36493:
    load    [$i11 + 1], $f10
    bne     $f10, $f0, be_else.36498
be_then.36498:
    store   $f0, [$i16 + 3]
.count b_cont
    b       be_cont.36498
be_else.36498:
    load    [$i14 + 6], $i17
    bg      $f0, $f10, ble_else.36499
ble_then.36499:
    li      0, $i18
.count b_cont
    b       ble_cont.36499
ble_else.36499:
    li      1, $i18
ble_cont.36499:
    bne     $i17, 0, be_else.36500
be_then.36500:
    mov     $i18, $i17
.count b_cont
    b       be_cont.36500
be_else.36500:
    bne     $i18, 0, be_else.36501
be_then.36501:
    li      1, $i17
.count b_cont
    b       be_cont.36501
be_else.36501:
    li      0, $i17
be_cont.36501:
be_cont.36500:
    load    [$i14 + 4], $i18
    load    [$i18 + 1], $f10
    bne     $i17, 0, be_else.36502
be_then.36502:
    fneg    $f10, $f10
    store   $f10, [$i16 + 2]
    load    [$i11 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
.count b_cont
    b       be_cont.36502
be_else.36502:
    store   $f10, [$i16 + 2]
    load    [$i11 + 1], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 3]
be_cont.36502:
be_cont.36498:
    load    [$i11 + 2], $f10
    bne     $f10, $f0, be_else.36503
be_then.36503:
    store   $f0, [$i16 + 5]
.count storer
    add     $i13, $i12, $tmp
    store   $i16, [$tmp + 0]
    sub     $i12, 1, $i3
.count move_args
    mov     $i10, $i2
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36492
be_else.36503:
    load    [$i14 + 6], $i17
    load    [$i14 + 4], $i18
    bg      $f0, $f10, ble_else.36504
ble_then.36504:
    li      0, $i19
.count b_cont
    b       ble_cont.36504
ble_else.36504:
    li      1, $i19
ble_cont.36504:
    bne     $i17, 0, be_else.36505
be_then.36505:
    mov     $i19, $i17
.count b_cont
    b       be_cont.36505
be_else.36505:
    bne     $i19, 0, be_else.36506
be_then.36506:
    li      1, $i17
.count b_cont
    b       be_cont.36506
be_else.36506:
    li      0, $i17
be_cont.36506:
be_cont.36505:
    load    [$i18 + 2], $f10
.count move_args
    mov     $i10, $i2
    sub     $i12, 1, $i3
.count storer
    add     $i13, $i12, $tmp
    bne     $i17, 0, be_else.36507
be_then.36507:
    fneg    $f10, $f10
    store   $f10, [$i16 + 4]
    load    [$i11 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36492
be_else.36507:
    store   $f10, [$i16 + 4]
    load    [$i11 + 2], $f10
    finv    $f10, $f10
    store   $f10, [$i16 + 5]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36492
be_else.36492:
    bne     $i15, 2, be_else.36508      # |          1 |          1 |
be_then.36508:
    li      4, $i2                      # |          1 |          1 |
    call    min_caml_create_array_float # |          1 |          1 |
.count move_ret
    mov     $i1, $i16                   # |          1 |          1 |
    load    [$i14 + 4], $i17            # |          1 |          1 |
    load    [$i14 + 4], $i18            # |          1 |          1 |
    load    [$i14 + 4], $i19            # |          1 |          1 |
    load    [$i11 + 0], $f10            # |          1 |          1 |
    load    [$i17 + 0], $f11            # |          1 |          1 |
    fmul    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i11 + 1], $f11            # |          1 |          1 |
    load    [$i18 + 1], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
    load    [$i11 + 2], $f11            # |          1 |          1 |
    load    [$i19 + 2], $f12            # |          1 |          1 |
    fmul    $f11, $f12, $f11            # |          1 |          1 |
    fadd    $f10, $f11, $f10            # |          1 |          1 |
.count move_args
    mov     $i10, $i2                   # |          1 |          1 |
    sub     $i12, 1, $i3                # |          1 |          1 |
.count storer
    add     $i13, $i12, $tmp            # |          1 |          1 |
    bg      $f10, $f0, ble_else.36509   # |          1 |          1 |
ble_then.36509:
    store   $f0, [$i16 + 0]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36508
ble_else.36509:
    finv    $f10, $f10                  # |          1 |          1 |
    fneg    $f10, $f11                  # |          1 |          1 |
    store   $f11, [$i16 + 0]            # |          1 |          1 |
    load    [$i14 + 4], $i17            # |          1 |          1 |
    load    [$i17 + 0], $f11            # |          1 |          1 |
    fmul_n  $f11, $f10, $f11            # |          1 |          1 |
    store   $f11, [$i16 + 1]            # |          1 |          1 |
    load    [$i14 + 4], $i17            # |          1 |          1 |
    load    [$i17 + 1], $f11            # |          1 |          1 |
    fmul_n  $f11, $f10, $f11            # |          1 |          1 |
    store   $f11, [$i16 + 2]            # |          1 |          1 |
    load    [$i14 + 4], $i17            # |          1 |          1 |
    load    [$i17 + 2], $f11            # |          1 |          1 |
    fmul_n  $f11, $f10, $f10            # |          1 |          1 |
    store   $f10, [$i16 + 3]            # |          1 |          1 |
    store   $i16, [$tmp + 0]            # |          1 |          1 |
    call    iter_setup_dirvec_constants.2826# |          1 |          1 |
.count b_cont
    b       be_cont.36508               # |          1 |          1 |
be_else.36508:
    li      5, $i2
    call    min_caml_create_array_float
.count move_ret
    mov     $i1, $i16
    load    [$i14 + 3], $i17
    load    [$i14 + 4], $i18
    load    [$i14 + 4], $i19
    load    [$i14 + 4], $i20
    load    [$i11 + 0], $f10
    load    [$i11 + 1], $f11
    load    [$i11 + 2], $f12
    fmul    $f10, $f10, $f13
    load    [$i18 + 0], $f14
    fmul    $f13, $f14, $f13
    fmul    $f11, $f11, $f14
    load    [$i19 + 1], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f12, $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    bne     $i17, 0, be_else.36510
be_then.36510:
    mov     $f13, $f10
.count b_cont
    b       be_cont.36510
be_else.36510:
    fmul    $f11, $f12, $f14
    load    [$i14 + 9], $i18
    load    [$i18 + 0], $f15
    fmul    $f14, $f15, $f14
    fadd    $f13, $f14, $f13
    fmul    $f12, $f10, $f12
    load    [$i14 + 9], $i18
    load    [$i18 + 1], $f14
    fmul    $f12, $f14, $f12
    fadd    $f13, $f12, $f12
    fmul    $f10, $f11, $f10
    load    [$i14 + 9], $i18
    load    [$i18 + 2], $f11
    fmul    $f10, $f11, $f10
    fadd    $f12, $f10, $f10
be_cont.36510:
    store   $f10, [$i16 + 0]
    load    [$i14 + 4], $i18
    load    [$i14 + 4], $i19
    load    [$i14 + 4], $i20
    load    [$i11 + 0], $f11
    load    [$i18 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i11 + 1], $f12
    load    [$i19 + 1], $f13
    fmul    $f12, $f13, $f13
    load    [$i11 + 2], $f14
    load    [$i20 + 2], $f15
    fmul    $f14, $f15, $f15
    fneg    $f11, $f11
    fneg    $f13, $f13
    fneg    $f15, $f15
.count storer
    add     $i13, $i12, $tmp
    sub     $i12, 1, $i3
.count move_args
    mov     $i10, $i2
    bne     $i17, 0, be_else.36511
be_then.36511:
    store   $f11, [$i16 + 1]
    store   $f13, [$i16 + 2]
    store   $f15, [$i16 + 3]
    bne     $f10, $f0, be_else.36512
be_then.36512:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36511
be_else.36512:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36511
be_else.36511:
    load    [$i14 + 9], $i17
    load    [$i14 + 9], $i18
    load    [$i17 + 1], $f16
    fmul    $f14, $f16, $f14
    load    [$i18 + 2], $f17
    fmul    $f12, $f17, $f12
    fadd    $f14, $f12, $f12
    fmul    $f12, $fc3, $f12
    fsub    $f11, $f12, $f11
    store   $f11, [$i16 + 1]
    load    [$i14 + 9], $i17
    load    [$i11 + 2], $f11
    load    [$i17 + 0], $f12
    fmul    $f11, $f12, $f11
    load    [$i11 + 0], $f14
    fmul    $f14, $f17, $f14
    fadd    $f11, $f14, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f13, $f11, $f11
    store   $f11, [$i16 + 2]
    load    [$i11 + 1], $f11
    fmul    $f11, $f12, $f11
    load    [$i11 + 0], $f12
    fmul    $f12, $f16, $f12
    fadd    $f11, $f12, $f11
    fmul    $f11, $fc3, $f11
    fsub    $f15, $f11, $f11
    store   $f11, [$i16 + 3]
    bne     $f10, $f0, be_else.36513
be_then.36513:
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
.count b_cont
    b       be_cont.36513
be_else.36513:
    finv    $f10, $f10
    store   $f10, [$i16 + 4]
    store   $i16, [$tmp + 0]
    call    iter_setup_dirvec_constants.2826
be_cont.36513:
be_cont.36511:
be_cont.36508:
be_cont.36492:
bge_cont.36491:
    sub     $ig0, 1, $i2                # |          1 |          1 |
    call    setup_reflections.3064      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    sub     $ig1, 1, $i10               # |          1 |          1 |
    sub     $i0, $ig7, $i2              # |          1 |          1 |
    call    min_caml_float_of_int       # |          1 |          1 |
    fmul    $fg17, $f1, $f1             # |          1 |          1 |
    fmul    $f1, $fg24, $f2             # |          1 |          1 |
    fadd    $f2, $fg18, $f2             # |          1 |          1 |
    load    [min_caml_screeny_dir + 1], $f3# |          1 |          1 |
    fmul    $f1, $f3, $f3               # |          1 |          1 |
    fadd    $f3, $fg19, $f3             # |          1 |          1 |
    load    [min_caml_screeny_dir + 2], $f4# |          1 |          1 |
    fmul    $f1, $f4, $f1               # |          1 |          1 |
    fadd    $f1, $fg20, $f4             # |          1 |          1 |
.count stack_load
    load    [$sp + 2], $i2              # |          1 |          1 |
.count move_args
    mov     $i10, $i3                   # |          1 |          1 |
.count move_args
    mov     $i1, $i4                    # |          1 |          1 |
    call    pretrace_pixels.2983        # |          1 |          1 |
    li      0, $i2                      # |          1 |          1 |
    li      2, $i6                      # |          1 |          1 |
.count stack_load
    load    [$sp + 1], $i3              # |          1 |          1 |
.count stack_load
    load    [$sp + 2], $i4              # |          1 |          1 |
.count stack_load
    load    [$sp + 3], $i5              # |          1 |          1 |
    call    scan_line.3000              # |          1 |          1 |
.count stack_load
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 18, $sp                # |          1 |          1 |
    li      0, $tmp                     # |          1 |          1 |
    ret                                 # |          1 |          1 |
.end main
                                        # | Instructions | Clocks     |
