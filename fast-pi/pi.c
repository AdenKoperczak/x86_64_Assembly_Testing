#include "fast_pi.h"
#include <math.h>

double c_pi(uint64_t num) {
  // literaly just a strait implemention of this. the only odd thing is is num*4
  double sum = 0;
  for (uint64_t i = 1; i <= num * 4; i++) {
    sum += 1 / ((double)(i * i));
  }

  return sqrt(sum * 6);
}
