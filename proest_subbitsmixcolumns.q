# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

stack32 caller_r1_stack
stack32 caller_r2_stack
stack32 caller_r3_stack
stack32 caller_r4_stack
stack32 caller_r5_stack
stack32 caller_r6_stack

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

enter ARM_ASM_SubBits_MixColumns
    caller_r4_stack = caller_r4
    caller_r5_stack = caller_r5
    caller_r6_stack = caller_r6

    # p = bits[0], q = bits[1]
    assign r1 r3 r4 r5 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]
    # FIXME 4 cycle latency

    # bits[0] = bits[2] ^ (p & q)
    bits_0 = x_0_1 & (x_0_1 unsigned>> 16)
    bits_0 ^= x_2_3
    mem16[input_0] = bits_0; input_0 += 2

    # bits[1] = bits[3] ^ (q & bits[2])
    bits_1 = x_2_3 & (x_0_1 unsigned>> 16)
    bits_1 ^= (x_2_3 unsigned>> 16)
    mem16[input_0] = bits_1; input_0 += 2

    # bits[2] = p ^ (bits[0] & bits[1])
    bits_2 = bits_0 & bits_1
    bits_2 ^= x_0_1
    mem16[input_0] = bits_2; input_0 += 2

    # bits[3] = q ^ (bits[1] & bits[2])
    bits_3 = bits_1 & bits_2
    bits_3 ^= (x_0_1 unsigned>> 16)
    mem16[input_0] = bits_3; input_0 += 2

    # Second iteration

    # bits[4] = bits[6] ^ (p & q)
    bits_4 = x_4_5 & (x_4_5 unsigned>> 16)
    bits_4 ^= x_6_7
    mem16[input_0] = bits_4; input_0 += 6

    # bits[5] = bits[7] ^ (q & bits[6])
    # y = bits[6]
    bits_5 = x_6_7 & (x_4_5 unsigned>> 16)
    bits_5 ^= (x_6_7 unsigned>> 16)

    # bits[6] = p ^ (bits[4] & bits[5])
    bits_6 = bits_4 & bits_5
    bits_6 ^= x_4_5

    # bits[7] = q ^ (bits[5] & bits[6])
    bits_7 = bits_5 & bits_6
    bits_7 ^= (x_4_5 unsigned>> 16)

    mem16[input_0] = bits_7; input_0 += 2

    # load next stuff
    assign r2 r3 r4 r6 to x_8_9 x_10_11 x_12_13 x_14_15 = mem128[input_0]

    # delayed saves to fill pipeline
    mem16[input_0 - 6] = bits_5  # FIXME these spend 2 calc cycles!!!!
    mem16[input_0 - 4] = bits_6

    # Third iteration

    # bits[8] = bits[2] ^ (p & q)
    bits_8 = x_8_9 & (x_8_9 unsigned>> 16)
    bits_8 ^= x_10_11
    mem16[input_0] = bits_8; input_0 += 2

    # bits[1] = bits[3] ^ (q & bits[2])
    bits_9 = x_10_11 & (x_8_9 unsigned>> 16)
    bits_9 ^= (x_10_11 unsigned>> 16)
    mem16[input_0] = bits_9; input_0 += 2

    # bits[2] = p ^ (bits[0] & bits[1])
    bits_10 = bits_8 & bits_9
    bits_10 ^= x_8_9
    mem16[input_0] = bits_10; input_0 += 2

    # bits[3] = q ^ (bits[1] & bits[2])
    bits_11 = bits_9 & bits_10
    bits_11 ^= (x_8_9 unsigned>> 16)
    mem16[input_0] = bits_11; input_0 += 2

    # Fourth iteration

    # bits[4] = bits[6] ^ (p & q)
    bits_12 = x_12_13 & (x_12_13 unsigned>> 16)
    bits_12 ^= x_14_15
    mem16[input_0] = bits_12; input_0 += 2

    # bits[5] = bits[7] ^ (q & bits[6])
    # y = bits[6]
    bits_13 = x_14_15 & (x_12_13 unsigned>> 16)
    bits_13 ^= (x_14_15 unsigned>> 16)
    mem16[input_0] = bits_13; input_0 += 2

    # bits[6] = p ^ (bits[4] & bits[5])
    bits_14 = bits_12 & bits_13
    bits_14 ^= x_12_13
    mem16[input_0] = bits_14; input_0 += 2

    # bits[7] = q ^ (bits[5] & bits[6])
    bits_15 = bits_13 & bits_14
    bits_15 ^= (x_12_13 unsigned>> 16)
    mem16[input_0] = bits_15; input_0 -= 30


# MixColumns
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

    # newx[0] = x[0] + x[4] + x[7] + x[10] + x[12] + x[14] + x[15]
    assign r1 r3 r4 r5 to x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]
    #x_0_1 = mem32[input_0 + 0]
    #x_4_5 = mem32[input_0 + 8]
    #x_6_7 = mem32[input_0 + 12]
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
    newx_0 = x

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
    newx_1 = x

    # newx[2] = x[2] + x[5] + x[8] + x[9] + x[12]
    x = x_12_13 ^ (x_4_5 unsigned>> 16)
    x ^= x_2_3
    x ^= x_8_9
    x ^= (x_8_9 unsigned>> 16)

    # push x on stack as newx[2]
    newx_2 = x

    # newx[3] = x[3] + x[6] + x[9] + x[10] + x[13]
    x = (x_2_3 unsigned>> 16)
    x ^= (x_8_9 unsigned>> 16)
    x ^= x_6_7
    x ^= (x_12_13 unsigned>> 16)
    x ^= x_10_11

    # push x on stack as newx[3]
    newx_3 = x

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
    newx_4 = x

    # newx[5] = x[0] + x[5] + x[8] + x[11] + x[15]
    x = x_0_1
    x ^= (x_10_11 unsigned>> 16)
    x ^= x_8_9
    x ^= (x_4_5 unsigned>> 16)
    x ^= (x_14_15 unsigned>> 16)

    # push x on stack as newx[5]
    newx_5 = x

    # newx[6] = x[1] + x[6] + x[8] + x[12] + x[13]
    x_12_13 = mem32[input_0 + 24]
    x = (x_0_1 unsigned>> 16)
    x ^= x_8_9
    x ^= x_6_7
    x ^= x_12_13
    x ^= (x_12_13 unsigned>> 16)

    # push x on stack as newx[6]
    newx_6 = x

    # newx[7] = x[2] + x[7] + x[9] + x[13] + x[14]
    x_2_3 = mem32[input_0 + 4]
    x = x_14_15 ^ (x_12_13 unsigned>> 16) # x[13]
    x ^= (x_6_7 unsigned>> 16)
    x ^= (x_8_9 unsigned>> 16)
    x ^= x_2_3
    newx_7 = x

    # newx[8] = x[2] + x[4] + x[6] + x[7] + x[8] + x[12] + x[15]
    x = x_2_3 ^ x_4_5
    x ^= x_6_7
    x ^= (x_6_7 unsigned>> 16)
    x ^= x_8_9
    x ^= (x_14_15 unsigned>> 16)
    x ^= x_12_13

    # push x on stack as newx[8]
    newx_8 = x

    # newx[9] = x[3] + x[4] + x[7] + x[9] + x[12]
    x = x_4_5 ^ (x_2_3 unsigned>> 16)
    x ^= (x_6_7 unsigned>> 16)
    x ^= (x_8_9 unsigned>> 16)
    x ^= x_12_13

    # push x on stack as newx[9]
    newx_9 = x

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
    x = newx_0
    mem16[input_0 + 0] = x

    # newx[1]
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

    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
return
