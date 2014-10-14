CC = gcc
CFLAGS = -std=c99 -g -Wall
BIN = test
QHASM = /home/thom/git/bachelor-thesis/code/qhasm/qhasm-arm

%.s: %.q
	$(QHASM) < $^ > $@

%.o: %.c
	$(CC) -c $(CFLAGS) $^ -o $@

test: test.o proestasm.s proest128.o
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: run
run: test
	./test

.PHONY: gdb
gdb: test
	gdb test

.PHONY: clean
clean:
	-rm -f *.s *.o $(BIN)
