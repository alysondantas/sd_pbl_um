.data

.text

.global main

main:

	addi r10, zero, 0x3020	# Endereco base de memoria dos LED1
	addi r11, zero, 0x3030	# Endereco base de memoria dos btn1
	addi r16, zero, 0x3		# Registrador para comparacao de botao
	addi r17, zero, 0x3		# Registrador para comparacao de estado
	addi r6, zero, 20

	br _LOOP
	
	
_LOOP:
	addi r11, zero, 0x3030		#trocar por enderço btn1
	ldwio	 r3, 0(r11)			# Pega estado do botao
	sub		r7, zero, r17
	bne zero, r7, _LOOPSELECT:
	bne  r16, r3, _botaoMenuDir
	
	addi r11, zero, 0x3040 		#trocar por enderço btn2
	ldwio	 r3, 0(r11)			# Pega estado do botao
	bne  r16, r3, _botaoMenuEsq
	
_LOOPSELECT:
	addi r11, zero, 0x3050 		#trocar por enderço btn3
	ldwio	 r3, 0(r11)			# Pega estado do botao
	bne  r16, r3, _botaoMenuSelect
	
	addi r11, zero, 0x3060 		#trocar por enderço btn4
	ldwio	 r3, 0(r11)			# Pega estado do botao
	bne  r16, r3, _botaoMenuBack
	
	br _LOOP


_botaoMenuDir:
	#calcular para escrever nova msg usando um rAlgo que guarde o estado da opção
	br _LOOP
	# br end

_botaoMenuEsq:
	#calcular para escrever nova msg usando um rAlgo que guarde o estado da opção
	br _LOOP
	# br end

_botaoMenuSelect:
	addi r17, zero, 0x1
	#calcular para escrever nova msg usando um rAlgo que guarde o estado da opção
	br _LOOP
	# br end

_botaoMenuBack:
	addi r17, zero, 0x00
	#calcular para escrever nova msg usando um rAlgo que guarde o estado da opção
	br _LOOP
	# br end




_DELAY:
    subi r6, r6, 1       # subtract 1 from delay
    bne r6, zero, _DELAY  # continue subtracting if delay not elapsed
    br _LOOP  
end:
	br end
	.end
