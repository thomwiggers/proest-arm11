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

int32 p
int32 q
int32 x
int32 y
int32 z
int32 ctr
int32 base

enter ARM_ASM_SubBits
    caller_r4_stack = caller_r4
    caller_r5_stack = caller_r5
    caller_r6_stack = caller_r6

    # Start of a[0] = input_0
    ctr = 4
    base = input_0
    loop_subbits:
        # p = bits[0], q = bits[1]
        p = mem32[base + 0]

        # bits[0] = bits[2] ^ (p & q)
        x = p & (p unsigned>> 16)
        y = mem16[base + 4]
        x ^= y
        mem16[base + 0] = x

        # bits[1] = bits[3] ^ (q & bits[2])
        # y = bits[2]
        y = mem16[base + 4]
        y &= (p unsigned>> 16)
        z = mem16[base + 6]
        y ^= z
        mem16[base + 2] = y
        
        # bits[2] = p ^ (bits[0] & bits[1])
        x = mem32[base + 0]
        x &= (x unsigned>> 16)
        x ^= p # x = bits[2]
        mem16[base + 4] = x
        
        # bits[3] = q ^ (bits[1] & bits[2])
        z = mem32[base + 2]
        z &= (z unsigned>> 16)
        z ^= (p unsigned>> 16)
        mem16[base + 6] = z
        
        #  JUMP
        base += 8
        unsigned>? ctr -= 1
        goto loop_subbits if unsigned>

    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack

return

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

int32 x_1_0
int32 x_1_1
int32 x_1_2
int32 x_1_3
int32 x_2_0
int32 x_2_1
int32 x_2_2
int32 x_2_3
int32 x_3_0
int32 x_3_1
int32 x_3_2
int32 x_3_3


enter ARM_ASM_ShiftRegisters
    caller_r4_stack = caller_r4
    caller_r5_stack = caller_r5
    caller_r6_stack = caller_r6
 
    #input_0: proest_ctx
    #input_1: rounds
    
    base = input_0 + 8 # first rotate is zero
    x = input_1 & 1
    # FIXME uitzoeken of dit niet zonder deze test kan mbv ands
    =? x - 1 
    goto shiftregisters_odd if =

        # x[1][0]
        # x[1][1]
        # x[1][2]
        x_1_0 = mem16[base]
        x_1_1 = mem16[base + 2]
        x_1_2 = mem16[base + 4]
        x_1_0 |= (x_1_0 << 16)
        x_1_1 |= (x_1_1 << 16)
        x_1_2 |= (x_1_2 << 16)
        x_1_0 >>>= 2
        x_1_1 >>>= 2
        x_1_2 >>>= 2
        mem16[base] = x_1_0; base += 2
        mem16[base] = x_1_1; base += 2
        mem16[base] = x_1_2; base += 2
     
        # x[1][3]
        # x[2][0]
        # x[2][1]
        x_1_3 = mem16[base]
        x_2_0 = mem16[base + 2]
        x_2_1 = mem16[base + 4]
        x_1_3 |= (x_1_3 << 16)
        x_2_0 |= (x_2_0 << 16)
        x_2_1 |= (x_2_1 << 16)
        x_1_3 >>>= 2
        x_2_0 >>>= 4
        x_2_1 >>>= 4
        mem16[base] = x_1_3; base += 2
        mem16[base] = x_2_0; base += 2
        mem16[base] = x_2_1; base += 2
 
        # x[2][2]
        # x[2][3]
        # x[3][0]
        x_2_2 = mem16[base]
        x_2_3 = mem16[base + 2]
        x_3_0 = mem16[base + 4]
        x_2_2 |= (x_2_2 << 16)
        x_2_3 |= (x_2_3 << 16)
        x_3_0 |= (x_3_0 << 16)
        x_2_2 >>>= 4
        x_2_3 >>>= 4
        x_3_0 >>>= 6
        mem16[base] = x_2_2; base += 2
        mem16[base] = x_2_3; base += 2
        mem16[base] = x_3_0; base += 2
 
        # x[3][1]
        # x[3][2]
        # x[3][3]
        x_3_1 = mem16[base]
        x_3_2 = mem16[base + 2]
        x_3_3 = mem16[base + 4]
        x_3_1 |= (x_3_1 << 16)
        x_3_2 |= (x_3_2 << 16)
        x_3_3 |= (x_3_3 << 16)
        x_3_1 >>>= 6
        x_3_2 >>>= 6
        x_3_3 >>>= 6
        mem16[base] = x_3_1; base += 2
        mem16[base] = x_3_2; base += 2
        mem16[base] = x_3_3; base += 2
    
    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
    return
 
    shiftregisters_odd:
        # x[1][0]
        # x[1][1]
        # x[1][2]
        x_1_0 = mem16[base]
        x_1_1 = mem16[base + 2]
        x_1_2 = mem16[base + 4]
        x_1_0 |= (x_1_0 << 16)
        x_1_1 |= (x_1_1 << 16)
        x_1_2 |= (x_1_2 << 16)
        x_1_0 >>>= 1
        x_1_1 >>>= 1
        x_1_2 >>>= 1
        mem16[base] = x_1_0; base += 2
        mem16[base] = x_1_1; base += 2
        mem16[base] = x_1_2; base += 2
     
        # x[1][3]
        # x[2][0]
        # x[2][1]
        x_1_3 = mem16[base]
        x_2_0 = mem16[base + 2]
        x_2_1 = mem16[base + 4]
        x_1_3 |= (x_1_3 << 16)
        x_2_0 |= (x_2_0 << 16)
        x_2_1 |= (x_2_1 << 16)
        x_1_3 >>>= 1
        x_2_0 >>>= 8
        x_2_1 >>>= 8
        mem16[base] = x_1_3; base += 2
        mem16[base] = x_2_0; base += 2
        mem16[base] = x_2_1; base += 2
 
        # x[2][2]
        # x[2][3]
        # x[3][0]
        x_2_2 = mem16[base]
        x_2_3 = mem16[base + 2]
        x_3_0 = mem16[base + 4]
        x_2_2 |= (x_2_2 << 16)
        x_2_3 |= (x_2_3 << 16)
        x_3_0 |= (x_3_0 << 16)
        x_2_2 >>>= 8
        x_2_3 >>>= 8
        x_3_0 >>>= 9
        mem16[base] = x_2_2; base += 2
        mem16[base] = x_2_3; base += 2
        mem16[base] = x_3_0; base += 2
 
        # x[3][1]
        # x[3][2]
        # x[3][3]
        x_3_1 = mem16[base]
        x_3_2 = mem16[base + 2]
        x_3_3 = mem16[base + 4]
        x_3_1 |= (x_3_1 << 16)
        x_3_2 |= (x_3_2 << 16)
        x_3_3 |= (x_3_3 << 16)
        x_3_1 >>>= 9
        x_3_2 >>>= 9
        x_3_3 >>>= 9
        mem16[base] = x_3_1; base += 2
        mem16[base] = x_3_2; base += 2
        mem16[base] = x_3_3
    
    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
