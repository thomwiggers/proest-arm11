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
int32 mx_2_3
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

int32 newx0
int32 newx1
int32 newx2
int32 newx3
int32 newx4
int32 newx5
int32 newx6
int32 newx7
int32 newx8
int32 newx9
int32 newx10
int32 newx11
int32 newx12
int32 newx13
int32 newx14
int32 newx15

int32 roundcounter

enter ARM_ASM_proest128_permute
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
    roundcounter = 32  # store round counter

    proest_beginning:

    mem16[input_0 + 92] = roundcounter

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

#enter ARM_ASM_MixColumns

    x_0_1 = mem32[input_0 + 0]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]
    x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    x_14_15 = mem32[input_0 + 28]
    # newx[0] = x[0] + x[4] + x[7] + x[10] + x[12] + x[14] + x[15]
    newx0 = bits_0 ^ bits_4
    newx0 ^= (x_6_7 unsigned>> 16)
    newx0 ^= x_10_11
    newx0 ^= x_12_13
    newx0 ^= x_14_15
    newx0 ^= (x_14_15 unsigned>> 16)

    # Push x on stack as newx[0]
    mem16[input_0 + 32] = newx0

    # newx[1] = x[1] + x[4] + x[11] + x[12] + x[15]
    newx1 = x_4_5 ^ (x_0_1 unsigned>> 16)
    newx1 ^= (x_14_15 unsigned>> 16)
    newx1 ^= (x_10_11 unsigned>> 16)

    # intermezzo: load for next op
    x_2_3 = mem32[input_0 + 4]
    x_8_9 = mem32[input_0 + 16]

    newx1 ^= x_12_13
    # push x on stack as newx[1]
    mem16[input_0 + 34] = newx1
    #newx_1 = x

    # newx[2] = x[2] + x[5] + x[8] + x[9] + x[12]
    newx2 = x_12_13 ^ (x_4_5 unsigned>> 16)
    newx2 ^= x_2_3
    newx2 ^= x_8_9
    newx2 ^= (x_8_9 unsigned>> 16)

    # push x on stack as newx[2]
    mem16[input_0 + 36] = newx2
    #newx_2 = x

    # newx[3] = x[3] + x[6] + x[9] + x[10] + x[13]
    newx3 = (x_2_3 unsigned>> 16)
    newx3 ^= (x_8_9 unsigned>> 16)
    newx3 ^= x_6_7
    newx3 ^= (x_12_13 unsigned>> 16)
    newx3 ^= x_10_11

    # push x on stack as newx[3]
    mem16[input_0 + 38] = newx3
    #newx_3 = x

    # newx[4] = x[0] + x[3] + x[4] + x[8] + x[10] + x[11] + x[14]
    newx4 = x_10_11 ^ (x_2_3 unsigned>> 16)
    newx4 ^= x_4_5
    newx4 ^= x_8_9
    newx4 ^= (x_10_11 unsigned>> 16)
    newx4 ^= x_14_15
    newx4 ^= x_0_1

    # push x on stack as newx[4]
    mem16[input_0 + 40] = newx4
    #newx_4 = x

    # newx[5] = x[0] + x[5] + x[8] + x[11] + x[15]
    newx5 = x_0_1 ^ (x_10_11 unsigned>> 16)
    newx5 ^= x_8_9
    newx5 ^= (x_4_5 unsigned>> 16)
    newx5 ^= (x_14_15 unsigned>> 16)

    # push x on stack as newx[5]
    mem16[input_0 + 42] = newx5
    #newx_5 = x

    # newx[6] = x[1] + x[6] + x[8] + x[12] + x[13]
    newx6 = x_8_9 ^ (x_0_1 unsigned>> 16)
    newx6 ^= x_6_7
    newx6 ^= x_12_13
    newx6 ^= (x_12_13 unsigned>> 16)

    # push x on stack as newx[6]
    mem16[input_0 + 44] = newx6
    #newx_6 = x

    # newx[7] = x[2] + x[7] + x[9] + x[13] + x[14]
    #x_2_3 = mem32[input_0 + 4]
    newx7 = x_14_15 ^ (x_12_13 unsigned>> 16) # x[13]
    newx7 ^= (x_6_7 unsigned>> 16)
    newx7 ^= (x_8_9 unsigned>> 16)
    newx7 ^= x_2_3
    mem16[input_0 + 46] = newx7  #newx_7

    # newx[8] = x[2] + x[4] + x[6] + x[7] + x[8] + x[12] + x[15]
    newx8 = x_2_3 ^ x_4_5
    newx8 ^= x_6_7
    newx8 ^= (x_6_7 unsigned>> 16)
    newx8 ^= x_8_9
    newx8 ^= (x_14_15 unsigned>> 16)
    newx8 ^= x_12_13

    # push x on stack as newx[8]
    mem16[input_0 + 48] = newx8

    # newx[9] = x[3] + x[4] + x[7] + x[9] + x[12]
    newx9 = x_4_5 ^ (x_2_3 unsigned>> 16)
    newx9 ^= (x_6_7 unsigned>> 16)
    newx9 ^= (x_8_9 unsigned>> 16)
    newx9 ^= x_12_13

    # push x on stack as newx[9]
    #newx_9 = x
    mem16[input_0 + 50] = newx9

    # newx[10] = x[0] + x[1] + x[4] + x[10] + x[13]
    #x_10_11 = mem32[input_0 + 20]
    newx10 = x_4_5 ^ (x_12_13 unsigned>> 16)
    newx10 ^= x_0_1
    newx10 ^= (x_0_1 unsigned>> 16)
    newx10 ^= x_10_11

    # Write back x to x[10]
    mem16[input_0 + 20] = newx10

    # newx[11] = x[1] + x[2] + x[5] + x[11] + x[14]
    newx11 = x_2_3 ^ (x_0_1 unsigned>> 16)
    newx11 ^= (x_4_5 unsigned>> 16)
    newx11 ^= (x_10_11 unsigned>> 16)
    newx11 ^= x_14_15

    # Write back x into x[11]
    mem16[input_0 + 22] = newx11

    # newx[12] = x[0] + x[2] + x[3] + x[6] + x[8] + x[11] + x[12]
    #x_6_7 = mem32[input_0 + 12]
    #x_8_9 = mem32[input_0 + 16]
    newx12 = x_0_1 ^ x_2_3
    newx12 ^= (x_2_3 unsigned>> 16)
    newx12 ^= (x_10_11 unsigned>> 16)
    newx12 ^= x_12_13
    newx12 ^= x_6_7
    newx12 ^= x_8_9

    # write back into 12, we don't need it anymore
    mem16[input_0 + 24] = newx12

    # newx[13] = x[0] + x[3] + x[7] + x[8] + x[13]
    newx13 = x_0_1 ^ (x_2_3 unsigned>> 16)
    newx13 ^= (x_6_7 unsigned>> 16)
    newx13 ^= x_8_9
    newx13 ^= (x_12_13 unsigned>> 16)

    # write back into 13, we don't need it anymore
    mem16[input_0 + 26] = newx13

    # newx[14] = x[0] + x[4] + x[5] + x[9] + x[14]
    #x_4_5 = mem32[input_0 + 8]
    #x_14_15 = mem32[input_0 + 28]
    newx14 = x_0_1 ^ (x_8_9 unsigned>> 16)
    newx14 ^= x_4_5
    newx14 ^= (x_4_5 unsigned>> 16)
    newx14 ^= x_14_15

    # write back into 14, we don't need it anymore
    mem16[input_0 + 28] = newx14

    # x[15] = x[1] + x[5] + x[6] + x[10] + x[15]
    newx15 = x_6_7 ^ (x_0_1 unsigned>> 16)
    newx15 ^= (x_4_5 unsigned>> 16)
    newx15 ^= x_10_11
    newx15 ^= (x_14_15 unsigned>> 16)

    # write back into 15, we don't need it anymore.
    mem16[input_0 + 30] = newx15

    # stuff stored in other locations is retrieved later

