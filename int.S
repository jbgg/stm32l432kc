
    .text
    .syntax unified

    # general handler
    .globl gen_int
gen_int:
    b .

    # svcall handler
    .globl svcall_int
svcall_int:
    bx lr

    # systick handler
    .globl systick_int
systick_int:
    b systick_tick

