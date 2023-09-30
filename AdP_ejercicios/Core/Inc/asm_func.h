#pragma once

#include <stdint.h>


void asm_zeros (uint32_t * vector, uint32_t longitud);
void asm_productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);
void asm_productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);
void asm_productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);
void asm_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);
