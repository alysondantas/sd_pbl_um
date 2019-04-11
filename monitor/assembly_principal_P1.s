#===================================================================
#---------- BOTÕES ----------------------
# Endereço Base - 0x5060
# S1 - SELECIONAR - 0xE - offset 0
# S2 - VOLTAR     - 0xD - offset 4
# S3 - DIREITA    - 0xB - offset 8
# S4 - ESQUERDA   - 0x7 - offset c
# Obs: os valores mais a direita pode ser que tenha que inverter a orde: S1->S4 e assim vai
#------------------------------------------
#------------ ESTADOS ---------------------
# ESTADO 1 - 0x1 - 
# ESTADO 2 - 0x2 - 
# ESTADO 3 - 0x3 - 
# ESTADO 4 - 0x4 - 
# ESTADO 5 - 0x5 - 
# r6 	- Registrador para o calculo do delay
# r16 	- Instruções LCD
# r17 	- Pino RS LCD
# r23 	- Retorno do Custom
#
# 
#=======================================================================
.data
botoes:		.word 0x000E, 0x000D, 0x000B, 0x0007
.text

.global main

main:
	br _init
	# br _EXIBE
	br _MOVIMENT
	
_init:
	movia r8, 0xCB735 # Setando o DELAY 200ms
	movia r9, 0x32DCD # Setando o DELAY 50ms	
	movia r10, 0x02300
	addi r21, zero, 0x000E
	stwio r21, 0(r10)
	addi r21, zero, 0x000D
	stwio r21, 4(r10)
	addi r21, zero, 0x000B
	stwio r21, 8(r10)
	addi r21, zero, 0x0007
	stwio r21, 12(r10)
	addi r11, zero, 0x5070	# Endereco base dos leds
	addi r12, zero, 0x5060	# Endereco base dos leds
	#addi r12, zero, 0x0040	# Endereco base das codificações dos estados pt1
	addi r14, zero, 0x0030	# Endereco base das codificações dos botões
	addi r15, zero, 0x0 	# Registrador de comparação de botão
	addi r18, zero, 0x0001 	# Registrador de comparação de estados
	addi r20, zero, 0x1	# Registrador que guarda o estado atual
	
	
	#-------------- INICIALIZAÇÃO DO LCD ------------------------------------
	
	call _delay_50ms
	addi r16, zero, 0x30 # Registrador d - comando set
	addi r17, zero, 0x0 # Registrador rs
	custom 0, r23, r17, r16  
	call _delay_50ms
	addi r16, zero, 0x0C # Registrador d - comando on/of
	custom 0, r23, r17, r16 
	call _delay_50ms
	addi r16, zero, 0x1 # Registrador d - comando clear
	custom 0, r23, r17, r16 
	call _delay_200ms
	addi r16, zero, 0x4 # Registrador d - comando mode set
	custom 0, r23, r17, r16 
	 
	
	br _EXIBE
	
	#------------------------------------- MAQUINA DE ESTADOS -----------------------------------
	
_MOVIMENT:
	
	ldwio r15, 0(r12)			# Pega estado do botao
	ldwio r18, 8(r10)			# Pega o valor referência pro botão direita
	beq r15, r18, _botaoMenuDir
	ldwio r18, 12(r10)			# Pega o valor referência pro botão esquerda
	beq r15, r18, _botaoMenuEsq
	ldwio r18, 0(r10)			# Pega o valor referência pro botão select
	beq r15, r18, _botaoMenuSelect
	ldwio r18, 4(r10)			# Pega o valor referência pro botão voltar
	beq r15, r18, _botaoMenuBack
	
	br _MOVIMENT


_botaoMenuDir:
	#calcular para escrever nova msg usando um rAlgo que guarde o estado da opção
	subi r22, r20, 0x1
	beq r22, zero, _OPDOISD
	subi r22, r20, 0x2
	beq r22, zero, _OPTRESD
	subi r22, r20, 0x3
	beq r22, zero, _OPQUATROD
	subi r22, r20, 0x4
	beq r22, zero, _OPCINCOD
	subi r22, r20, 0x5
	beq r22, zero, _OPUMD
	#exibe o titulo 
	#br _MOVIMENT
	# br end

