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
	mov edx, 0 ;inicializo el registro donde voy a obtener los primeros 8 digitos de la cadena codificada
	mov ebx, [ebp + 8] 
	mov dl , [ebx] ; asigno los primeros 8 bits codificados a dl

	mov ebx, 0 ;  indice del arreglo para la decodificacion
	mov edi, 0 ; indice del arreglo codificado
	mov dword[ebp - 4],1 ;contador de shifteos de registro de 8 bits, asigno uno para descontar el primer shifteo que hago
	shl dl, 1 ;le shiteo un 0 para sacar el 0 del bit mas significativo
	jmp shift

;=================

cambiarRegistro:
	inc edi ; avanzo al proximo registro de las codificaciones
	mov edx, 0 ;inicializo el registro donde guardo los 8 bits corrientes
	mov ecx, [ebp + 8] ; asigno la direccion del arreglo
	mov dl, [ecx + edi] ;asigno los 8 bits corrientes
	mov dword[ebp - 4], 0 ;reinicio el contador de shifteos hasta el momento
	jmp finCambiarRegistro

;PRINCIPAL

;==================

shift:
	mov eax, 0 ; incializo el registro de shifteos
shiftRegs:
	cmp dword[ebp - 4],8 ;comparo para ver si se hicieron 8 shifteos, si se cumplieron cambio al proximo indice
	je cambiarRegistro
finCambiarRegistro:
	inc dword[ebp - 4]
	shl dl,1 ; arreglo donde esta la codificacion
	jnc finShift ; si se vuelve a shiftear un cero es porque termino
	rcl al,1 ;le shifteo lo que saque del arreglo de codificaciones
	jmp shiftRegs
finShift:
	cmp al, 0
	je fin

;==================
	push dword[ebp + 12] ;push de la tabla con la codifiacion de cada letra
	push eax ;push de la codificacion obtenida
	call assignLetter ;me dice que letra asignar dependiendo de la codificacion pasada y de la tabla
	add esp, 8 ;resultado esta en eax

;==================
	mov ecx,[ebp + 16] ; asigno la direccion del arreglo
	mov dword[ecx + ebx], eax ;muevo al arreglo decodificado la letra obtenida del assignLetter
	mov eax, 0 ; inicializo el registr
	inc ebx ;incremento el indice del arreglo decodificado
	jmp shift

;==================

fin:


	mov esp, ebp
	pop ebp
	ret