# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

int32 x

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
    mem32[input_0 + 52] = caller_r4
    mem32[input_0 + 56] = caller_r5
    mem32[input_0 + 60] = caller_r6
    storesp[input_0 + 64]
 
    #input_0: proest_ctx
    #input_1: rounds
    

    =? x = input_1 & 1
    goto shiftregisters_odd if !=

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
    return
 
    shiftregisters_odd:
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
return


