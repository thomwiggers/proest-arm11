#ifndef PROESTASM_H
#define PROESTASM_H

void ARM_ASM_SubBits(proest_ctx *x);
void ARM_ASM_AddConstant(proest_ctx *x, int round);
void ARM_ASM_ShiftRegisters(proest_ctx *x, int round);
void ARM_ASM_MixColumns(proest_ctx *x);
void ARM_ASM_MiniMixColumns(proest_ctx *x);
void ARM_ASM_SubBits_MixColumns(proest_ctx *x);
void ARM_ASM_proest128_permute(proest_ctx *x);
void ARM_ASM_proest_unrolled(proest_ctx *x);
#endif
