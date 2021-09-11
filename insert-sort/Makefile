BUILD_DIR=build

INSERT_SORT=${BUILD_DIR}/insert_sort.o

main: main.c ${INSERT_SORT} insert_sort.h
	gcc -Wall -o main main.c ${INSERT_SORT}

${INSERT_SORT}: insert_sort.asm
	nasm -f elf64 -o ${INSERT_SORT} insert_sort.asm

