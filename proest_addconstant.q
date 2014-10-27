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

int32 base
int32 ctr
int32 c1
int32 c2
int32 round

enter ARM_ASM_AddConstant
    caller_r4_stack = caller_r4
    caller_r5_stack = caller_r5
    caller_r6_stack = caller_r6

    # input_0 => proest_ctx
    # input_1 => rounds

    c1 = 0x75817581
    c2 = 0xb2c5b2c5
    # FIXME volgende berekening proberen te fixen.
    z = 32
    z -= input_1

    c1 >>>= z
    c2 >>>= z

    base = input_0
    ctr = 16
    #FIXME UNROLL
    loop_addconstant:
        x = mem16[base]
        y = mem16[base + 2]
        x ^= c1
        y ^= (c2 >>> 31) #c2 always +1, use free shift
        c1 >>>= 30
        c2 >>>= 30
        
        mem16[base] = x; base += 2
        mem16[base] = y; base += 2
        
        unsigned>? ctr -= 2
        goto loop_addconstant if unsigned>
        
    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
return


