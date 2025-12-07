# Assembly Pi
This is an implementation of the [Basel Problem](https://en.wikipedia.org/wiki/Basel_problem)
approximation of Pi. Actually, it is 2 implementations (C and Assembly). asm_pi is 
the assembly implementation, while c_pi is the C implementation. The accuracy of
this program will never get better than like 5-7 digits, because of limitations
with doubles.

# asm_pi
asm_pi (in fast_pi.asm) is implemented using simd instructions. In particular it
needs a processor with AVX2 / V2. To check if your cpu has it, you can look for
acx2 in /proc/cpuinfo. The grep command below does this.
```grep "avx2" /proc/cpuinfo```
If it returns some lines from the file, you should be good.
