.syntax unified
.thumb
.text

@ Simbolos exportados --> No olvidar de colocar los nombres de las funciones aquí

.global asm_zeros
.global asm_productoEscalar32
.global asm_productoEscalar16
.global asm_productoEscalar12
.global asm_pack32to16

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_zeros(uint32_t *vectorIn, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: vectorIn
@   r1: longitud
@
@ Valor de retorno:
@   -
@

.thumb_func
    asm_zeros:
    	// Guardas de seguridad:
    	cbz r0, exit
    	cbz r1, exit
    	// Se utiliza para str
    	mov r2, #0

    	loop:
    		// Decremento el contador
    		subs r1, #1
    		// Se guarda un 0 en la posición *
    		str r2, [r0, r1, lsl #2]
    		bne loop
	exit:
		bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar)
@
@ Parametros recibidos:
@   r0: vectorIn
@   r1: vectorOut
@	r2: longitud
@   r3: escalar
@
@ Valor de retorno:
@   -
@

.thumb_func
	asm_productoEscalar32:
		//Guardas de seguridad
		//cbz r0, exit1
		//cbz r1, exit1
		//cbz r2, exit1
		push {r4}
		loop_pEscalar32:
			subs r2, #1		// decremento valor del indice para recorrer el vector
			ldr r4, [r0, r2, lsl #2]	// cargo el valor del cada elemento del vector en r4
			mul r4, r4, r3	// realizo multiplicacion del elemento del vector cargado por el escalar
			str r4, [r1, r2, lsl #2]	// guardo el producto en el vectorOut
			bne loop_pEscalar32
		pop {r4}
		bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar)
@
@ Parametros recibidos:
@   r0: vectorIn
@   r1: vectorOut
@	r2: longitud
@   r3: escalar
@
@ Valor de retorno:
@   -
@

.thumb_func
	asm_productoEscalar16:
		push {r4}
		// Guardas de seguridad
		//cbz r0, exit2
		//cbz r1, exit2
		//cbz r2, exit2

		loop2:
			// decremento valor del indice para recorrer el vector
			subs r2, #1
			// cargo el valor del cada elemento del vector en r4
			ldrh r4, [r0, r2, lsl #1]
			// realizo multiplicacion del elemento del vector cargado por el escalar
			mul r4, r4, r3
			// guardo el producto en el vectorOut
			strh r4, [r1, r2, lsl #1]
			bne loop2
		pop {r4}
	exit2:
		bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar)
@
@ Parametros recibidos:
@   r0: vectorIn
@   r1: vectorOut
@	r2: longitud
@   r3: escalar
@
@ Valor de retorno:
@   -
@

.thumb_func
	asm_productoEscalar12:
		push {r4}
		// Guardas de seguridad
		// cbz r0, exit3
		// cbz r1, exit3
		// cbz r2, exit3

		loop3:
			// decremento valor del indice para recorrer el vector
			subs r2, #1
			// cargo el valor del cada elemento del vector en r4
			ldrh r4, [r0, r2, lsl #1]
			// realizo multiplicacion del elemento del vector cargado por el escalar
			mul r4, r4, r3
			// saturo el resultado a 12 bits
			usat16 r4, #12, r4
			// guardo el producto en el vectorOut
			strh r4, [r1, r2, lsl #1]
			bne loop3
	exit3:
		pop {r4}
		bx lr


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void pack32to16 (int32_t * vectorIn, int16_t * vectorOut, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: vectorIn
@   r1: vectorOut
@	r2: longitud
@
@
@ Valor de retorno:
@   -
@

.thumb_func
	asm_pack32to16:
		push {r4}
		sub r2, 1

	loop6:
		ldr r3, [r0, r2, lsl #2]
		cmp r3, 0
		ite mi
		asrmi r4, r3, 16
		lsrpl r4, r3, 16
		strh r4, [r1, r2, lsl #1]
		subs r2, 1
		bne loop6

		pop {r4}
		bx lr





