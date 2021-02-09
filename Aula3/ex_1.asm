	.data
str1:	.asciiz "Introduza o numero: "
str2:	.asciiz "Valor ignorado\n"
str3:	.asciiz "A soma dos positivos e: "
	.eqv print_str,4
	.eqv print_int,5
	.eqv read_int,1
	.text
	.globl main
	
	# i -> $t0
	# value -> $t1
	# soma -> $t2
	
main:
	li $t0,0
	li $t1,0
	li $t2,0
while:
	addi $t0,$t0,1
	beq $t0,5,endWhile
	#print(str1) && read int
	
	la $a0,str1
	li $v0,print_str
	syscall
	
	li $v0,print_int
	syscall
	add $t1,$v0,$0
	
	ble $t1,0,else
	add $t2,$t2,$t1
	j endIf
else:	
	#print(str2)
	la $a0,str2
	li $v0,print_str
	syscall
endIf:
	
	j while
endWhile:	

	#print(str3)
	la $a0,str3
	li $v0,print_str
	syscall
	
	#print(soma)
	la $a0,$t2
	li $v0,print_int
	syscall

	jr $ra