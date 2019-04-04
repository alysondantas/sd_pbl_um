.data
values: .word 1, 0
.text

.global main

main:

	addi r10, zero, 0x5030	# Endereco base de memoria dos LEDs
	addi r11, zero, 0x5020	# Endereco base de memoria dos botoes
	addi r16, zero, 0xf		# Registrador para comparacao de botao
	addi r6, zero, 20

	br _LOOP
	
	# addi r10, r10, 0 
	# ldw r4, 0(r10)
	# stw r4, 0(r10)
	
	# mov r2, r0
	# movi r3, 1
	# movia r10, values
	# ldw r4, 0(r10)


_acenderLeds:
	addi r4, zero, 0x0		# Seleciona quais LEDs acenderao
	stwio  r4, 0(r10)			# Acender os LEDs
	movia r6, 10000000		
	br _DELAY
	br _LOOP
	# br end

_LOOP:
	ldwio	 r3, 0(r11)			# Pega estado do botao
	bne  r16, r3, _acenderLeds
	call _apagarLeds
	br _LOOP 
_apagarLeds:
	addi r4, zero, 0xff		# Seleciona quais LEDs apagarao
	stwio  r4, 0(r10)			# Acender os LEDs
	br _LOOP
_DELAY:
    subi r6, r6, 1       # subtract 1 from delay
    bne r6, zero, _DELAY  # continue subtracting if delay not elapsed
    br _LOOP  
end:
	br end
	.end