#enter ARM_ASM_ShiftRegisters
    #input_0: proest_ctx
    #roundcounter: rounds

    # x[1][0]
    # x[1][1]
    # x[1][2]
    # x[1][3]
    x_1_0 = mem16[input_0 + 40] # == newx4
    x_1_1 = mem16[input_0 + 42] # == newx5
    x_1_2 = mem16[input_0 + 44] # == newx6
    x_1_3 = mem16[input_0 + 46] # == newx7
    x_1_0 |= (x_1_0 << 16)
    x_1_1 |= (x_1_1 << 16)
    x_1_2 |= (x_1_2 << 16)
    x_1_3 |= (x_1_3 << 16)
    x_1_0 >>>= 2
    x_1_1 >>>= 2
    x_1_2 >>>= 2
    x_1_3 >>>= 2

    # x[2][0]
    # x[2][1]
    # x[2][2]
    # x[2][3]
    x_2_0 = mem16[input_0 + 48] # newx8
    x_2_1 = mem16[input_0 + 50] # newx9
    x_2_2 = mem16[input_0 + 20]
    mx_2_3 = mem16[input_0 + 22]
    x_2_0 |= (x_2_0 << 16)
    x_2_1 |= (x_2_1 << 16)
    x_2_2 |= (x_2_2 << 16)
    mx_2_3 |= (mx_2_3 << 16)
    x_2_0 >>>= 4
    x_2_1 >>>= 4
    x_2_2 >>>= 4
    mx_2_3 >>>= 4

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

