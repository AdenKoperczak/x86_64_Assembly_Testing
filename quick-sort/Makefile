BUILD_DIR=build

QUICK_SORT=${BUILD_DIR}/quick_sort.o

main: main.c ${QUICK_SORT} quick_sort.h
	gcc -Wall -o main main.c ${QUICK_SORT}

${QUICK_SORT}: quick_sort.asm
	nasm -f elf64 -o ${QUICK_SORT} quick_sort.asm

