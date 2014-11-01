%include "asm_io.inc"

segment .text
	global linker

	extern div4
	extern maxElementPos

linker:
	push ebp 
	mov ebp,esp 

	mov ecx, 0
	mov esi, [ebp + 12] ; arreglo que contiene la cantidad de repeticiones de cada letra
	
while:	
	push esi
	call maxElementPos
	add esp, 4
	mov edi, eax ;retorno la posicion del maximo elemento en eax
	mov dword[esi + edi], -1 ;seteo el valor del maximo de la iteracion en -1 para no tenerlo en cuenta en la iteracion siguiente

	cmp ecx, 0 ;si el indice es 0 entonces se shiftea el 01
	je assign01

	cmp ecx, 1 ;si el indice es 1 entonces se shiftea el 011
	je assign011

	cmp ecx, 2 ;si el indice es 2 entonces se shiftea el 0111
	je assign0111

	cmp ecx, 3 ;si el indice es 3 entonces se shiftea el 01111
	je assign01111
fAssignBL:

	mov edx, [ebp + 8] ; arreglo donde se pondraa la codificacion de cada letra
	push edi
	call div4
	pop eax
	mov [edx + eax],bl

	inc ecx
	cmp ecx, 4
	je fin
	jmp while

;de acuerdo al indice que era es lo que se va a shiftear
;=======================
assign01: ; indice 0 se shiftea 01
	mov bl, 1
	jmp fAssignBL 

assign011: ; indice 1 se shiftea 011
	mov bl, 3
	jmp fAssignBL

assign0111: ; indice 2 se shiftea 0111
	mov bl, 7
	jmp fAssignBL

assign01111: ; indice 3 se shiftea 01111
	mov bl, 15
	jp fAssignBL
	
fin:

	mov esp, ebp
	pop ebp
	ret