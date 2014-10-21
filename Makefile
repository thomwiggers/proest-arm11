CC = gcc
AS = as
ASFLAGS = --warn
CFLAGS = -std=c99 -g -Wall -Wpedantic
BIN = test
QHASM = /home/thom/git/bachelor-thesis/code/qhasm/qhasm-arm

.PRECIOUS: %.s
%.s: %.q
	$(QHASM) < $^ > $@

%.o: %.c
	$(CC) -c $(CFLAGS) $^ -o $@

%.a: %.s
	$(AS) $(ASFLAGS) $^ -o $@

test: test.o proestasm.a proest128.o
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: run
run: test
	./test

.PHONY: gdb
gdb: test
	gdb test

.PHONY: clean
clean:
	-rm -f *.s *.o *.a $(BIN)
