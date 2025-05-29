section .data
    dividendo dd 81
    divisor dd 9
    mensaje db "81 dividido entre 9 da: ", 0
    mensaje_len equ $ - mensaje
    salto_linea db 10

section .bss
    ascii_out resb 12

section .text
    global _start

_start:
    mov eax, [dividendo]
    xor edx, edx
    div dword [divisor]     ; eax = 9

    mov edi, ascii_out + 10
    mov byte [edi], 0
    dec edi
    mov byte [edi], 10

    test eax, eax
    jz .es_cero

    mov ecx, 10
.convertir:
    dec edi
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz .convertir
    jmp .mostrar

.es_cero:
    dec edi
    mov byte [edi], '0'

.mostrar:
    ; Imprimir mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, mensaje_len
    int 0x80

    ; Imprimir número
    mov eax, 4
    mov ebx, 1
    lea ecx, [edi]
    mov edx, ascii_out + 11
    sub edx, ecx
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto_linea
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
