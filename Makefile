DISTCC = distcc
CC = $(DISTCC) cc
AS = $(DISTCC) as
ASFLAGS = --warn
CFLAGS = -std=c99 -g -Wall -Wpedantic -O2
QHASM = $(DISTCC) qhasm
BUILDDIR = build
MAQ = ../../../../maq/maq
PROEST_ASM_OBJ := proest_mixcolumns.o proest_subbits.o \
				  proest_addconstant.o proest_shiftregisters.o \
				  proest_concat.o
				 # proest_subbitsmixcolumns.o \
				 # proest_minimixcolumns.o

%.q: %.pq
	$(MAQ) $^ > $@

.PRECIOUS: %.s
%.s: %.q
	@mkdir -p $(BUILDDIR)
	cp $^ $(BUILDDIR)/$^.c
	$(QHASM) -c $(BUILDDIR)/$^.c -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $^ -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $^ -o $@

test_asm: test_asm.o proest128.o $(PROEST_ASM_OBJ)
	$(CC) $(CFLAGS) $^ -o $@

cyclecounter: cyclecounter.o dev4ns.o proest128.o $(PROEST_ASM_OBJ)
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: run
run: test_asm
	./test_asm

.PHONY: gdb
gdb: test_asm
	gdb test_asm

.PHONY: clean
clean:
	-rm -f *.s *.o test_asm cyclecounter
	-rm -fr $(BUILDDIR)
