CC = gcc
AS = as
ASFLAGS = --warn
CFLAGS = -std=c99 -g -Wall -Wpedantic
BIN = test_asm
QHASM = /home/thom/git/bachelor-thesis/code/qhasm/qhasm-arm

.PRECIOUS: %.s
%.s: %.q
	$(QHASM) < $^ > $@

%.o: %.c
	$(CC) -c $(CFLAGS) $^ -o $@

%.a: %.s
	$(AS) $(ASFLAGS) $^ -o $@

$(BIN): test_asm.o proestasm.a proest128.o
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: run
run: $(BIN)
	./$(BIN)

.PHONY: gdb
gdb: $(BIN)
	gdb $(BIN)

.PHONY: clean
clean:
	-rm -f *.s *.o *.a $(BIN)
