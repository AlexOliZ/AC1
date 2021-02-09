	.data
	.eqv read_int,5
	.eqv print_float,2
val1:	.float 2.59365
	.text
	.globl main
	# registos 
	# $f12 -> res
	# $f1 -> val
	
main:
	la $t0,val1
	l.s $f2,0($t0)
do:
	li $v0,read_int
	syscall
	mtc1 $v0,$f1
	
	cvt.s.w $f1,$f1
	mul.s $f4,$f1,$f2
	
	mov.s $f12,$f4
	li $v0,print_float
	syscall
	
	mtc1 $0,$f0
	cvt.s.w $f0,$f0
	
	c.eq.d $f4,$f0
	bc1f do
endw:
	move $v0,$0
	jr $ra
