# G9 -> 4
	.data
	.eqv SIZE,4
	.eqv read_double,7
	.eqv print_double,3
	.align 2
a:	.space 32
	.text
	.globl main
	
max:
	li $t0,0
	mtc1 $t0,$f12
	cvt.d.w $f12,$f12
for:
	bge $t0,$a1,end
	l.d $f2,0($a0)
if:
	c.le.d $f2,$f12
	bc1t else
	mov.d $f12,$f2
else:
	addiu $a0,$a0,8
	addiu $t0,$t0,1
	j for
end:
	
	jr $ra
	
	
main:
	addiu $sp,$sp,-12
	sw $ra,0($sp)
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
	jal max
	
	lw $ra,0($sp)
	addiu $sp,$sp,11
	li $v0,print_double
	syscall
	jr $ra