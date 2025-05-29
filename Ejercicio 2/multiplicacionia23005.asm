section .data
    valor1 db 9
    valor2 db 3
    texto db "Resultado de 9 * 3 es: ", 0
    texto_len equ $ - texto
    lf db 10

section .bss
    resultado resb 4

section .text
    global _start

_start:
    mov al, [valor1]
    mul byte [valor2]     ; al * valor2 → resultado en AX
    mov [resultado], al

    movzx eax, byte [resultado]
    mov edi, resultado + 3
    mov byte [edi], 10
    dec edi

    mov ecx, 10
to_ascii:
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz to_ascii

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
    mov ecx, lf
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
