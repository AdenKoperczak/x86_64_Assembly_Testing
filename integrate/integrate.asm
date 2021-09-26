global integrate

integrate:
; lower xmm0
; upper xmm1
; steps rdi
; func  rsi

; Set up the stack
    push rbp
    mov rbp, rsp

    sub rsp, 48
; save the function pointer
    mov [rbp - 8], rsi

; find the length of a single step, is equivalant to (upper - lower) / steps
    movsd xmm2, xmm1
    subsd xmm2, xmm0
    cvtsi2sd xmm3, rdi
    divsd xmm2, xmm3
; move variables to memory for function call.
    movsd [rbp - 16], xmm2 ; step
    movsd [rbp - 24], xmm1 ; upper

; clear the variable that will be the sum
    xorpd xmm1, xmm1
    movsd xmm1, [rbp - 40]

; set xmm1 to the lower value, is used as current value
    movsd xmm1, xmm0

loop:
    ; return on ending
    comisd xmm1, [rbp - 24]
    jnb ending
    
    ; do the integration

    ; save variables
    movsd [rbp - 32], xmm1
    ; call function
    movsd xmm0, xmm1
    call [rbp - 8] 
    ; recall variables
    movsd xmm1, [rbp - 32]

    ; do the summation
    addsd xmm0, [rbp - 40]
    movsd [rbp - 40], xmm0
    
    ; increment counter
    addsd xmm1, [rbp - 16]
    jmp loop

ending:
    ; do the final multiplication 
    ; xmm0 will be the sum.
    mulsd xmm0, [rbp - 16] 

    ; return
    mov rsp, rbp
    pop rbp
    ret