#enter ARM_ASM_AddConstant
    # input_0 => proest_ctx
    # roundcounter => rounds

    c1 = 0x75817581
    c2 = 0x658b658b # already rotated by 1

    # load initial data

    # preload data
    roundcounter = mem16[input_0 + 92]
    x_0_1 = mem32[input_0 + 32]
    x_2_3 = mem32[input_0 + 36]

    #assign r2 r3 r12 r14 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]

    # rotate c1, c2 left by input supplied by c code = 32-#round
    c1 >>>= roundcounter
    c2 >>>= roundcounter

    # start adding constant
    y = c2 ^ (x_0_1 unsigned>> 16)
    x_0_1 ^= c1
    c2 >>>= 30

    mem16[input_0 + 0] = x_0_1
    mem16[input_0 + 2] = y

    y = c2 ^ (x_2_3 unsigned>> 16)
    x_2_3 ^= (c1 >>> 30)

    mem16[input_0 + 4] = x_2_3
    mem16[input_0 + 6] = y

    y = x_1_1 ^ (c2 >>> 30)
    x_1_0 ^= (c1 >>> 28)

    mem16[input_0 + 8] = x_1_0
    mem16[input_0 + 10] = y

    #x_6_7 = mem32[input_0]
    y = x_1_3 ^ (c2 >>> 28)
    x_1_2 ^= (c1 >>> 26)

    mem16[input_0 + 12] = x_1_2
    mem16[input_0 + 14] = y

    #x_8_9 = mem32[input_0 + 16]
    #x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    x_14_15 = mem32[input_0 + 28]
    #assign r4 r5 r6 r12 to x_8_9 x_10_11 x_12_13 x_14_15 = mem128[input_0]

    y = x_2_1 ^ (c2 >>> 26)
    x_2_0 ^= (c1 >>> 24)

    mem16[input_0 + 16] = x_2_0
    mem16[input_0 + 18] = y

    y = mx_2_3 ^ (c2 >>> 24)
    x_2_2 ^= (c1 >>> 22)

    mem16[input_0 + 20] = x_2_2
    mem16[input_0 + 22] = y

    y = x_3_1 ^ (c2 >>> 22)
    x_12_13 ^= (c1 >>> 20)
    c2 >>>= 20

    mem16[input_0 + 24] = x_12_13
    mem16[input_0 + 26] = y

    #x_14_15 = mem32[input_0]
    y = c2 ^ (x_14_15 unsigned>> 16)
    x_14_15 ^= (c1 >>> 18)

    mem16[input_0 + 28] = x_14_15
    mem16[input_0 + 30] = y

