# x86_64_Assembly_Testing
Just some testing and learning I have been doing in x86_64 assembly.

All of this code was assembled on the Ubuntu Linux Subsystem for Windows. I 
make no guarantees that it will work there or anywhere else. It is 64 bit 
assembly, and my assembler of choice is nasm. I use gcc to link in most cases. 
See each README.md for more details on individual projects.

## Use of main.c
Many of these examples use a `main.c` file. These files only contian code which
uses the function defined in the assembly file. This is done becasue assembly
takes time so it is easier to write a C program which uses the assembly. I think
of the assembly as a library, and the C as an example of how to use it.
