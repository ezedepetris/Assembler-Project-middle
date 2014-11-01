%include "asm_io.inc"

 segment .text
	global maxElementPos

maxElementPos:
	push ebp 
	mov ebp,esp 

	mov ebx, [ebp + 8] ;tabla de repeticiones
	mov edi, 0 ;almaceno el elemento corriente del arreglo
	mov edx, 4 ;indice para el arreglo de repeticiones
	mov eax, 0 ;indice maximo elemento de repeticion e indice de retorno

	;devuelve el indice del maximo elemento del arreglo
;================	
	jmp while
changeMax:
	mov eax, edx ; cambio el indice del maximo
	jmp continue

while:
	cmp edx, 12 ;comparo que no se termine el arreglo
	jg endWhile
	mov edi, [ebx + edx] ;almaceno el elemento corriente
	cmp edi, [ebx + eax] ;comparo el elemento corriente con el que creo que es el maximo
	jg changeMax
continue:
	add edx, 4 ; obtengo el proximo elemento
	jmp while
endWhile:

	mov esp, ebp
	pop ebp
	ret







