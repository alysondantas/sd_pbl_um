# ------------------------------------------------------------------------
#	r6 - Registrador usando como contador em delay 
#
# ------------------------------------------------------------------------



.data
values: .word 1, 0
.equ CONST_30mics, 0x7D	   # 125
.equ CONST_50mics, 0xD0	   # 208
.equ CONST_50ms,   0x‭32DCD‬ # 208.333
.equ CONST_200ms,  0x‭CB735 # 833.333

movia r9, 0x000000			# Endereco de memoria do enable lcd
movia r10, 0x00000			# Endereco de memoria do data lcd


.text

.global main

main:
  call _lcd_init


_lcd_init:
	_delay_50ms								# aguarda a tensão estabilizar no display
	add r7, zero, 0x34						# 1 - linha, display on
	add r8, zero, 0x1 						# comando enable do lcd
	stwio r7, 0(r10)						# coloca o comando no data
	stwio r8, 0(r9)  						# habilita o enable
	add r8, zero, 0x0						# zera o r8
	stwio r8, 0(r9)  						# desabilita o enable

	_delay_50micseg							# Aguarda para enviar o proximo comando
	add r7, zero, 0x30						# Display on, cursor off e blink off 
	add r8, zero, 0x1 						# comando enable do lcd
	stwio r7, 0(r10)						# coloca o comando no data
	stwio r8, 0(r9)  						# habilita o enable
	add r8, zero, 0x0						# zera o r8
	stwio r8, 0(r9)  						# desabilita o enable


# ------------------------------------------- DELAY -----------------------------------------------
_delay_200ms:
    add r6, r6, 1       	   				# adiciona um ao contador
    bne r6, CONT_200ms, _delay_200ms	    # continua chamando a label
	add r6, zero, zero						# Zera o registrador r6, adiciona +20ns
    ret  									# pc <- ra. Tempo da rotina 199,99996  milisegundos

_delay_50ms:
    add r6, r6, 1       	   				# adiciona um ao contador
    bne r6, CONT_50ms, _delay_50ms	    	# continua chamando a label
	add r6, zero, zero						# Zera o registrador r6, adiciona +20ns
    ret  									# pc <- ra. Tempo da rotina 49,99996 milisegundos

_delay_50micseg:
    add r6, r6, 1       	   				# adiciona um ao contador
    bne r6, CONT_50mics, _delay_50micseg    # continua chamando a label
	add r6, zero, zero						# Zera o registrador r6, adiciona +20ns
    ret  	

_delay_30micseg:
    add r6, r6, 1       	   				# adiciona um ao contador
    bne r6, CONT_30mics, _delay_30micseg    # continua chamando a label
	add r6, zero, zero						# Zera o registrador r6, adiciona +20ns
    ret  									# pc <- ra. Tempo da rotina 30,04 microsegundos
