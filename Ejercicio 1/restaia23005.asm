section .data
    a dw 90
    b dw 20
    c dw 10
    final dw 0
    texto db "90 menos 20 menos 10 da: ", 0
    texto_len equ $ - texto
    salto db 10

section .bss
    ascii_num resb 5

section .text
    global _start

_start:
    mov bx, [a]
    sub bx, [b]
    sub bx, [c]
    mov [final], bx

    mov ax, [final]
    mov edi, ascii_num + 4
    mov byte [edi], 10
    dec edi

    mov cx, 10
conv_loop:
    xor dx, dx
    div cx
    add dl, '0'
    mov [edi], dl
    dec edi
    test ax, ax
    jnz conv_loop

    mov eax, 4
    mov ebx, 1
    mov ecx, texto
    mov edx, texto_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    lea ecx, [edi + 1]
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
