
    .equ rcc_cr, 0x40021000

    .text
    .syntax unified

    .globl clock_config
clock_config:

    ldr r1, =rcc_cr
    ldr r0, [r1]
    
    @ setting msi clock at 48MHz
    tst r0, #(1<<1)
    itttt ne
    andne r0, r0, # ~(0xf << 4)
    orrne r0, r0, # (0xb << 4)
    orrne r0, r0, # (1 << 3)
    strne r0, [r1]
    
    
    
    

    bx lr

