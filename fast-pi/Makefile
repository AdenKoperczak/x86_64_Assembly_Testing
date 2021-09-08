main: build/asm.o build/c.o main.c fast_pi.h
	gcc -o main build/asm.o build/c.o main.c -lm

build/asm.o: fast_pi.asm
	nasm -f elf64 -o build/asm.o fast_pi.asm

build/c.o: pi.c
	gcc -O2 -c -o build/c.o pi.c 
