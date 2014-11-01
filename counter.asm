%include "asm_io.inc"
segment .text
	global counter

counter:
	push ebp
	mov ebp,esp

 	mov ebx, 0
	mov eax, 0
	mov ecx, dword[ebp + 12]; arreglo con la cadena original
	mov edx, dword[ebp + 8] ; arreglo donde se pondra las ocurrencia de cada letra
	
comparar:
	mov bl,[ecx + eax];muevo lo que hay en el arreglo en el indice eax en bl
	cmp bl, 65 ; letra "A"
	je countA
	cmp bl, 66 ; letra "B"
	je countB
	cmp bl, 67 ; letra "C"
	je countC
	cmp bl, 68 ; letra "D"
	je countD
	inc eax ; incremento indice del arreglo
	cmp bl, 48 ; comparo con fin de cadena
	je finPrintD
	jmp comparar

countA:;cuenta las ocurrencias de A
	inc dword[edx] ; aumentar el contador de la a en el arreglo de la pila
	inc eax ; incremento indice de arreglo
	cmp bl, 48 ;comparo on fiind e cadena
	je finPrintD
	jmp comparar
finPrintA:

countB:;cuenta las ocurrencias de B
	inc dword[edx + 4] ; aumentar el contador de la b en el arreglo de la pila
	inc eax ; incremento indice de arreglo
	cmp bl, 48 ;comparo on fiind e cadena
	je finPrintD
	jmp comparar
finPrintB:

countC:;cuenta las ocurrencias de C
	inc dword[edx + 8] ; aumentar el contador de la c en el arreglo de la pila
	inc eax ; incremento indice de arreglo
	cmp bl, 48 ;comparo on fiind e cadena
	je finPrintD
	jmp comparar
finPrintC:

countD:;cuenta las ocurrencias de D
	inc dword[edx + 12] ; aumentar el contador de la d en el arreglo de la pila
	add eax,4 ; incremento indice de arreglo
	cmp bl, 48 ;comparo on fiind e cadena
	je finPrintD
	jmp comparar
finPrintD:

	mov esp, ebp
	pop ebp
	ret
