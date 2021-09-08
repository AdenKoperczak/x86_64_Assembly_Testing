global main

; External functions
extern printf
extern scanf

; variables
%define counter [rbp - 32]
%define max     [rbp - 24]
%define five_c  [rbp - 16]
%define three_c [rbp -  8]

SECTION .text
main:
    ; enter the function
    push rbp
    push rbx
    mov rbp, rsp
    sub rsp, 40 ; 40 because of alignment. rbx is pushed.
    
    ; initalize variables
    mov QWORD counter, 1
    mov QWORD five_c,  1
    mov QWORD three_c, 1

    ; print prompt
    mov rdi, prompt
    call printf wrt ..plt

    ; get input
    mov rdi, input
    lea rsi, max
    call scanf wrt ..plt

    ; check if loop is needed (aka max > 0)
    cmp QWORD max, 0
    je return

loop:
    ; reset rbx
    xor rbx, rbx
; run_fizz
    ; see if fizz needs to be printed
    cmp QWORD three_c, 3
    jne run_buzz
    
    ; print fizz, and set rbx, so no number, and reset three counter
    mov QWORD three_c, 0
    mov rbx, 1
    mov rdi, fizz
    call printf wrt ..plt

run_buzz:
    ; see if buzz needs to be printed
    cmp QWORD five_c, 5
    jne final
    
    ; print buzz and set rbx. so no number, and reset five counter
    mov QWORD five_c, 0
    mov rbx, 1
    mov rdi, buzz
    call printf wrt ..plt

final:
    ; check if the number should be printed
    cmp rbx, 0
    jne no_num
    
    ; print the number
    mov rdi, number
    mov rsi, counter    
    call printf wrt ..plt

no_num:
    ; print the newline
    mov rdi, newline
    call printf wrt ..plt

    ; increment the three and five counters
    inc QWORD three_c
    inc QWORD five_c

    ; increment the counter
    inc QWORD counter
    mov rax, counter

    ; loop when the counter is lessthan or equal to the max
    cmp rax, max
    jng loop

return:
    ; set the return value to be zero
    xor rax, rax

    ; return from the function
    mov rsp, rbp
    pop rbx
    pop rbp
    ret
    

SECTION .data
    prompt:  db 'Enter the last number: ', 0
    input:   db '%lu', 0
    fizz:    db 'fizz', 0
    buzz:    db 'buzz', 0
    newline: db 10,0
    number:  db '%lu', 0