##################################################################
# SECOND ROUND!                                                  #
##################################################################

#Subbits

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

#enter ARM_ASM_MixColumns

    x_0_1 = mem32[input_0 + 0]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]
    x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    x_14_15 = mem32[input_0 + 28]
    # newx[0] = x[0] + x[4] + x[7] + x[10] + x[12] + x[14] + x[15]
    newx0 = bits_0 ^ bits_4
    newx0 ^= (x_6_7 unsigned>> 16)
    newx0 ^= x_10_11
    newx0 ^= x_12_13
    newx0 ^= x_14_15
    newx0 ^= (x_14_15 unsigned>> 16)

    # Push x on stack as newx[0]
    mem16[input_0 + 32] = newx0

    # newx[1] = x[1] + x[4] + x[11] + x[12] + x[15]
    newx1 = x_4_5 ^ (x_0_1 unsigned>> 16)
    newx1 ^= (x_14_15 unsigned>> 16)
    newx1 ^= (x_10_11 unsigned>> 16)

    # intermezzo: load for next op
    x_2_3 = mem32[input_0 + 4]
    x_8_9 = mem32[input_0 + 16]

    newx1 ^= x_12_13
    # push x on stack as newx[1]
    mem16[input_0 + 34] = newx1
    #newx_1 = x

    # newx[2] = x[2] + x[5] + x[8] + x[9] + x[12]
    newx2 = x_12_13 ^ (x_4_5 unsigned>> 16)
    newx2 ^= x_2_3
    newx2 ^= x_8_9
    newx2 ^= (x_8_9 unsigned>> 16)

    # push x on stack as newx[2]
    mem16[input_0 + 36] = newx2
    #newx_2 = x

    # newx[3] = x[3] + x[6] + x[9] + x[10] + x[13]
    newx3 = (x_2_3 unsigned>> 16)
    newx3 ^= (x_8_9 unsigned>> 16)
    newx3 ^= x_6_7
    newx3 ^= (x_12_13 unsigned>> 16)
    newx3 ^= x_10_11

    # push x on stack as newx[3]
    mem16[input_0 + 38] = newx3
    #newx_3 = x

    # newx[4] = x[0] + x[3] + x[4] + x[8] + x[10] + x[11] + x[14]
    newx4 = x_10_11 ^ (x_2_3 unsigned>> 16)
    newx4 ^= x_4_5
    newx4 ^= x_8_9
    newx4 ^= (x_10_11 unsigned>> 16)
    newx4 ^= x_14_15
    newx4 ^= x_0_1

    # push x on stack as newx[4]
    mem16[input_0 + 40] = newx4
    #newx_4 = x

    # newx[5] = x[0] + x[5] + x[8] + x[11] + x[15]
    newx5 = x_0_1 ^ (x_10_11 unsigned>> 16)
    newx5 ^= x_8_9
    newx5 ^= (x_4_5 unsigned>> 16)
    newx5 ^= (x_14_15 unsigned>> 16)

    # push x on stack as newx[5]
    mem16[input_0 + 42] = newx5
    #newx_5 = x

    # newx[6] = x[1] + x[6] + x[8] + x[12] + x[13]
    newx6 = x_8_9 ^ (x_0_1 unsigned>> 16)
    newx6 ^= x_6_7
    newx6 ^= x_12_13
    newx6 ^= (x_12_13 unsigned>> 16)

    # push x on stack as newx[6]
    mem16[input_0 + 44] = newx6
    #newx_6 = x

    # newx[7] = x[2] + x[7] + x[9] + x[13] + x[14]
    #x_2_3 = mem32[input_0 + 4]
    newx7 = x_14_15 ^ (x_12_13 unsigned>> 16) # x[13]
    newx7 ^= (x_6_7 unsigned>> 16)
    newx7 ^= (x_8_9 unsigned>> 16)
    newx7 ^= x_2_3
    mem16[input_0 + 46] = newx7  #newx_7

    # newx[8] = x[2] + x[4] + x[6] + x[7] + x[8] + x[12] + x[15]
    newx8 = x_2_3 ^ x_4_5
    newx8 ^= x_6_7
    newx8 ^= (x_6_7 unsigned>> 16)
    newx8 ^= x_8_9
    newx8 ^= (x_14_15 unsigned>> 16)
    newx8 ^= x_12_13

    # push x on stack as newx[8]
    mem16[input_0 + 48] = newx8

    # newx[9] = x[3] + x[4] + x[7] + x[9] + x[12]
    newx9 = x_4_5 ^ (x_2_3 unsigned>> 16)
    newx9 ^= (x_6_7 unsigned>> 16)
    newx9 ^= (x_8_9 unsigned>> 16)
    newx9 ^= x_12_13

    # push x on stack as newx[9]
    #newx_9 = x
    mem16[input_0 + 50] = newx9

    # newx[10] = x[0] + x[1] + x[4] + x[10] + x[13]
    #x_10_11 = mem32[input_0 + 20]
    newx10 = x_4_5 ^ (x_12_13 unsigned>> 16)
    newx10 ^= x_0_1
    newx10 ^= (x_0_1 unsigned>> 16)
    newx10 ^= x_10_11

    # Write back x to x[10]
    mem16[input_0 + 20] = newx10

    # newx[11] = x[1] + x[2] + x[5] + x[11] + x[14]
    newx11 = x_2_3 ^ (x_0_1 unsigned>> 16)
    newx11 ^= (x_4_5 unsigned>> 16)
    newx11 ^= (x_10_11 unsigned>> 16)
    newx11 ^= x_14_15

    # Write back x into x[11]
    mem16[input_0 + 22] = newx11

    # newx[12] = x[0] + x[2] + x[3] + x[6] + x[8] + x[11] + x[12]
    #x_6_7 = mem32[input_0 + 12]
    #x_8_9 = mem32[input_0 + 16]
    newx12 = x_0_1 ^ x_2_3
    newx12 ^= (x_2_3 unsigned>> 16)
    newx12 ^= (x_10_11 unsigned>> 16)
    newx12 ^= x_12_13
    newx12 ^= x_6_7
    newx12 ^= x_8_9

    # write back into 12, we don't need it anymore
    mem16[input_0 + 24] = newx12

    # newx[13] = x[0] + x[3] + x[7] + x[8] + x[13]
    newx13 = x_0_1 ^ (x_2_3 unsigned>> 16)
    newx13 ^= (x_6_7 unsigned>> 16)
    newx13 ^= x_8_9
    newx13 ^= (x_12_13 unsigned>> 16)

    # write back into 13, we don't need it anymore
    mem16[input_0 + 26] = newx13

    # newx[14] = x[0] + x[4] + x[5] + x[9] + x[14]
    #x_4_5 = mem32[input_0 + 8]
    #x_14_15 = mem32[input_0 + 28]
    newx14 = x_0_1 ^ (x_8_9 unsigned>> 16)
    newx14 ^= x_4_5
    newx14 ^= (x_4_5 unsigned>> 16)
    newx14 ^= x_14_15

    # write back into 14, we don't need it anymore
    mem16[input_0 + 28] = newx14

    # x[15] = x[1] + x[5] + x[6] + x[10] + x[15]
    newx15 = x_6_7 ^ (x_0_1 unsigned>> 16)
    newx15 ^= (x_4_5 unsigned>> 16)
    newx15 ^= x_10_11
    newx15 ^= (x_14_15 unsigned>> 16)

    # write back into 15, we don't need it anymore.
    mem16[input_0 + 30] = newx15

    # stuff stored in other locations is retrieved later


