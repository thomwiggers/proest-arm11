CC = distcc
AS = distcc as
ASFLAGS = --warn
CFLAGS = -std=c99 -g -Wall -Wpedantic
BIN = test_asm
QHASM = distcc qhasm
BUILDDIR = build


.PRECIOUS: %.s
%.s: %.q
	mkdir -p $(BUILDDIR)
	cp $^ $(BUILDDIR)/$^.c
	$(QHASM) -c $(BUILDDIR)/$^.c -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $^ -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $^ -o $@

$(BIN): test_asm.o proestasm.o proest128.o
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: run
run: $(BIN)
	./$(BIN)

.PHONY: gdb
gdb: $(BIN)
	gdb $(BIN)

.PHONY: clean
clean:
	-rm -f *.s *.o $(BIN)
	-rm -fr $(BUILDDIR)
