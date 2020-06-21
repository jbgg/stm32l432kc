
    .equ VTOR, 0xe000ed08
    
    .text
    .syntax unified

    .globl _start
_start:
    ldr r0, =_vtable
    ldr sp, [r0]

    ldr r1, =VTOR
    str r0, [r1]

    bl clock_config

    bl systick_config

    bl led3_config

    bl jmpd2_config

    bl usart1_config

    ldr r0, ='h'
    bl usart1_putc

    ldr r0, ='o'
    bl usart1_putc

    ldr r0, ='l'
    bl usart1_putc

    ldr r0, ='a'
    bl usart1_putc

1:

    bl usart1_getc
    
    bl led3_on
    ldr r0, =1000
    bl delay
    bl led3_off

    b 1b

    

1:
    wfi
    b 1b

