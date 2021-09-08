main: fib.o fib.h main.c
	gcc -o main fib.o main.c

fib.o: fib.asm
	nasm -f elf64 -o fib.o fib.asm

