; make local labels local in elf.
%pragma elf    gprefix
%pragma elf    lprefix .L

global radix_sort_msb

radix_sort_msb:
    push rbp

;GET_LAST_BIT
    xor rdx, rdx
    lea r8, [rsi - 1]
.MSB_LAST_BIT_LOOP:
    or rdx, [rdi + r8 * 8]
    sub r8, 1
    jnb .MSB_LAST_BIT_LOOP

    cmp rdx, rdx

    lzcnt rdx, rdx
    jc .RADIX_SORT_MSB_RETURN ; All zeros

    mov rcx, 64
    sub rcx, rdx
    mov rdx, 1
    shl rdx, cl
    shr rdx, 1

    call .RADIX_SORT_MSB_REQ

.RADIX_SORT_MSB_RETURN:
    pop rbp
    ret




.RADIX_SORT_MSB_REQ:
    push rbp
    mov rbp, rsp
    sub rsp, 32

; lower = r10
; upper = r11

; temp = r9

; len < 2; trivially sorted
    cmp rsi, 2
    jb .RADIX_SORT_MSB_REQ_RETURN

; bit is zero; already sorted
    test rdx, rdx
    je .RADIX_SORT_MSB_REQ_RETURN

; set vars
    mov r10, -1
    mov r11, rsi

.RADIX_SORT_MSB_LOOP:

.LOWER_LOOP:
    add r10, 1
    cmp r10, r11
    je .RADIX_SORT_MSB_EQ
    test rdx, [rdi + r10 * 8]
    jz .LOWER_LOOP

.UPPER_LOOP:
    sub r11, 1
    cmp r10, r11
    je .RADIX_SORT_MSB_EQ
    test rdx, [rdi + r11 * 8]
    jnz .UPPER_LOOP

    cmp r10, r11
    jae .RADIX_SORT_MSB_EQ
    ; lower < upper

    ; swap values
    mov r9, [rdi + r10 * 8]
    xor r9, [rdi + r11 * 8]
    xor [rdi + r10 * 8], r9
    xor [rdi + r11 * 8], r9

    ; loop
    jmp .RADIX_SORT_MSB_LOOP

.RADIX_SORT_MSB_EQ:
    ; lower == upper
    shr rdx, 1 ; shift rdx

    test r10, r10
    je .RADIX_SORT_MSB_ONE_SORT
    cmp r10, rsi
    je .RADIX_SORT_MSB_ONE_SORT
    ; upper and lower in middle of array

    ; save registers
    mov [rsp +  0], rdi
    mov [rsp +  8], rsi
    mov [rsp + 16], rdx
    mov [rsp + 24], r10

    mov rsi, r10
    call .RADIX_SORT_MSB_REQ

    mov rdi, [rsp +  0]
    mov rsi, [rsp +  8]
    mov rdx, [rsp + 16]
    mov r10, [rsp + 24]

    lea rdi, [rdi + 8 * r10]
    sub rsi, r10
    call .RADIX_SORT_MSB_REQ
    jmp .RADIX_SORT_MSB_REQ_RETURN


.RADIX_SORT_MSB_ONE_SORT:
    ; lower == length || lower == 0
    call .RADIX_SORT_MSB_REQ

.RADIX_SORT_MSB_REQ_RETURN:
    mov rsp, rbp
    pop rbp
    ret
