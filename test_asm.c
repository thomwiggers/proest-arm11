/* unit tests */

#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include <stdio.h>

#include "proest128.h"
#include "proestasm.h"

// not necessarily safe...
#define print_test_header(X) \
    puts("======================================"); \
    puts("  TEST " X ); \
    puts("======================================");
#define print_test_footer() \
    puts("--------------------------------------\n\n");
#define print_subtest(X) puts("  -> " X );

#define TRAILS 50


/**
 * Generate a random proest_ctx
 */
void randomize_proeststate(proest_ctx *x) {
    for (unsigned int i = 0; i < 8; i++)
        for (unsigned int j = 0; j < 4; j++)
            x->a[i][j] = (uint16_t) rand() & 0xffff;
}

/**
 * Copy x to y
 */
void copy_proeststate(proest_ctx *x, proest_ctx *y) {
    for (unsigned int i = 0; i < 4; i++)
        for (unsigned int j = 0; j < 4; j++)
            y->a[i][j] = x->a[i][j];
}

void print_proeststate(proest_ctx *x) {
    unsigned char output[32];
    proest_writestate(output, x);
    unsigned int counter = 0;
    for (unsigned int i = 0; i < 32; i++) {
        printf("%02x", output[i]);
        if (counter++ == 3) {
            counter = 0;
            printf(" ");
        }
    }
}

unsigned short test_proest_same(proest_ctx *x, proest_ctx *y) {
    assert(x != y);
    for (unsigned int i = 0; i < 4; i++) {
        for (unsigned int j = 0; j < 4; j++) {
            if (x->a[i][j] != y->a[i][j]) {
                puts("FAIL");
                printf("TEST FAILED! x[%u][%u] != y[%u][%u]\n",
                    i, j, i, j);
                printf("x: ");
                print_proeststate(x);
                printf("\ny: ");
                print_proeststate(y);
                printf("\n");
                return 0;
            }
        }
    }
    return 1;
}

void assert_proest_same(proest_ctx *x, proest_ctx *y) {
    assert(test_proest_same(x, y));
}

int test_sanity() {
    print_test_header("Sanity check of testing tools");
    proest_ctx x, y;

    print_subtest("Randomizing state x, copying x->y");
    randomize_proeststate(&x);
    copy_proeststate(&x, &y);
    assert_proest_same(&x, &y);
    print_test_footer();
    return 1;
}

extern void SubBits(proest_ctx *x);

int test_sboxes() {
    print_test_header("Checking S-Boxes");
    proest_ctx x, y;
    print_subtest("Checking if C Sbox consistent");
    for (int i = 0; i < TRAILS; i++) {
        printf("\tTest %d\t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        SubBits(&x);
        SubBits(&y);
        if(test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }

    print_subtest("Checking if C == qhasm result");
    for (int i = 0; i < TRAILS; i++) {
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        printf("\tTest %d\t", i);
        SubBits(&x);
        ARM_ASM_SubBits(&y);
        if(test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }
    
    print_test_footer();
    return 1;
}

extern void AddConstant(proest_ctx *x, int round);

int test_addconstant() {
    print_test_header("Checking AddConstant");
    proest_ctx x,y;
    print_subtest("Checking C AddConstant consistency");
    for (int i = 0; i < 16; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        AddConstant(&x, i);
        AddConstant(&y, i);
        if (test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }

    print_subtest("Checking C == qhasm result");
    for (int i = 0; i < 16; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        AddConstant(&x, i);
        ARM_ASM_AddConstant(&y, (32-i));
        if (test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }

    print_test_footer();
    return 1;
}

extern void ShiftRegisters(proest_ctx *x, int round);

int test_shiftregisters() {
    print_test_header("Checking ShiftRegisters");
    proest_ctx x, y;
    print_subtest("Checking C consistency");
    for (int i = 0; i < 16; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        ShiftRegisters(&x, i);
        ShiftRegisters(&y, i);
        if (test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }

    print_subtest("Checking C == qhasm result");
    for (int i = 0; i < 16; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        ShiftRegisters(&x, i);
        ARM_ASM_ShiftRegisters(&y, i);
        if (test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }
    print_test_footer();
    return 1;
}

extern void MixColumns(proest_ctx *x);
int test_mixcolumns() {
    print_test_header("Checking MixColumns");
    proest_ctx x, y;
    print_subtest("Checking C consistency");
    for (int i = 0; i < TRAILS; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        MixColumns(&x);
        MixColumns(&y);
        if(test_proest_same(&x, &y)) 
            puts("OK");
        else return 0;
    }


    print_subtest("Checking C == qhasm result");
    for (int i = 0; i < TRAILS; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        MixColumns(&x);
        ARM_ASM_MixColumns(&y);
        if (test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }
    print_test_footer();

    // All done
    return 1;
}

#ifdef TESTMINIMIX
int test_minimixcolumns() {
    print_test_header("Checking MiniMixColumns");
    proest_ctx x, y;

    print_subtest("Checking C == qhasm result");
    for (int i = 0; i < TRAILS; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        MixColumns(&x);
        ARM_ASM_MiniMixColumns(&y);
        if (test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }
    print_test_footer();

    // All done
    return 1;
}
#endif

int test_proest_permute() {
    print_test_header("Checking proest permute");
    proest_ctx x, y;
    print_subtest("Checking C consistency");
    for (int i = 0; i < TRAILS; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        proest_permute_C(&x);
        proest_permute_C(&y);
        if(test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }


    print_subtest("Checking C == qhasm result");
    for (int i = 0; i < TRAILS; i++) {
        printf("\tRound %d... \t", i);
        randomize_proeststate(&x);
        copy_proeststate(&x, &y);
        proest_permute_C(&x);
        proest_permute(&y);
        if (test_proest_same(&x, &y))
            puts("OK");
        else return 0;
    }

    print_test_footer();
    // All done
    return 1;
}

int main(int argv, char* argc[]) {
    srand(time(NULL));
    //srand(1);

    //tests
    assert(test_sanity());
    assert(test_sboxes());
    assert(test_addconstant());
    assert(test_shiftregisters());
    assert(test_mixcolumns());
#ifdef TESTMINIMIX
    assert(test_minimixcolumns());
#endif
    assert(test_proest_permute());
    //assert(test_proest_unrolled());

    return 0;
}
