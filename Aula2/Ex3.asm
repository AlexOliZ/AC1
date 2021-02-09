	.data
str1:	.asciiz "Introduza 2 numeros\n"
str2: 	.asciiz "A soma dos dois numeros e': "
 	.eqv print_string,4
 	.eqv read_int,1
 	.eqv print_int10,5
 	.text
 	.globl main 
main: 
	la $a0,str1
 	ori $v0,$0,print_string
 	syscall 			# print_string(str1);
 	
 	ori $v0,$0,read_int
 	syscall 			# valor lido e' retornado em $v0
 	or $t0,$v0,$0 			# $t0=read_int()
 	
 	ori $v0,$0,read_int		# b = read_int();
	syscall				
	
	add $t0, $v0, $t0		# a + b 
	
	la $a0, strB			# print_string("A soma dos dois numeros e': ");
	ori $v0,$0, print_string 
	syscall		
					
	or $a0, $0, $t0			# print_int(a + b);
	ori $v0, $0, print_int10
	syscall
 	
 	jr $ra 				# fim do programa 
