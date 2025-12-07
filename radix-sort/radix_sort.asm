; make local labels local in elf.
%pragma elf    gprefix 
%pragma elf    lprefix .L

global radix_sort

extern malloc
extern free

;reg mapping: 
;list         = rdi, 
;length       = rsi,
;lower_start  = rax,
;upper_start  = rcx,
;bit          = rdx,
;i            = r8,
;second_list  = r9,
;temp         = r10
;last_set_inv = r11

radix_sort:
    push rbp
    mov rbp, rsp
    shl rsi, 3

    sub rsp, 32
    mov [rsp], rdi
    mov [rsp + 8], rsi

    mov rdi, rsi
    
    call malloc wrt ..plt
    
    mov r9, rax
    mov [rsp + 16], rax

    test rax, rax
    jz .return_err 

    mov rdi, [rsp]
    mov rsi, [rsp + 8]

    cmp rsi, 16
    jb  .return

    test rdi, rdi
    jz .return_err

;get last bit
    xor r11, r11 
    lea r8, [rsi - 8]
.last_bit_loop:
    or r11, [rdi + r8]
    sub r8, 8
    jnb .last_bit_loop

    cmp r11, r11
    
    lzcnt r11, r11
    jc .return ; All zeros
    
    mov rcx, 64
    sub rcx, r11
    mov r11, 1
    shl r11, cl
    not r11
    
    mov rdx, 1
.bit_loop:
    mov rcx, 0
    lea r8, [rsi - 8]
    
.count_loop:
    test rdx, [rdi + r8]
    jne .count_loop_iterate
    
    add rcx, 8
.count_loop_iterate:
    sub r8, 8
    jnb .count_loop

    ; test if all same.
    test rcx, rcx
    je .bit_loop_iterate
    cmp rcx, rsi
    je .bit_loop_iterate
    
    mov r8, 0
    mov rax, 0
.reorder_loop:
    mov r10, [rdi + r8]
    test rdx, r10
    jne .reorder_loop_set

;.reorder_loop_not_set
    mov [r9 + rax], r10
    add rax, 8
    jmp .reorder_loop_iterate

.reorder_loop_set:
    mov [r9 + rcx], r10
    add rcx, 8

.reorder_loop_iterate:
    add r8, 8
    cmp r8, rsi
    jb .reorder_loop

;.flip lists
    xor rdi, r9
    xor r9,  rdi
    xor rdi, r9

.bit_loop_iterate:
    shl rdx, 1
    test rdx, r11
    jne .bit_loop

;.copy_back_array_if_needed
    cmp rdi, [rsp]
    je .return
    
    lea r8, [rsi - 8]
.copy_loop:
    mov r10, [rdi + r8]
    mov [r9 + r8], r10
    sub r8, 8
    jnb .copy_loop

.return:
    mov rax, 0
    jmp .return_
.return_err:
    mov rax, 1
.return_:
    mov rdi, [rsp + 16]
    call free wrt ..plt

    mov rsp, rbp
    pop rbp
    ret