return

enter ARM_ASM_MixColumns
    caller_r4_stack = caller_r4
    caller_r5_stack = caller_r5
    caller_r6_stack = caller_r6
 
    # put 32B on stack
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
    x = mem16[input_0 + 0]
    y = mem16[input_0 + 8] # x[4]
    x ^= y
    z = mem16[input_0 + 14] # x[7]
    x ^= z
    z = mem16[input_0 + 20] # x[10]
    x ^= z
    z = mem16[input_0 + 24] # x[12]
    x ^= z
    z = mem16[input_0 + 28] # x[14]
    x ^= z
    z = mem16[input_0 + 30] # x[15]
    x ^= z

    # Push x on stack as newx[0]
    newx_0 = x

    # newx[1] = x[1] + x[4] + x[11] + x[12] + x[15]
    x = mem16[input_0 + 2]
    z = mem16[input_0 + 30] # x[15], already loaded!
    x ^= z
    y = mem16[input_0 + 8]  # x[4] already loaded!
    x ^= y
    z = mem16[input_0 + 22]   # x[11]
    x ^= z
    z = mem16[input_0 + 24]   # x[12]
    x ^= z

    # push x on stack as newx[1]
    newx_1 = x

    # newx[2] = x[2] + x[5] + x[8] + x[9] + x[12]
    x = mem16[input_0 + 4]
    x ^= z                  # z = x[12] from previous segment
    z = mem16[input_0 + 10]
    x ^= z
    z = mem16[input_0 + 16]
    x ^= z
    z = mem16[input_0 + 18]
    x ^= z

    # push x on stack as newx[2]
    newx_2 = x

    # newx[3] = x[3] + x[6] + x[9] + x[10] + x[13]
    x = mem16[input_0 + 6]
    x ^= z                 # z = x[9] from previous segment
    z = mem16[input_0 + 12]
    x ^= z
    z = mem16[input_0 + 26]
    x ^= z
    z = mem16[input_0 + 20]
    x ^= z

    # push x on stack as newx[3]
    newx_3 = x

    # newx[4] = x[0] + x[3] + x[4] + x[8] + x[10] + x[11] + x[14]
    x = mem16[input_0 + 0]
    x ^= z                  # z = x[10] 
    z = mem16[input_0 + 6]
    x ^= z
    z = mem16[input_0 + 8]
    x ^= z
    z = mem16[input_0 + 28]
    x ^= z
    y = mem16[input_0 + 16]
    x ^= y
    z = mem16[input_0 + 22]
    x ^= z

    # push x on stack as newx[4]
    newx_4 = x

    # newx[5] = x[0] + x[5] + x[8] + x[11] + x[15]
    x = mem16[input_0 + 0]
    x ^= z                  # z = x[11]
    x ^= y                  # y = x[8]
    z = mem16[input_0 + 10]
    x ^= z
    z = mem16[input_0 + 30]
    x ^= z

    # push x on stack as newx[5]
    newx_5 = x

    # newx[6] = x[1] + x[6] + x[8] + x[12] + x[13]
    x = mem16[input_0 + 2]
    x ^= y                 # y = x[8]
    z = mem16[input_0 + 12]
    x ^= z
    z = mem16[input_0 + 24]
    x ^= z
    z = mem16[input_0 + 26]
    x ^= z

    # push x on stack as newx[6]
    newx_6 = x

    # newx[7] = x[2] + x[7] + x[9] + x[13] + x[14]
    x = mem16[input_0 + 4]
    x ^= z                 # x[13]
    z = mem16[input_0 + 14]
    x ^= z
    z = mem16[input_0 + 18]
    x ^= z
    z = mem16[input_0 + 28]
    x ^= z
    newx_7 = x

    # newx[8] = x[2] + x[4] + x[6] + x[7] + x[8] + x[12] + x[15]
    x = mem16[input_0 + 4]
    z = mem16[input_0 + 8]
    x ^= z
    z = mem32[input_0 + 12]
    x ^= z
    #z = mem16[input_0 + 14]
    x ^= (z unsigned>> 16)
    z = mem16[input_0 + 16]
    x ^= z
    z = mem16[input_0 + 24]
    x ^= z
    z = mem16[input_0 + 30]
    x ^= z

    # push x on stack as newx[8]
    newx_8 = x

    # newx[9] = x[3] + x[4] + x[7] + x[9] + x[12]
    x = mem32[input_0 + 6]
    x ^= (x unsigned>> 16)
    z = mem16[input_0 + 14]
    x ^= z
    z = mem16[input_0 + 18]
    x ^= z
    z = mem16[input_0 + 24]
    x ^= z

    # push x on stack as newx[9]
    newx_9 = x

    # newx[10] = x[0] + x[1] + x[4] + x[10] + x[13]
    x = mem32[input_0 + 0]
    x ^= (x unsigned>> 16)
    z = mem16[input_0 + 8]
    x ^= z
    z = mem16[input_0 + 20]
    x ^= z
    z = mem16[input_0 + 26]
    x ^= z

    # push x on stack as newx[10]
    newx_10 = x
    
    # newx[11] = x[1] + x[2] + x[5] + x[11] + x[14]
    x = mem32[input_0 + 2]
    x ^= (x unsigned>> 16) # x[2]
    z = mem16[input_0 + 10]
    x ^= z
    z = mem16[input_0 + 22]
    x ^= z
    z = mem16[input_0 + 28]
    x ^= z

    # push x on stack as newx[11]
    newx_11 = x

    # newx[12] = x[0] + x[2] + x[3] + x[6] + x[8] + x[11] + x[12]
    x = mem16[input_0 + 0]
    z = mem32[input_0 + 4]
    x ^= z
    x ^= (z unsigned>> 16)
    z = mem32[input_0 + 12]
    x ^= z
    z = mem32[input_0 + 16]
    x ^= z
    z = mem32[input_0 + 22]
    x ^= z
    z = mem32[input_0 + 24]
    x ^= z
    
    # write back into 12, we don't need it anymore
    mem16[input_0 + 24] = x

    # newx[13] = x[0] + x[3] + x[7] + x[8] + x[13]
    x = mem16[input_0 + 0]
    z = mem16[input_0 + 6]
    x ^= z
    z = mem32[input_0 + 14]
    x ^= z
    x ^= (z unsigned>> 16)
    z = mem16[input_0 + 26]
    x ^= z
    
    # write back into 13, we don't need it anymore
    mem16[input_0 + 26] = x

    # newx[14] = x[0] + x[4] + x[5] + x[9] + x[14]
    x = mem16[input_0 + 0]
    z = mem32[input_0 + 8]
    x ^= z
    x ^= (z unsigned>> 16)
    z = mem16[input_0 + 18]
    x ^= z
    z = mem16[input_0 + 28]
    x ^= z

    # write back into 14, we don't need it anymore
    # TODO merge with below
    mem16[input_0 + 28] = x

    # x[15] = x[1] + x[5] + x[6] + x[10] + x[15]
    x = mem16[input_0 + 2]
    z = mem32[input_0 + 10]
    x ^= z
    x ^= (z unsigned>> 16)
    z = mem16[input_0 + 20]
    x ^= z
    z = mem16[input_0 + 30]
    x ^= z
    # write back into 15, we don't need it anymore.
    mem16[input_0 + 30] = x

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

    x = newx_10
    mem16[input_0 + 20] = x

    x = newx_11
    mem16[input_0 + 22] = x

    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
return
