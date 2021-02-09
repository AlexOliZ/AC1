	.data
	.eqv print_int,1
	.eqv SIZE,4
array:	.word 7682, 23, 5, 234
	.text
	.globl main
	
	# Mapa de registos
	# p: $t0
	# pultimo:$t1	
	# *p $t2
	# soma: $t3
	
main:
	# guarda cada indice de 4 em 4 endereços da memoria logo
	li $t4,SIZE
	sll $t4,$t4,2
	
	# pultimo = primeiro_endereço + SIZE*4
	
	# pultimo
	li $t3,0
	la $t1,array
	addu $t1,$t1,$t4
	
	la $t0,array
while:
	bge $t0,$t1,endw
	
	lw $t2, 0, ($t0)
	add $t3,$t3,$t2
	
	addiu $t0,$t0,4
	j while
endw:

	li $v0,print_int
	move $a0,$t3
	syscall

	jr $ra