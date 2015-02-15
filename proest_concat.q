# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

int32 x_1_0
int32 x_1_1
int32 x_1_2
int32 x_1_3
int32 x_2_0
int32 x_2_1
int32 x_2_2
#int32 x_2_3
int32 x_3_0
int32 x_3_1
int32 x_3_2
int32 x_3_3

int32 p
int32 q
int32 x
int32 y
int32 z
int32 ctr
int32 c1
int32 c2

int32 x_0_1
int32 x_2_3
int32 x_3_4
int32 x_4_5
int32 x_6_7
int32 x_8_9
int32 x_10_11
int32 x_12_13
int32 x_14_15

int32 bits_0
int32 bits_1
int32 bits_2
int32 bits_3
int32 bits_4
int32 bits_5
int32 bits_6
int32 bits_7
int32 bits_8
int32 bits_9
int32 bits_10
int32 bits_11
int32 bits_12
int32 bits_13
int32 bits_14
int32 bits_15

enter ARM_ASM_proest_rounds_two
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]

    # p = bits[0], q = bits[1]
    x_0_1 = mem32[input_0 + 0]
    x_2_3 = mem32[input_0 + 4]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]
    #assign r1 r3 r4 r5 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]
    # FIXME 4 cycle latency

    # bits[0] = bits[2] ^ (p & q)
    bits_0 = x_0_1 & (x_0_1 unsigned>> 16)
    bits_0 ^= x_2_3
    mem16[input_0 + 0] = bits_0

    # bits[1] = bits[3] ^ (q & bits[2])
    bits_1 = x_2_3 & (x_0_1 unsigned>> 16)
    bits_1 ^= (x_2_3 unsigned>> 16)
    mem16[input_0 + 2] = bits_1

    # bits[2] = p ^ (bits[0] & bits[1])
    bits_2 = bits_0 & bits_1
    bits_2 ^= x_0_1
    mem16[input_0 + 4] = bits_2

    # bits[3] = q ^ (bits[1] & bits[2])
    bits_3 = bits_1 & bits_2
    bits_3 ^= (x_0_1 unsigned>> 16)
    mem16[input_0 + 6] = bits_3

    # Second iteration

    # bits[4] = bits[6] ^ (p & q)
    bits_4 = x_4_5 & (x_4_5 unsigned>> 16)
    bits_4 ^= x_6_7
    mem16[input_0 + 8] = bits_4

    # y = bits[6]
    bits_5 = x_6_7 & (x_4_5 unsigned>> 16)
    bits_5 ^= (x_6_7 unsigned>> 16)

    # bits[6] = p ^ (bits[4] & bits[5])
    bits_6 = bits_4 & bits_5
    bits_6 ^= x_4_5

    # bits[7] = q ^ (bits[5] & bits[6])
    bits_7 = bits_5 & bits_6
    bits_7 ^= (x_4_5 unsigned>> 16)

    mem16[input_0 + 14] = bits_7
    mem16[input_0 + 10] = bits_5
    mem16[input_0 + 12] = bits_6

    # load next stuff
    x_8_9 = mem32[input_0 + 16]
    x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    x_14_15 = mem32[input_0 + 28]
    #assign r2 r3 r4 r6 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]

    # Third iteration

    # bits[8] = bits[2] ^ (p & q)
    bits_8 = x_8_9 & (x_8_9 unsigned>> 16)
    bits_8 ^= x_10_11
    mem16[input_0 + 16] = bits_8

    # bits[1] = bits[3] ^ (q & bits[2])
    bits_9 = x_10_11 & (x_8_9 unsigned>> 16)
    bits_9 ^= (x_10_11 unsigned>> 16)
    mem16[input_0 + 18] = bits_9

    # bits[2] = p ^ (bits[0] & bits[1])
    bits_10 = bits_8 & bits_9
    bits_10 ^= x_8_9
    mem16[input_0 + 20] = bits_10

    # bits[3] = q ^ (bits[1] & bits[2])
    bits_11 = bits_9 & bits_10
    bits_11 ^= (x_8_9 unsigned>> 16)
    mem16[input_0 + 22] = bits_11

    # Fourth iteration

    # bits[4] = bits[6] ^ (p & q)
    bits_12 = x_12_13 & (x_12_13 unsigned>> 16)
    bits_12 ^= x_14_15
    mem16[input_0 + 24] = bits_12

    # bits[5] = bits[7] ^ (q & bits[6])
    # y = bits[6]
    bits_13 = x_14_15 & (x_12_13 unsigned>> 16)
    bits_13 ^= (x_14_15 unsigned>> 16)
    mem16[input_0 + 26] = bits_13

    # bits[6] = p ^ (bits[4] & bits[5])
    bits_14 = bits_12 & bits_13
    bits_14 ^= x_12_13
    mem16[input_0 + 28] = bits_14

    # bits[7] = q ^ (bits[5] & bits[6])
    bits_15 = bits_13 & bits_14
    bits_15 ^= (x_12_13 unsigned>> 16)
    mem16[input_0 + 30] = bits_15

    caller_r4 = mem32[input_0 + 52]
    caller_r5 = mem32[input_0 + 56]
    caller_r6 = mem32[input_0 + 60]
    loadsp[input_0 + 64]