#enter ARM_ASM_ShiftRegisters
    #input_0: proest_ctx
    #roundcounter: rounds
    # x[1][0]
    # x[1][1]
    # x[1][2]
    # x[1][3]
    x_1_0 = mem16[input_0 + 40] # == newx4
    x_1_1 = mem16[input_0 + 42] # == newx5
    x_1_2 = mem16[input_0 + 44] # == newx6
    x_1_3 = mem16[input_0 + 46] # == newx7
    x_1_0 |= (x_1_0 << 16)
    x_1_1 |= (x_1_1 << 16)
    x_1_2 |= (x_1_2 << 16)
    x_1_3 |= (x_1_3 << 16)
    x_1_0 >>>= 1
    x_1_1 >>>= 1
    x_1_2 >>>= 1
    x_1_3 >>>= 1

    # x[2][0]
    # x[2][1]
    # x[2][2]
    # x[2][3]
    x_2_0 = mem16[input_0 + 48] # newx8
    x_2_1 = mem16[input_0 + 50] # newx9
    x_2_2 = mem16[input_0 + 20]
    mx_2_3 = mem16[input_0 + 22]
    x_2_0 |= (x_2_0 << 16)
    x_2_1 |= (x_2_1 << 16)
    x_2_2 |= (x_2_2 << 16)
    mx_2_3 |= (mx_2_3 << 16)
    x_2_0 >>>= 8
    x_2_1 >>>= 8
    x_2_2 >>>= 8
    mx_2_3 >>>= 8

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


