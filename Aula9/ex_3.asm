	.data
	.eqv read_int,5
	.eqv print_double,3
	.eqv SIZE,4
	.align 2
a:	.space 32
	.text
	.globl main
	
average:
	li $t0,0
	mtc1 $t0,$f12
	# ultimo endereço do array
	move $t1,$a1
	li $t2,8
	mult $t1,$t2
	addu $t1,$t1,$a0
	subu $t1,$t1,8
for1:
	bge $t0,SIZE,end1

	#sll $t0,$a0,4
	#subu $t0,$a1,$t0
	l.d $f0,0($t1)
	add.d $f12,$f0,$f12
	#addiu $a0,$a0,8
	subu $t1,$t1,8
	addi $t0,$t0,1
	j for1
end1:

	mov.d $f2,$f2
	mtc1 $a1,$f2
	div.d $f12,$f12,$f2
	
	jr $ra
	
main:
	addiu $sp,$sp,-8
	sw $ra,0($sp)
	sw $ra,4($sp)
	
	li $t0,0
	la $t1,a
for:
	bge $t0,SIZE,end
	# ponteiro
	#sll $t1,$t0,2
	#addiu $t1,$t1,$t1
	#addu $t1,$t1,$t2
	# read_int
	li $v0,read_int
	syscall
	#mov.d $v0,$f12
	
	# convert e store
	mtc1 $v0,$f12
	cvt.s.w $f1,$f1
	s.d $f12,0($t1)
	addiu $t1,$t1,8
	addiu $t0,$t0,1
	j for
end:	
	la $a0,a
	li $a1,SIZE
	jal average 
	
	li $v0,print_double
	syscall
	
	lw $ra,0($sp)
	lw $ra,4($sp)
	addiu $sp,$sp,8
	jr $ra
