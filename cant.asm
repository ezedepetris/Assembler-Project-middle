%include "asm_io.inc"

segment .text
	global cant

cant:
	push ebp
	mov ebp,esp
	
	cmp dword[ebp + 8], 1  ; compara lo que hay en la pila con 01
	je changeEax1

	cmp dword[ebp + 8], 3	; compara lo que hay en la pila con 011
	je changeEax2

	cmp dword[ebp + 8], 7 ; compara lo que hay en la pila con 0111
	je changeEax3

	cmp dword[ebp + 8], 15 ; compara lo que hay en la pila con 01111
	je changeEax4
	
changeEax1:
	mov dword[ebp + 8], 1 ; si habia un uno en la pila se shiftea un uno
	jmp endCant

changeEax2:
	mov dword[ebp + 8], 2 ; si habia un tres en la pila se shiftea dos uno
	jmp endCant

changeEax3:
	mov dword[ebp + 8], 3 ; si habia un 7 en la pila se shiftea tres uno
	jmp endCant

changeEax4:
	mov dword[ebp + 8], 4 ; si habia un 15 en la pila se shiftea cuatro uno
endCant:

	mov esp, ebp
	pop ebp
	ret
