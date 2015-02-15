# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

int32 p
int32 q
int32 x
int32 y
int32 z
int32 ctr

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

enter ARM_ASM_SubBits
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

    # load next stuff
    x_0_1 = mem32[input_0 + 16]
    x_2_3 = mem32[input_0 + 20]
    x_4_5 = mem32[input_0 + 24]
    x_6_7 = mem32[input_0 + 28]
    #assign r2 r3 r4 r6 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]

    # delayed saves to fill pipeline
    mem16[input_0 + 10] = bits_5  # FIXME these spend 2 calc cycles!!!!
    mem16[input_0 + 12] = bits_6

    # Third iteration
    # FIXME don't reuse labels except qhasm borks

    # bits[8] = bits[2] ^ (p & q)
    bits_8 = x_0_1 & (x_0_1 unsigned>> 16)
    bits_8 ^= x_2_3
    mem16[input_0 + 16] = bits_8

    # bits[1] = bits[3] ^ (q & bits[2])
    bits_9 = x_2_3 & (x_0_1 unsigned>> 16)
    bits_9 ^= (x_2_3 unsigned>> 16)
    mem16[input_0 + 18] = bits_9

    # bits[2] = p ^ (bits[0] & bits[1])
    bits_10 = bits_8 & bits_9
    bits_10 ^= x_0_1
    mem16[input_0 + 20] = bits_10

    # bits[3] = q ^ (bits[1] & bits[2])
    bits_11 = bits_9 & bits_10
    bits_11 ^= (x_0_1 unsigned>> 16)
    mem16[input_0 + 22] = bits_11

    # Fourth iteration

    # bits[4] = bits[6] ^ (p & q)
    bits_12 = x_4_5 & (x_4_5 unsigned>> 16)
    bits_12 ^= x_6_7
    mem16[input_0 + 24] = bits_12

    # bits[5] = bits[7] ^ (q & bits[6])
    # y = bits[6]
    bits_13 = x_6_7 & (x_4_5 unsigned>> 16)
    bits_13 ^= (x_6_7 unsigned>> 16)
    mem16[input_0 + 26] = bits_13

    # bits[6] = p ^ (bits[4] & bits[5])
    bits_14 = bits_12 & bits_13
    bits_14 ^= x_4_5
    mem16[input_0 + 28] = bits_14

    # bits[7] = q ^ (bits[5] & bits[6])
    bits_15 = bits_13 & bits_14
    bits_15 ^= (x_4_5 unsigned>> 16)
    mem16[input_0 + 30] = bits_15

    caller_r4 = mem32[input_0 + 52]
    caller_r5 = mem32[input_0 + 56]
    caller_r6 = mem32[input_0 + 60]
    loadsp[input_0 + 64]
return
