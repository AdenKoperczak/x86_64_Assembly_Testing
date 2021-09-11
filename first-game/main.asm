global main

; exernals
extern printf
extern scanf
extern srand
extern rand
extern time

; variables
%define response [rbp-8]

SECTION .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 16

; Setup random from current time
    mov rdi, 0
    call time wrt ..plt
    
    mov rdi, rax
    call srand wrt ..plt

    jmp loop

; I gues this is kind of part of the main game loop
; it just prints the lose message.
lose:
    mov rdi, lose_str
    call printf wrt ..plt
    
; The main game loop
loop:
    ; prompt the user for a number
    mov rdi, prompt
    call printf wrt ..plt

    ; get the number from the user
    mov rdi, scanf_str
    lea rsi, response
    call scanf wrt ..plt

    ; Check if the number is valid
    mov rcx, response
    cmp rcx, 0
    jl invalid

    cmp rcx, 9
    jg invalid

;valid
    ; get the random number
    call rand wrt ..plt
    mov rdx, 0
    mov rcx, 10
    div rcx
    
    ; set up registor for printing
    mov rsi, response

    ; check if their number is correct
    cmp rdx, rsi
    jne lose

;win
    mov rdi, win_str
    call printf wrt ..plt
    
; The return code
    mov rsp, rbp
    pop rbp
    ret

invalid:
    mov rdi, inv_str
    mov rsi, response
    call printf wrt ..plt
    jmp loop

SECTION .data
    prompt:    db 'Enter Your Guess (0-9): ',0
    scanf_str: db '%ld',0
    win_str:   db 'Your guess %ld was correct. You Win.',10,0
    lose_str:  db 'Your guess %ld was incorrect. It should have been %ld. Try Again.',10,0
    inv_str:   db 'Your guess %ld was invalid. Try Again.',10,0
