# Assembly FizzBuzz
This is an x86_64 assembly implementation of the classic job interview challenge 
[fizzbuzz](https://en.wikipedia.org/wiki/Fizz_buzz). It is a 100% assembly, and 
only one function (I know it would be better to break it up). Simply run the 
program, and input the last number you want it to output for, and it will count 
up to that number using classic fizzbuzz rules.

## Implementation
This program uses an implementation that I came up with on my own, but I doubt
I was the first to come up with it. It uses three counters, one for which number
it is currently on, one for fizz, and one for buzz. All counters are incremented 
on each loop. When the fizz or the buzz counters reach their corresponding value
(3 for fizz, 5 for buzz) a message is printed, and the counter is set to zero. This 
should be quite fast (as far as an algorithm goes) because it avoids using
division/modulo, and reduces the number of times memory must be accessed.
