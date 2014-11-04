#! /bin/bash
clear
nasm -f elf div4.asm
nasm -f elf linker.asm
nasm -f elf encoded.asm
nasm -f elf counter.asm
nasm -f elf codificador.asm
nasm -f elf cant.asm
nasm -f elf maxElementPos.asm
nasm -f elf assignLetter.asm
nasm -f elf decoded.asm
gcc -o encoded main.c decoded.o assignLetter.o asm_io.o linker.o encoded.o counter.o cant.o codificador.o maxElementPos.o div4.o
./encoded
