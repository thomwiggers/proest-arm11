# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :


int32 x
int32 y
int32 z

int32 c1
int32 c2

enter ARM_ASM_AddConstant
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]
    # input_0 => proest_ctx
    # input_1 => rounds

    c1 = 0x75817581
    c2 = 0x658b658b # already rotated by 1

    int32 x_0_1
    int32 x_2_3
    int32 x_4_5
    int32 x_6_7
    int32 x_8_9
    int32 x_10_11
    int32 x_12_13
    int32 x_14_15

    # load initial data

    # preload data
    x_0_1 = mem32[input_0 + 0]
    x_2_3 = mem32[input_0 + 4]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]

    #assign r2 r3 r12 r14 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]

    # rotate c1, c2 left by input supplied by c code = 32-#round
    c1 >>>= input_1
    c2 >>>= input_1

    # start adding constant
    y = c2 ^ (x_0_1 unsigned>> 16)
    x_0_1 ^= c1
    c2 >>>= 30

    mem16[input_0 + 0] = x_0_1
    mem16[input_0 + 2] = y

    y = c2 ^ (x_2_3 unsigned>> 16)
    x_2_3 ^= (c1 >>> 30)
    c2 >>>= 30

    mem16[input_0 + 4] = x_2_3
    mem16[input_0 + 6] = y

    y = c2 ^ (x_4_5 unsigned>> 16)
    x_4_5 ^= (c1 >>> 28)
    c2 >>>= 30

    mem16[input_0 + 8] = x_4_5
    mem16[input_0 + 10] = y

    #x_6_7 = mem32[input_0]
    y = c2 ^ (x_6_7 unsigned>> 16)
    x_6_7 ^= (c1 >>> 26)
    c2 >>>= 30

    mem16[input_0 + 12] = x_6_7
    mem16[input_0 + 14] = y

    x_8_9 = mem32[input_0 + 16]
    x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    x_14_15 = mem32[input_0 + 28]
    #assign r4 r5 r6 r12 to x_8_9 x_10_11 x_12_13 x_14_15 = mem128[input_0]

    y = c2 ^ (x_8_9 unsigned>> 16)
    x_8_9 ^= (c1 >>> 24)
    c2 >>>= 30

    mem16[input_0 + 16] = x_8_9
    mem16[input_0 + 18] = y

    y = c2 ^ (x_10_11 unsigned>> 16)
    x_10_11 ^= (c1 >>> 22)
    c2 >>>= 30

    mem16[input_0 + 20] = x_10_11
    mem16[input_0 + 22] = y

    y = c2 ^ (x_12_13 unsigned>> 16)
    x_12_13 ^= (c1 >>> 20)
    c2 >>>= 30

    mem16[input_0 + 24] = x_12_13
    mem16[input_0 + 26] = y

    #x_14_15 = mem32[input_0]
    y = c2 ^ (x_14_15 unsigned>> 16)
    x_14_15 ^= (c1 >>> 18)

    mem16[input_0 + 28] = x_14_15
    mem16[input_0 + 30] = y

    caller_r4 = mem32[input_0 + 52] # 52
    caller_r5 = mem32[input_0 + 56] # 56
    caller_r6 = mem32[input_0 + 60] # 60
    loadsp[input_0 + 64]
return


