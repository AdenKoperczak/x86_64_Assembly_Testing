# Assembly Fibonacci Sequence
This is a basic Fibonacci Sequance Generator.

## main and main.c
main.c simple defines a main function that implements the CLI for this program.
Simply type in the lower and upper values (they can be separated by spaces or 
newlines) and the number of items to output, and it will output the items in the
sequence. For the classic 1, 1, 2 ... sequence lower and upper should be '1 0'.

## fib.asm and fib.h 
fib.asm and fib.h define a C compatable function (fib) which does all of the 
hard work. fib takes the count, lower, and upper, as arguments. It then returns
an array which contains the sequence. The sequence starts at the next value, 
(lower + upper) and goes from their.

### IMPORTANT
If you are useing fib in your program, you should do the following:
1. Check to make sure the returned array is not NULL.
2. Free the returned array when you are done with it.

