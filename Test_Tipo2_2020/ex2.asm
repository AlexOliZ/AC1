	.data 
	.text 
	.globl main
	
funk:
	jr $ra	
	
funk2:
	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	move $s0,$a0
	move $s0,$a1
	li $s2,0
	
while:
	lw $t0,0($s0)
	beq $t0,$s1,end
	
	move $a0,$t0
	move $a1,$s1
	jal funk
	add $s2,$s2,$v0
	addi $s0,$s0,1
	
	j while
end:	

	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addiu $sp,$sp,16
	move $v0,$s2
	jr $ra
	
main:
	jr $ra

