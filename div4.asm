%include "asm_io.inc"

 segment .text
	global div4

;a falta de registros tuvimos que hacer una subrutina que nos divida los indice en 4
; ===============
div4:
	push ebp 
	mov ebp,esp 

	cmp dword[ebp + 8], 0 ;veo si en la pila hay un 0
	je assign0

	cmp dword[ebp + 8], 4 ;veo si en la pila hay un 4
	je assign1

	cmp dword[ebp + 8], 8 ;veo si en la pila hay un 8
	je assign2

	cmp dword[ebp + 8], 12 ;veo si en la pila hay un 12
	je assign3

	jmp endAssign

assign0:
	mov dword[ebp + 8], 0 ;si habia un cero devuelvo cero
	jmp endAssign

assign1:
	mov dword[ebp + 8], 1 ;si habia un 4 devuelvo 1
	jmp endAssign

assign2:
	mov dword[ebp + 8], 2 ;si habia un 8 devuelvo 2
	jmp endAssign

assign3:
	mov dword[ebp + 8], 3 ;si habia un 12 devuelvo 3

endAssign:

	mov esp, ebp
	pop ebp
	ret