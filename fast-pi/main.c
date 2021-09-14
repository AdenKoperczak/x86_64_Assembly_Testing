#include <stdio.h>
#include "fast_pi.h"
#include <math.h>

int main() {
    // get the number of iterations
    uint64_t num;
    printf("Enter number of iterations: ");
    scanf("%lu", &num);
  
    // get the outputs, and print them
    printf("real: %.15lf\n", M_PI);
    printf(" asm: %.15lf\n", asm_pi(num));
    printf("   C: %.15lf\n", c_pi(num));

    return 0;
}
