# Makefile

PREFIX=arm-none-eabi-
AS=$(PREFIX)as
LD=$(PREFIX)ld
OBJDUMP=$(PREFIX)objdump
GDB=$(PREFIX)gdb

MEMSTART=0x20000000
MEMEND=0x20000fff

OBJ=vtable.o boot.o int.o clock.o systick.o led3.o jmpd2.o usart1.o


all: sys

%.o:%.S
	$(AS) -c \
		-g \
		-mcpu=cortex-m4 \
		-march=armv7 \
	   	-mthumb \
		-defsym .memstart=$(MEMSTART) \
		-defsym .memend=$(MEMEND) \
		-o $@ $^

sys: $(OBJ)
	$(LD) \
		-static \
		--thumb-entry=_start \
		-z common-page-size=512 \
		-z max-page-size=512 \
		-Ttext $(MEMSTART) \
		-o $@ $^

dis: sys
	$(OBJDUMP) -Mforce-thumb -d sys

info: sys
	$(OBJDUMP) -x sys


# connect gdb to st-util server
gdb_: sys
	$(GDB) \
		-ex 'target remote tcp:172.23.0.1:4242' \
		-ex 'set arm force-mode thumb' \
		-ex 'load sys' \
		-ex 'b _start' \
		sys

gdb_2:
	$(GDB) \
		-ex 'target remote tcp:172.23.0.1:4242' \
		-ex 'set arm force-mode thumb'

# connect gdb to openocd server
gdb: sys
	$(GDB) \
		-ex 'target remote tcp:172.23.0.1:3333' \
		-ex 'set arm force-mode thumb' \
		-ex 'monitor reset halt' \
		-ex 'load' \
		sys

gdb2:
	$(GDB) \
		-ex 'target remote tcp:172.23.0.1:3333' \
		-ex 'set arm force-mode thumb' \
		-ex 'monitor reset halt'

clean:
	rm -rf sys $(OBJ)
	@rm -rf *~ .*~

