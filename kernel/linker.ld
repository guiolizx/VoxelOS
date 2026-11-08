ENTRY(_start) /*Diz ao linker que _start e o ponto entrada do executavel*/

SECTIONS /*definicao das secoes*/
{
    . = 1M; /*define o endereco de memoria atual como 1MiB*/

    .text : /*Secao com instrucoes executaveis*/
    {
        KEEP(*(.multiboot)) /*inclui a secao multiboot*/
        *(.text .text.*) /*inclui a secao de codigo*/
    }

    .rodata :   /*armazena dados somente para leitura*/
    {
        *(.rodata .rodata.*)
    }

    .data : /*variaveis globais ou estaticas que ja possuem um valor inicial*/
    {
        *(.data .data.*)
    }

    .bss : /*variaveis globais ou estaticas que comecam zeradas*/
    {
        *(COMMON)
        *(.bss .bss.*)
    }
}