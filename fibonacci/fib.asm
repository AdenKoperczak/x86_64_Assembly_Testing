global fib

extern calloc

fib:
    ; Set up stack stuff
    push rbp
    mov rbp, rsp
    sub rsp, 32

    ; save variables for calloc call
    mov [rbp - 16], rdi
    mov [rbp - 24], rsi
    mov [rbp - 32], rdx

    ; call calloc
    mov rdi, [rbp - 16]
    mov rsi, 8
    call calloc wrt ..plt
    ; make sure output is not null
    
    cmp rax, 0
    je return

    ; Variables in fib
    mov rdi, rax        ; int64_t *arr 
    mov rsi, [rbp - 16] ; uint64_t count
    mov rdx, [rbp - 24] ; int64_t lower
    mov rcx, [rbp - 32] ; int64_t upper

    ; check to make sure that some number of iterations are needed
    cmp rsi, 0
    je return

    ; r8 will be a counter (thing i in a for loop) set r8 to zero
    xor r8, r8

loop:
    ; r9 is a tempary copy of upper
    ; do an iteration
    mov r9, rcx
    add rcx, rdx
    mov rdx, r9
    
    ; add the output ot the array
    mov [rdi + r8 * 8], rcx
    
    ; increment count and loop if needed.
    inc r8
    cmp r8, rsi
    jb loop

    ; return with stack stuff
return:
    mov rsp, rbp
    pop rbp
    ret