#return
# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

#enter ARM_ASM_MixColumns
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]

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
#return
# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :



#enter ARM_ASM_ShiftRegisters
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]

    #input_0: proest_ctx
    #input_1: rounds

    # x[1][0]
    # x[1][1]
    # x[1][2]
    # x[1][3]
    x_1_0 = mem16[input_0 + 8]
    x_1_1 = mem16[input_0 + 10]
    x_1_2 = mem16[input_0 + 12]
    x_1_3 = mem16[input_0 + 14]
    x_1_0 |= (x_1_0 << 16)
    x_1_1 |= (x_1_1 << 16)
    x_1_2 |= (x_1_2 << 16)
    x_1_3 |= (x_1_3 << 16)
    x_1_0 >>>= 2
    x_1_1 >>>= 2
    x_1_2 >>>= 2
    x_1_3 >>>= 2
    mem16[input_0 + 8] = x_1_0
    mem16[input_0 + 10] = x_1_1
    mem16[input_0 + 12] = x_1_2
    mem16[input_0 + 14] = x_1_3

    # x[2][0]
    # x[2][1]
    # x[2][2]
    # x[2][3]
    x_2_0 = mem16[input_0 + 16]
    x_2_1 = mem16[input_0 + 18]
    x_2_2 = mem16[input_0 + 20]
    x_2_3 = mem16[input_0 + 22]
    x_2_0 |= (x_2_0 << 16)
    x_2_1 |= (x_2_1 << 16)
    x_2_2 |= (x_2_2 << 16)
    x_2_3 |= (x_2_3 << 16)
    x_2_0 >>>= 4
    x_2_1 >>>= 4
    x_2_2 >>>= 4
    x_2_3 >>>= 4
    mem16[input_0 + 16] = x_2_0
    mem16[input_0 + 18] = x_2_1
    mem16[input_0 + 20] = x_2_2
    mem16[input_0 + 22] = x_2_3


    # x[3][0]
    # x[3][1]
    # x[3][2]
    # x[3][3]
    x_3_0 = mem16[input_0 + 24]
    x_3_1 = mem16[input_0 + 26]
    x_3_2 = mem16[input_0 + 28]
    x_3_3 = mem16[input_0 + 30]
    x_3_0 |= (x_3_0 << 16)
    x_3_1 |= (x_3_1 << 16)
    x_3_2 |= (x_3_2 << 16)
    x_3_3 |= (x_3_3 << 16)
    x_3_0 >>>= 6
    x_3_1 >>>= 6
    x_3_2 >>>= 6
    x_3_3 >>>= 6
    mem16[input_0 + 24] = x_3_0
    mem16[input_0 + 26] = x_3_1
    mem16[input_0 + 28] = x_3_2
    mem16[input_0 + 30] = x_3_3

    caller_r4 = mem32[input_0 + 52]
    caller_r5 = mem32[input_0 + 56]
    caller_r6 = mem32[input_0 + 60]
    loadsp[input_0 + 64]
    #return

