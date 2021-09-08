main: fizzbuzz.o
	gcc -o main fizzbuzz.o

fizzbuzz.o: fizzbuzz.asm
	nasm -f elf64 -o fizzbuzz.o fizzbuzz.asm

