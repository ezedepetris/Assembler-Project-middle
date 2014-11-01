#! /bin/bash
clear
nasm -f elf div4.asm
nasm -f elf linker.asm
nasm -f elf encoded.asm
nasm -f elf counter.asm
nasm -f elf codificador.asm
nasm -f elf cant.asm
nasm -f elf maxElementPos.asm
gcc -o encoded main.c asm_io.o linker.o encoded.o counter.o cant.o codificador.o maxElementPos.o div4.o
./encoded
