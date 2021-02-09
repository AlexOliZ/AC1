	.data
	.eqv print_int,1
	.eqv read_str,8
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	.align 2
str1:	.space 25
str2:	.space 25
str3:	.asciiz "---LENGTH----"
	.text
	.globl main
	
	# Mapa de Registos
main:	
	li $a1,25
	la $a0,str1
	li $v0,read_str
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall
	
	li $v0,read_int
	syscall
	move $t2,$v0 #a
	li $a0,'\n'
	li $v0,print_char
	syscall
	
	li $v0,read_int
	syscall
	move $t3,$v0 #b
	li $a0,'\n'
	li $v0,print_char
	syscall
			
if:	
	ble $t3,$t2,else
	la $t8,str1
	la $t9,str2
	li $t0,0
	li $t1,0

while1:
	bge $t0,$t2,end1
	addu $t4,$t8,$t0
	lb $t5,0($t4)
	beq $t5,'\0',end1
	addi $t0,$t0,1
	j while1
end1:



while2:
	bgt $t0,$t3,end2
	addu $t4,$t0,$t8
	lb $t5,0($t4)
	beq $t5,'\0',end2
	addu $t6,$t1,$t9
	sb $t5,0($t6)
	addi $t0,$t0,1
	addi $t1,$t1,1
	j while2
end2:
	li $t0,'\0'
	sb $t0,0($t6)
else:
	
	la $a0,str2
	li $v0,print_str
	syscall
	
	jr $ra