	.data
	
	.eqv print_str,4
	.eqv read_int,5
	.eqv MAX_SIZE,33
str:	.asciiz ""
	.text
	.globl main

# _____________________ REVERSE _____________________
exchange:
	lb $t0,0($a0)
	lb $t1,0($a1)
	sb $t1,0($a0)
	sb $t0,0($a1)
	jr $ra
strrev:	
	addiu $sp,$sp,-16#reserva espaco na stack
	sw $ra,0($sp)#guarda endereço de retorno (strrev(str) guarda str)
	sw $s0,4($sp)#guarda valor dos registos return
	sw $s1,8($sp)
	sw $s2,12($sp) 
	move $s0,$a0
	move $s1,$a0
	move $s2,$a0
	
while1:
	lb $t0, 0($s2)
	beq $t0,'\0',endw1
	addiu $s2,$s2,1
	j while1
endw1:
	addiu $s2,$s2,-1
while2:
	bge $s1,$s2,endw2	
	move $a0,$s1
	move $a1,$s2
	jal exchange
	addiu $s1,$s1,1
	addiu $s2,$s2,-1
	j while2
endw2:

	move $v0,$s0
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addiu $sp,$sp,16
	jr $ra

# ________________________ ASCII _______________________#

toascii:
	addi $a0,$a0,'0'
	ble $a0,'0',else
	addi $a0,$a0,7
else:
	move $v0,$a0
	jr $ra
	
	
# ________________________ ITOA _______________________#	
	
itoa:
	addiu $sp,$sp,-24
	sw $ra,0($sp)
	sw $s0,4($sp)	 
	sw $s1,8($sp) 	
	sw $s2,12($sp)	
	sw $s3,16($sp)	
	sw $s4,20($sp)
	
	move $s0,$a0	# s 
	move $s1,$a1	# n
	move $s2,$a2	# b
	move $s3,$a2	# p
do:	
	
	rem $t1,$s1,$s2
	move $v0,$t1
	jal exchange
	addi $t0,$t0,1
	bgt $s2,0,do
	
	rem $t0,$s1,$s2
	
	move $v0,$s0
	jal strrev
	
	move $v0,$s1
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	lw $s3,20($sp)
	addiu $sp,$sp,24
	
	
	jr $ra	
		
	
			
							
main:
	
do:	
	li $v0,read_int
	syscall
	move $t0,$a0

	blt $t0,16,end
	
	# ----- armazenar na stack -----
	addiu $sp,$sp,-12
	sw $ra,0($sp)
	sw $ra,4($sp)
	sw $ra,8($sp)	
	
	li $a0,$t0
	li $a1,2
	la $a2,str
	jal itoa
	
	move $a0,$v0
	li $v0,print_str
	syscall
	
	# ---- report stack -----
	lw $ra,0($sp)
	lw $ra,4($sp)
	lw $ra,8($sp)
	addiu $sp,$sp,12
	
	
	# ----- armazenar na stack -----
	addiu $sp,$sp,-12
	sw $ra,0($sp)
	sw $ra,4($sp)
	sw $ra,8($sp)	
	
	li $a0,$t0
	li $a1,8
	la $a2,str
	jal itoa
	
	move $a0,$v0
	li $v0,print_str
	syscall
	
	# ---- report stack -----
	lw $ra,0($sp)
	lw $ra,4($sp)
	lw $ra,8($sp)
	addiu $sp,$sp,12
	
	
	# ----- armazenar na stack -----
	addiu $sp,$sp,-12
	sw $ra,0($sp)
	sw $ra,4($sp)
	sw $ra,8($sp)	
	
	li $a0,$t0
	li $a1,16
	la $a2,str
	jal itoa
	
	move $a0,$v0
	li $v0,print_str
	syscall
	
	# ---- report stack -----
	lw $ra,0($sp)
	lw $ra,4($sp)
	lw $ra,8($sp)
	addiu $sp,$sp,12
	
	
	bne $t0,0,do

	jr $ra
	
		
			
				
	
	
