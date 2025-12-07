%define BYTES_PER 8

%define LO [rbp -  8]
%define HI [rbp - 16]
%define  I [rbp - 24]
%define  J [rbp - 32]
%define PI rcx

global quick_sort
quick_sort:
    ; Set up for _quick_sort_rec. equivilant to a wrapper function
    lea rdx, [rsi - 1]
    mov rsi, 0

_quick_sort_rec:
    push rbp
    mov rbp, rsp

    sub rsp, 32

; Check if sorting needed
    cmp rdx, rsi
    jle ENDING
    cmp rsi, 0
    jl  ENDING

; Put needed value onto the stack
    mov PI, [rdi + rdx * BYTES_PER]
    mov LO, rsi
    mov HI, rdx

    dec rdx ; do not sort the pivot, it will go in the middle.

; partion loop start
PARTITION_LOOP:
    ; test state of current byte
    cmp [rdi + rsi * BYTES_PER], PI
    jge PARTITION_GREATER_EQUAL

PARTITION_LESS:
    inc rsi  ; LT just increment i, already in correct location

    jmp PARTITION_CONDITION ; Go strait to condition
PARTITION_GREATER_EQUAL:
    ; Flip items
    mov r8, [rdi + rsi * BYTES_PER]
    mov r9, [rdi + rdx * BYTES_PER]
    mov [rdi + rdx * BYTES_PER], r8
    mov [rdi + rsi * BYTES_PER], r9

    ; decrement the upper counter
    dec rdx

PARTITION_CONDITION:
    ; check to see if the end has been reached.
    cmp rsi, rdx
    jle PARTITION_LOOP

FINISH_SORT:
    ; do the final parts of the sort, including recursion
    ; move J to the stack
    mov J, rdx

    ; Put the pivot in the middle of the sorted list.
    mov rdx, HI
    mov r8, [rdi + rsi * BYTES_PER]
    mov r9, [rdi + rdx * BYTES_PER]
    mov [rdi + rdx * BYTES_PER], r8
    mov [rdi + rsi * BYTES_PER], r9
    inc rsi ; Do not re-sort the pivot, it is in the right spot.

    mov I, rsi

    ; sort the upper list (I to HI)
    call _quick_sort_rec

    ; sort the lower list (LO to J)
    mov rsi, LO
    mov rdx, J
    call _quick_sort_rec

    ; retern
ENDING:
    mov rsp, rbp
    pop rbp
    ret
