	.data
	.eqv read_int,5
	.eqv print_int,1
	.eqv print_string,4
	.eqv SIZE,10
	.eqv TRUE,1
str1:	.asciiz "Introduza um Numero:"
	.align 2
str2:	.asciiz ";"
	.align 2
str3:	.asciiz "\n"
	.align 2
array1:	.space 40
	.align 2
array2:	.space 40
	.align 2
	.text
	.globl main

#	t0 -> index
#	t1 -> *p1
#	t2 -> *p2
#	t5 -> even
#	t6 -> odd


main:
	li $t0,0
	la $t4,array1
	la $t2,array2
	
for1:
	bge $t0,SIZE,end1
	
	la $a0,str1
	li $v0,print_string
	syscall
	
	#READ INT
	li $v0,read_int
	syscall
	
	#*p1 = read_int
	sll $t3,$t0,2
	addu $t1,$t4,$t3
	sw $v0,0($t1)
	
	# Incrementar
	addi $t0,$t0,1
	
	la $a0,str3
	li $v0,print_string
	syscall
	
	j for1
end1:
	
	#la $t0,array1		# *p1 
	la $t1,array1		# *p2
	la $t2,array2
	li $t3,SIZE
	sll $t4,$t3,2
	addu $t0,$t1,$t4	# limite do array
	
	li $t5,0		# even
	li $t6,0		# odd
	
for2:
	bge $t1,$t0,end2	# *p1 < SIZE + a
	
	# *p1%2 == 0
	lw $t3,0($t1)
	rem $t4,$t3,2
	
	# if odd else even
	beq $t4,0,else
	
	sw $t3,0($t2)  # *p2 = *p1 
	addi $t6,$t6,1 # odd ++
	addiu $t2,$t2,4 
	
	j endif
else:
	addi $t5,$t5,1	# even ++
endif:
	# incrementar o ponteiro
	addiu $t1,$t1,4 
	j for2
end2:

	li $t0,0 
	la $t1,array1
	la $t7,array2
for3:
	bge $t0,$t6,end3 # $t0 < SIZE

	# $t4 = *p1
	sll $t3,$t0,2
	addu $t2,$t7,$t3
	lw $t4,0($t2)
	
	# print *p2
	move $a0,$t4
	li $v0,print_int
	syscall
	
	la $a0,str2
	li $v0,print_string
	syscall
	
	# incrementar
	addi $t0,$t0,1
	
	j for3
end3:
	
	la $a0,str3
	li $v0,print_string
	syscall
	
	jr $ra







