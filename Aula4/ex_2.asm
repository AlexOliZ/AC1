	.data
	.eqv SIZE,20
str:	.space SIZE
newLine: .asciiz "\n"
	.eqv read_string,8
	.eqv print_int,1
	.eqv print_string,4
	.text
	.globl main
	
	# Mapa de registos
	# num: $t0
	# p: $t1
	# *p: $t2 
	
main:
	li $a1,SIZE
	la $a0,str
	li $v0,read_string
	syscall
	
	la $a0,newLine
	li $v0,print_string
	syscall
	
	li $t0,0
	la $t1,str
while:	
	lb $t2,0($t1)	
	
	beq $t2,'\0',endw
	
	blt $t2,'0',endif
	bge $t2,'9',endif
	addi $t0,$t0,1
	
endif:
	addiu $t1,$t1,1	
	j while
endw:


	
	move $a0,$t0
	li $v0,print_int
	syscall
	
	la $a0,newLine
	li $v0,print_string
	syscall
	
	jr $ra
	
	
	
	
		
			
				
					
						
	
		
	
		
			
				
	
		
			
				
					
						
							
								
									
										
											
								