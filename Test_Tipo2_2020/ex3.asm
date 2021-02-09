	# size 	align 	offset
# name     50     0       0
# num	    4     2	  52
# grade     4     2       56
# type      1     0       60
	.data
	.eqv print_float,2
	.eqv print_str,4
	.eqv read_str,8
	.eqv read_int,5
	.eqv read_float,6
	.eqv read_char,12
	.align 2
stf:	.asciiz "Rei Eusebio"	#
	.space 38		# 50 chars
	.align 2		# +2
	.word 12345		# 52
	.float 17.2 		# 56
	.byte 'Y'		# 61
	.align 2		# +3
				#
	.asciiz "Rainha Amalia"	# 0
	.space 38		# 50 chars
	.align 2		# +2
	.word 23450		# 52
	.float 12.5 		# 56
	.byte 'C'		# 61
	.align 2		# +3
a:	.space 64
	# por objecto ... -> 64 bytes
	# total -> 128
	.text		
	.globl main

	
	
print:
	li $t0,2
	mtc1 $t0,$f2
	cvt.s.w $f2,$f2
	
	li $t0,0
	mtc1 $t0,$f0
	cvt.s.w $f0,$f0
	
	move $t0,$a0
	move $t1,$a1
	
for:
	ble $t1,0,end
	
	li $v0,print_str
	syscall
	
	l.s $f12,56($t0)
	li $v0,print_float
	syscall
	add.s $f0,$f0,$f12
	
	addiu $t0,$t0,64
	subu $t1,$t1,1
	move $a0,$t0
	j for
end:
	div.s $f0,$f0,$f2
	mov.s $f12,$f0
	li $v0,print_float
	syscall	
	jr $ra

read:
	move $t0,$a0
	
	move $a0,$t0
	li $a1,50
	li $v0,read_str
	syscall
	
	li $v0,read_int
	syscall
	sw $v0,52($t0)
	
	li $v0,read_float
	syscall
	sw $v0,56($t0)
	
	li $v0,read_char
	syscall
	sb $v0,57($t0)

	jr $ra


main:
	addiu $sp,$sp,-4
  	sw $ra,0($sp)
	
 	la $a0,stf
 	li $a1,2
	jal print
	mov.s $f12,$f0
	li $v0,print_float
	syscall
	mov.s $f12,$f0
	li $v0,print_float
	syscall
	mov.s $f12,$f0
	li $v0,print_float
	syscall
	
	jal read
	
	la $a0,stf
	li $a1,3
	jal print
	mov.s $f12,$f0
	li $v0,print_float
	syscall
	
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
 	jr $ra