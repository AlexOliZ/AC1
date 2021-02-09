	.data
	.eqv read_double,7
	.eqv print_double,3
	.eqv print_str,4
newline:.asciiz "\n"
str1:	.asciiz "value: "
str2:	.asciiz "result: "
value:	.double 1.0
zero:	.double 0.0
five:	.double 0.5
	.text
	.globl main
	
sqrt:
	# val -> $f12
	# aux -> $f0
	# xn -> $f1
	la $t0,value
	l.d $f0,0($t0)
	l.d $f2,0($t0)
	la $t0,zero
	l.d $f4,0($t0)
	li $t0,0
	
if:
	c.le.d $f2,$f12
	bc1f else
do:	
	#ver esta conta
	mov.d $f0,$f2
	div.d $f6,$f12,$f2 
	add.d $f2,$f6,$f2
	la $t0,five
	l.d $f6,0($t0)
	mul.d $f2,$f2,$f6
	
	#ver esta comp
	c.eq.d $f0,$f2
	bc1f while
	addi $t0,$t0,1
	ble $t0,25,while
	j do
while: 
	j endif
else:
	la $t0,zero
	l.d $f2,0($t0)
endif:
	mov.d $f12,$f2
	jr $ra
	
	
main:

	addiu $sp,$sp,-4
	sw $ra,0($sp)

	la $a0,str1
	li $v0,print_str
	syscall
	li $v0,read_double
	syscall
	mov.d $f12,$f0
	
	jal sqrt

	la $a0,str2
	li $v0,print_str
	syscall
	li $v0,print_double
	syscall
	
	la $a0,newline
	li $v0,print_str
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	
	jr $ra