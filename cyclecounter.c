#include <stdlib.h>
#include <stdio.h>
#include "dev4ns.h"
#include "proest128.h"

const unsigned long long N_ROUNDS = 1000000;

/**
 * Generate a random proest_ctx
 */
void randomize_proeststate(proest_ctx *x) {
    for (unsigned int i = 0; i < 4; i++)
        for (unsigned int j = 0; j < 4; j++)
            x->a[i][j] = (uint16_t) rand() & 0xffff;
}

int compare (const void *a, const void *b) {
    return ( *(int*) a - *(int*) b );
}

int main(int argv, char* argc[]) {
    unsigned long long cycles;
    
    unsigned long long results[N_ROUNDS];
    proest_ctx x;

    printf("Measuring C implementation\n");
    printf("Measuring %llu rounds\n", N_ROUNDS);
    for (unsigned long long round = 0; round < N_ROUNDS; round++) {
        randomize_proeststate(&x);
        cycles = cpucycles();
        proest_permute_C(&x);
        results[round] = cpucycles() - cycles;
        //printf("Round %d: %llu cycles\n", round, results[round]);
    }

    printf("Sorting...\n");
    qsort(results, N_ROUNDS, sizeof(unsigned long long), compare);

    puts("Statistics:");
    printf("\tMinimum amount of cycles: %llu\n", results[0]);
    printf("\tMaximum amount of cycles: %llu\n", results[N_ROUNDS-1]);
    printf("\tMedian  amount of cycles: %llu\n", results[N_ROUNDS/2]);

    puts("\nMeasuring ASM implementation");
    printf("Measuring %llu rounds\n", N_ROUNDS);
    for (unsigned long long round = 0; round < N_ROUNDS; round++) {
        randomize_proeststate(&x);
        cycles = cpucycles();
        proest_permute(&x);
        results[round] = cpucycles() - cycles;
        //printf("Round %d: %llu cycles\n", round, results[round]);
    }

    printf("Sorting...\n");
    qsort(results, N_ROUNDS, sizeof(unsigned long long), compare);
    
    puts("Statistics:");
    printf("\tMinimum amount of cycles: %llu\n", results[0]);
    printf("\tMaximum amount of cycles: %llu\n", results[N_ROUNDS-1]);
    printf("\tMedian  amount of cycles: %llu\n", results[N_ROUNDS/2]);
}


        
