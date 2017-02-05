CURSEBASE=
CURSESINC=
CURSESLIB=
OBJFORMAT=elf32
ASM=nasm
COPY=cp
RM=rm -f
UNDERSCORE=
OBJ=.o
EXE=.out
LIBS=-lpanel -lncurses
CC=gcc -m32
CFLAGS= -Wall -g $(CURSESINC)
LDFLAGS= -static -Wall -g
LIBASMFLAGS=-g -f $(OBJFORMAT) $(UNDERSCORE)
ASMFLAGS=-g -f $(OBJFORMAT)
LIBIUT=libIUT.a

OBJS=main$(OBJ) go_asm$(OBJ) read$(OBJ) write$(OBJ) debug$(OBJ)

all:	$(LIBIUT) \
		exemple1$(EXE) exemple2$(EXE) exemple3$(EXE) exemple4$(EXE) \
		test0$(EXE) test1$(EXE) test2$(EXE) villa$(EXE) \
		intero1$(EXE) intero2$(EXE) intero3$(EXE) intero4$(EXE) intero5$(EXE)

$(LIBIUT) : $(OBJS)
	ar r $(LIBIUT) $(OBJS)

main$(OBJ) : main.c
	$(CC) $(CFLAGS) -c main.c -o main$(OBJ)

go_asm$(OBJ) : go_asm.asm
	$(ASM) $(LIBASMFLAGS) go_asm.asm

read$(OBJ) : read.asm
	$(ASM) $(LIBASMFLAGS) read.asm

write$(OBJ) : write.asm
	$(ASM) $(LIBASMFLAGS) write.asm

debug$(OBJ) : debug.asm
	$(ASM) $(LIBASMFLAGS) debug.asm

exemple1$(EXE) : exemple1.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) exemple1.asm
	$(CC) -o exemple1$(EXE) exemple1$(OBJ) -L. -lIUT $(LIBS)

exemple2$(EXE) : exemple2.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) exemple2.asm
	$(CC) -o exemple2$(EXE) exemple2$(OBJ) -L. -lIUT $(LIBS)

exemple3$(EXE) : exemple3.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) exemple3.asm
	$(CC) -o exemple3$(EXE) exemple3$(OBJ) -L. -lIUT $(LIBS)

exemple4$(EXE) : exemple4.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) exemple4.asm
	$(CC) -o exemple4$(EXE) exemple4$(OBJ) -L. -lIUT $(LIBS)


test0$(EXE) : test0.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) test0.asm
	$(CC) -o test0$(EXE) test0$(OBJ) -L. -lIUT $(LIBS)

test1$(EXE) : test1.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) test1.asm
	$(CC) -o test1$(EXE) test1$(OBJ) -L. -lIUT $(LIBS)

test2$(EXE) : test2.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) test2.asm
	$(CC) -o test2$(EXE) test2$(OBJ) -L. -lIUT $(LIBS)

villa$(EXE) : villa.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) villa.asm
	$(CC) -o villa$(EXE) villa$(OBJ) -L. -lIUT $(LIBS)

intero1$(EXE) : intero1.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) intero1.asm
	$(CC) -o intero1$(EXE) intero1$(OBJ) -L. -lIUT $(LIBS)

intero2$(EXE) : intero2.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) intero2.asm
	$(CC) -o intero2$(EXE) intero2$(OBJ) -L. -lIUT $(LIBS)

intero3$(EXE) : intero3.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) intero3.asm
	$(CC) -o intero3$(EXE) intero3$(OBJ) -L. -lIUT $(LIBS)

intero4$(EXE) : intero4.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) intero4.asm
	$(CC) -o intero4$(EXE) intero4$(OBJ) -L. -lIUT $(LIBS)

intero5$(EXE) : intero5.asm $(LIBIUT)
	$(ASM) $(ASMFLAGS) intero5.asm
	$(CC) -o intero5$(EXE) intero5$(OBJ) -L. -lIUT $(LIBS)

clean:
	$(RM) $(OBJS) $(LIBIUT)
	$(RM) exemple1$(EXE) exemple1$(OBJ)
	$(RM) exemple2$(EXE) exemple2$(OBJ)
	$(RM) exemple3$(EXE) exemple3$(OBJ)
	$(RM) exemple4$(EXE) exemple4$(OBJ)
	$(RM) test0$(EXE)    test0$(OBJ)
	$(RM) test1$(EXE)    test1$(OBJ)
	$(RM) test2$(EXE)    test2$(OBJ)
	$(RM) intero1$(EXE)  intero1$(OBJ)
	$(RM) intero2$(EXE)  intero2$(OBJ)
	$(RM) intero3$(EXE)  intero3$(OBJ)
	$(RM) intero4$(EXE)  intero4$(OBJ)
	$(RM) intero5$(EXE)  intero5$(OBJ)
	$(RM) villa$(EXE)    villa$(OBJ)

deploy:	deploy-zip all
	@if [ -d $$HOME/xenawww/Ens/Info1.Archi/libIUT/elf32 ]; then cp iut.inc $(LIBIUT) $$HOME/xenawww/Ens/Info1.Archi/libIUT/elf32 ; else echo "Répertoire non-monté"; fi

deploy-zip : clean
	cd .. ; zip -r /tmp/libIUT.zip libIUT
	@if [ -d $$HOME/xenawww/Ens/Info1.Archi/libIUT/elf32 ]; then cp /tmp/libIUT.zip $$HOME/xenawww/Ens/Info1.Archi/libIUT ; else echo "Répertoire non-monté"; fi