#   shiftregisters_odd:
#       # x[1][0]
#       # x[1][1]
#       # x[1][2]
#       # x[1][3]
#       x_1_0 = mem16[input_0 + 8]
#       x_1_1 = mem16[input_0 + 10]
#       x_1_2 = mem16[input_0 + 12]
#       x_1_3 = mem16[input_0 + 14]
#       x_1_0 |= (x_1_0 << 16)
#       x_1_1 |= (x_1_1 << 16)
#       x_1_2 |= (x_1_2 << 16)
#       x_1_3 |= (x_1_3 << 16)
#       x_1_0 >>>= 1
#       x_1_1 >>>= 1
#       x_1_2 >>>= 1
#       x_1_3 >>>= 1
#       mem16[input_0 + 8] = x_1_0
#       mem16[input_0 + 10] = x_1_1
#       mem16[input_0 + 12] = x_1_2
#       mem16[input_0 + 14] = x_1_3
#
#       # x[2][0]
#       # x[2][1]
#       # x[2][2]
#       # x[2][3]
#       x_2_0 = mem16[input_0 + 16]
#       x_2_1 = mem16[input_0 + 18]
#       x_2_2 = mem16[input_0 + 20]
#       x_2_3 = mem16[input_0 + 22]
#       x_2_0 |= (x_2_0 << 16)
#       x_2_1 |= (x_2_1 << 16)
#       x_2_2 |= (x_2_2 << 16)
#       x_2_3 |= (x_2_3 << 16)
#       x_2_0 >>>= 8
#       x_2_1 >>>= 8
#       x_2_2 >>>= 8
#       x_2_3 >>>= 8
#       mem16[input_0 + 16] = x_2_0
#       mem16[input_0 + 18] = x_2_1
#       mem16[input_0 + 20] = x_2_2
#       mem16[input_0 + 22] = x_2_3
#
#       # x[3][0]
#       # x[3][1]
#       # x[3][2]
#       # x[3][3]
#       x_3_0 = mem16[input_0 + 24]
#       x_3_1 = mem16[input_0 + 26]
#       x_3_2 = mem16[input_0 + 28]
#       x_3_3 = mem16[input_0 + 30]
#       x_3_0 |= (x_3_0 << 16)
#       x_3_1 |= (x_3_1 << 16)
#       x_3_2 |= (x_3_2 << 16)
#       x_3_3 |= (x_3_3 << 16)
#       x_3_0 >>>= 9
#       x_3_1 >>>= 9
#       x_3_2 >>>= 9
#       x_3_3 >>>= 9
#       mem16[input_0 + 24] = x_3_0
#       mem16[input_0 + 26] = x_3_1
#       mem16[input_0 + 28] = x_3_2
#       mem16[input_0 + 30] = x_3_3
#
#   caller_r4 = mem32[input_0 + 52]
#   caller_r5 = mem32[input_0 + 56]
#   caller_r6 = mem32[input_0 + 60]
#   loadsp[input_0 + 64]
#return


# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

#enter ARM_ASM_AddConstant
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]
    # input_0 => proest_ctx
    # input_1 => rounds

    c1 = 0x75817581
    c2 = 0x658b658b # already rotated by 1

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
#return


# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :


##################################################################
# SECOND ROUND!                                                  #
##################################################################

