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
        p = mem16[base + 0]
        q = mem16[base + 2]

        # bits[0] = bits[2] ^ (p & q)
        x = p & q
        y = mem16[base + 4]
        x ^= y

        # bits[1] = bits[3] ^ (q & bits[2])
        # y = bits[2]
        y &= q
        z = mem16[base + 6]
        y ^= z
        x |= (y << 16) # append y back to x
        mem32[base + 0] = x
        
        # bits[2] = p ^ (bits[0] & bits[1])
        x = mem32[base + 0]
        x &= (x unsigned>> 16)
        x ^= p # x = bits[2]
        
        # bits[3] = q ^ (bits[1] & bits[2])
        z = mem16[base + 2]
        z &= x
        z ^= q
        x |= (z << 16) # append y back to x        
        mem32[base + 4] = x
        
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
        x = mem16[base]
        x |= (x << 16)
        x >>>= 2
        mem16[base] = x; base += 2
     
        # x[1][1]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 2
        mem16[base] = x; base += 2
     
        # x[1][2]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 2
        mem16[base] = x; base += 2
     
        # x[1][3]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 2
        mem16[base] = x; base += 2
     
        # x[2][0]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 4
        mem16[base] = x; base += 2
 
        # x[2][1]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 4
        mem16[base] = x; base += 2
 
        # x[2][2]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 4
        mem16[base] = x; base += 2
 
        # x[2][3]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 4
        mem16[base] = x; base += 2
 
        # x[3][0]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 6
        mem16[base] = x; base += 2
 
        # x[3][1]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 6
        mem16[base] = x; base += 2
 
        # x[3][2]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 6
        mem16[base] = x; base += 2
 
        # x[3][3]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 6
        mem16[base] = x; base += 2
    
    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
    return
 
    shiftregisters_odd:
        # x[1][0]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 1
        mem16[base] = x; base += 2
     
        # x[1][1]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 1
        mem16[base] = x; base += 2
     
        # x[1][2]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 1
        mem16[base] = x; base += 2
     
        # x[1][3]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 1
        mem16[base] = x; base += 2
     
        # x[2][0]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 8
        mem16[base] = x; base += 2
 
        # x[2][1]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 8
        mem16[base] = x; base += 2
 
        # x[2][2]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 8
        mem16[base] = x; base += 2
 
        # x[2][3]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 8
        mem16[base] = x; base += 2
 
        # x[3][0]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 9
        mem16[base] = x; base += 2
 
        # x[3][1]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 9
        mem16[base] = x; base += 2
 
        # x[3][2]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 9
        mem16[base] = x; base += 2
 
        # x[3][3]
        x = mem16[base]
        x |= (x << 16)
        x >>>= 9
        mem16[base] = x; base += 2
    
    caller_r4 = caller_r4_stack
    caller_r5 = caller_r5_stack
    caller_r6 = caller_r6_stack
return
