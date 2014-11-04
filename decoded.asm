%include "asm_io.inc"

segment .text
	global decode
	extern assignLetter

decode:
	push ebp 
	mov ebp,esp
	sub esp,4 

	;[ebp + 8] ;cadena codificada
	;[ebp + 12] ;tabla con las codificaciones
	;[ebp + 16] ;string vacio para la cadena a decodificar
	mov ebx, [ebp +12]
	mov dl , [ebx]

	mov ebx,0 ;  indice del arreglo para la decodificacion
	mov edi,0 ; indice del arreglo codificado
	mov dword[ebp - 4],0 ;contador de shifteos de registro de 8 bits
	jmp shift

;=================

cambiarRegistro0:
	inc edi ; avanzo al proximo registro de las codificaciones
	mov dword[ebp - 4], 0 ;reinicio el contador de shifteos
	jmp finCambiarRegistro0

cambiarRegistro:
	inc edi ; avanzo al proximo registro de las codificaciones
	mov ecx, [ebp + 8]
	mov edx, [ecx + edi]
	mov dword[ebp - 4], 0 ;reinicio el contador de shifteos
	jmp finCambiarRegistro


;PRINCIPAL

;==================

shift:
	mov eax, 0 ; incializo el registro de shifteos
	;mov edx,0
	cmp dword[ebp - 4],7 ;comparo para ver si se hicieron 8 shifteos, si se cumplieron cambio al proximo indice
	je cambiarRegistro0
finCambiarRegistro0:
	shl al,1 ;shifteo un uno del principio para luego preguntar si el proximo que se ingreso es 0 sali
shiftRegs:
	cmp dword[ebp - 4],7 ;comparo para ver si se hicieron 8 shifteos, si se cumplieron cambio al proximo indice
	je cambiarRegistro
finCambiarRegistro:
	shr dl,1 ; arreglo donde esta la codificacion
	jnc finShift ; si se vuelve a shiftear un cero es porque termino
	rcl al,1 ;le shifteo lo que saque del arreglo de codificaciones
	inc dword[ebp - 4]
	jmp shiftRegs
finShift:
	cmp al, 0
	dump_regs 234
	je fin

;==================

	push dword[ebp + 12]
	push eax
	call assignLetter
	add esp, 8 ;resultado esta en eax

;==================

	mov ecx,[ebp + 16]
	mov dword[ecx + ebx], eax
	mov eax, 0
	inc ebx
	jmp shift

;==================

fin:






	mov esp, ebp
	pop ebp
	ret