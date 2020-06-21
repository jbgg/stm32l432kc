
    .equ rcc_ahb2enr, 0x4002104c
    .equ rcc_apb2enr, 0x40021060

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

    .equ usart1_cr1, 0x40013800
    .equ usart1_cr2, 0x40013804
    .equ usart1_cr3, 0x40013808
    .equ usart1_brr, 0x4001380c
    .equ usart1_gtpr, 0x40013810
    .equ usart1_rtor, 0x40013814
    .equ usart1_rqr, 0x40013818
    .equ usart1_isr, 0x4001381c
    .equ usart1_icr, 0x40013820
    .equ usart1_rdr, 0x40013824
    .equ usart1_tdr, 0x40013828

    .text
    .syntax unified

    .globl usart1_config
usart1_config:

    @ IO port A clock enable
    ldr r1, =rcc_ahb2enr
    ldr r0, [r1]
    orr r0, r0, 1 << 0
    str r0, [r1]

    @ IO port A pin 9 and 10 AF7
    ldr r1, =gpioa_moder
    ldr r0, [r1]
    and r0, r0, #~( (3 << 20) | (3 << 18) )
    orr r0, r0, #( (2 << 20) | (2 << 18) )
    str r0, [r1]

    ldr r1, =gpioa_afrh
    ldr r0, [r1]
    and r0, r0, #~( (0xf << 4) | (0xf << 8) )
    orr r0, r0, #( (7 << 4) | (7 << 8) )
    str r0, [r1]
    

    @ USART1EN clock enable
    ldr r1, =rcc_apb2enr
    ldr r0, [r1]
    orr r0, r0, 1 << 14
    str r0, [r1]

    @ USART disable
    ldr r1, =usart1_cr1
    ldr r0, [r1]
    and r0, #~(1 << 0)
    str r0, [r1]

    @ setting USARTDIV
    ldr r1, =usart1_brr
    ldr r0, =0x1388
    str r0, [r1]
    
    @ USART enable
    ldr r1, =usart1_cr1
    ldr r0, [r1]
    orr r0, #( (1 << 3) | (1 << 2) | (1 << 0))
    str r0, [r1]
    
    bx lr

    .globl usart1_putc
usart1_putc:

    ldr r1, =usart1_isr
1:
    ldr r2, [r1]
    tst r2, #(1 << 7)
    beq 1b
    
    and r0, r0, #0xff
    ldr r1, =usart1_tdr
    str r0, [r1]
    
    bx lr

    .globl usart1_getc
usart1_getc:

    
    ldr r1, =usart1_isr
1:
    ldr r0, [r1]
    tst r0, #(1 << 5)
    beq 1b
    
    ldr r1, =usart1_rdr
    ldr r0, [r1]
    
    bx lr

