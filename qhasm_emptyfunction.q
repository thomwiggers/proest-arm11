# Proest functions in ARM11 assembly
# Author: Thom Wiggers <thom@thomwiggers.nl>
# vim: set ts=4 sw=4 tw=0 et :

# ...

enter ARM_ASM_empty
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
