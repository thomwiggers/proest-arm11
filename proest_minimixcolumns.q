# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

stack32 caller_r1_stack
stack32 caller_r2_stack
stack32 caller_r3_stack
stack32 caller_r4_stack
stack32 caller_r5_stack
stack32 caller_r6_stack
# ...

enter ARM_ASM_MiniMixColumns
    caller_r4_stack = caller_r4
    caller_r5_stack = caller_r5
    caller_r6_stack = caller_r6

    # Get enough stack space
    stack32 newx_0
    stack32 newx_1
    stack32 newx_2
    stack32 newx_3
    stack32 newx_4
    stack32 newx_5
    stack32 newx_6
    stack32 newx_7
    stack32 newx_8
    stack32 newx_9
    stack32 newx_10
    stack32 newx_11
    stack32 newx_12
    stack32 newx_13
    stack32 newx_14
    stack32 newx_15

    stack32 store_t1
    stack32 store_t2
    stack32 store_t5shifted
    stack32 store_t10
    stack32 store_t12
    stack32 store_t14
    stack32 store_t15
    stack32 store_t16shifted
    stack32 store_t17
    stack32 store_t27
    stack32 store_t28shifted
    stack32 store_t30
    stack32 store_t33

    int32 x_0_1
    int32 x_2_3
    int32 x_3_4
    int32 x_4_5
    int32 x_5_6
    int32 x_6_7
    int32 x_7_8
    int32 x_8_9
    int32 x_9_10
    int32 x_10_11
    int32 x_11
    int32 x_11_12
    int32 x_12_13
    int32 x_13_14
    int32 x_14_15
    int32 x_15

    int32 t1
    int32 t2
    int32 t3
    int32 t4
    int32 t5shifted
    int32 t6
    int32 t7
    int32 t8
    int32 t9
    int32 t10
    int32 t11shifted
    int32 t12
    int32 t13
    int32 t14
    int32 t15
    int32 t16shifted
    int32 t17
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
    int32 t28shifted
    int32 t29
    int32 t30
    int32 t31
    int32 t32shifted
    int32 t33
    int32 t34

    # working register
    int32 x

    x_0_1 = mem32[input_0 + 0]
    x_4_5 = mem32[input_0 + 8]
    x_14_15 = mem32[input_0 + 28]
    x_8_9 = mem32[input_0 + 16]
    t1 = x_0_1 ^ x_4_5

    x_10_11 = mem32[input_0 + 20]
    t5shifted = x_8_9 ^ x_4_5
    store_t5shifted = t5shifted
    x_12_13 = mem32[input_0 + 24]
    t3 = t1 ^ x_14_15
    store_t1 = t1
    x = t3 ^ (t5shifted unsigned>> 16)
    newx_14 = x  # y14

    x_2_3 = mem32[input_0 + 4]
    t12 = x_10_11 ^ t3
    store_t12 = t12
    t2 = x_12_13 ^ x_8_9
    store_t2 = t2
    t4 = t2 ^ x_2_3
    x = t4 ^ (t5shifted unsigned>> 16) # y2
    newx_2 = x

    x_14_15 = mem32[input_0 + 28]
    x_6_7 = mem32[input_0 + 12]
    x_3_4 = mem32[input_0 + 6]
    t14 = x_6_7 ^ t4
    t33 = t14 ^ (x_14_15 unsigned>> 16)
    store_t14 = t14
    store_t33 = t33
    x_11_12 = mem32[input_0 + 22]
    t11shifted = x_11_12 ^ x_14_15
    t28shifted = t11shifted ^ x_6_7
    store_t28shifted = t28shifted
    t10 = x_11_12 ^ (x_0_1 unsigned>> 16)
    store_t10 = t10
    t19 = t10 ^ (x_3_4 unsigned>> 16)
    x = t19 ^ (t11shifted unsigned>> 16) # y1
    newx_1 = x

    x_7_8 = mem32[input_0 + 14]
    x_13_14 = mem32[input_0 + 26]
    x_9_10 = mem32[input_0 + 18]
    t21 = t12 ^ x_3_4
    t13 = x_11_12 ^ (x_7_8 unsigned>> 16)
    x = t13 ^ t21 # y4
    newx_4 = x

    t6 = x_13_14 ^ (x_0_1 unsigned>> 16)
    t22 = t6 ^ (x_9_10 unsigned>> 16)
    t2 = store_t2
    t27 = t2 ^ t22
    t1 = store_t1
    store_t27 = t27
    x_2_3 = mem32[input_0 + 4]
    x = t1 ^ t22
    newx_10 = x # y10
    t9 = x_2_3 ^ (x_13_14 unsigned>> 16)
    t23 = x_9_10 ^ t9
    t8 = x_7_8 ^ x_13_14
    t30 = t8 ^ (x_7_8 unsigned>> 16)
    store_t30 = t30
    t10 = store_t10
    t5shifted = store_t5shifted
    t24 = t10 ^ t23
    x = t8 ^ t23 # y7
    newx_7 = x

    x = t24 ^ (t5shifted unsigned>> 16) # y11
    newx_11 = x # y11

    t12 = store_t12
    t28shifted = store_t28shifted
    x_0_1 = mem32[input_0 + 0]
    x_5_6 = mem32[input_0 + 10]
    x = t12 ^ (t28shifted unsigned>> 16)
    newx_0 = x # y0
    x_15 = mem16[input_0 + 30]
    t25 = x_0_1 ^ t13
    x_3_4 = mem32[input_0 + 6]
    t15 = x_5_6 ^ x_15
    store_t15 = t15
    x_9_10 = mem32[input_0 + 18]
    x = t15 ^ t25 # y5
    x_12_13 = mem32[input_0 + 24]
    newx_5 = x

    x_7_8 = mem32[input_0 + 14]
    t17 = x_3_4 ^ x_9_10
    store_t17 = t17
    t26 = x_12_13 ^ t17
    t18 = x_7_8 ^ (x_3_4 unsigned>> 16)
    x = t18 ^ t26  # y9
    t27 = store_t27
    t16shifted = x_5_6 ^ x_9_10
    newx_9 = x

    x = t27 ^ (t16shifted unsigned>> 16)
    x_0_1 = mem32[input_0 + 0]
    newx_6 = x  # y6

    t30 = store_t30
    t7 = x_0_1 ^ x_3_4
    x = t7 ^ t30

    x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    newx_13 = x # y13
    t14 = store_t14
    t34 = t7 ^ (x_10_11 unsigned>>16)
    x = t34 ^ t14 # y12
    t17 = store_t17
    newx_12 = x
    t31 = t17 ^ (x_12_13 unsigned>> 16)

    x = t31 ^ (t16shifted unsigned>> 16)

    t15 = store_t15
    t32shifted = x_0_1 ^ t16shifted
    newx_3 = x
    t33 = store_t33
    x = t15 ^ (t32shifted unsigned>>16)
    x_11 = mem16[input_0 + 22]
    newx_15 = x

    x = t33 ^ t18  # y8
    newx_8 = x




    x = newx_0
    mem16[input_0 + 0] = x

    x = newx_1
    mem16[input_0 + 2] = x

    x = newx_2
    mem16[input_0 + 4] = x

    x = newx_3
    mem16[input_0 + 6] = x

    x = newx_4
    mem16[input_0 + 8] = x

    x = newx_5
    mem16[input_0 + 10] = x

    x = newx_6
    mem16[input_0 + 12] = x

    x = newx_7
    mem16[input_0 + 14] = x

    x = newx_8
    mem16[input_0 + 16] = x

    x = newx_9
    mem16[input_0 + 18] = x

    x = newx_10
    mem16[input_0 + 20] = x

    x = newx_11
    mem16[input_0 + 22] = x

    x = newx_12
    mem16[input_0 + 24] = x

    x = newx_13
    mem16[input_0 + 26] = x

    x = newx_14
    mem16[input_0 + 28] = x

    x = newx_15
    mem16[input_0 + 30] = x

    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
return
