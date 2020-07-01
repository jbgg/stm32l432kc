
    .equ rcc_ahb2enr, 0x4002104c
    .equ rcc_ccipr, 0x40021088

    .equ adc1_isr, 0x50040000
    .equ adc1_ier, 0x50040004
    .equ adc1_cr, 0x50040008
    .equ adc1_cfgr, 0x5004000c
    .equ adc1_cfgr2, 0x50040010
    .equ adc1_smpr1, 0x50040014
    .equ adc1_smpr2, 0x50040018
    .equ adc1_tr1, 0x50040020
    .equ adc1_tr2, 0x50040024
    .equ adc1_tr3, 0x50040028
    .equ adc1_sqr1, 0x50040030
    .equ adc1_sqr2, 0x50040034
    .equ adc1_sqr3, 0x50040038
    .equ adc1_sqr4, 0x5004003c
    .equ adc1_dr, 0x50040040
    .equ adc1_jsqr, 0x5004004c
    .equ adc1_ofr1, 0x50040060
    .equ adc1_ofr2, 0x50040064
    .equ adc1_ofr3, 0x50040068
    .equ adc1_ofr4, 0x5004006c
    .equ adc1_jdr1, 0x50040080
    .equ adc1_jdr2, 0x50040084
    .equ adc1_jdr3, 0x50040088
    .equ adc1_jdr4, 0x5004008c
    .equ adc1_awd2cr, 0x500400a0
    .equ adc1_difsel, 0x500400b0
    .equ adc1_calfact, 0x500400b4

    .equ adc_ccr, 0x50040308



    .text
    .syntax unified

    .globl adc_config
adc_config:
    push {lr}

    @ ADC clock enable
    ldr r1, =rcc_ahb2enr
    ldr r0, [r1]
    orr r0, r0, 1 << 13
    str r0, [r1]
    
    ldr r0, =10
    bl delay


    @ exit Deep-power-down mode
    ldr r1, =adc1_cr
    ldr r0, [r1]
    and r0, r0, #~(1 << 29)
    str r0, [r1]

    @ ADC internal voltage regulator enable
    ldr r1, =adc1_cr
    ldr r0, [r1]
    orr r0, r0, #(1 << 28)
    str r0, [r1]

    ldr r0, =100
    bl delay

    @ ADCEN=0
    ldr r1, =adc1_cr
    ldr r0, [r1]
    and r0, r0, #~(1 << 0)
    str r0, [r1]

    @ ADC calibration
break:
    ldr r1, =adc1_cr
    ldr r0, [r1]
    and r0, r0, #~(1 << 30) @ ADCALDIF=0
    orr r0, r0, #(1 << 31)  @ ADCAL=1
    str r0, [r1]
    
    ldr r1, =adc1_cr
1:
    ldr r0, [r1]
    tst r0, 1 << 31
    bne 1b

    

    @ ADC clock source selection
    ldr r1, =rcc_ccipr
    ldr r0, [r1]
    orr r0, r0, 3 << 28
    str r0, [r1]

    @ ADC clock mode
    ldr r1, =adc_ccr
    ldr r0, [r1]
    and r0, r0, #~(3 << 16)
    and r0, r0, #(7 << 18)
    orr r0, r0, #(0 << 18)
    str r0, [r1] 
    
    @ channel 17 selection
    ldr r1, =adc_ccr
    ldr r0, [r1]
    orr r0, r0, #(1 << 23)
    str r0, [r1]
    
    @ ADCEN=1
    ldr r1, =adc1_cr
    ldr r0, [r1]
    orr r0, r0, #(1 << 0)
    str r0, [r1]

    pop {pc}

    .globl adc_start
adc_start:


    @ check ADRDY
    ldr r1, =adc1_isr
    ldr r0, [r1]
    tst r0, 1 << 0
    beq 1f

    ldr r1, =adc1_cr
    ldr r0, [r1]
    tst r0, 1 << 1
    bne 1f              @ exit if ADDIS=1

    @ check ADSTART=0
    ldr r1, =adc1_cr
1:
    ldr r0, [r1]
    tst r0, #(1 << 2)
    bne 1b
    
    @ setting regular sequence register
    ldr r1, =adc1_sqr1
    ldr r0, =((17 << 6) | (0 << 0))
    str r0, [r1]
    
    @ set ADSTART
    ldr r1, =adc1_cr
    ldr r0, [r1]
    and r0, r0, #(1 << 2)
    str r0, [r1]

    ldr r0, =0
    bx lr

1:
    ldr r0, =1
    bx lr
    

    .globl adc_read
adc_read:

    @ test EOC flag
    ldr r1, =adc1_isr
1:
    ldr r0, [r1]
    tst r0, #(1<<2)
    beq 1b

    ldr r1, =adc1_dr
    ldr r0, [r1]
    
    bx lr
    
    