#enter ARM_ASM_SubBits
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]

    # p = bits[0], q = bits[1]
    x_0_1 = mem32[input_0 + 0]
    x_2_3 = mem32[input_0 + 4]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]
    #assign r1 r3 r4 r5 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]
    # FIXME 4 cycle latency

    # bits[0] = bits[2] ^ (p & q)
    bits_0 = x_0_1 & (x_0_1 unsigned>> 16)
    bits_0 ^= x_2_3
    mem16[input_0 + 0] = bits_0

    # bits[1] = bits[3] ^ (q & bits[2])
    bits_1 = x_2_3 & (x_0_1 unsigned>> 16)
    bits_1 ^= (x_2_3 unsigned>> 16)
    mem16[input_0 + 2] = bits_1

    # bits[2] = p ^ (bits[0] & bits[1])
    bits_2 = bits_0 & bits_1
    bits_2 ^= x_0_1
    mem16[input_0 + 4] = bits_2

    # bits[3] = q ^ (bits[1] & bits[2])
    bits_3 = bits_1 & bits_2
    bits_3 ^= (x_0_1 unsigned>> 16)
    mem16[input_0 + 6] = bits_3

    # Second iteration

    # bits[4] = bits[6] ^ (p & q)
    bits_4 = x_4_5 & (x_4_5 unsigned>> 16)
    bits_4 ^= x_6_7
    mem16[input_0 + 8] = bits_4

    # y = bits[6]
    bits_5 = x_6_7 & (x_4_5 unsigned>> 16)
    bits_5 ^= (x_6_7 unsigned>> 16)

    # bits[6] = p ^ (bits[4] & bits[5])
    bits_6 = bits_4 & bits_5
    bits_6 ^= x_4_5

    # bits[7] = q ^ (bits[5] & bits[6])
    bits_7 = bits_5 & bits_6
    bits_7 ^= (x_4_5 unsigned>> 16)

    mem16[input_0 + 14] = bits_7
    mem16[input_0 + 10] = bits_5
    mem16[input_0 + 12] = bits_6

    # load next stuff
    x_8_9 = mem32[input_0 + 16]
    x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    x_14_15 = mem32[input_0 + 28]
    #assign r2 r3 r4 r6 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]

    # Third iteration

    # bits[8] = bits[2] ^ (p & q)
    bits_8 = x_8_9 & (x_8_9 unsigned>> 16)
    bits_8 ^= x_10_11
    mem16[input_0 + 16] = bits_8

    # bits[1] = bits[3] ^ (q & bits[2])
    bits_9 = x_10_11 & (x_8_9 unsigned>> 16)
    bits_9 ^= (x_10_11 unsigned>> 16)
    mem16[input_0 + 18] = bits_9

    # bits[2] = p ^ (bits[0] & bits[1])
    bits_10 = bits_8 & bits_9
    bits_10 ^= x_8_9
    mem16[input_0 + 20] = bits_10

    # bits[3] = q ^ (bits[1] & bits[2])
    bits_11 = bits_9 & bits_10
    bits_11 ^= (x_8_9 unsigned>> 16)
    mem16[input_0 + 22] = bits_11

    # Fourth iteration

    # bits[4] = bits[6] ^ (p & q)
    bits_12 = x_12_13 & (x_12_13 unsigned>> 16)
    bits_12 ^= x_14_15
    mem16[input_0 + 24] = bits_12

    # bits[5] = bits[7] ^ (q & bits[6])
    # y = bits[6]
    bits_13 = x_14_15 & (x_12_13 unsigned>> 16)
    bits_13 ^= (x_14_15 unsigned>> 16)
    mem16[input_0 + 26] = bits_13

    # bits[6] = p ^ (bits[4] & bits[5])
    bits_14 = bits_12 & bits_13
    bits_14 ^= x_12_13
    mem16[input_0 + 28] = bits_14

    # bits[7] = q ^ (bits[5] & bits[6])
    bits_15 = bits_13 & bits_14
    bits_15 ^= (x_12_13 unsigned>> 16)
    mem16[input_0 + 30] = bits_15

    caller_r4 = mem32[input_0 + 52]
    caller_r5 = mem32[input_0 + 56]
    caller_r6 = mem32[input_0 + 60]
    loadsp[input_0 + 64]
    #return
# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

#enter ARM_ASM_MixColumns
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]

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
#return
# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

#enter ARM_ASM_ShiftRegisters
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]

    #input_0: proest_ctx
    #input_1: rounds


#   =? x = input_1 & 1
#   goto shiftregisters_odd if !=
#
#       # x[1][0]
#       # x[1][1]
#       # x[1][2]
#       # x[1][3]
#       x_1_0 = mem16[input_0 + 8]
#       x_1_1 = mem16[input_0 + 10]
#       x_1_2 = mem16[input_0 + 12]
#       x_1_3 = mem16[input_0 + 14]
#       x_1_0 |= (x_1_0 << 16)
#       x_1_1 |= (x_1_1 << 16)
#       x_1_2 |= (x_1_2 << 16)
#       x_1_3 |= (x_1_3 << 16)
#       x_1_0 >>>= 2
#       x_1_1 >>>= 2
#       x_1_2 >>>= 2
#       x_1_3 >>>= 2
#       mem16[input_0 + 8] = x_1_0
#       mem16[input_0 + 10] = x_1_1
#       mem16[input_0 + 12] = x_1_2
#       mem16[input_0 + 14] = x_1_3
#
#       # x[2][0]
#       # x[2][1]
#       # x[2][2]
#       # x[2][3]
#       x_2_0 = mem16[input_0 + 16]
#       x_2_1 = mem16[input_0 + 18]
#       x_2_2 = mem16[input_0 + 20]
#       x_2_3 = mem16[input_0 + 22]
#       x_2_0 |= (x_2_0 << 16)
#       x_2_1 |= (x_2_1 << 16)
#       x_2_2 |= (x_2_2 << 16)
#       x_2_3 |= (x_2_3 << 16)
#       x_2_0 >>>= 4
#       x_2_1 >>>= 4
#       x_2_2 >>>= 4
#       x_2_3 >>>= 4
#       mem16[input_0 + 16] = x_2_0
#       mem16[input_0 + 18] = x_2_1
#       mem16[input_0 + 20] = x_2_2
#       mem16[input_0 + 22] = x_2_3
#
#
#       # x[3][0]
#       # x[3][1]
#       # x[3][2]
#       # x[3][3]
#       x_3_0 = mem16[input_0 + 24]
#       x_3_1 = mem16[input_0 + 26]
#       x_3_2 = mem16[input_0 + 28]
#       x_3_3 = mem16[input_0 + 30]
#       x_3_0 |= (x_3_0 << 16)
#       x_3_1 |= (x_3_1 << 16)
#       x_3_2 |= (x_3_2 << 16)
#       x_3_3 |= (x_3_3 << 16)
#       x_3_0 >>>= 6
#       x_3_1 >>>= 6
#       x_3_2 >>>= 6
#       x_3_3 >>>= 6
#       mem16[input_0 + 24] = x_3_0
#       mem16[input_0 + 26] = x_3_1
#       mem16[input_0 + 28] = x_3_2
#       mem16[input_0 + 30] = x_3_3
#
#   caller_r4 = mem32[input_0 + 52]
#   caller_r5 = mem32[input_0 + 56]
#   caller_r6 = mem32[input_0 + 60]
#   loadsp[input_0 + 64]
#   return

