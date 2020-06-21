
    .equ rcc_ahb2enr, 0x4002104c

    .equ gpioa_moder, 0x48000000
    .equ gpioa_otyper, 0x48000004
    .equ gpioa_ospeedr, 0x48000008
    .equ gpioa_pupdr, 0x4800000c
    .equ gpioa_idr, 0x48000010
    .equ gpioa_odr, 0x48000014
    .equ gpioa_bsrr, 0x48000018
    .equ gpioa_lckr, 0x4800001c
    .equ gpioa_afrl, 0x48000020
    .equ gpioa_afrh, 0x48000024
    .equ gpioa_brr, 0x48000028

    .text
    .syntax unified

    .globl jmpd2_config
jmpd2_config:
    stmdb sp!, {lr}

    @ IO port A clock enable
    ldr r1, =rcc_ahb2enr
    ldr r0, [r1]
    orr r0, r0, 1 << 0
    str r0, [r1]

    # delay
    ldr r0, =10
    bl delay
    
    ldr r1, =gpioa_moder
    ldr r0, [r1]
    and r0, r0, ~(3 << 24)   @ input mode
    str r0, [r1]

    ldr r1, =gpioa_pupdr
    ldr r0, [r1]
    and r0, r0, ~(3 << 24)  @ floating
    str r0, [r1]

    ldm sp!, {pc}

    .globl jmpd2_state
jmpd2_state:
    
    ldr r1, =gpioa_idr
    ldr r0, [r1]
    lsr r0, r0, #12
    and r0, r0, 1

    bx lr

