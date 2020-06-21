
    .text
    .syntax unified

    .globl _vtable
_vtable:
    # initial sp    0x00
    .long .memend+1
    # reset         0x04
    .long _start+1
    # nmi           0x08
    .long gen_int+1
    # hard fault    0x0c
    .long gen_int+1
    # memory management fault 0x10
    .long gen_int+1
    # bus fault     0x14
    .long gen_int+1
    # usage fault   0x18
    .long gen_int+1
    # reserved      0x1c
    .long gen_int+1
    # reserved      0x20
    .long gen_int+1
    # reserved      0x24
    .long gen_int+1
    # reserved      0x28
    .long gen_int+1
    # SVCall        0x2c
    .long svcall_int+1
    # reserved for debug 0x30
    .long gen_int+1
    # reserved      0x34
    .long gen_int+1
    # PendSV        0x38
    .long gen_int+1
    # Systick       0x3c
    .long systick_int+1
    # IRQ0          0x40
    .long gen_int+1
    # IRQ1          0x44
    .long gen_int+1
    # IRQ2          0x48
    .long gen_int+1
    # IRQ3          0x4c
    .long gen_int+1
    # IRQ4          0x50
    .long gen_int+1
    # IRQ5          0x54
    .long gen_int+1
    # IRQ6          0x58
    .long gen_int+1
    # IRQ7          0x5c
    .long gen_int+1
    # IRQ8          0x60
    .long gen_int+1
    # IRQ9          0x64
    .long gen_int+1
    # IRQ10          0x68
    .long gen_int+1
    # IRQ11          0x6c
    .long gen_int+1
    # IRQ12          0x70
    .long gen_int+1
    # IRQ13          0x74
    .long gen_int+1
    # IRQ14          0x78
    .long gen_int+1
    # IRQ15          0x7c
    .long gen_int+1
    # IRQ16          0x80
    .long gen_int+1
    # IRQ17          0x84
    .long gen_int+1
    # IRQ18          0x88
    .long gen_int+1
    # IRQ19          0x8c
    .long gen_int+1
    # IRQ20          0x90
    .long gen_int+1
    # IRQ21          0x94
    .long gen_int+1
    # IRQ22          0x98
    .long gen_int+1
    # IRQ23          0x9c
    .long gen_int+1
    # IRQ24          0xa0
    .long gen_int+1
    # IRQ25          0xa4
    .long gen_int+1
    # IRQ26          0xa8
    .long gen_int+1
    # IRQ27          0xac
    .long gen_int+1
    # IRQ28          0xb0
    .long gen_int+1
    # IRQ29          0xb4
    .long gen_int+1
    # IRQ30          0xb8
    .long gen_int+1
    # IRQ31          0xbc
    .long gen_int+1
    # IRQ32          0xc0
    .long gen_int+1
    # IRQ33          0xc4
    .long gen_int+1
    # IRQ34          0xc8
    .long gen_int+1
    # IRQ35          0xcc
    .long gen_int+1
    # IRQ36          0xd0
    .long gen_int+1
    # IRQ37          0xd4
    .long gen_int+1
    # IRQ38          0xd8
    .long gen_int+1
    # IRQ39          0xdc
    .long gen_int+1
    # IRQ40          0xe0
    .long gen_int+1
    # IRQ41          0xe4
    .long gen_int+1
    # IRQ42          0xe8
    .long gen_int+1
    # IRQ43          0xec
    .long gen_int+1

