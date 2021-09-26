#include <stdio.h>
#include "integrate.h"

double test1(double x) {
    return x * x;
}

int main() {
    double   lower;
    double   upper;
    uint64_t steps;

    printf("Enter bounds and number of steps: ");
    scanf("%lf %lf %lu", &lower, &upper, &steps);

    double answer = integrate(lower, upper, steps, test1);
    printf("The integral is %lf\n", answer);

    return 0;
}
