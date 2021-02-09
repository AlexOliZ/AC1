	.data
	.eqv print_str,8
	.eqv print_char,11
	.eqv SIZE,3
str1:	.asciiz "AC1"
	.align 2
str2:	.asciiz "GUIAO"
	.align 2
str3:	.asciiz "SEIS"
	.align 2	
array:  .word str1,str2,str3
	.text
	.globl main
	
	# Mapa de Registos
	# i -> $t0
	# array -> $t1
	# array* -> $t2
	# str -> $t3
	# str* -> $t4
	
main:
	li $t0,0
	la $t1,array
	
while:
	bge $t0,SIZE,endw
	
	sll $t2,$t0,2
	addu $t2,$t2,$t1
	lw $t3,0($t2)
	move $t5,$t3
while1:
	lb $a0,0($t5)
	beq $a0,'\0',endw1
	li $v0,print_char
	syscall
	addi $t5,$t5,1
	j while1
endw1:	
	
	
	li $a0,' '
	li $v0,print_char
	syscall
	addi $t0,$t0,1
	j while
endw:
	li $a0,'\n'
	li $v0,print_char
	syscall
	jr $ra
