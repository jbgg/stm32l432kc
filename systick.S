

    .equ stk_ctrl, 0xe000e010
    .equ stk_load, 0xe000e014
    .equ stk_val, 0xe000e018
    .equ stk_calib, 0xe000e01c

    .text
    .syntax unified

    # configuration of systick clock
    .globl systick_config
systick_config:

    ldr r1, =systick_reload
    ldr r0, [r1]
    ldr r1, =stk_load
    str r0, [r1]
    
    ldr r1, =stk_ctrl
    ldr r0, =(1 << 1) | (1 << 0)
    str r0, [r1]
    
    bx lr
    
    # update the number of thick
    # it is called on every systick exception
    .globl systick_tick
systick_tick:

    ldr r1, =systick_ntick
    ldr r0, [r1]
    add r0, r0, #1
    str r0, [r1]
    
    bx lr

    # delay a number of ms
    .globl delay
delay:
    ldr r1, =systick_ntick
    ldr r2, [r1]
    add r0, r0, r2
    
1:
    ldr r2, [r1]
    cmp r2, r0
    bls 1b

    bx lr
    

    .data
systick_reload: .long 6*1000-1
systick_ntick: .long 0x0


