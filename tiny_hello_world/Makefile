hello_world: hello_world_large remove_section_header.py
	./remove_section_header.py hello_world_large hello_world

hello_world_large: hello_world.o
	ld hello_world.o -o hello_world_large -Ttext=80 -s

hello_world.o: hello_world.asm Makefile
	nasm -f elf64 -o hello_world.o hello_world.asm -O2
