ifndef CROSS_COMPILE
	CROSS_COMPILE = or1k-elf-
endif
CC = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy

OBJECTS = example.o

export CROSS_COMPILE

all: example.or32 example.trace mem.data

%.o: %.S
	$(CC) $< -o $@

example.or32: ram.ld $(OBJECTS)
	$(LD) -T ram.ld $(OBJECTS) -o $@

mem.bin: example.or32
	$(OBJCOPY) -O binary $< $@

mem.data: mem.bin
	python3 bin2mem.py -f $< -o $@

example.trace: example.or32
	or1k-sim -t $< -m1M > $@

clean:
	rm -f *.o *.or32 *.bin *.data *.trace
