#include <stdint.h>
/* These functions simply take the number of iterations to make (actualy 4 per)
 * and return an approximation of pi
 */

// the assembly version of this function.
double asm_pi(uint64_t);
// the c version of this function.
double c_pi(uint64_t); 
