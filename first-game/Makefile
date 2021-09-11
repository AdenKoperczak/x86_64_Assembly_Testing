main: main.o
	gcc main.o -o main

main.o: main.asm
	nasm -o main.o -f elf64 main.asm