#enter ARM_ASM_AddConstant
    # input_0 => proest_ctx
    # roundcounter => rounds

    c1 = 0x75817581
    c2 = 0x658b658b # already rotated by 1

    # load initial data

    # preload data
    roundcounter = mem16[input_0 + 92]
    x_0_1 = mem32[input_0 + 32]
    x_2_3 = mem32[input_0 + 36]

    #assign r2 r3 r12 r14 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]

    # rotate c1, c2 left by input supplied by c code = 32-#round
    roundcounter -= 1
    c1 >>>= roundcounter
    c2 >>>= roundcounter

    # start adding constant
    y = c2 ^ (x_0_1 unsigned>> 16)
    x_0_1 ^= c1
    c2 >>>= 30

    mem16[input_0 + 0] = x_0_1
    mem16[input_0 + 2] = y

    y = c2 ^ (x_2_3 unsigned>> 16)
    x_2_3 ^= (c1 >>> 30)

    mem16[input_0 + 4] = x_2_3
    mem16[input_0 + 6] = y

    y = x_1_1 ^ (c2 >>> 30)
    x_1_0 ^= (c1 >>> 28)

    mem16[input_0 + 8] = x_1_0
    mem16[input_0 + 10] = y

    #x_6_7 = mem32[input_0]
    y = x_1_3 ^ (c2 >>> 28)
    x_1_2 ^= (c1 >>> 26)

    mem16[input_0 + 12] = x_1_2
    mem16[input_0 + 14] = y

    #x_8_9 = mem32[input_0 + 16]
    #x_10_11 = mem32[input_0 + 20]
    x_12_13 = mem32[input_0 + 24]
    x_14_15 = mem32[input_0 + 28]
    #assign r4 r5 r6 r12 to x_8_9 x_10_11 x_12_13 x_14_15 = mem128[input_0]

    y = x_2_1 ^ (c2 >>> 26)
    x_2_0 ^= (c1 >>> 24)

    mem16[input_0 + 16] = x_2_0
    mem16[input_0 + 18] = y

    y = mx_2_3 ^ (c2 >>> 24)
    x_2_2 ^= (c1 >>> 22)

    mem16[input_0 + 20] = x_2_2
    mem16[input_0 + 22] = y

    y = x_3_1 ^ (c2 >>> 22)
    x_12_13 ^= (c1 >>> 20)
    c2 >>>= 20

    mem16[input_0 + 24] = x_12_13
    mem16[input_0 + 26] = y
    roundcounter = mem16[input_0 + 92]

    #x_14_15 = mem32[input_0]
    y = c2 ^ (x_14_15 unsigned>> 16)
    x_14_15 ^= (c1 >>> 18)

    mem16[input_0 + 28] = x_14_15
    mem16[input_0 + 30] = y

    roundcounter -= 2
    =? roundcounter - 16
    goto proest_beginning if !=

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


