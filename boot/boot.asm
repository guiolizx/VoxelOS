BITS 32

section .multiboot
align 8

header_start:
    dd 0xE85250D6                                       ; magic number: identifica o Multiboot2

    dd 0                                                ; Arquitetura do multiboot2, onde 0 equivale a i386 ou seja 32 bits

    dd header_end - header_start                        ; tamanho total do cabecalho

    dd -(0xE85250D6 + 0 + (header_end - header_start))  ; checksum para validar o cabecalho

    ; FIM DAS TAGS
    dw 0
    dw 0
    dd 8

header_end:

section .text
global _start
extern kernel_main

BITS 32

_start:
    mov esp, stack_top

    mov [multiboot_magic], eax
    mov [multiboot_info], ebx

    cli

    lgdt [gdt_descriptor]

    jmp 0x08:reload_segments

reload_segments:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    cld

    xor eax, eax
    mov edi, pml4_table
    mov ecx, 3072
    rep stosd
    ;PML4 aponta para PDPT
    mov eax, pdpt_table
    or eax, 0x03
    mov [pml4_table], eax
    ;PDPT aponta para PD
    mov eax, pd_table
    or eax, 0x03
    mov [pdpt_table], eax

    xor ecx, ecx

.fill_pd:
    mov eax, ecx
    shl eax, 21
    or eax, 0x83

    mov [pd_table + ecx * 8], eax
    
    inc ecx
    cmp ecx, 512
    jne .fill_pd

    mov eax, cr4
    or eax, 0x20
    mov cr4, eax

    mov eax, pml4_table
    mov cr3, eax

    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax

    jmp 0x18:long_mode_start

BITS 64
long_mode_start:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov rsp, stack_top

    call kernel_main

.halt:
    hlt
    jmp .halt

section .bss
alignb 16

stack_bottom:
    resb 16384          ; reserva 16KiB pra stack

stack_top:

multiboot_magic:
    resd 1

multiboot_info:
    resd 1

alignb 4096
pml4_table:
    resb 4096

alignb 4096
pdpt_table:
    resb 4096

alignb 4096
pd_table:
    resb 4096

section .rodata
align 8

gdt_start:

gdt_null:
    dq 0

gdt_code32:
    dq 0x00CF9A000000FFFF

gdt_data:
    dq 0x00CF92000000FFFF

gdt_code64:
    dq 0x00AF9A000000FFFF

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start