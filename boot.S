
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

    bl adc_config

    bl adc_start
    
    tst r0, #1
    bne blink
    

    bl adc_read


    bl led3_on
    

halt:
    wfi
    b halt

blink:
    bl led3_on
    ldr r0, =1000
    bl delay
    bl led3_off
    ldr r0, =1000
    bl delay
    b blink
    

