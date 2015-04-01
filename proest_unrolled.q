# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

# ...
int32 x_0_1
int32 x_2_3
int32 x_4_5
int32 x_6_7
int32 x_8_9
int32 x_10_11
int32 x_11
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

int32 x
int32 y
int32 z
int32 roundcounter
int32 c1
int32 c2

enter ARM_ASM_proest_unrolled # originally minimixcolumns
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

#SUBBITS 1
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

# Mixcolumns

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

## ShiftRegisters

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

## ADDCONSTANT

    c1 = 0x75817581
    c2 = 0x658b658b # already rotated by 1

    # load initial data

    # preload data
    roundcounter = mem16[input_0 + 92]
    x_0_1 = mem32[input_0 + 0]
    x_2_3 = mem32[input_0 + 4]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]

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


## AND AGAIN
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


## MIXCOLUMNS

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

    # Writeback
    # FIXME unroll
    y4 = mem16[input_0 + 36]
    mem16[input_0 + 8] = y4
    y10 = mem16[input_0 + 38]
    mem16[input_0 + 20] = y10
    y11 = mem16[input_0 + 40]
    mem16[input_0 + 22] = y11
    y14 = mem16[input_0 + 34]
    mem16[input_0 + 28] = y14


## ShiftRegisters 2
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

# addconstant
    c1 = 0x75817581
    c2 = 0x658b658b # already rotated by 1

    # load initial data

    # preload data
    roundcounter = mem16[input_0 + 92]
    x_0_1 = mem32[input_0 + 0]
    x_2_3 = mem32[input_0 + 4]
    x_4_5 = mem32[input_0 + 8]
    x_6_7 = mem32[input_0 + 12]

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

    roundcounter = mem16[input_0 + 92]
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
