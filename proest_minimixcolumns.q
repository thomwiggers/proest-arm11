# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

# ...

enter ARM_ASM_MiniMixColumns
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    mem32[input_0 + 64] = caller_r7
    mem32[input_0 + 68] = caller_r8
    mem32[input_0 + 72] = caller_r9
    mem32[input_0 + 76] = caller_r10
    mem32[input_0 + 80] = caller_r11
    mem32[input_0 + 84] = caller_r14
    storesp[input_0 + 88]

    int32 x_0_1
    int32 x_2_3
    int32 x_4_5
    int32 x_6_7
    int32 x_8_9
    int32 x_10_11
    int32 x_11
    int32 x_12_13
    int32 x_14_15

    int32 t1
    int32 t2
    int32 t3
    int32 t4
    int32 t5shifted
    int32 t6shifted
    int32 t7
    int32 t8
    int32 t8shifted
    int32 t9
    int32 t10shifted
    int32 t11
    int32 t12
    int32 t13
    int32 t14
    int32 t15shifted
    int32 t16
    int32 t17shifted
    int32 t18
    int32 t19
    int32 t20
    int32 t21
    int32 t22
    int32 t23
    int32 t24
    int32 t25
    int32 t26
    int32 t27
    int32 t28
    int32 t29
    int32 t30
    int32 t31shifted
    int32 t32
    int32 t33
    int32 t34

    int32 y0
    int32 y1
    int32 y2
    int32 y3
    int32 y4
    int32 y5
    int32 y6
    int32 y7
    int32 y8
    int32 y9
    int32 y10
    int32 y11
    int32 y12
    int32 y13
    int32 y14
    int32 y15

    x_0_1 = mem32[input_0 + 0]
    x_2_3 = mem32[input_0 + 4]
    x_4_5 = mem32[input_0 + 8]
    x_14_15 = mem32[input_0 + 28]
    x_8_9 = mem32[input_0 + 16]
    t1 = x_0_1 ^ x_4_5
    t3 = t1 ^ x_14_15
    t5shifted = x_8_9 ^ x_4_5

    x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    y14 = t3 ^ (t5shifted unsigned>> 16)
    mem16[input_0 + 34] = y14

    t12 = x_10_11 ^ t3
    mem16[input_0 + 42] = t12
    t2 = x_12_13 ^ x_8_9
    mem16[input_0 + 32] = t2
    t4 = t2 ^ x_2_3
    t9 = x_2_3 ^ x_14_15

    x_6_7 = mem32[input_0 + 12]

    y2 = t4 ^ (t5shifted unsigned>> 16)
    mem16[input_0 + 4] = y2

    t10shifted = x_0_1 ^ x_10_11
    t14 = x_6_7 ^ t4
    t19 = x_4_5 ^ (t10shifted unsigned>> 16)
    t11 = x_12_13 ^ (x_14_15 unsigned>> 16)
    y1 = t19 ^ t11
    mem16[input_0 + 48] = t11
    mem16[input_0 + 2] = y1

    t21 = t12 ^ (x_2_3 unsigned>> 16)
    t13 = x_8_9 ^ (x_10_11 unsigned>> 16)

    y4 = t13 ^ t21
    mem16[input_0 + 36] = y4

    t6shifted = x_0_1 ^ x_12_13
    t22 = x_10_11 ^ (t6shifted unsigned>> 16)

    y10 = t1 ^ t22
    mem16[input_0 + 38] = y10

    x_6_7 = mem32[input_0 + 12]

    t9 = x_2_3 ^ x_14_15
    t23 = t9 ^ (x_8_9 unsigned>> 16)
    t8shifted = x_6_7 ^ x_12_13
    mem32[input_0 + 44] = t8shifted # Use upper 4 bytes in input_0 + 46

    y7 = t23 ^ (t8shifted unsigned>> 16)
    mem16[input_0 + 14] = y7

    t24 = t23 ^ (t10shifted unsigned>> 16)
    y11 = t24 ^ (t5shifted unsigned>> 16)
    mem16[input_0 + 40] = y11

    t25 = x_0_1 ^ t13
    x_4_5 = mem32[input_0 + 8]
    t15shifted = x_4_5 ^ x_14_15

    y5 = t25 ^ (t15shifted unsigned>> 16)
    mem16[input_0 + 10] = y5

    t17shifted = x_2_3 ^ x_8_9
    t26 = x_12_13 ^ (t17shifted unsigned>> 16)
    t18 = x_4_5 ^ (x_6_7 unsigned>> 16)

    y9 = t18 ^ t26
    mem16[input_0 + 44] = t18
    mem16[input_0 + 18] = y9

    t2 = mem16[input_0 + 32]
    x_10_11 = mem32[input_0 + 20]

    t27 = t2 ^ t22
    t16 = x_6_7 ^ x_10_11

    y6 = t16 ^ t27
    mem16[input_0 + 12] = y6

    t11 = mem16[input_0 + 48]
    t12 = mem16[input_0 + 42]
    t28 = t11 ^ (x_6_7 unsigned>> 16)

    y0 = t12 ^ t28
    mem16[input_0 + 0] = y0

    t8 = mem16[input_0 + 46]
    t30 = x_8_9 ^ t8

    t7 = x_0_1 ^ (x_2_3 unsigned>> 16)

    y13 = t7 ^ t30
    mem16[input_0 + 26] = y13

    t31shifted = t17shifted ^ x_12_13

    y3 = t16 ^ (t31shifted unsigned>> 16)
    mem16[input_0 + 6] = y3

    t32 = t16 ^ (x_0_1 unsigned>> 16)

    y15 = t32 ^ (t15shifted unsigned>> 16)
    mem16[input_0 + 30] = y15

    t18 = mem16[input_0 + 44]
    t33 = t14 ^ (x_14_15 unsigned>> 16)

    y8 = t18 ^ t33
    mem16[input_0 + 16] = y8

    t34 = t14 ^ (x_10_11 unsigned>> 16)

    y12 = t34 ^ t7
    mem16[input_0 + 24] = y12


    y4 = mem16[input_0 + 36]
    mem16[input_0 + 8] = y4
    y10 = mem16[input_0 + 38]
    mem16[input_0 + 20] = y10
    y11 = mem16[input_0 + 40]
    mem16[input_0 + 22] = y11
    y14 = mem16[input_0 + 34]
    mem16[input_0 + 28] = y14

    caller_r4 = mem32[input_0 + 52] # 52
    caller_r5 = mem32[input_0 + 56] # 56
    caller_r6 = mem32[input_0 + 60] # 60
    caller_r7 = mem32[input_0 + 64]
    caller_r8 = mem32[input_0 + 68]
    caller_r9 = mem32[input_0 + 72]
    caller_r10 = mem32[input_0 + 76]
    caller_r11 = mem32[input_0 + 80]
    caller_r14 = mem32[input_0 + 84]
    loadsp[input_0 + 88]
return
