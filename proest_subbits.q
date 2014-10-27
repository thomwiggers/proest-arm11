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

