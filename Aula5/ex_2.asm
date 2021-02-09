	.data
	.eqv  SIZE,10
	.eqv print_int,1
	.eqv print_string,4
str:	.asciiz ";"
lista:   .word 8,-4,3,5,124,-15,87,9,27,15
	.align 2
line:	.asciiz "\n"


	.text
	.globl main

	#Mapa de Registos
	# i -> $t0
	# &lista -> $t1
	# *lista -> $t2
	# tmp -> $t3
	# index_aux -> $t4	
	
main:	

	li $v0,print_string
	la $a0,line
	syscall
	
	li $t0,0
	la $t1,lista
while:	
	bge $t0,SIZE,end
	
	# ponteiro
	sll $t4,$t0,2
	addu $t2,$t1,$t4
	lw $t3,0($t2)
	li $v0,print_int
	move $a0,$t3
	syscall
	
	li $v0,print_string
	la $a0,str
	syscall
	
	addi $t0,$t0,1
	
	j while
end:	
	li $v0,print_string
	la $a0,line
	syscall

	jr $ra