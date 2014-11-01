%include "asm_io.inc"

segment .data
	contador dd 0,0,0,0 ;arreglo donde se alamcenaran la cantidad de repeticiones de cada letra, 
	;como se necesita durante todo el programa era lo mismo utilizar un label

segment .text
	global encode
	extern counter
	extern linker
	extern codificador

encode:
	push ebp 
	mov ebp,esp 

	push dword[ebp + 8] ;arreglo con la cadena original
	push contador ;cotiene la cantidad de repeticiones de cada letra
	call counter ; subrutina que cuenta la cantidad de ocurrencia de cada letra
	add esp, 8
	
	push contador ;contiene la cantidad de repeticiones de cada letra
	push dword[ebp + 12] ; tabla a llenar con los binarios correspondiente a la codificacion de cada letra
	call linker ;subrutina que arma la tabla de binarios de cada letra
	add esp, 8

	push dword[ebp + 8] ;arreglo con la cadena original
	push dword[ebp + 16] ; arreglo vacion qdonde se alojarra el mje codificado
	push dword[ebp + 12] ; tabla con los binarios correspondiente a la codificacion de cada letra
	call codificador ;subrutina que codifica el arreglo de acuerdo a la tabla de binarios
	add esp, 12

	mov esp, ebp
	pop ebp
	ret