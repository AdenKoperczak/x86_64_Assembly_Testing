#include <stdint.h>

/* A function which makes a fibonacci sequence
 * Lower and upper are the first and second items in the sequence
 * Count is the number of new items to make
 * It returnes a pointer to an array of length count (or null).
 * The first item in the array will the the next item in the fibonacci sequence
 * (lower + upper)
 */
int64_t *fib(uint64_t count, int64_t lower, int64_t upper);
