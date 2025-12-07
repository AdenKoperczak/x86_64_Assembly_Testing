BUILD_DIR=build

RADIX_SORT=${BUILD_DIR}/radix_sort.o
RADIX_SORT_MSB=${BUILD_DIR}/radix_sort_msb.o

main: main.c ${RADIX_SORT} ${RADIX_SORT_MSB} radix_sort.h
	gcc -g -O3 -Wall -o main main.c ${RADIX_SORT} ${RADIX_SORT_MSB}

${RADIX_SORT}: radix_sort.asm
	nasm -f elf64 -o ${RADIX_SORT} radix_sort.asm

${RADIX_SORT_MSB}: radix_sort_msb.asm
	nasm -f elf64 -o ${RADIX_SORT_MSB} radix_sort_msb.asm
