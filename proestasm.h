#ifndef PROESTASM_H
#define PROESTASM_H

void ARM_ASM_SubBits(proest_ctx *x);
void ARM_ASM_AddConstant(proest_ctx *x, int round);
void ARM_ASM_ShiftRegisters(proest_ctx *x, int round);
#endif
