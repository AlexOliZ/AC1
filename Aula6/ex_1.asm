	.data
	.eqv print_str,4
	.eqv print_char,11
	.eqv SIZE,3
str1:	.asciiz "array"
	.align 2
str2:	.asciiz "de"
	.align 2
str3:	.asciiz "ponteiros"
	.align 2
array:	.word str1,str2,str3 
	.text
	.globl main
	
main:
	la $t1,array
	
for1:
	bge $t0,SIZE,end1
	
	sll $t2,$t0,2
	addu $t3,$t1,$t2
	
	lw $a0,0($t3)
	li $v0,print_str
	syscall
	
	li $a0,'\n'
	li $v0,print_char
	syscall
	
	addi $t0,$t0,1
	j for1
end1: 

	jr $ra