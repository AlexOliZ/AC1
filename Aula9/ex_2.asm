	.data
	.eqv read_int,5
	.eqv print_double,3
	.text
	.globl main
	
	
f2c:
	li $t0,5
	li $t1,9
	li $t1,32
	
	mtc1 $t0,$f0
	mtc1 $t1,$f2
	mtc1 $t2,$f4
	
	cvt.d.w $f0,$f0
	cvt.d.w $f2,$f2
	cvt.d.w $f4,$f4

	div.d $f2,$f0,$f2
	sub.d $f4,$f12,$f4
	mul.d $f12,$f4,$f2
	
	jr $ra
	
main:
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	li $t0,1
while: 	
	blt $t0,0,endw
	#read value
	li $v0,read_int
	syscall
	move $t0,$v0
	#converter valor
	mtc1 $v0,$f12
	cvt.d.w $f12,$f12
	jal f2c	
	#print value
	li $v0,print_double
	syscall
	j while
endw:
	lw $ra,0($sp)
	addiu $sp,$sp,4 
	li $v0,0
	jr $ra
