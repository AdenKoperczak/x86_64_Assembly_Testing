%define BYTES_PER 8

global insert_sort
insert_sort:
    push rbp
    mov rbp, rsp

; Check if sorting needed
    cmp rsi, 2
    jl  ENDING

; Setup
    ; turn rsi into a number of bytes
    lea rsi, [rsi * BYTES_PER]

    mov rcx, 0 ; the relitave position of the first unsorted item.
    
OUTER_LOOP:
    ; you have sorted one element. check if it is the end of the array
    add rcx, BYTES_PER
    cmp rcx, rsi
    jae ENDING    

    ; set the inital insert index
    mov rdx, rcx
    
INNER_LOOP:
    ; Get the item that is being sorted, and the item to compair it to
    mov r9, [rdi + rdx]
    mov r8, [rdi + rdx - BYTES_PER]

    ; if they are already in position, then no further sorting is needed
    cmp r9, r8
    jge OUTER_LOOP

    ; swap the two values.
    mov [rdi + rdx], r8
    mov [rdi + rdx - BYTES_PER], r9
    
    ; decrement index, and check to see if it is zero (on zero go to outer loop)_
    sub rdx, BYTES_PER
    jnz INNER_LOOP
    jmp OUTER_LOOP

    ; retern
ENDING:
    mov rsp, rbp
    pop rbp
    ret