#    shiftregisters_odd:
        # x[1][0]
        # x[1][1]
        # x[1][2]
        # x[1][3]
        x_1_0 = mem16[input_0 + 8]
        x_1_1 = mem16[input_0 + 10]
        x_1_2 = mem16[input_0 + 12]
        x_1_3 = mem16[input_0 + 14]
        x_1_0 |= (x_1_0 << 16)
        x_1_1 |= (x_1_1 << 16)
        x_1_2 |= (x_1_2 << 16)
        x_1_3 |= (x_1_3 << 16)
        x_1_0 >>>= 1
        x_1_1 >>>= 1
        x_1_2 >>>= 1
        x_1_3 >>>= 1
        mem16[input_0 + 8] = x_1_0
        mem16[input_0 + 10] = x_1_1
        mem16[input_0 + 12] = x_1_2
        mem16[input_0 + 14] = x_1_3

        # x[2][0]
        # x[2][1]
        # x[2][2]
        # x[2][3]
        x_2_0 = mem16[input_0 + 16]
        x_2_1 = mem16[input_0 + 18]
        x_2_2 = mem16[input_0 + 20]
        x_2_3 = mem16[input_0 + 22]
        x_2_0 |= (x_2_0 << 16)
        x_2_1 |= (x_2_1 << 16)
        x_2_2 |= (x_2_2 << 16)
        x_2_3 |= (x_2_3 << 16)
        x_2_0 >>>= 8
        x_2_1 >>>= 8
        x_2_2 >>>= 8
        x_2_3 >>>= 8
        mem16[input_0 + 16] = x_2_0
        mem16[input_0 + 18] = x_2_1
        mem16[input_0 + 20] = x_2_2
        mem16[input_0 + 22] = x_2_3

        # x[3][0]
        # x[3][1]
        # x[3][2]
        # x[3][3]
        x_3_0 = mem16[input_0 + 24]
        x_3_1 = mem16[input_0 + 26]
        x_3_2 = mem16[input_0 + 28]
        x_3_3 = mem16[input_0 + 30]
        x_3_0 |= (x_3_0 << 16)
        x_3_1 |= (x_3_1 << 16)
        x_3_2 |= (x_3_2 << 16)
        x_3_3 |= (x_3_3 << 16)
        x_3_0 >>>= 9
        x_3_1 >>>= 9
        x_3_2 >>>= 9
        x_3_3 >>>= 9
        mem16[input_0 + 24] = x_3_0
        mem16[input_0 + 26] = x_3_1
        mem16[input_0 + 28] = x_3_2
        mem16[input_0 + 30] = x_3_3

    caller_r4 = mem32[input_0 + 52]
    caller_r5 = mem32[input_0 + 56]
    caller_r6 = mem32[input_0 + 60]
    loadsp[input_0 + 64]
# return

# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

#enter ARM_ASM_AddConstant
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]
    # input_0 => proest_ctx
    # input_1 => rounds

    c1 = 0x75817581
    c2 = 0x658b658b # already rotated by 1

    # load initial data

    # preload data
    x_0_1 = mem32[input_0 + 0]
    x_2_3 = mem32[input_0 + 4]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]

    #assign r2 r3 r12 r14 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]
    #

    # rotate c1, c2 left by input supplied by c code = 32-#round
    input_1 -= 1
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

