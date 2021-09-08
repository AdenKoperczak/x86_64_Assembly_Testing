SECTION .text

GLOBAL asm_pi
asm_pi:
    ; Set up the stack.
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    ; make sure that rdi is not 0
    cmp rdi, 0
    je return_0

    ; set up registers.
    vmovupd ymm1, [rel init] ; is the incrementor(s). Will start as 1, 2, 3, 4 and each will go up by 4 every cycle 
    vxorpd  ymm3, ymm3       ; The "sum". This uses horizontal add for speed, so it will not actualy be the sum, but close.
    vmovupd ymm4, [rel incr] ; will be used to increment the incrementor(s)/ymm1
    vmovupd ymm5, [rel ones] ; will be used in taking the invers

loop:
    ; Do the 1 / (i**2) part
    vmovapd ymm2, ymm1
    vmulpd  ymm2, ymm2, ymm2
    vdivpd  ymm2, ymm5, ymm2
    ; add it to the sum
    vaddpd  ymm3, ymm3, ymm2

    ; invrement the incrementor(s)
    vaddpd ymm1, ymm1, ymm4

    ; for counting iterations.
    dec rdi
    jnz loop  

    ; move the contents of the sum into memory
    vmovupd [rbp-32], ymm3
    
    ; set xmm0 to 0, and get the actual sum.
    xorpd  xmm0, xmm0
    addsd  xmm0, [rbp-32]
    addsd  xmm0, [rbp-24]
    addsd  xmm0, [rbp-16]
    addsd  xmm0, [rbp-8]

    ; do the sqrt(sum * 6) portion.
    mulsd  xmm0, [rel six]
    sqrtsd xmm0, xmm0
    
    ; return properly
return:
    mov rsp, rbp
    pop rbp
    ret
    ; return 0 
return_0:
    xorpd xmm0, xmm0
    jmp return

SECTION .data
    init: dq 1.0, 2.0, 3.0, 4.0 ; The inital value(s) of the incrementor(s)
    zero: dq 0.0, 0.0, 0.0, 0.0 ; all zeros
    incr: dq 4.0, 4.0, 4.0, 4.0 ; what to increment by
    ones: dq 1.0, 1.0, 1.0, 1.0 ; all ones.
    six:  dq 6.0, 6.0, 6.0, 6.0 ; all sixes (i think i only use one).