_botaoMenuEsq:
	#calcular para escrever nova msg usando um rAlgo que guarde o estado da opção
	subi r22, r20, 0x1
	beq r22, zero, _OPCINCOE
	subi r22, r20, 0x2
	beq r22, zero, _OPUME
	subi r22, r20, 0x3
	beq r22, zero, _OPDOISE
	subi r22, r20, 0x4
	beq r22, zero, _OPTRESE
	subi r22, r20, 0x5
	beq r22, zero, _OPQUATROE
	#br _MOVIMENT
	# br end

_botaoMenuSelect:
	#addi r23, zero, 0x1
	#calcular para escrever nova msg usando um rAlgo que guarde o estado da opção
	br _MOVIMENT
	# br end

_botaoMenuBack:
	#addi r23, zero, 0x00
	#calcular para escrever nova msg usando um rAlgo que guarde o estado da opção
	br _MOVIMENT
	# br end
	
#---------- Opções direita -----------------

_OPUMD:
	addi r20, zero, 0x1
	br _EXIBE
	br _MOVIMENT

_OPDOISD:
	addi r20, zero, 0x2
	br _EXIBE
	br _MOVIMENT

_OPTRESD:
	addi r20, zero, 0x3
	br _EXIBE
	br _MOVIMENT

_OPQUATROD:
	addi r20, zero, 0x4
	br _EXIBE
	br _MOVIMENT

_OPCINCOD:
	addi r20, zero, 0x5
	br _EXIBE
	br _MOVIMENT

#---------- Opções esquerda -----------------
	
_OPUME:
	addi r20, zero, 0x1
	br _EXIBE
	br _MOVIMENT

_OPDOISE:
	addi r20, zero, 0x2
	br _EXIBE
	br _MOVIMENT

_OPTRESE:
	addi r20, zero, 0x3
	br _EXIBE
	br _MOVIMENT

_OPQUATROE:
	addi r20, zero, 0x4
	br _EXIBE
	br _MOVIMENT

_OPCINCOE:
	addi r20, zero, 0x5
	br _EXIBE
	br _MOVIMENT
	
	#---------- Exbição -----------------
	
_EXIBE:
	#---------- Primeiro estado -----------------
	addi r17, zero, 0x0 # Registrador rs
	addi r16, zero, 0x1 # Registrador Clear
	custom 0, r23, r17, r16 
	call _delay_50ms
	addi r17, zero, 0x1 # Registrador rs
	addi r16, zero, 0x4F # Registrador d - caracter para escrita
	custom 0, r23, r17, r16 
	call _delay_50ms
	addi r16, zero, 0x50 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16 
	call _delay_50ms
	addi r16, zero, 0x43 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16 
	call _delay_50ms
	addi r16, zero, 0x41 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16 
	call _delay_50ms
	addi r16, zero, 0x4F # Registrador d - caracter para escrita
	custom 0, r23, r17, r16 
	call _delay_50ms
	addi r16, zero, 0x20 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16 
	
	call _delay_50ms
	
	subi r22,r20,0x1
	beq r22,zero, _EXIBEA
	subi r22,r20,0x2
	beq r22,zero, _EXIBEB
	subi r22,r20,0x3
	beq r22,zero, _EXIBEC
	subi r22,r20,0x4
	beq r22,zero, _EXIBED
	subi r22,r20,0x5
	beq r22,zero, _EXIBEE
	
	br _MOVIMENT
	
_EXIBEA:
	addi r16, zero, 0x41 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	call _delay_50ms
	addi r16, zero, 0x20 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16

	br _MOVIMENT

_EXIBEB:
	addi r16, zero, 0x42 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	call _delay_50ms
	addi r16, zero, 0x20 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	br _MOVIMENT
	
_EXIBEC:
	addi r16, zero, 0x43 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	call _delay_50ms
	addi r16, zero, 0x20 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	br _MOVIMENT

_EXIBED:
	addi r16, zero, 0x44 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	call _delay_50ms
	addi r16, zero, 0x20 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	br _MOVIMENT
	
_EXIBEE:
	addi r16, zero, 0x45 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	call _delay_50ms
	addi r16, zero, 0x20 # Registrador d - caracter para escrita
	custom 0, r23, r17, r16
	br _MOVIMENT

# # ------------------------------------------- DELAYS -----------------------------------------------
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

end:
	br end
.end
