	.data
	
	.eqv print_int,1
	.align 2
str : 	.asciiz "2016 e 2020 sao anos bissextos"
bin:	.asciiz "101101"
	.text
	.globl main

# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1
# Sub-rotina terminal: não devem ser usados registos $sx

atoi_binary:
	li $v0,0 		# res = 0;
	li $t0,0
whileb: 
	lb $t0,0($a0) 		# while(*s >= ...)
 	blt $t0,'0',endwb 	#
 	bgt $t0,'1',endwb 	# {
 	sub $t1,$t0,'0' 	# digit = *s – '0'
 	addiu $a0,$a0,1  	# s++;
 	mul $v0,$v0,2 		# res = 10 * res;
 	add $v0,$t1,$v0 	# res = 10 * res + digit; 
 	j whileb			# }
endwb:
	jr $ra
atoi: 
	# ---- armazenar na stack ----
	#addiu $sp,$sp,-8
	#sw $ra,0($sp)#guarda endereço de retorno (str)
	#sw $s0,4($sp)#guarda valor dos registos return
	#move $s0,$a0
	
	# ----------------------------
	li $v0,0 		# res = 0;
	li $t0,0
while: 
	lb $t0,0($a0) 		# while(*s >= ...)
 	blt $t0,'0',endw 	#
 	bgt $t0,'9',endw 	# {
 	sub $t1,$t0,'0' 	# digit = *s – '0'
 	addiu $a0,$a0,1  	# s++;
 	mul $v0,$v0,10 		# res = 10 * res;
 	add $v0,$t1,$v0 	# res = 10 * res + digit; 
 	j while			# }
endw:
 	
 	jr $ra 			# termina sub-rotina 

main:	
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,bin
	jal atoi_binary
	move $a0,$v0
	li $v0,print_int
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	
	jr $ra
