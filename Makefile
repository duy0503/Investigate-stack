default: a.out

c1.o: c1.c
	gcc -c c1.c

c2.o: c2.c
	gcc -c c2.c

c3.o: c3.c
	gcc -c c3.c

c4.o: c4.c
	gcc -c c4.c

c5.o: c5.c
	gcc -c c5.c

debug.o: debug.asm debug.inc
	nasm -f elf64 -o debug.o debug.asm

findframe.o: findframe.asm
	nasm -f elf64 -o findframe.o findframe.asm
	
a.out: c1.o c2.o c3.o c4.o c5.o findframe.o debug.o
	gcc c1.o c2.o c3.o c4.o c5.o findframe.o debug.o -o a.out
