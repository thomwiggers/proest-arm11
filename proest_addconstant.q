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

int32 x
int32 y
int32 z

int32 c1
int32 c2

enter ARM_ASM_AddConstant
    caller_r4_stack = caller_r4
    caller_r5_stack = caller_r5
    caller_r6_stack = caller_r6

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

    # FIXME check if following can't be done easier
    z = 32
    z -= input_1

    # preload data
    x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]

    # rotate c1, c2 left by input_0 = right by 32-input_0
    c1 >>>= z
    c2 >>>= z

    # start adding constant
    y = c2 ^ (x_0_1 unsigned>> 16)
    x_0_1 ^= c1
    c2 >>>= 30

    mem16[input_0] = x_0_1; input_0 += 2
    mem16[input_0] = y;     input_0 += 2

    y = c2 ^ (x_2_3 unsigned>> 16)
    x_2_3 ^= (c1 >>> 30)
    c2 >>>= 30

    mem16[input_0] = x_2_3; input_0 += 2
    mem16[input_0] = y;     input_0 += 2

    y = c2 ^ (x_4_5 unsigned>> 16)
    x_4_5 ^= (c1 >>> 28)
    c2 >>>= 30

    mem16[input_0] = x_4_5; input_0 += 2
    mem16[input_0] = y;     input_0 +=2

    #x_6_7 = mem32[input_0]
    y = c2 ^ (x_6_7 unsigned>> 16)
    x_6_7 ^= (c1 >>> 26)

    mem16[input_0] = x_6_7; input_0 += 2
    mem16[input_0] = y;     input_0 += 2

    # FIXME get better labels, except wtf that doesn't work.
    x_0_1 x_2_3 x_4_5 x_6_7 = mem128[input_0]

    # FIXME get rid of latency (related to ^)
    c2 >>>= 30

    y = c2 ^ (x_0_1 unsigned>> 16)
    x_0_1 ^= (c1 >>> 24)
    c2 >>>= 30

    mem16[input_0] = x_0_1; input_0 += 2
    mem16[input_0] = y;     input_0 += 2

    y = c2 ^ (x_2_3 unsigned>> 16)
    x_2_3 ^= (c1 >>> 22)
    c2 >>>= 30

    mem16[input_0] = x_2_3; input_0 += 2
    mem16[input_0] = y;     input_0 += 2

    y = c2 ^ (x_4_5 unsigned>> 16)
    x_4_5 ^= (c1 >>> 20)
    c2 >>>= 30

    mem16[input_0] = x_4_5; input_0 += 2
    mem16[input_0] = y;     input_0 +=2

    #x_6_7 = mem32[input_0]
    y = c2 ^ (x_6_7 unsigned>> 16)
    x_6_7 ^= (c1 >>> 18)

    mem16[input_0] = x_6_7; input_0 += 2
    mem16[input_0] = y;     input_0 += 2


    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
return


