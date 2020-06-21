
    .equ rcc_ahb2enr, 0x4002104c

    .equ gpiob_moder, 0x48000400
    .equ gpiob_otyper, 0x48000404
    .equ gpiob_ospeedr, 0x48000408
    .equ gpiob_pupdr, 0x4800040c
    .equ gpiob_idr, 0x48000410
    .equ gpiob_odr, 0x48000414
    .equ gpiob_bsrr, 0x48000418
    .equ gpiob_lckr, 0x4800041c
    .equ gpiob_afrl, 0x48000420
    .equ gpiob_afrh, 0x48000424
    .equ gpiob_brr, 0x48000428

    .text
    .syntax unified

    # configuration of led 3
    .globl led3_config
led3_config:
    stmdb sp!, {lr}

    ldr r1, =rcc_ahb2enr
    ldr r0, [r1]
    orr r0, r0, 1 << 1
    str r0, [r1]

    # delay
    ldr r0, =10
    bl delay
    
    ldr r1, =gpiob_moder
    ldr r0, [r1]
    orr r0, r0, 1 << 6
    and r0, r0, ~(1 << 7)
    str r0, [r1]

    ldr r1, =gpiob_otyper
    ldr r0, [r1]
    and r0, r0, ~(1 << 3)
    str r0, [r1]

    ldr r1, =gpiob_ospeedr
    ldr r0, [r1]
    orr r0, r0, 3 << 6
    str r0, [r1]

    ldr r1, =gpiob_pupdr
    ldr r0, [r1]
    orr r0, r0, 1 << 6
    and r0, r0, ~(1 << 7)
    str r0, [r1]

    ldm sp!, {pc}

    # TODO
    # get the state of led 3
led3_state:
    
    bx lr

    # set the led 3
    .globl led3_on
led3_on:
    
    ldr r1, =gpiob_bsrr
    ldr r0, =1<<3
    str r0, [r1]
    
    bx lr

    # reset the led 3
    .globl led3_off
led3_off:

    ldr r1, =gpiob_brr
    ldr r0, =1<<(3)
    str r0, [r1]
    
    bx lr

