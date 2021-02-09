	.data
str:	.asciiz "Arquitetura de Computadores 1"
	.eqv print_int,1
	.text
	.globl main
	
strlen:
	# args em $a
	li $t0,0
while:	
	lb $t1,0($a0)
	addiu $a0,$a0,1
	beq $t1,'\0',end
	addi $t0,$t0,1
	j while
end:
	move $v0,$t0
	jr $ra
	# return em $v

main:

	# abrir espaço na stack subu sb-4
	addiu $sp,$sp,4
	sw $ra,0($sp)
	
	# enviar os args com $a
	la $a0,str
	jal strlen
	move $a0,$v0
	li $v0,print_int
	syscall
	# repor a stack
	lw $ra ,0($sp)
	addi $sp,$sp,-4
	jr $ra