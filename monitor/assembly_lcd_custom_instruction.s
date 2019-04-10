.data
	CONST_50ms:   	.word 0x32DCD 		# 208.333 0x‭32DCD‬
	CONST_50mics: 	.word 0xD0		  	# 208
	CONST_30mics: 	.word 0x7D		  	# 125
	CONST_200ms:	.word 0xCB735		# 833.333
	
 .text

 .global main

 main:
	call _init
	call _init_lcd
	br end
	
_init:
	movia r8, 0xCB735
	movia r9, 0x32DCD
	movia r10, 0xD0
	movia r11, 0x7D
	ret
	
_init_lcd:
	call _delay_50ms
	call _delay_50ms
	addi r16, zero, 0x30 # Registrador d - comando set
	addi r15, zero, 0x0 # Registrador rs
	custom 0, r19, r15, r16  
	call _delay_50ms
	addi r16, zero, 0x0E # Registrador d - comando on/of
	custom 0, r19, r15, r16 
	call _delay_50ms
	addi r16, zero, 0x6 # Registrador d - comando clear
	custom 0, r19, r15, r16 
	call _delay_200ms
	addi r16, zero, 0x1 # Registrador d - comando mode set
	custom 0, r19, r15, r16 
	
	ret
	
	
# # ------------------------------------------- DELAY -----------------------------------------------
_delay_200ms:
    addi r6, r6, 1       	   				# adiciona um ao contador
    bne r6, r8, _delay_200ms	    # continua chamando a label
	add r6, zero, zero						# Zera o registrador r6, adiciona +20ns
    ret  									# pc <- ra. Tempo da rotina 199,99996  milisegundos

_delay_50ms:
    addi r6, r6, 1       	   				# adiciona um ao contador
    bne r6, r9, _delay_50ms	    	# continua chamando a label
	add r6, zero, zero						# Zera o registrador r6, adiciona +20ns
    ret  									# pc <- ra. Tempo da rotina 49,99996 milisegundos

_delay_50micseg:
    addi r6, r6, 1       	   				# adiciona um ao contador
    bne r6, r10, _delay_50micseg    			# continua chamando a label
	add r6, zero, zero						# Zera o registrador r6, adiciona +20ns
    ret  									# pc <- ra. 

_delay_30micseg:
    addi r6, r6, 1       	   				# adiciona um ao contador
    bne r6, r11, _delay_30micseg    # continua chamando a label
	add r6, zero, zero						# Zera o registrador r6, adiciona +20ns
    ret  									# pc <- ra. Tempo da rotina 30,04 microsegundos


 .end
end:
	br end