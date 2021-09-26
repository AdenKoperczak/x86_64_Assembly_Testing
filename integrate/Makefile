
main: main.c integrate.o integrate.h
	gcc -o main main.c integrate.o

integrate.o: integrate.asm
	nasm -f elf64 -o integrate.o integrate.asm
