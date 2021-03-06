# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

enter ARM_ASM_MixColumns
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]

    int32 x_0_1
    int32 x_2_3
    int32 x_4_5
    int32 x_6_7
    int32 x_8_9
    int32 x_10_11
    int32 x_12_13
    int32 x_14_15

    # working register
    int32 x

    # newx[0] = x[0] + x[4] + x[7] + x[10] + x[12] + x[14] + x[15]
    x_0_1 = mem32[input_0 + 0]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]
    x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    x_14_15 = mem32[input_0 + 28]
    x = x_0_1 ^ x_4_5
    x ^= (x_6_7 unsigned>> 16)
    x ^= x_10_11
    x ^= x_12_13
    x ^= x_14_15
    x ^= (x_14_15 unsigned>> 16)

    # Push x on stack as newx[0]
    mem16[input_0 + 32] = x

    # newx[1] = x[1] + x[4] + x[11] + x[12] + x[15]
    x = (x_0_1 unsigned>> 16)
    x ^= (x_14_15 unsigned>> 16)
    x ^= x_4_5
    x ^= (x_10_11 unsigned>> 16)

    # intermezzo: load for next op
    x_2_3 = mem32[input_0 + 4]
    x_8_9 = mem32[input_0 + 16]

    x ^= x_12_13
    # push x on stack as newx[1]
    mem16[input_0 + 34] = x
    #newx_1 = x

    # newx[2] = x[2] + x[5] + x[8] + x[9] + x[12]
    x = x_12_13 ^ (x_4_5 unsigned>> 16)
    x ^= x_2_3
    x ^= x_8_9
    x ^= (x_8_9 unsigned>> 16)

    # push x on stack as newx[2]
    mem16[input_0 + 36] = x
    #newx_2 = x

    # newx[3] = x[3] + x[6] + x[9] + x[10] + x[13]
    x = (x_2_3 unsigned>> 16)
    x ^= (x_8_9 unsigned>> 16)
    x ^= x_6_7
    x ^= (x_12_13 unsigned>> 16)
    x ^= x_10_11

    # push x on stack as newx[3]
    mem16[input_0 + 38] = x
    #newx_3 = x

    # newx[4] = x[0] + x[3] + x[4] + x[8] + x[10] + x[11] + x[14]
    x_0_1 = mem32[input_0 + 0]
    x_14_15 = mem32[input_0 + 28]
    x = x_10_11 ^ (x_2_3 unsigned>> 16)
    x ^= x_4_5
    x ^= x_8_9
    x ^= (x_10_11 unsigned>> 16)
    x ^= x_14_15
    x ^= x_0_1

    # push x on stack as newx[4]
    mem16[input_0 + 40] = x
    #newx_4 = x

    # newx[5] = x[0] + x[5] + x[8] + x[11] + x[15]
    x = x_0_1
    x ^= (x_10_11 unsigned>> 16)
    x ^= x_8_9
    x ^= (x_4_5 unsigned>> 16)
    x ^= (x_14_15 unsigned>> 16)

    # push x on stack as newx[5]
    mem16[input_0 + 42] = x
    #newx_5 = x

    # newx[6] = x[1] + x[6] + x[8] + x[12] + x[13]
    x_12_13 = mem32[input_0 + 24]
    x = (x_0_1 unsigned>> 16)
    x ^= x_8_9
    x ^= x_6_7
    x ^= x_12_13
    x ^= (x_12_13 unsigned>> 16)

    # push x on stack as newx[6]
    mem16[input_0 + 44] = x
    #newx_6 = x

    # newx[7] = x[2] + x[7] + x[9] + x[13] + x[14]
    x_2_3 = mem32[input_0 + 4]
    x = x_14_15 ^ (x_12_13 unsigned>> 16) # x[13]
    x ^= (x_6_7 unsigned>> 16)
    x ^= (x_8_9 unsigned>> 16)
    x ^= x_2_3
    mem16[input_0 + 46] = x  #newx_7

    # newx[8] = x[2] + x[4] + x[6] + x[7] + x[8] + x[12] + x[15]
    x = x_2_3 ^ x_4_5
    x ^= x_6_7
    x ^= (x_6_7 unsigned>> 16)
    x ^= x_8_9
    x ^= (x_14_15 unsigned>> 16)
    x ^= x_12_13

    # push x on stack as newx[8]
    mem16[input_0 + 48] = x

    # newx[9] = x[3] + x[4] + x[7] + x[9] + x[12]
    x = x_4_5 ^ (x_2_3 unsigned>> 16)
    x ^= (x_6_7 unsigned>> 16)
    x ^= (x_8_9 unsigned>> 16)
    x ^= x_12_13

    # push x on stack as newx[9]
    #newx_9 = x
    mem16[input_0 + 50] = x

    # newx[10] = x[0] + x[1] + x[4] + x[10] + x[13]
    x_0_1 = mem32[input_0 + 0]
    x_10_11 = mem32[input_0 + 20]
    x = x_4_5 ^ (x_12_13 unsigned>> 16)
    x ^= x_0_1
    x ^= (x_0_1 unsigned>> 16)
    x ^= x_10_11

    # Write back x to x[10]
    mem16[input_0 + 20] = x

    # newx[11] = x[1] + x[2] + x[5] + x[11] + x[14]
    x = x_2_3 ^ (x_0_1 unsigned>> 16)
    x ^= (x_4_5 unsigned>> 16)
    x ^= (x_10_11 unsigned>> 16)
    x ^= x_14_15

    # Write back x into x[11]
    mem16[input_0 + 22] = x

    # newx[12] = x[0] + x[2] + x[3] + x[6] + x[8] + x[11] + x[12]
    x_6_7 = mem32[input_0 + 12]
    x_8_9 = mem32[input_0 + 16]
    x = x_0_1 ^ x_2_3
    x ^= (x_2_3 unsigned>> 16)
    x ^= (x_10_11 unsigned>> 16)
    x ^= x_12_13
    x ^= x_6_7
    x ^= x_8_9

    # write back into 12, we don't need it anymore
    mem16[input_0 + 24] = x

    # newx[13] = x[0] + x[3] + x[7] + x[8] + x[13]
    x = x_0_1 ^ (x_2_3 unsigned>> 16)
    x ^= (x_6_7 unsigned>> 16)
    x ^= x_8_9
    x ^= (x_12_13 unsigned>> 16)

    # write back into 13, we don't need it anymore
    mem16[input_0 + 26] = x

    # newx[14] = x[0] + x[4] + x[5] + x[9] + x[14]
    x_4_5 = mem32[input_0 + 8]
    x_14_15 = mem32[input_0 + 28]
    x = x_0_1 ^ (x_8_9 unsigned>> 16)
    x ^= x_4_5
    x ^= (x_4_5 unsigned>> 16)
    x ^= x_14_15

    # write back into 14, we don't need it anymore
    mem16[input_0 + 28] = x

    # x[15] = x[1] + x[5] + x[6] + x[10] + x[15]
    x = (x_0_1 unsigned>> 16)
    x ^= (x_4_5 unsigned>> 16)
    x ^= x_6_7
    x ^= x_10_11
    x ^= (x_14_15 unsigned>> 16)

    # write back into 15, we don't need it anymore.
    mem16[input_0 + 30] = x

    # TODO work back and reduce these for not-reloaded ones
    # retrieve stuff from stack
    # newx[0]
    x = mem16[input_0 + 32]
    mem16[input_0 + 0] = x

    # newx[1]
    x = mem16[input_0 + 34]
    mem16[input_0 + 2] = x

    x = mem16[input_0 + 36]
    mem16[input_0 + 4] = x

    x = mem16[input_0 + 38]
    mem16[input_0 + 6] = x

    x = mem16[input_0 + 40]
    mem16[input_0 + 8] = x

    x = mem16[input_0 + 42]
    mem16[input_0 + 10] = x

    x = mem16[input_0 + 44]
    mem16[input_0 + 12] = x

    x = mem16[input_0 + 46]
    mem16[input_0 + 14] = x

    x = mem16[input_0 + 48]
    mem16[input_0 + 16] = x

    x = mem16[input_0 + 50]
    mem16[input_0 + 18] = x

    caller_r4 = mem32[input_0 + 52]
    caller_r5 = mem32[input_0 + 56]
    caller_r6 = mem32[input_0 + 60]
    loadsp[input_0 + 64]
return
