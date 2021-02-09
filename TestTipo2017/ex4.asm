# passar os pares para um array
# passar os impares para outro array
# e pares e preencher o array
	.data
	.eqv SIZE,5
	.eqv read_int,5
	.eqv print_int,1
	.eqv print_str,4
	.eqv print_char,11
str1:	.asciiz "integer:"
str2:   .asciiz "pares: "
str3:	.asciiz "impares: " 
	.align 2
array: 	.space 20
	.align 2
array_even:  	.space 20
	.align 2
array_odd:	.space 20
	.align 2
	.text
	.globl main
	
	# Mapa de registos
	# i -> $t0
	# *p -> $t1
	# p -> $t2
	# even -> $t5
	# odd -> $t6
	# array_even* -> $t3
	# array_odd* -> $t4
	
main:
	li $t0,0
	li $t5,0
	li $t6,0
	la $t2,array
	la $t3,array_even
	la $t4,array_odd
while1:
	bge $t0,SIZE,endw1
	la $a0,str1
	li $v0,print_str
	syscall	
	
	li $v0,read_int
	syscall
	# armazenar no array
	sll $t1,$t0,2
	addu $t1,$t1,$t2
	sw $v0,0($t1)
	# armazenar no array pares
if_even:rem $t8,$v0,2
	bne $t8,0 else
	sw $v0,0($t3)
	addiu $t3,$t3,4
	addi $t5,$t5,1
	j endif
else:	# armazenar no array impares
	sw $v0,0($t4)
	addiu $t4,$t4,4
	addi $t6,$t6,1
endif:
	addi $t0,$t0,1
	j while1
endw1:
	la $t2,array_even
	li $t0,0
	
	#print n_even\n
	la $a0,str2
	li $v0,print_str
	syscall
	move $a0,$t5
	li $v0,print_int
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall 
	# print array_even
while2:
	bge $t0,$t5,endw2
	sll $t3,$t0,2
	addu $t3,$t3,$t2
	lw $a0,0($t3)
	li $v0,print_int
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall
	addi $t0,$t0,1
	j while2
endw2:	
	# print n_odd\n
	la $t2,array_odd
	la $a0,str3
	li $v0,print_str
	syscall
	move $a0,$t6
	li $v0,print_int
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall
	
	la $t4,array_odd
	li $t0,0
	# print array_odd
while3:
	bge $t0,$t6,endw3
	sll $t4,$t0,2
	addu $t4,$t4,$t2
	lw $a0,0($t4)
	li $v0,print_int
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall
	addi $t0,$t0,1
	j while3
endw3:
	
	jr $ra