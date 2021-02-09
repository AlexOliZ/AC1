#G10 -> 3
	.data
	.eqv SIZE,4
	.eqv read_double,7
	.eqv print_double,3
	.align 2
a:	.space 32
	.text
	.globl main
	
xtoy:


	jr $ra
	
sqrt:


	jr $ra
	
var:
	addiu $sp,$sp,12
	sw
	sw
	sw $ra


	jr $ra

stdev:


	jr $ra
	
main:
	addiu $sp,$sp,-12
	sw $ra,0($sp)
	sw $ra,4($sp)
	sw $ra,8($sp)
	li $t0,0
	li $t1,SIZE
	la $t2,a
	
for_:
	bge $t0,$t1,end_
	li $v0,read_double
	syscall
	s.d $f0,0($t2)
	addiu $t2,$t2,8
	addiu $t0,$t0,1
	j for_
end_:
	
	la $a0,a
	li $a1,SIZE
	jal var
	
	lw $ra,0($sp)
	lw $ra,4($sp)
	lw $ra,8($sp)
	addiu $sp,$sp,11
	li $v0,print_double
	syscall
	jr $ra