%include "asm_io.inc"

segment .text
	global assignLetter

assignLetter:
	push ebp 
	mov ebp,esp

	mov eax, [ebp + 12] ;tabla con las codificaciones
	mov ecx, 0 ;inicializacion del registro

	mov cl,[eax]
	cmp [ebp + 8], ecx ;comparo si es lo que esta en la tabla en la 0 posicion
	je isA

	mov cl,[eax + 1]
	cmp [ebp + 8], ecx ;comparo si es lo que esta en la tabla en la 1 posicion
	je isB
	
	mov cl,[eax + 2]
	cmp [ebp + 8], ecx ;comparo si es lo que esta en la tabla en la 2 posicion
	je isC
	
	mov cl,[eax + 3]
	cmp [ebp + 8], ecx ;comparo si es lo que esta en la tabla en la 3 posicion
	je isD


	isA:
	mov eax, 0
	mov eax, 65 ;si era la posicion 0 le asigo A
	jmp EndD

	isB:
	mov eax, 0
	mov eax, 66 ;si era la posicion 1 le asigo B
	jmp EndD

	isC:
	mov eax, 0
	mov eax, 67 ;si era la posicion 2 le asigo C
	jmp EndD

	isD:
	mov eax, 0
	mov eax, 68 ;si era la posicion 3 le asigo D
	EndD:

	mov esp, ebp
	pop ebp
	ret