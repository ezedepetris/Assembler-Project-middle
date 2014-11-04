%include "asm_io.inc"

segment .text
	global assignLetter

assignLetter:
	push ebp 
	mov ebp,esp 

	mov eax, [ebp + 12] ;tabla con las codificaciones
	mov esi, [ebp + 8] ;codficacion a comparar

	cmp esi, [eax] ;comparo si es lo que esta en la tabla en la 0 posicion
	je isA

	cmp esi, [eax + 1] ;comparo si es lo que esta en la tabla en la 1 posicion
	je isB
	
	cmp esi, [eax + 2] ;comparo si es lo que esta en la tabla en la 2 posicion
	je isC
	
	cmp esi, [eax + 3] ;comparo si es lo que esta en la tabla en la 3 posicion
	je isD

	isA:
	mov eax, 0
	mov eax, 65 ;si era la posicion 0 le asigo A
	jmp EndD

	isB:
	mov eax, 0
	mov eax, 65 ;si era la posicion 1 le asigo B
	jmp EndD

	isC:
	mov eax, 0
	mov eax, 66 ;si era la posicion 2 le asigo C
	jmp EndD

	isD:
	mov eax, 0
	mov eax, 67 ;si era la posicion 3 le asigo D
	EndD:

	mov esp, ebp
	pop ebp
	ret