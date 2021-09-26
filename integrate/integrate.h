#include <stdint.h>

double integrate(double lower, double upper, uint64_t steps, double (*func)(double));
