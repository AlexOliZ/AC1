	.data
	.eqv read_float,6
	.eqv print_float,2
	.eqv read_int,5
	.eqv print_str,4
str1:   .asciiz "x: "
str2:	.asciiz "y: "
newline:.asciiz "\n"
str3:	.asciiz "result: "
result:	.float 1.0
	.text
	.globl main
	
	
abs:

ifabs: 	bge $a0,0,elseabs
	subu $a0,$0,$a0
elseabs:
	move $v0,$a0
	jr $ra
	
xtoy:
	# armazenar espaço na stack
	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $ra,4($sp)
	sw $ra,8($sp)
	sw $ra,12($sp)
	# inicializar registos
	
	mov.s $f22,$f12
	cvt.s.w $f22,$f22
	
	la $t0,result
	l.s $f20,0($t0)
	
	move $s0,$a0
	li $s1,0
	
for:
	move $a0,$s0
	jal abs
	
	bge $s1,$v0,end
if:
	ble $a0,0,else
	mul.s $f20,$f20,$f22
	j endif
else:	
	div.s $f20,$f20,$f22
endif:
	addi $s1,$s1,1
	j for
end:

	lw $ra,0($sp)
	lw $ra,4($sp)
	lw $ra,8($sp)
	lw $ra,12($sp)
	addiu $sp,$sp,16
	
	mov.s $f12,$f20
	jr $ra
	
	
main:
	addiu $sp,$sp,-8
	sw $ra,0($sp)
	sw $ra,4($sp)

	la $a0,str1
	li $v0,print_str
	syscall
	
	# valor de x
	li $v0 read_float
	syscall
	mov.s $f12,$f0
	cvt.s.w $f12,$f12
	
	la $a0,str2
	li $v0,print_str
	syscall
	
	# valor de y
	li $v0,read_int
	syscall
	move $a0,$v0
	
	# armazenar, chamar, print, repor
	
	jal xtoy
	
	la $a0,str3
	li $v0,print_str
	syscall
	li $v0,print_float
	syscall
	
	la $a0,newline
	li $v0,print_str
	syscall
	
	lw $ra,0($sp)
	lw $ra,4($sp)
	addiu $sp,$sp,8
	jr $ra