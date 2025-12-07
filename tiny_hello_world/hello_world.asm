global _start

_start:
    mov al, 1
    mov edi, eax
    lea rsi, [rel t]
    mov dl, 12
    syscall
    mov al, 60
    dec edi
    syscall
t:  db "Hello World", 0x0a
