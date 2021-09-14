#include "fib.h"
#include <stdio.h>
#include <stdlib.h>

/* ============================================================================
 * Wrapper code for my fib function.
 * ============================================================================ */

int main() {
    int64_t lower;  // The lower number
    int64_t upper;  // The upper number
    uint64_t count; // The number of inputs to take

    // Get lower and upper
    printf("Enter starting values: ");
    scanf("%ld", &lower);
    scanf("%ld", &upper);

    // Get count
    printf("Enter number of iterations: ");
    scanf("%lu", &count);

    // Get the fibonacci sequence
    int64_t * arr = fib(count, lower, upper);

    // Check for errors in memory allocation
    if (arr == NULL) {
      printf("An error occurred in memory allocation. Maybe count is to large, or zero?\n");
      return 1;
    }

    // print the sequence.
    for (uint64_t i = 0; i < count; i++) {
      printf("%ld ", arr[i]);
    }
    printf("\n");

    free(arr);

    return 0;
}
