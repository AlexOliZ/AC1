# Mapa de registos
# num: $t0
# p: $t1
# *p: $t2
 	.data
 	.eqv SIZE, 20		# define SIZE 20
	.eqv read_string, 8
	.eqv print_int10, 1
str:	.space SIZE
 	.text
 	.globl main
 	
main: 	ori $t0,$0,0 				
 	ori $v0,$0,read_string
 	la $a0,str
 	li $a1,SIZE
 	syscall
 	la $t1,str 			# p = str;
 	
while: 					# while(*p != '\0')
 	lb $t2,100($t1)			#
 	beq $t2,0,endw 			# {
 	blt $t2,'0',endif 		# if(str[i] >='0' &&
 	bgt $t2,'9',endif 		# str[i] <= '9')
 	addi $t0,$t0,1 			# num++;
endif:
 	addiu $t1,$t1,1			# p++;
 	j while				# }
endw: 	ori $v0,$0,print_int10		# print_int10(num);
 	or $a0,$0,$t0
 	syscall
 	
 	
 	jr $ra 				# termina o programa 
