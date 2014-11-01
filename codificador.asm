%include "asm_io.inc"
segment .text
	global codificador
	extern cant

codificador:
	push ebp
	mov ebp, esp
	sub esp, 8

	mov dword[ebp - 4], 0 ; indice que controla que el registro no este lleno 0..8
	mov dword[ebp - 8], 0 ; contador de shifteo hasta el momento
 	mov ebx, 0 ; indice del arreglo original
 	mov eax, 0 ; indice del arreglo de binaros 0,1,2,3
 	mov edi, 0 ; indice del arreglo codificado
 	mov ecx, [ebp + 16] ;original
 	mov edx, 0 ; lugar donde se van a hacer el shifteo que luego se moveran en codificado
 	mov esi, [ebp + 8] ; bin 
 	jmp noFinArreglo

 ;=========================

 isA:
 	
 	mov eax, 0 
 	mov esi, [ebp + 8] ; asigno a esi la direccion del primer elemento de la tabla de bin 
 	mov al,[esi] ;a al le doy lo que hay en esi en la posicion 0
 	jmp finCmpLetra

 isB:
  mov eax, 0 
 	mov esi, [ebp + 8] ; asigno a esi la direccion del primer elemento de la tabla de bin 
 	mov al, [esi + 1] ;a al le doy lo que hay en esi en la posicion 1
 	jmp finCmpLetra

 isC:
  mov eax, 0 
 	mov esi, [ebp + 8] ; asigno a esi la direccion del primer elemento de la tabla de bin 
 	mov al, [esi + 2] ;a al le doy lo que hay en esi en la posicion 2
 	jmp finCmpLetra

 isD:
  mov eax, 0 
 	mov esi, [ebp + 8] ; asigno a esi la direccion del primer elemento de la tabla de bin 
 	mov al, [esi + 3] ;a al le doy lo que hay en esi en la posicion 3
 	jmp finCmpLetra

;=========================
shiftUno:
	cmp dword[ebp - 4], 8 ; controlo que se hallan llenado los 8 bit 
	jge CambiarRegistro
	finCambiarRegistro:
	stc
	rcl dl, 1
	inc dword[ebp - 4] ;indice que controla que el registro no este lleno 0..8
	inc dword[ebp - 8] ;contador de shifteo hasta el momento
	cmp dword[ebp - 8],eax ; cantidad de unos ashiftear
	je finShifteo ; si se shiftearon n lugares terminaron si no sigue
	jmp shiftUno

;=========================

CambiarRegistro:
	mov ecx, [ebp + 12] ; arreglo codificado como necesitamos un registro extra liberamos momentaneamente uno
	mov [ecx + edi], dl ; muevo al arrelgo codificado el regisro ya lleno de 0 y unos
	mov ecx, [ebp + 16] ; arreglo original recuperamos lo que tenia el registro anterior mente
	inc edi
	mov edx, 0 ; inicializo el registro donde se shiftearan 1
	mov dword[ebp - 4], 0
	jmp finCambiarRegistro


;=========================

CambiarRegistro0: ;cambia el registro lleno por si se lleno cuando shifteo los ceros
	mov ecx, [ebp + 12]; arreglo codificado como necesitamos un registro extra liberamos momentaneamente uno
	mov [ecx + edi], dl ; muevo al arrelgo codificado el regisro ya lleno de 0 y unos
	mov ecx, [ebp + 16] ;arreglo original recuperamos lo que tenia el registro anterior mente
	inc edi
	mov edx, 0 ; inicializo el registro donde se shiftearan 1
	mov dword[ebp - 4], 0
	jmp finCambiarRegistro0

;=========================

noFinArreglo:
	mov al,[ecx + ebx] ; a al le doy el elemento corriento del arreglo original
	
	cmp al, 65 ;comparo si es A
	je isA
	cmp al, 66 ;comparo si es B
	je isB
	cmp al, 67 ;comparo si es C
	je isC
	cmp al, 68 ;comparo si es D
	je isD
	cmp al, 48 ; compara si es el fin de cadena osea "0"
	je finArreglo
finCmpLetra:
	push eax
	call cant ; calcula la cantidad de uno que tengo que shiftear
	pop eax
	 
	cmp dword[ebp - 4], 8 ; controlo que no se hallan llenado los 8 bit 
	je CambiarRegistro0
	finCambiarRegistro0:
	mov dword[ebp - 8], 0  	; inicializo en 0 la cantidad de unos a shiftear
	shl dl, 1 							; rutina que shiftea
	inc dword[ebp - 4]			; ceros al comienzo
	
	jmp shiftUno
finShifteo:
	
	cmp dword[ebp - 4], 8 ; verifico si se lleno el registro en donde realizo los shifteo
	jne continue					;si se lleno lo cambio
	mov ecx, [ebp + 12]; areglo codificado como necesitamos un registro extra liberamos momentaneamente uno
	mov [ecx + edi], dl ; muevo al arrelgo codificado el regisro ya lleno de 0 y unos
	mov ecx, [ebp + 16] ;arreglo original recuperamos lo que tenia el registro anterior mente
	inc edi
	mov edx, 0 ; inicializo el registro donde se shiftearan 1
	mov dword[ebp - 4], 0
continue:

	inc ebx ; obtengo la proxima letra
	jmp noFinArreglo
finArreglo:
	cmp dword[ebp - 4], 8 ;veo si el registro donde realizo los shifteo no esta lleno si lo esta termin si no
	je termine	;lo lleno de 0 hasta que las codificaciones queden en la parte mas significativa
	
	shl dl, 1 ; shifteo 0 para llenar el registro
	inc dword[ebp - 4] ; incremento el contador que verifica el espacio del registro
	cmp dword[ebp - 4], 8 ; comparo que no este lleno
	jl finArreglo

;==========================
;el registro lleno lo paso al arreglo codificado
	mov ecx, [ebp + 12]; codificado como necesitamos un registro extra liberamos momentaneamente uno
	mov [ecx + edi], dl ; muevo al arrelgo codificado el regisro ya lleno de 0 y unos
termine:
;=========================

	mov esp, ebp
	pop ebp
	ret